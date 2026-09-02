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
    )

    if failures:
        print(f"\nFAILED ({len(failures)}):")
        for failure in failures:
            print(f"  - {failure}")
        return 1
    print("\nAll checks passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
