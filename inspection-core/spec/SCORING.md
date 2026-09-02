# Elgarde inspection scoring — specification

Canonical, implementation-neutral description of how an Elgarde inspection turns individual
answers into group scores and one overall verdict. Every port must reproduce this exactly and
must pass [`conformance/vectors.json`](../conformance/vectors.json).

## Answers

Each checklist item is answered with one of:

| Value | Meaning |
|---|---|
| `1`–`5` | A real rating. 1 = worst, 5 = best. Only these feed any rollup. |
| `-1` | **Not applicable** — the item does not apply to this car. |
| `-2` | **Not inspected** — the inspector explicitly skipped it. |
| absent / `null` | Untouched. |

`-1` and `-2` are deliberately negative so a numeric rollup can exclude them with a single
`score > 0` test. An item is *answered* (for progress) when its value is present at all,
including the two sentinels; it is *real* only when it is `1`–`5`.

## Group score

A group's score is derived from its **direct items** (real scores only) plus the scores of its
**child groups** (each child contributing its own rolled-up score with weight `1`). A group with
nothing real underneath it scores `null` and is excluded from everything above it.

The combination depends on the group's `aggregation`:

| `aggregation` | Result |
|---|---|
| `average` (default) | Arithmetic mean of the contributions. |
| `weighted` | `Σ(value × weight) / Σ(weight)`; items use `item.weight` (default `1.0`), child groups use `1`. If `Σ(weight)` is `0`, the result is `0`. |
| `worst_case` | The single lowest contribution. |

Child-group contributions carry weight `1` even under `weighted`: a subsection counts once,
regardless of how many items it holds.

## Overall verdict

1. Take the score of every **top-level** group; drop the `null`s. If none remain, the overall
   verdict is `null`.
2. The verdict starts as the arithmetic mean of those top-level scores.
3. **Critical clamp.** For every item marked `critical` anywhere in the tree, if it has a real
   score `s` with `s <= criticalThreshold` (default `2`) and `s < verdict`, the verdict is
   lowered to `s`.

The clamp is what stops a car with good averages and one failed safety item from reading as
healthy. It only ever lowers the verdict, never raises it, and an unanswered critical item has
no effect.

## Progress

`progress` counts, over all leaf items in the assembled checklist, how many have any value
present (sentinels included) against the total number of items. It is a completion indicator,
not a score.

## Checklist assembly

The checklist for a car is assembled in this order:

1. every top-level group of `data/checklist.json` → `base`, in `order`;
2. the fuel module `modules.fuel[<fuelType>]`, when the car's fuel type is one of
   `petrol` · `diesel` · `hybrid` · `ev` (`other` and unknown add nothing);
3. the model-defect group, when a rule in `data/defects.json` matches (see below).

## Defect rule matching

`data/defects.json` holds an **ordered** list of rules; the **first** match wins and no more than
one defect group is ever appended. Make and model are compared lowercased.

A rule matches when **any** of its `match` clauses matches. A clause matches when:

- the make contains any string in `makeAny`, **and**
- if the clause has `modelAny`, the model contains any string in it.

Matching is skipped entirely when both make and model are empty.

The matched rule becomes one top-level group (`id: "defects"`, `order: 6`) holding a single child
group (`id: "defects.g"`) whose items are the rule's defects in order, with:

- item id = `defect.<defect.id>`,
- `sourceDefectId` = `<defect.id>` (provenance back to the defect record),
- `critical` copied from the defect,
- prompt = the defect text (`en` and `pt` only — other languages fall back to `en`).

### One documented divergence

The original Dart matcher tests the Volkswagen make as `make == 'vw'` (exact) while testing every
other brand token with `contains`. The canon uses `contains` uniformly. No realistic make string
distinguishes the two, and uniformity is what keeps the ports honest.

## Localisation

Every title and prompt is a `{lang: text}` map. Checklist content carries `en`, `pt`, `ru`, `uk`,
`fr`; defect text carries `en` and `pt`. A consumer asking for a language that is absent falls
back to `en`.
