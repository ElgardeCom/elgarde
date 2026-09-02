# elgarde-inspection

Everything you should check before buying a used car, as data you can ship: a **multilingual
inspection checklist**, **curated model-specific known defects**, and the 1–5 scoring rules that
turn answers into one verdict.

Zero dependencies. No network, no API key, no configuration — the data lives inside the package.
It is the same canon behind the [Elgarde](https://elgarde.com/) app and its
[free API](https://elgarde.com/api/), and it passes the same conformance vectors as every other
port.

```bash
npm install elgarde-inspection
```

## Use

```js
import { assemble, allItems, localize, overall, progress } from 'elgarde-inspection';

const groups = assemble({ make: 'Volkswagen', model: 'Golf', fuelType: 'diesel' });

groups.map((g) => g.id);
// ['ext', 'int', 'eng', 'road', 'docs', 'fuel.diesel', 'defects']

allItems(groups).length;
// 33 — 25 base items, 3 diesel-specific, 5 known VAG weak points
```

The checklist adapts to the car. A diesel gets DPF and glow-plug items, an EV gets
state-of-health and charging items, and a recognised model gets its documented weak points: the
DQ200 dry clutch, the PureTech wet timing belt, the N47 chain.

### Render it in one language

```js
for (const group of localize(groups, 'pt')) {
  console.log(group.title);
  for (const child of group.children ?? []) {
    for (const item of child.items ?? []) {
      console.log('  ', item.prompt, item.critical ? '(critical)' : '');
    }
  }
}
```

Checklist content is authored in **English, Portuguese, Russian, Ukrainian and French**; defect
text in English and Portuguese, falling back to English.

### Score it

Answers are `1`–`5`, or `-1` for *not applicable* and `-2` for *not inspected*. Leave an item out
and it counts as unanswered.

```js
const scores = Object.fromEntries(allItems(groups).map((i) => [i.id, 5]));
scores['docs.all.mileage'] = 1;  // odometer does not match the records

overall(groups, scores);   // 1
progress(groups, scores);  // [33, 33]
```

The plain average was 4.86. A **critical** item scoring 2 or below clamps the verdict down to it,
because a car with good averages and a failed safety or provenance check is not a good car. The
clamp only ever lowers the result, and an unanswered critical item does nothing.

Groups roll up by `average`, `weighted` (using `item.weight`) or `worst_case`. The algorithm is
written out in
[`spec/SCORING.md`](https://github.com/ElgardeCom/elgarde/blob/main/inspection-core/spec/SCORING.md).

### Only the known defects

```js
import { matchDefectRule } from 'elgarde-inspection';

matchDefectRule('Peugeot', '208').defects.map((d) => d.id);
// ['puretech.wetbelt', 'ep6.chain', 'hdi.turbo']
```

`null` means nothing is curated for that model yet — **not** that the model is trouble-free.

TypeScript types ship with the package. The raw canon is importable too:
`elgarde-inspection/data/checklist.json`.

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
known weak point on a *model* — never a claim about an individual car.

## Licence

Code MIT; the inspection data is [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) —
attribution to <https://elgarde.com/> is the only condition.

Source and conformance suite: <https://github.com/ElgardeCom/elgarde>
