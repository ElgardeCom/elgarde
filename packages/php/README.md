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

Checklist content and defect text are authored in **English, Portuguese, Russian, Ukrainian and
French**; any other language falls back to English.

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

## Known defects v3

The v2 rules above match on make and model only. Known defects v3 also looks at what you know
about the particular car — year, build date, fuel, engine code, gearbox — and says, for every
sourced dossier on that model, whether it `applies`, is `possible` (and which facts would settle
it), or is `not_applicable` (and which facts ruled it out). Unknown is never rounded down to "not
applicable".

```php
use Elgarde\Inspection\DefectsV3;

$facts = ['make' => 'VW', 'model' => 'Golf', 'gearbox' => 'manual', 'fuel' => 'diesel'];

foreach (DefectsV3::resolveDefects($facts) as $r) {
    echo $r->defectId, ' ', $r->status, ' ', implode(',', $r->needs ?: $r->excludedBy), "\n";
}
// dsg.dq200 not_applicable gearbox
// tdi.egr possible year,engineCode
// tsi.chain not_applicable fuel
// tsi.oil not_applicable fuel

DefectsV3::resolveDefect('dsg.dq200', ['make' => 'VW', 'model' => 'Golf', 'gearboxCode' => '0am'])
    ->status;                                // 'applies'
DefectsV3::servedId('m271.balanceshaft');    // 'm271.timingchain' (renamed dossier)
```

Facts use the API's names — `make`, `model`, `year`, `productionDate` (`YYYY-MM`), `fuel`,
`engineCode`, `engineFamily`, `gearbox`, `gearboxCode`, `cc`, `powerKw`, `vin` — and all are
optional. A VIN is used offline for its first three characters only, to find the make. Each
result is a `Resolution` (`toArray()` gives the API's JSON shape).

`DefectsV3::assembleV3($facts)` builds the whole checklist from facts: the v2 rule's rows first
(same ids, so stored answers stay valid), minus those that do not apply, then every other dossier
that applies or is possible. Items also carry `status`, `needs`, `dossierId` and `hint`, which
`Inspection::localize()` passes through.

The package bundles the dossiers' applicability, prompts and hints. Their sources, evidence and
prevalence are served by the free API: `https://api.elgarde.com/api/v1/defects/{id}`. Name
matching folds case and accents with `ext-intl` when it is installed, and with a bundled table
when it is not.

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
known weak point on a *model*, never a claim about an individual car.

## Licence

Code MIT; the inspection data is [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) —
attribution to <https://elgarde.com/> is the only condition.

Source and conformance suite: <https://github.com/ElgardeCom/elgarde>
