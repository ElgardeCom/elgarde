<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * The inspection canon: checklist content and defect rules.
 *
 * The data ships with the package as JSON, copied from `inspection-core/data/`
 * by `inspection-core/tools/sync_canon.py`. Never edit those files by hand.
 */
final class Canon
{
    /** Not applicable — the item does not apply to this car. */
    public const SCORE_NOT_APPLICABLE = -1;

    /** Not inspected — the inspector explicitly skipped it. */
    public const SCORE_NOT_INSPECTED = -2;

    /** A critical item at or below this score clamps the overall verdict. */
    public const CRITICAL_THRESHOLD = 2;

    /** @var list<string> */
    public const FUEL_TYPES = ['petrol', 'diesel', 'hybrid', 'ev', 'other'];

    /** @var array<string, mixed>|null */
    private static ?array $checklist = null;

    /** @var array<string, mixed>|null */
    private static ?array $defects = null;

    /** @return array<string, mixed> */
    public static function checklist(): array
    {
        return self::$checklist ??= self::read('checklist');
    }

    /** @return array<string, mixed> */
    public static function defects(): array
    {
        return self::$defects ??= self::read('defects');
    }

    /** @return array{checklist: int, defects: int} */
    public static function version(): array
    {
        return [
            'checklist' => self::checklist()['version'],
            'defects' => self::defects()['version'],
        ];
    }

    /**
     * One language out of a `{lang: text}` map, falling back to English.
     *
     * @param array<string, string> $text
     */
    public static function pick(array $text, string $lang): string
    {
        return $text[$lang] ?? $text['en'] ?? (reset($text) ?: '');
    }

    /** @return array<string, mixed> */
    private static function read(string $name): array
    {
        $path = \dirname(__DIR__) . "/data/{$name}.json";
        $raw = file_get_contents($path);
        if ($raw === false) {
            throw new \RuntimeException("Canon file missing: {$path}");
        }

        /** @var array<string, mixed> $decoded */
        $decoded = json_decode($raw, true, 512, \JSON_THROW_ON_ERROR);

        return $decoded;
    }
}
