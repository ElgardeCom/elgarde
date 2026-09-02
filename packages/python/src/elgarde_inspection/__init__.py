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

__version__ = "1.0.0"

__all__ = [
    "CRITICAL_THRESHOLD",
    "FUEL_TYPES",
    "SCORE_NOT_APPLICABLE",
    "SCORE_NOT_INSPECTED",
    "Car",
    "all_items",
    "assemble",
    "canon",
    "canon_version",
    "critical_items",
    "defect_group",
    "group_score",
    "is_real_score",
    "localize",
    "match_defect_rule",
    "overall",
    "overall_before_clamp",
    "pick",
    "progress",
    "__version__",
]
