#!/usr/bin/env python3
"""Self-check for the canon: schemas, structure, and the conformance vectors.

Run before publishing anything that embeds this data:

    python3 tools/check.py

The scoring code below is a deliberately independent reference implementation of
spec/SCORING.md — small enough to read in one sitting, and written so that the
vectors are checked by something other than the port they were generated with.
Schema validation is skipped (with a notice) when `jsonschema` is not installed;
everything else always runs.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def load(rel: str) -> dict:
    return json.loads((ROOT / rel).read_text("utf-8"))


CHECKLIST = load("data/checklist.json")
DEFECTS = load("data/defects.json")
VECTORS = load("conformance/vectors.json")
TOLERANCE = VECTORS["notes"]["tolerance"]

V3_FILES = ("defects", "evidence", "prevalence", "vehicles", "disclaimer", "release")

failures: list[str] = []


def check(condition: bool, message: str) -> None:
    if not condition:
        failures.append(message)


def near(got: float | None, want: float | None, label: str) -> None:
    if got is None or want is None:
        check(got == want, f"{label}: got {got!r}, want {want!r}")
        return
    check(abs(got - want) <= TOLERANCE, f"{label}: got {got!r}, want {want!r}")


# ---------------------------------------------------------------------------
# Reference implementation of spec/SCORING.md
# ---------------------------------------------------------------------------


def group_score(group: dict, scores: dict) -> float | None:
    parts: list[tuple[float, float]] = []
    for item in group.get("items", []):
        value = scores.get(item["id"])
        if value is not None and value > 0:
            parts.append((float(value), float(item.get("weight", 1.0))))
    for child in group.get("children", []):
        child_score = group_score(child, scores)
        if child_score is not None:
            parts.append((child_score, 1.0))
    if not parts:
        return None

    mode = group.get("aggregation", "average")
    if mode == "worst_case":
        return min(value for value, _ in parts)
    if mode == "weighted":
        total_weight = sum(weight for _, weight in parts)
        if total_weight == 0:
            return 0.0
        return sum(v * w for v, w in parts) / total_weight
    return sum(value for value, _ in parts) / len(parts)


def leaf_items(groups: list[dict]) -> list[dict]:
    out: list[dict] = []
    for group in groups:
        out.extend(group.get("items", []))
        out.extend(leaf_items(group.get("children", [])))
    return out


def overall(groups: list[dict], scores: dict, threshold: int = 2) -> float | None:
    tops = [s for s in (group_score(g, scores) for g in groups) if s is not None]
    if not tops:
        return None
    verdict = sum(tops) / len(tops)
    for item in leaf_items(groups):
        if not item.get("critical"):
            continue
        value = scores.get(item["id"])
        if value is not None and 0 < value <= threshold and value < verdict:
            verdict = float(value)
    return verdict


def progress(groups: list[dict], scores: dict) -> list[int]:
    items = leaf_items(groups)
    return [sum(1 for i in items if scores.get(i["id"]) is not None), len(items)]


def match_rule(make: str | None, model: str | None) -> dict | None:
    mk, md = (make or "").lower(), (model or "").lower()
    if not mk and not md:
        return None
    for rule in DEFECTS["rules"]:
        for clause in rule["match"]:
            if not any(token in mk for token in clause["makeAny"]):
                continue
            if "modelAny" in clause and not any(
                token in md for token in clause["modelAny"]
            ):
                continue
            return rule
    return None


def assemble(car: dict) -> list[dict]:
    groups = list(CHECKLIST["base"])
    module = CHECKLIST["modules"]["fuel"].get(car.get("fuelType") or "")
    if module:
        groups.append(module)
    rule = match_rule(car.get("make"), car.get("model"))
    if rule:
        groups.append(
            {
                "id": "defects",
                "order": 6,
                "title": rule["label"],
                "children": [
                    {
                        "id": "defects.g",
                        "order": 0,
                        "title": rule["label"],
                        "items": [
                            {
                                "id": f"defect.{d['id']}",
                                "order": i,
                                "prompt": d["text"],
                                "critical": bool(d.get("critical", False)),
                            }
                            for i, d in enumerate(rule["defects"])
                        ],
                    }
                ],
            }
        )
    return groups


# ---------------------------------------------------------------------------
# Checks
# ---------------------------------------------------------------------------


def check_schemas() -> None:
    try:
        from jsonschema import Draft202012Validator
    except ImportError:
        print("  (jsonschema not installed — schema validation skipped)")
        return
    for name, data in (("checklist", CHECKLIST), ("defects", DEFECTS)):
        schema = load(f"data/schema/{name}.schema.json")
        Draft202012Validator.check_schema(schema)
        for error in Draft202012Validator(schema).iter_errors(data):
            failures.append(f"{name}.json {list(error.path)}: {error.message}")
    for name in V3_FILES:
        schema = load(f"data/schema/v3/{name}.schema.json")
        Draft202012Validator.check_schema(schema)
        for error in Draft202012Validator(schema).iter_errors(load(f"data/v3/{name}.json")):
            failures.append(f"v3/{name}.json {list(error.path)}: {error.message}")


SERVED_GRADES = ("established", "well_documented")


def evidence_grade(defect: dict, evidence_by_id: dict[str, dict]) -> str:
    """The publication threshold (architecture section 4.6), as the API computes it."""
    evs = [evidence_by_id[e] for e in defect.get("evidence", ()) if e in evidence_by_id]
    for ev in evs:
        if (
            ev.get("tier") == 1
            and "existence" in ev.get("supports", ())
            and ev.get("confidence") in ("high", "medium")
        ):
            return "established"
    publishers = {
        (ev.get("source", {}).get("publisher") or "").casefold()
        for ev in evs
        if ev.get("tier") == 2 and {"existence", "mechanism"} <= set(ev.get("supports", ()))
    }
    publishers.discard("")
    return "well_documented" if len(publishers) >= 2 else "reported"


def check_v3_references() -> None:
    """Every id a v3 dossier points at must exist, every published dossier must
    clear the evidence threshold (the ports serve every published dossier and do
    not carry the evidence to check it themselves), aliases and replacements must
    point the right way, and the release counts must be true."""
    defects = load("data/v3/defects.json")["defects"]
    evidence = load("data/v3/evidence.json")["evidence"]
    prevalence = load("data/v3/prevalence.json")["prevalence"]
    release = load("data/v3/release.json")
    by_id = {d["id"]: d for d in defects}
    check(len(by_id) == len(defects), "v3 defects.json: duplicate ids")
    evidence_by_id = {e["id"]: e for e in evidence}
    prevalence_ids = {p["id"] for p in prevalence}
    published = {i for i, d in by_id.items() if d["status"] == "published"}
    deprecated = {i for i, d in by_id.items() if d["status"] == "deprecated"}
    for d in defects:
        for ref in d.get("evidence", ()):
            check(ref in evidence_by_id, f"v3 defect {d['id']}: unknown evidence {ref}")
        for ref in d.get("prevalence", ()):
            check(ref in prevalence_ids, f"v3 defect {d['id']}: unknown prevalence {ref}")
        if d["id"] in published:
            grade = evidence_grade(d, evidence_by_id)
            check(grade in SERVED_GRADES,
                  f"v3 defect {d['id']}: published with evidence grade {grade!r}")
        for alias in d.get("aliases", ()):
            check(d["id"] in published, f"v3 defect {d['id']}: only a published dossier has aliases")
            old = by_id.get(alias)
            check(old is not None and old["status"] == "deprecated" and old.get("replacedBy") == d["id"],
                  f"v3 defect {d['id']}: alias {alias} must be a deprecated record replaced by it")
        if d.get("replacedBy") is not None:
            check(d["replacedBy"] in published and d["id"] in by_id[d["replacedBy"]].get("aliases", ()),
                  f"v3 defect {d['id']}: replacedBy {d['replacedBy']} must be a published dossier listing it in aliases")
    for e in evidence:
        for ref in e["defects"]:
            check(ref in by_id, f"v3 evidence {e['id']}: unknown defect {ref}")
        check(e["source"]["license"] in release["licenses"], f"v3 evidence {e['id']}: licence not in release.json")
    for p in prevalence:
        check(p["defect"] in by_id, f"v3 prevalence {p['id']}: unknown defect {p['defect']}")
        for ref in p["evidence"]:
            check(ref in evidence_by_id, f"v3 prevalence {p['id']}: unknown evidence {ref}")
    # Every v2 defect id lives on in v3, as a dossier or as a deprecated record.
    for rule in DEFECTS["rules"]:
        for entry in rule["defects"]:
            check(entry["id"] in by_id, f"v2 defect {entry['id']} has no v3 record")
    counts = release["counts"]
    want = {"defects": len(published), "evidence": len(evidence), "prevalence": len(prevalence)}
    if "deprecated" in counts:
        want["deprecated"] = len(deprecated)
    check(counts == want, f"v3 release.json counts {counts} do not match the data {want}")
    check(release["changelog"][-1]["release"] == release["release"],
          "v3 release.json: the last changelog entry is not the current release")


def check_structure() -> None:
    languages = CHECKLIST["languages"]
    ids: list[str] = []

    def walk(group: dict) -> None:
        check(bool(group.get("title")), f"group {group['id']} has no title")
        for item in group.get("items", []):
            ids.append(item["id"])
            missing = set(languages) - set(item["prompt"])
            check(not missing, f"item {item['id']} missing {sorted(missing)}")
        for child in group.get("children", []):
            walk(child)

    for group in CHECKLIST["base"] + list(CHECKLIST["modules"]["fuel"].values()):
        walk(group)

    check(len(ids) == len(set(ids)), "duplicate checklist item ids")

    rule_ids = [r["id"] for r in DEFECTS["rules"]]
    check(len(rule_ids) == len(set(rule_ids)), "duplicate defect rule ids")
    for rule in DEFECTS["rules"]:
        defect_ids = [d["id"] for d in rule["defects"]]
        check(
            len(defect_ids) == len(set(defect_ids)),
            f"duplicate defect ids in {rule['id']}",
        )


def check_vectors() -> None:
    for vector in VECTORS["scoring"]:
        groups = VECTORS["fixtures"][vector["fixture"]]["groups"]
        scores, expect = vector["scores"], vector["expect"]
        name = vector["name"]
        for group_id, want in expect["groupScores"].items():
            group = next(g for g in groups if g["id"] == group_id)
            near(group_score(group, scores), want, f"{name} / {group_id}")
        near(overall(groups, scores), expect["overall"], f"{name} / overall")
        check(
            progress(groups, scores) == expect["progress"],
            f"{name} / progress: {progress(groups, scores)} != {expect['progress']}",
        )

    for vector in VECTORS["assembly"]:
        groups = assemble(vector["car"])
        expect, name = vector["expect"], vector["name"]
        check(
            [g["id"] for g in groups] == expect["groupIds"],
            f"{name} / groupIds: {[g['id'] for g in groups]}",
        )
        check(
            len(leaf_items(groups)) == expect["itemCount"],
            f"{name} / itemCount: {len(leaf_items(groups))} != {expect['itemCount']}",
        )
        rule = match_rule(vector["car"]["make"], vector["car"]["model"])
        check(
            (rule["id"] if rule else None) == expect["defectRuleId"],
            f"{name} / defectRuleId",
        )

    for vector in VECTORS["matching"]:
        rule = match_rule(vector["make"], vector["model"])
        got = rule["id"] if rule else None
        check(
            got == vector["expect"],
            f"match {vector['make']}/{vector['model']}: {got} != {vector['expect']}",
        )

    for vector in VECTORS["canonScoring"]:
        groups = assemble(vector["car"])
        scores = {item["id"]: vector["fillAll"] for item in leaf_items(groups)}
        scores.update(vector["override"])
        expect, name = vector["expect"], vector["name"]
        near(overall(groups, scores), expect["overall"], f"{name} / overall")
        check(
            progress(groups, scores) == expect["progress"],
            f"{name} / progress",
        )


def main() -> int:
    print("elgarde-inspection-core self-check")
    check_schemas()
    check_structure()
    check_v3_references()
    check_vectors()

    items = len(leaf_items(CHECKLIST["base"]))
    fuel_items = sum(
        len(leaf_items([m])) for m in CHECKLIST["modules"]["fuel"].values()
    )
    print(f"  languages:      {', '.join(CHECKLIST['languages'])}")
    print(f"  base items:     {items}  (+{fuel_items} across the fuel modules)")
    print(f"  defect rules:   {len(DEFECTS['rules'])}")
    print(
        f"  defect entries: {sum(len(r['defects']) for r in DEFECTS['rules'])}"
    )
    print(
        "  vectors:        "
        f"{sum(len(VECTORS[k]) for k in ('scoring', 'assembly', 'matching', 'canonScoring'))}"
        " (+"
        f"{sum(len(VECTORS.get(k, ())) for k in ('resolveV3', 'resolveDefect', 'v3Names', 'v3ServedIds', 'assembleV3'))}"
        " known-defects v3, run by the ports)"
    )
    release = load("data/v3/release.json")
    print(f"  defects v3:     release {release['release']}, {release['counts']}")

    if failures:
        print(f"\nFAILED ({len(failures)}):")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    print("\nAll checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
