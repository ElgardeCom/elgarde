<?php

declare(strict_types=1);

/*
 * The shared conformance suite. vectors.json is copied from
 * inspection-core/conformance/ by inspection-core/tools/sync_canon.py; every
 * port must pass exactly these vectors. A failure here means this port
 * disagrees with the canon, not that the vectors need updating.
 *
 * Deliberately dependency-free — run it with `php tests/conformance.php`, no
 * composer install required.
 */

use Elgarde\Inspection\Canon;
use Elgarde\Inspection\ConditionError;
use Elgarde\Inspection\DefectsCanon;
use Elgarde\Inspection\DefectsV3;
use Elgarde\Inspection\Inspection;
use Elgarde\Inspection\Scoring;

spl_autoload_register(static function (string $class): void {
    $prefix = 'Elgarde\\Inspection\\';
    if (!str_starts_with($class, $prefix)) {
        return;
    }
    $relative = substr($class, \strlen($prefix));
    $path = __DIR__ . '/../src/' . str_replace('\\', '/', $relative) . '.php';
    if (is_file($path)) {
        require_once $path;
    }
});

$vectors = json_decode(
    (string) file_get_contents(__DIR__ . '/vectors.json'),
    true,
    512,
    \JSON_THROW_ON_ERROR,
);
$tolerance = $vectors['notes']['tolerance'];

$failures = [];
$checks = 0;

function check(bool $condition, string $message): void
{
    global $failures, $checks;
    ++$checks;
    if (!$condition) {
        $failures[] = $message;
    }
}

function near(?float $actual, int|float|null $expected, string $message): void
{
    global $tolerance;
    if ($actual === null || $expected === null) {
        check($actual === $expected, sprintf(
            '%s: got %s, want %s',
            $message,
            var_export($actual, true),
            var_export($expected, true),
        ));

        return;
    }
    check(abs($actual - (float) $expected) <= $tolerance, sprintf(
        '%s: got %s, want %s',
        $message,
        $actual,
        $expected,
    ));
}

// --- scoring -----------------------------------------------------------------

foreach ($vectors['scoring'] as $vector) {
    $groups = $vectors['fixtures'][$vector['fixture']]['groups'];
    $scores = $vector['scores'];
    $expect = $vector['expect'];
    $name = $vector['name'];

    foreach ($expect['groupScores'] as $id => $want) {
        $group = null;
        foreach ($groups as $candidate) {
            if ($candidate['id'] === $id) {
                $group = $candidate;
            }
        }
        near(Scoring::groupScore($group, $scores), $want, "{$name} / {$id}");
    }

    near(
        Scoring::overallBeforeClamp($groups, $scores),
        $expect['overallBeforeClamp'],
        "{$name} / overallBeforeClamp",
    );
    near(Scoring::overall($groups, $scores), $expect['overall'], "{$name} / overall");
    check(
        Scoring::progress($groups, $scores) === $expect['progress'],
        "{$name} / progress",
    );
}

// --- assembly ----------------------------------------------------------------

foreach ($vectors['assembly'] as $vector) {
    $car = $vector['car'];
    $expect = $vector['expect'];
    $name = $vector['name'];

    $groups = Inspection::assemble($car['make'], $car['model'], $car['fuelType']);
    check(
        array_column($groups, 'id') === $expect['groupIds'],
        "{$name} / groupIds: " . implode(',', array_column($groups, 'id')),
    );
    check(
        \count(Inspection::allItems($groups)) === $expect['itemCount'],
        "{$name} / itemCount: " . \count(Inspection::allItems($groups)),
    );

    $rule = Inspection::matchDefectRule($car['make'], $car['model']);
    check(($rule['id'] ?? null) === $expect['defectRuleId'], "{$name} / defectRuleId");
}

// --- matching ----------------------------------------------------------------

foreach ($vectors['matching'] as $vector) {
    $rule = Inspection::matchDefectRule($vector['make'], $vector['model']);
    check(
        ($rule['id'] ?? null) === $vector['expect'],
        sprintf(
            'match %s/%s: got %s, want %s',
            (string) $vector['make'],
            (string) $vector['model'],
            var_export($rule['id'] ?? null, true),
            var_export($vector['expect'], true),
        ),
    );
}

// --- canon scoring -----------------------------------------------------------

foreach ($vectors['canonScoring'] as $vector) {
    $car = $vector['car'];
    $expect = $vector['expect'];
    $name = $vector['name'];

    $groups = Inspection::assemble($car['make'], $car['model'], $car['fuelType']);
    $scores = [];
    foreach (Inspection::allItems($groups) as $item) {
        $scores[$item['id']] = $vector['fillAll'];
    }
    foreach ($vector['override'] as $id => $score) {
        $scores[$id] = $score;
    }

    if (\array_key_exists('overallBeforeClamp', $expect)) {
        near(
            Scoring::overallBeforeClamp($groups, $scores),
            $expect['overallBeforeClamp'],
            "{$name} / overallBeforeClamp",
        );
    }
    near(Scoring::overall($groups, $scores), $expect['overall'], "{$name} / overall");
    check(Scoring::progress($groups, $scores) === $expect['progress'], "{$name} / progress");
}

// --- the packaged canon ------------------------------------------------------

check(
    Canon::checklist()['languages'] === ['en', 'pt', 'ru', 'uk', 'fr'],
    'packaged checklist carries all five languages',
);
check(
    Canon::version() === ['checklist' => 1, 'defects' => 2],
    'packaged canon version',
);
check(\count(Canon::defects()['rules']) >= 8, 'packaged defect rules');

$bmw = Inspection::assemble('BMW', '320d');
$defects = null;
foreach ($bmw as $group) {
    if ($group['id'] === 'defects') {
        $defects = $group;
    }
}
$prompt = $defects['children'][0]['items'][0]['prompt'];
$english = Canon::pick($prompt, 'en');
foreach (['pt', 'ru', 'uk', 'fr'] as $lang) {
    $translated = Canon::pick($prompt, $lang);
    check($translated !== $english, "defect text in {$lang} still falls back to English");
    check(str_contains($translated, 'N47'), "defect text in {$lang} lost the engine code");
}
check(Canon::pick($prompt, 'de') === $english, 'unsupported language falls back to English');

$golf = Inspection::assemble('Volkswagen', 'Golf', 'diesel');
$full = [];
foreach (Inspection::allItems($golf) as $item) {
    $full[$item['id']] = 5;
}
$full['docs.all.mileage'] = 1;
near(Scoring::overall($golf, $full), 1.0, 'the documented example holds');

// --- known defects v3 --------------------------------------------------------

/** @param list<\Elgarde\Inspection\Resolution> $list */
function resolutions(array $list): array
{
    return array_map(static fn ($r) => $r->toArray(), $list);
}

function show(mixed $value): string
{
    return json_encode($value, \JSON_UNESCAPED_UNICODE | \JSON_UNESCAPED_SLASHES);
}

function runV3(array $vectors, string $mode): void
{
    $fixtures = [];
    foreach ($vectors['v3Fixtures'] as $fixtureName => $fixture) {
        $fixtures[$fixtureName] = new DefectsCanon($fixture['vehicles'], $fixture['defects']);
    }
    $canonFor = static fn (array $v): ?DefectsCanon => isset($v['fixture']) ? $fixtures[$v['fixture']] : null;

    foreach ($vectors['resolveV3'] as $vector) {
        $got = resolutions(DefectsV3::resolveV3($vector['facts'], $canonFor($vector)));
        check($got === $vector['expect'], "[{$mode}] resolveV3 {$vector['name']}: got " . show($got));
    }

    foreach ($vectors['resolveDefect'] as $vector) {
        $got = DefectsV3::resolveDefect($vector['defectId'], $vector['facts'], $canonFor($vector));
        $got = $got?->toArray();
        check($got === $vector['expect'], "[{$mode}] resolveDefect {$vector['name']}: got " . show($got));
    }

    foreach ($vectors['v3Names'] as $vector) {
        $got = DefectsV3::resolvedModel($vector);
        check(
            $got === $vector['expect'],
            sprintf('[%s] v3Names %s/%s: got %s', $mode, show($vector['make']), show($vector['model']), show($got)),
        );
    }

    foreach ($vectors['v3ServedIds'] as $vector) {
        $got = DefectsV3::servedId($vector['id']);
        check($got === $vector['expect'], "[{$mode}] servedId '{$vector['id']}': got " . show($got));
    }

    foreach ($vectors['assembleV3'] as $vector) {
        $name = "[{$mode}] assembleV3 {$vector['name']}";
        $expect = $vector['expect'];
        $groups = DefectsV3::assembleV3($vector['facts']);
        check(
            array_column($groups, 'id') === $expect['groupIds'],
            "{$name} / groupIds: " . implode(',', array_column($groups, 'id')),
        );
        check(
            \count(Inspection::allItems($groups)) === $expect['itemCount'],
            "{$name} / itemCount: " . \count(Inspection::allItems($groups)),
        );
        $group = null;
        foreach ($groups as $candidate) {
            if ($candidate['id'] === 'defects') {
                $group = $candidate;
            }
        }
        if ($group === null) {
            check($expect['defectsTitle'] === null && $expect['defects'] === [], "{$name} / defects group missing");
            continue;
        }
        check($group['ruleId'] === $expect['defectRuleId'], "{$name} / ruleId: " . show($group['ruleId']));
        check(Canon::pick($group['title'], 'en') === $expect['defectsTitle'], "{$name} / title");
        $items = Inspection::allItems([$group]);
        $rows = [];
        foreach ($items as $item) {
            $rows[] = [
                'id' => $item['id'],
                'sourceDefectId' => $item['sourceDefectId'],
                'dossierId' => $item['dossierId'],
                'status' => $item['status'],
                'needs' => $item['needs'],
                'critical' => $item['critical'],
                'prompt' => Canon::pick($item['prompt'], 'en'),
                'hint' => $item['hint'] ? Canon::pick($item['hint'], 'en') : null,
            ];
        }
        check($rows === $expect['defects'], "{$name} / rows: " . show($rows));
        check(array_column($items, 'order') === range(0, \count($rows) - 1), "{$name} / orders");
    }

    // A `market` leaf is outside the closed condition language (format 3).
    $closed = new DefectsCanon($vectors['v3Fixtures']['synthetic']['vehicles'], [
        'format' => 3,
        'defects' => [[
            'id' => 'x',
            'status' => 'published',
            'applicability' => ['models' => ['testa.alpha'], 'when' => ['market' => ['EU']]],
        ]],
    ]);
    $raised = false;
    try {
        $closed->resolveV3(['make' => 'testa', 'model' => 'alpha']);
    } catch (ConditionError) {
        $raised = true;
    }
    check($raised, "[{$mode}] a market leaf raises ConditionError");

    // Decomposed input and compatibility characters fold like precomposed ones.
    check(DefectsV3::normalizeName("S\u{030C}KODA  Fa\u{0301}bia_Combi") === 'skoda fabia combi', "[{$mode}] normalizeName decomposed");
    check(DefectsV3::normalizeName("Citro\u{00EB}n\u{00A0}C-3 STRA\u{1E9E}E") === 'citroen c 3 strasse', "[{$mode}] normalizeName compat");
}

$modes = ['fallback' => false];
if (class_exists(\Normalizer::class) && class_exists(\IntlChar::class)) {
    $modes = ['intl' => true] + $modes;
} else {
    echo "ext-intl not available: testing the FoldTable fallback only.\n";
}
foreach ($modes as $mode => $intl) {
    DefectsCanon::useIntl($intl);
    runV3($vectors, $mode);
}
DefectsCanon::useIntl(null);

// The v3 API on the bundled canon.
$canonV3 = DefectsV3::canon();
check($canonV3->format() === 3, 'v3 canon format');
check(\count($canonV3->defectsById()) === 15, 'v3 canon serves 15 dossiers');
foreach (['dsg.dq200', 'n47.chain', 'puretech.wetbelt'] as $id) {
    check(isset($canonV3->defectsById()[$id]), "v3 canon serves {$id}");
}
check($canonV3->aliasOf() === ['m271.balanceshaft' => 'm271.timingchain'], 'v3 aliases');

$facts = ['make' => 'BMW', 'model' => '320d', 'year' => 2010];
check(
    resolutions(DefectsV3::resolveDefects($facts)) === resolutions(DefectsV3::resolveV3($facts)),
    'resolveDefects is resolveV3',
);
$n47 = DefectsV3::resolveDefect('n47.chain', ['make' => 'BMW', 'model' => '320d', 'engineCode' => 'n47d20', 'year' => 2010]);
check($n47 !== null && $n47->status === 'applies', 'n47.chain applies to an N47D20');

$golfV3 = DefectsV3::resolveDefects(['make' => 'VW', 'model' => 'Golf', 'gearbox' => 'manual', 'fuel' => 'diesel']);
check(
    $golfV3[0]->defectId === 'dsg.dq200' && $golfV3[0]->status === 'not_applicable',
    'the documented v3 example holds',
);

$cClass = DefectsV3::assembleV3(['make' => 'Mercedes-Benz', 'model' => 'C-Class']);
$rows = Inspection::localize($cClass, 'fr');
$rows = $rows[\count($rows) - 1]['children'][0]['items'];
$alias = null;
foreach ($rows as $row) {
    if (($row['sourceDefectId'] ?? null) === 'm271.balanceshaft') {
        $alias = $row;
    }
}
check($alias !== null && $alias['id'] === 'defect.m271.balanceshaft', 'localized alias row id');
check(($alias['dossierId'] ?? null) === 'm271.timingchain', 'localized alias row dossierId');
check(
    ($alias['status'] ?? null) === 'possible' && ($alias['needs'] ?? null) === ['year', 'engineCode'],
    'localized alias row status and needs',
);
check(\array_key_exists('hint', $alias ?? []), 'localized v3 rows carry a hint key');
$scores = [];
foreach (Inspection::allItems($cClass) as $item) {
    $scores[$item['id']] = 4;
}
$scores['defect.m271.balanceshaft'] = Canon::SCORE_NOT_APPLICABLE;
near(Scoring::overall($cClass, $scores), 4.0, 'a possible item answered not-applicable scores as -1');

// The v2 API is untouched by v3.
$v2 = Inspection::assemble('Mercedes-Benz', 'C-Class', 'petrol');
$v2Items = Inspection::allItems([$v2[\count($v2) - 1]]);
check(
    array_column($v2Items, 'sourceDefectId') === ['om651.injectors', 'm271.balanceshaft', 'rust'],
    'v2 C-Class defects unchanged',
);
$untouched = true;
foreach ($v2Items as $item) {
    $untouched = $untouched && !\array_key_exists('status', $item);
}
foreach (Inspection::localize($v2, 'en') as $group) {
    foreach ($group['children'] ?? [] as $child) {
        foreach ($child['items'] ?? [] as $item) {
            $untouched = $untouched && array_keys($item) === ['id', 'order', 'prompt', 'critical'];
        }
    }
}
check($untouched, 'v2 items carry no v3 fields, assembled or localized');

// --- report ------------------------------------------------------------------

if ($failures !== []) {
    echo 'FAILED (' . \count($failures) . " of {$checks} checks):\n";
    foreach ($failures as $failure) {
        echo "  - {$failure}\n";
    }
    exit(1);
}

echo "All {$checks} conformance checks passed.\n";
