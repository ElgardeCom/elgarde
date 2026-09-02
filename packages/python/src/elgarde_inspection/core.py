"""Checklist assembly, defect-rule matching and scoring for Elgarde.

The canon is data, not code: ``data/checklist.json`` and ``data/defects.json``
ship with this package and are copied from ``inspection-core/data/`` by
``inspection-core/tools/sync_canon.py``. The algorithm below implements
``inspection-core/spec/SCORING.md``, and correctness is pinned by the shared
conformance vectors that every port — Python, Dart, JS, PHP — must pass.

Never edit the JSON here by hand: change the canon and re-run the sync.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path

CANON_DIR = Path(__file__).parent / "data"

# Non-numeric answers, stored in the same map as 1–5 ratings and kept negative
# so a single ``> 0`` test excludes them from every rollup.
SCORE_NOT_APPLICABLE = -1
SCORE_NOT_INSPECTED = -2

CRITICAL_THRESHOLD = 2

FUEL_TYPES = ("petrol", "diesel", "hybrid", "ev", "other")

Scores = dict[str, int | None]
Group = dict
Item = dict


@dataclass(frozen=True)
class Car:
    make: str | None = None
    model: str | None = None
    fuel_type: str | None = None


@lru_cache(maxsize=1)
def canon() -> tuple[dict, dict]:
    """(checklist, defects), parsed once."""
    checklist = json.loads((CANON_DIR / "checklist.json").read_text("utf-8"))
    defects = json.loads((CANON_DIR / "defects.json").read_text("utf-8"))
    return checklist, defects


def canon_version() -> dict[str, int]:
    checklist, defects = canon()
    return {"checklist": checklist["version"], "defects": defects["version"]}


# ---------------------------------------------------------------------------
# Defect matching
# ---------------------------------------------------------------------------


def _clause_matches(clause: dict, make: str, model: str) -> bool:
    if not any(token in make for token in clause.get("makeAny", ())):
        return False
    model_any = clause.get("modelAny")
    if model_any is None:
        return True
    return any(token in model for token in model_any)


def match_defect_rule(make: str | None, model: str | None) -> dict | None:
    """First matching rule from the ordered rule list, or None. Rules are tried
    in canon order and at most one ever applies."""
    mk = (make or "").lower()
    md = (model or "").lower()
    if not mk and not md:
        return None
    _, defects = canon()
    for rule in defects["rules"]:
        if any(_clause_matches(c, mk, md) for c in rule["match"]):
            return rule
    return None


def defect_group(rule: dict) -> Group:
    """The rule rendered as the top-level 'defects' group appended to the
    checklist. Defect text carries en/pt only; other languages fall back to en."""
    return {
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
                        "sourceDefectId": d["id"],
                    }
                    for i, d in enumerate(rule["defects"])
                ],
            }
        ],
    }


# ---------------------------------------------------------------------------
# Assembly
# ---------------------------------------------------------------------------


def assemble(car: Car) -> list[Group]:
    """Base groups + the matching fuel module + the matching defect group."""
    checklist, _ = canon()
    groups: list[Group] = [dict(g) for g in checklist["base"]]

    module = checklist["modules"]["fuel"].get(car.fuel_type or "")
    if module is not None:
        groups.append(module)

    rule = match_defect_rule(car.make, car.model)
    if rule is not None:
        groups.append(defect_group(rule))
    return groups


def all_items(groups: list[Group]) -> list[Item]:
    out: list[Item] = []

    def walk(g: Group) -> None:
        out.extend(g.get("items", ()))
        for child in g.get("children", ()):
            walk(child)

    for g in groups:
        walk(g)
    return out


# ---------------------------------------------------------------------------
# Scoring
# ---------------------------------------------------------------------------


def is_real_score(s: int | None) -> bool:
    return s is not None and s > 0


def group_score(group: Group, scores: Scores) -> float | None:
    """Rolled-up 1–5 score for a group, or None when nothing real is answered
    underneath it. Child groups contribute with weight 1."""
    weighted: list[tuple[float, float]] = []

    for item in group.get("items", ()):
        s = scores.get(item["id"])
        if is_real_score(s):
            weighted.append((float(s), float(item.get("weight", 1.0))))
    for child in group.get("children", ()):
        cs = group_score(child, scores)
        if cs is not None:
            weighted.append((cs, 1.0))

    if not weighted:
        return None

    aggregation = group.get("aggregation", "average")
    if aggregation == "worst_case":
        return min(v for v, _ in weighted)
    if aggregation == "weighted":
        den = sum(w for _, w in weighted)
        return 0.0 if den == 0 else sum(v * w for v, w in weighted) / den
    return sum(v for v, _ in weighted) / len(weighted)


def critical_items(groups: list[Group]) -> list[Item]:
    return [i for i in all_items(groups) if i.get("critical")]


def overall(
    groups: list[Group],
    scores: Scores,
    *,
    critical_threshold: int = CRITICAL_THRESHOLD,
) -> float | None:
    """Mean of the top-level group scores, then clamped down by any answered
    critical item scoring at or below [critical_threshold]."""
    verdict = overall_before_clamp(groups, scores)
    if verdict is None:
        return None
    for item in critical_items(groups):
        s = scores.get(item["id"])
        if is_real_score(s) and s <= critical_threshold and s < verdict:
            verdict = float(s)
    return verdict


def overall_before_clamp(groups: list[Group], scores: Scores) -> float | None:
    tops = [s for s in (group_score(g, scores) for g in groups) if s is not None]
    if not tops:
        return None
    return sum(tops) / len(tops)


def progress(groups: list[Group], scores: Scores) -> tuple[int, int]:
    """(answered, total) over leaf items. Sentinels count as answered."""
    items = all_items(groups)
    answered = sum(1 for i in items if scores.get(i["id"]) is not None)
    return answered, len(items)


# ---------------------------------------------------------------------------
# Localisation
# ---------------------------------------------------------------------------


def pick(text: dict[str, str], lang: str) -> str:
    return text.get(lang) or text.get("en") or next(iter(text.values()), "")


def localize(groups: list[Group], lang: str) -> list[dict]:
    """The assembled tree with one language resolved per title/prompt."""

    def item(i: Item) -> dict:
        out = {
            "id": i["id"],
            "order": i.get("order", 0),
            "prompt": pick(i["prompt"], lang),
            "critical": bool(i.get("critical", False)),
        }
        if i.get("weight", 1.0) != 1.0:
            out["weight"] = i["weight"]
        if i.get("sourceDefectId"):
            out["sourceDefectId"] = i["sourceDefectId"]
        return out

    def group(g: Group) -> dict:
        out = {
            "id": g["id"],
            "order": g.get("order", 0),
            "title": pick(g["title"], lang),
            "aggregation": g.get("aggregation", "average"),
        }
        if g.get("children"):
            out["children"] = [group(c) for c in g["children"]]
        if g.get("items"):
            out["items"] = [item(i) for i in g["items"]]
        return out

    return [group(g) for g in groups]
