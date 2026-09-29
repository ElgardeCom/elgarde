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

// --- report ------------------------------------------------------------------

if ($failures !== []) {
    echo 'FAILED (' . \count($failures) . " of {$checks} checks):\n";
    foreach ($failures as $failure) {
        echo "  - {$failure}\n";
    }
    exit(1);
}

echo "All {$checks} conformance checks passed.\n";
