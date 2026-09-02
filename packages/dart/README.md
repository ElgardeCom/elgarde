# elgarde_inspection

A structured **pre-purchase used-car inspection** for Dart and Flutter: a multilingual checklist
that adapts to the car, curated model-specific known defects, and 1–5 scoring with a critical
clamp.

No dependencies and no network — the canon is compiled into the package, so it works offline, on
device, in a `flutter test`, or in a server-side Dart process.

```yaml
dependencies:
  elgarde_inspection: ^1.0.0
```

## Use

```dart
import 'package:elgarde_inspection/elgarde_inspection.dart';

final groups = assemble(
  const Car(make: 'Volkswagen', model: 'Golf', fuelType: 'diesel'),
);

groups.map((g) => g.id).toList();
// [ext, int, eng, road, docs, fuel.diesel, defects]

allItems(groups).length; // 33
```

The checklist is assembled per car: base groups for everything, a fuel module (DPF and glow plugs
for a diesel, state-of-health and charging for an EV), and the model's documented weak points when
one is curated — the DQ200 dry clutch, the PureTech wet timing belt, the N47 chain.

## Show it

Every title and prompt is a `LocalizedText`, authored in **English, Portuguese, Russian,
Ukrainian and French** — `resolve` falls back to English for anything missing.

```dart
for (final group in groups) {
  print(group.title.resolve('pt'));
  for (final child in group.children) {
    for (final item in child.items) {
      print('  ${item.prompt.resolve('pt')}${item.critical ? ' (crítico)' : ''}');
    }
  }
}
```

## Score it

Answers are `1`–`5`, or `kScoreNotApplicable` (-1) and `kScoreNotInspected` (-2). An absent key is
unanswered.

```dart
final scores = <String, int?>{for (final item in allItems(groups)) item.id: 5};
scores['docs.all.mileage'] = 1; // odometer does not match the records

overall(groups, scores);        // 1.0
progress(groups, scores);       // (33, 33)
```

The plain average was 4.86. A **critical** item scoring at or below 2 clamps the verdict down to
it: a car with good averages and a failed safety or provenance check is not a good car. The clamp
only ever lowers the verdict, and an unanswered critical item has no effect.

Groups roll up by `ScoreAggregation.average`, `.weighted` (using `item.weight`) or `.worstCase`.
The algorithm is written out in
[`spec/SCORING.md`](https://github.com/ElgardeCom/elgarde/blob/main/inspection-core/spec/SCORING.md),
and this package passes the same conformance vectors as the Python, JavaScript and PHP ports.

## Just the defects

```dart
final rule = matchDefectRule('Peugeot', '208');
rule?.defects.map((d) => d.id).toList();
// [puretech.wetbelt, ep6.chain, hdi.turbo]
```

`null` means nothing is curated for that model yet — **not** that the model is trouble-free.

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
known weak point on a *model*, never a claim about an individual car.

## Licence

Code MIT; the inspection data is [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) —
attribution to <https://elgarde.com/> is the only condition.

Source and conformance suite: <https://github.com/ElgardeCom/elgarde>
