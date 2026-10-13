"""Elgarde inspection core — a structured pre-purchase used-car inspection.

The checklist, the model-specific known defects and the scoring rules that
Elgarde (https://elgarde.com/) runs on, as data plus a small pure-Python
implementation. No network, no dependencies.

    >>> from elgarde_inspection import Car, assemble, localize, overall
    >>> groups = assemble(Car(make="Volkswagen", model="Golf", fuel_type="diesel"))
    >>> [g["id"] for g in groups]
    ['ext', 'int', 'eng', 'road', 'docs', 'fuel.diesel', 'defects']
    >>> overall(groups, {"docs.all.mileage": 1})
    1.0

Known defects v3 resolve the facts known about a car — year, fuel, gearbox,
engine code… — to what applies, what is possible and what is ruled out:

    >>> from elgarde_inspection import resolve_defects
    >>> facts = {"make": "VW", "model": "Golf", "gearbox": "manual", "fuel": "diesel"}
    >>> [(r.defect_id, r.status) for r in resolve_defects(facts)][0]
    ('dsg.dq200', 'not_applicable')

Elgarde is a self-service checklist, not a certified, mechanical or legal
inspection and not professional advice. A defect entry describes a known weak
point on a *model* — never a claim about an individual car.

Data is CC-BY-4.0: attribution to https://elgarde.com/ is the only condition.
"""

from .core import (
    CRITICAL_THRESHOLD,
    FUEL_TYPES,
    SCORE_NOT_APPLICABLE,
    SCORE_NOT_INSPECTED,
    Car,
    all_items,
    assemble,
    canon,
    canon_version,
    critical_items,
    defect_group,
    group_score,
    is_real_score,
    localize,
    match_defect_rule,
    overall,
    overall_before_clamp,
    pick,
    progress,
)
from .defects_v3 import (
    GEARBOX_COARSE,
    KNOWN_DEFECTS_TITLE,
    NEEDS_ORDER,
    ConditionError,
    DefectsCanon,
    Facts,
    Resolution,
    assemble_v3,
    canon_v3,
    make_from_wmi,
    normalize_make,
    normalize_model,
    normalize_name,
    resolve_defect,
    resolve_defects,
    resolve_v3,
    resolved_model,
    served_id,
)

__version__ = "1.2.0"

__all__ = [
    "CRITICAL_THRESHOLD",
    "FUEL_TYPES",
    "GEARBOX_COARSE",
    "KNOWN_DEFECTS_TITLE",
    "NEEDS_ORDER",
    "SCORE_NOT_APPLICABLE",
    "SCORE_NOT_INSPECTED",
    "Car",
    "ConditionError",
    "DefectsCanon",
    "Facts",
    "Resolution",
    "__version__",
    "all_items",
    "assemble",
    "assemble_v3",
    "canon",
    "canon_v3",
    "canon_version",
    "critical_items",
    "defect_group",
    "group_score",
    "is_real_score",
    "localize",
    "make_from_wmi",
    "match_defect_rule",
    "normalize_make",
    "normalize_model",
    "normalize_name",
    "overall",
    "overall_before_clamp",
    "pick",
    "progress",
    "resolve_defect",
    "resolve_defects",
    "resolve_v3",
    "resolved_model",
    "served_id",
]
