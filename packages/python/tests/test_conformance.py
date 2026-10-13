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


# ---------------------------------------------------------------------------
# Known defects v3
# ---------------------------------------------------------------------------

V3_FIXTURES = {
    name: core.DefectsCanon.from_data(fx["vehicles"], fx["defects"])
    for name, fx in VECTORS["v3Fixtures"].items()
}


def canon_for(vec: dict) -> core.DefectsCanon:
    return V3_FIXTURES[vec["fixture"]] if "fixture" in vec else core.canon_v3()


@pytest.mark.parametrize("vec", VECTORS["resolveV3"], ids=lambda v: v["name"])
def test_resolve_v3(vec: dict) -> None:
    got = core.resolve_v3(vec["facts"], canon_for(vec))
    assert [r.to_dict() for r in got] == vec["expect"]


@pytest.mark.parametrize("vec", VECTORS["resolveDefect"], ids=lambda v: v["name"])
def test_resolve_defect(vec: dict) -> None:
    got = core.resolve_defect(vec["defectId"], vec["facts"], canon_for(vec))
    assert (got.to_dict() if got else None) == vec["expect"]


@pytest.mark.parametrize(
    "vec", VECTORS["v3Names"], ids=lambda v: f"{v['make']}-{v['model']}"
)
def test_v3_names(vec: dict) -> None:
    make, model = core.resolved_model(vec)
    assert {"make": make, "model": model} == vec["expect"]


@pytest.mark.parametrize(
    "vec", VECTORS["v3ServedIds"], ids=lambda v: v["id"] or "empty"
)
def test_v3_served_ids(vec: dict) -> None:
    assert core.served_id(vec["id"]) == vec["expect"]


@pytest.mark.parametrize("vec", VECTORS["assembleV3"], ids=lambda v: v["name"])
def test_assemble_v3(vec: dict) -> None:
    groups = core.assemble_v3(vec["facts"])
    expect = vec["expect"]
    assert [g["id"] for g in groups] == expect["groupIds"]
    assert len(core.all_items(groups)) == expect["itemCount"]
    group = next((g for g in groups if g["id"] == "defects"), None)
    if group is None:
        assert expect["defectsTitle"] is None and expect["defects"] == []
        return
    assert group["ruleId"] == expect["defectRuleId"]
    assert core.pick(group["title"], "en") == expect["defectsTitle"]
    rows = [
        {
            "id": i["id"],
            "sourceDefectId": i["sourceDefectId"],
            "dossierId": i["dossierId"],
            "status": i["status"],
            "needs": i["needs"],
            "critical": i["critical"],
            "prompt": core.pick(i["prompt"], "en"),
            "hint": core.pick(i["hint"], "en") if i["hint"] else None,
        }
        for i in core.all_items([group])
    ]
    assert rows == expect["defects"]
    assert [i["order"] for i in core.all_items([group])] == list(range(len(rows)))


def test_assemble_v3_localizes_and_scores() -> None:
    groups = core.assemble_v3({"make": "Mercedes-Benz", "model": "C-Class"})
    out = core.localize(groups, "fr")
    rows = out[-1]["children"][0]["items"]
    alias = next(r for r in rows if r["sourceDefectId"] == "m271.balanceshaft")
    assert alias["id"] == "defect.m271.balanceshaft"
    assert alias["dossierId"] == "m271.timingchain"
    assert alias["status"] == "possible" and alias["needs"] == ["year", "engineCode"]
    # A 'possible' item answered "not applicable" is just a -1 to scoring.
    scores = {i["id"]: 4 for i in core.all_items(groups)}
    scores[alias["id"]] = core.SCORE_NOT_APPLICABLE
    assert core.overall(groups, scores) == pytest.approx(4.0)


def test_v2_api_is_untouched_by_v3() -> None:
    groups = core.assemble(core.Car("Mercedes-Benz", "C-Class", "petrol"))
    items = core.all_items([groups[-1]])
    assert [i["sourceDefectId"] for i in items] == [
        "om651.injectors",
        "m271.balanceshaft",
        "rust",
    ]
    assert all("status" not in i for i in items)


def test_resolve_defects_is_resolve_v3() -> None:
    facts = {"make": "BMW", "model": "320d", "year": 2010}
    assert core.resolve_defects(facts) == core.resolve_v3(facts)


def test_v3_typed_facts_match_the_dict_form() -> None:
    typed = core.Facts(make="BMW", model="320d", engine_code="n47d20", year=2010)
    loose = {"make": "BMW", "model": "320d", "engineCode": "n47d20", "year": 2010}
    assert core.resolve_v3(typed) == core.resolve_v3(loose)
    n47 = core.resolve_defect("n47.chain", typed)
    assert n47 is not None and n47.status == "applies"


def test_v3_packaged_canon() -> None:
    canon = core.canon_v3()
    assert canon.format == 3
    assert {"dsg.dq200", "n47.chain", "puretech.wetbelt"} <= set(canon.defects_by_id)
    assert len(canon.defects_by_id) == 15
    assert canon.alias_of == {"m271.balanceshaft": "m271.timingchain"}


def test_v3_closed_condition_language() -> None:
    canon = core.DefectsCanon.from_data(
        VECTORS["v3Fixtures"]["synthetic"]["vehicles"],
        {
            "format": 3,
            "defects": [
                {
                    "id": "x",
                    "status": "published",
                    "applicability": {
                        "models": ["testa.alpha"],
                        "when": {"market": ["EU"]},
                    },
                }
            ],
        },
    )
    with pytest.raises(core.ConditionError):
        canon.resolve_v3({"make": "testa", "model": "alpha"})


def test_v3_docstring_example_holds() -> None:
    facts = {"make": "VW", "model": "Golf", "gearbox": "manual", "fuel": "diesel"}
    got = core.resolve_defects(facts)
    assert (got[0].defect_id, got[0].status) == ("dsg.dq200", "not_applicable")
