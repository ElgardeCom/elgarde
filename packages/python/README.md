# elgarde-inspection

A structured **pre-purchase used-car inspection** as data plus a small pure-Python
implementation: a multilingual checklist, curated model-specific known defects, and the 1–5
scoring rules that turn answers into one verdict.

No dependencies, no network calls, no configuration. This is the same canon that powers the
[Elgarde](https://elgarde.com/) app and its [free API](https://elgarde.com/api/), and it passes
the same conformance vectors as every other port.

```bash
pip install elgarde-inspection
```

## Use

```python
from elgarde_inspection import Car, assemble, all_items, localize, overall, progress

groups = assemble(Car(make="Volkswagen", model="Golf", fuel_type="diesel"))
[g["id"] for g in groups]
# ['ext', 'int', 'eng', 'road', 'docs', 'fuel.diesel', 'defects']

len(all_items(groups))
# 33  — 25 base items, 3 diesel-specific, 5 known VAG weak points
```

The checklist adapts to the car: a diesel gets DPF and glow-plug items, an EV gets
state-of-health and charging items, and a recognised model gets its documented weak points —
the DQ200 dry clutch, the PureTech wet belt, the N47 timing chain.

### Read it in one language

```python
for group in localize(groups, "pt"):
    print(group["title"])
    for child in group.get("children", []):
        for item in child.get("items", []):
            print("  ", item["prompt"], "(critical)" if item["critical"] else "")
```

Content, defect texts included, is authored in **English, Portuguese, Russian, Ukrainian and
French**; any other language falls back to English.

### Score an inspection

Answers are `1`–`5`, or `-1` for *not applicable* and `-2` for *not inspected*. Omit an item to
leave it unanswered.

```python
scores = {item["id"]: 5 for item in all_items(groups)}
scores["docs.all.mileage"] = 1          # odometer does not match the records

overall(groups, scores)                 # 1.0
progress(groups, scores)                # (33, 33)
```

The average was 4.86. A **critical** item scoring at or below 2 clamps the verdict down to that
score, because a car with good averages and a failed safety or provenance check is not a good
car. That clamp only ever lowers the verdict, and an unanswered critical item has no effect.

Group rollups are `average`, `weighted` (by `item["weight"]`) or `worst_case`, per group. The
full algorithm is written down in
[`spec/SCORING.md`](https://github.com/ElgardeCom/elgarde/blob/main/inspection-core/spec/SCORING.md).

### Just the known defects

```python
from elgarde_inspection import match_defect_rule

rule = match_defect_rule("Peugeot", "208")
[(d["id"], d.get("critical", False)) for d in rule["defects"]]
# [('puretech.wetbelt', True), ('ep6.chain', False), ('hdi.turbo', False)]
```

`None` means nothing is curated for that model yet — **not** that the model is trouble-free.

### Known defects v3: what applies to *this* car

The v2 rules above match on make and model only, so the DQ200 dry clutch shows up on every Golf,
manual ones included. v3 dossiers say which engines, gearboxes and build dates a defect concerns,
and resolve what you know about the car to `applies`, `possible` (with the facts that would settle
it) or `not_applicable` (with the facts that ruled it out). Unknown is never rounded down to "not
applicable".

```python
from elgarde_inspection import assemble_v3, resolve_defects, served_id

facts = {"make": "Volkswagen", "model": "Golf", "fuel": "petrol",
         "engineCode": "CBZB", "productionDate": "2010-05"}
[(r.defect_id, r.status, r.needs) for r in resolve_defects(facts)]
# [('dsg.dq200', 'possible', ('gearbox',)),
#  ('tdi.egr', 'not_applicable', ()),
#  ('tsi.chain', 'applies', ()),
#  ('tsi.oil', 'not_applicable', ())]

groups = assemble_v3(facts)            # the checklist, with only what can apply
[i["id"] for i in groups[-1]["children"][0]["items"]]
# ['defect.dsg.dq200', 'defect.tsi.chain']

served_id("m271.balanceshaft")         # a renamed v2 id -> its dossier
# 'm271.timingchain'
```

Facts use the API's names: `make`, `model`, `year`, `productionDate` (`YYYY-MM`), `fuel`,
`engineCode`, `engineFamily`, `gearbox` (`manual`/`automatic`/`dct`/`cvt`), `gearboxCode`, `cc`,
`powerKw`, `vin` (only its first three characters are used, for the make). `assemble_v3` keeps
the v2 item ids (`defect.<v2 id>`), so answers stored against the v2 checklist stay valid; a
`possible` item answered *not applicable* is simply a `-1`.

The package bundles the dictionary and the dossiers (`data/v3/vehicles.json`,
`data/v3/defects.json`, release 2026.10.1). The evidence and prevalence behind each dossier are
served by the free API: `https://api.elgarde.com/api/v1/defects/{id}`.

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
known weak point on a *model* — something worth checking — and is never a claim about any
individual car.

## Licence

Code MIT; the inspection data is [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) —
attribution to <https://elgarde.com/> is the only condition.

Source, the canon, and the conformance suite: <https://github.com/ElgardeCom/elgarde>
