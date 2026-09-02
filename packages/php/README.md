# elgarde/inspection

Pre-purchase used-car inspection for PHP: a **multilingual checklist** that adapts to the car,
**curated model-specific known defects**, and 1–5 scoring with a critical clamp.

No dependencies beyond `ext-json` and `ext-mbstring`, and no network calls — the canon ships as
JSON inside the package. Useful anywhere a listing, a dealer site or a WordPress plugin needs a
real inspection checklist rather than a hand-written one.

```bash
composer require elgarde/inspection
```

## Use

```php
use Elgarde\Inspection\Inspection;
use Elgarde\Inspection\Scoring;

$groups = Inspection::assemble('Volkswagen', 'Golf', 'diesel');

array_column($groups, 'id');
// ['ext', 'int', 'eng', 'road', 'docs', 'fuel.diesel', 'defects']

count(Inspection::allItems($groups)); // 33
```

Base groups apply to every car; a fuel module adds what that drivetrain needs (DPF and glow plugs
for a diesel, state-of-health and charging for an EV); a recognised model adds its documented weak
points — the DQ200 dry clutch, the PureTech wet timing belt, the N47 chain.

Groups and items are plain arrays in the canon's own shape, identical to what the
[Elgarde API](https://elgarde.com/api/) returns.

## Render one language

```php
foreach (Inspection::localize($groups, 'pt') as $group) {
    echo $group['title'], "\n";
    foreach ($group['children'] ?? [] as $child) {
        foreach ($child['items'] ?? [] as $item) {
            echo '  ', $item['prompt'], $item['critical'] ? ' (crítico)' : '', "\n";
        }
    }
}
```

Checklist content is authored in **English, Portuguese, Russian, Ukrainian and French**; defect
text in English and Portuguese, falling back to English.

## Score

Answers are `1`–`5`, or `-1` for not applicable and `-2` for not inspected.

```php
$scores = [];
foreach (Inspection::allItems($groups) as $item) {
    $scores[$item['id']] = 5;
}
$scores['docs.all.mileage'] = 1; // odometer does not match the records

Scoring::overall($groups, $scores);   // 1.0
Scoring::progress($groups, $scores);  // [33, 33]
```

The plain average was 4.86. A **critical** item scoring at or below 2 clamps the verdict down to
it — good averages do not redeem a failed safety or provenance check. The clamp only ever lowers
the verdict.

The algorithm is written out in
[`spec/SCORING.md`](https://github.com/ElgardeCom/elgarde/blob/main/inspection-core/spec/SCORING.md),
and this package passes the same conformance vectors as the Python, Dart and JavaScript ports.

## Just the defects

```php
$rule = Inspection::matchDefectRule('Peugeot', '208');
array_column($rule['defects'], 'id');
// ['puretech.wetbelt', 'ep6.chain', 'hdi.turbo']
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
