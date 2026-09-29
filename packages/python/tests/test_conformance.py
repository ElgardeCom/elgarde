"""The shared conformance suite. `vectors.json` is copied from
`inspection-core/conformance/` by `inspection-core/tools/sync_canon.py`; every
port of the core must pass exactly these vectors. A failure here means this port
disagrees with the canon, not that the vectors need updating.
"""

from __future__ import annotations

import json
from pathlib import Path

import pytest

import elgarde_inspection as core

VECTORS = json.loads((Path(__file__).parent / "vectors.json").read_text("utf-8"))
TOLERANCE = VECTORS["notes"]["tolerance"]


def approx(value: float | None) -> object:
    return None if value is None else pytest.approx(value, abs=TOLERANCE)


def car_of(spec: dict) -> core.Car:
    return core.Car(make=spec["make"], model=spec["model"], fuel_type=spec["fuelType"])


@pytest.mark.parametrize("vec", VECTORS["scoring"], ids=lambda v: v["name"])
def test_scoring(vec: dict) -> None:
    groups = VECTORS["fixtures"][vec["fixture"]]["groups"]
    scores, expect = vec["scores"], vec["expect"]

    for group_id, want in expect["groupScores"].items():
        group = next(g for g in groups if g["id"] == group_id)
        assert core.group_score(group, scores) == approx(want), group_id

    assert core.overall_before_clamp(groups, scores) == approx(
        expect["overallBeforeClamp"]
    )
    assert core.overall(groups, scores) == approx(expect["overall"])
    assert list(core.progress(groups, scores)) == expect["progress"]


@pytest.mark.parametrize("vec", VECTORS["assembly"], ids=lambda v: v["name"])
def test_assembly(vec: dict) -> None:
    groups = core.assemble(car_of(vec["car"]))
    expect = vec["expect"]

    assert [g["id"] for g in groups] == expect["groupIds"]
    assert len(core.all_items(groups)) == expect["itemCount"]

    rule = core.match_defect_rule(vec["car"]["make"], vec["car"]["model"])
    assert (rule["id"] if rule else None) == expect["defectRuleId"]


@pytest.mark.parametrize(
    "vec", VECTORS["matching"], ids=lambda v: f"{v['make']}-{v['model']}"
)
def test_matching(vec: dict) -> None:
    rule = core.match_defect_rule(vec["make"], vec["model"])
    assert (rule["id"] if rule else None) == vec["expect"]


@pytest.mark.parametrize("vec", VECTORS["canonScoring"], ids=lambda v: v["name"])
def test_canon_scoring(vec: dict) -> None:
    groups = core.assemble(car_of(vec["car"]))
    scores: dict[str, int | None] = {
        item["id"]: vec["fillAll"] for item in core.all_items(groups)
    }
    scores.update(vec["override"])
    expect = vec["expect"]

    if "overallBeforeClamp" in expect:
        assert core.overall_before_clamp(groups, scores) == approx(
            expect["overallBeforeClamp"]
        )
    assert core.overall(groups, scores) == approx(expect["overall"])
    assert list(core.progress(groups, scores)) == expect["progress"]


def test_packaged_canon_is_complete() -> None:
    """The data actually shipped inside the wheel, not the repo's copy."""
    checklist, defects = core.canon()
    assert checklist["languages"] == ["en", "pt", "ru", "uk", "fr"]
    assert len(defects["rules"]) >= 8
    assert core.canon_version() == {"checklist": 1, "defects": 2}


def test_defect_text_is_authored_in_every_language() -> None:
    """Since canon v2 the defect corpus is translated, not fallen back on."""
    groups = core.assemble(core.Car(make="BMW", model="320d"))
    defects = next(g for g in groups if g["id"] == "defects")
    item = defects["children"][0]["items"][0]

    english = core.pick(item["prompt"], "en")
    for lang in ("pt", "ru", "uk", "fr"):
        translated = core.pick(item["prompt"], lang)
        assert translated != english, f"{lang} is still falling back to English"
        assert "N47" in translated, f"{lang} lost the engine code"

    # An unsupported language still falls back rather than coming back empty.
    assert core.pick(item["prompt"], "de") == english


def test_readme_example_holds() -> None:
    """The snippet in README.md and the package docstring must stay true."""
    groups = core.assemble(
        core.Car(make="Volkswagen", model="Golf", fuel_type="diesel")
    )
    assert [g["id"] for g in groups] == [
        "ext",
        "int",
        "eng",
        "road",
        "docs",
        "fuel.diesel",
        "defects",
    ]
    assert core.overall(groups, {"docs.all.mileage": 1}) == 1.0
