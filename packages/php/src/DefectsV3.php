<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * Known defects v3 over the canon bundled with this package.
 *
 * Given the facts known about a car, says for every curated dossier on its
 * model whether it `applies`, is `possible` (and which facts would settle
 * it), or is `not_applicable` (and which facts ruled it out). The data ships
 * in `data/v3/` (vehicles + defects), copied from `inspection-core/data/v3/`
 * by `inspection-core/tools/sync_canon.py`; never edit it by hand.
 *
 * Every method takes an optional {@see DefectsCanon} to run against other
 * data instead of the bundled release.
 */
final class DefectsV3
{
    /** Query-parameter names in the order `needs` and `excludedBy` list them. */
    public const NEEDS_ORDER = [
        'model',
        'year',
        'fuel',
        'gearbox',
        'gearboxCode',
        'engineCode',
        'productionDate',
    ];

    /** The coarse gearbox answers a buyer can give. */
    public const GEARBOX_COARSE = ['manual', 'automatic', 'dct', 'cvt'];

    /** @var list<string> */
    public const STATUSES = ['applies', 'possible', 'not_applicable'];

    /** @var list<string> */
    public const FUEL_TYPES = ['petrol', 'diesel', 'hybrid', 'ev', 'other'];

    /** Title of the assembled `defects` group when no v2 rule matched the car. */
    public const KNOWN_DEFECTS_TITLE = [
        'en' => 'Known defects',
        'pt' => 'Defeitos conhecidos',
        'ru' => 'Известные дефекты',
        'uk' => 'Відомі дефекти',
        'fr' => 'Défauts connus',
    ];

    private static ?DefectsCanon $canon = null;

    /** The bundled v3 canon, parsed and indexed once. */
    public static function canon(): DefectsCanon
    {
        return self::$canon ??= DefectsCanon::fromDirectory(\dirname(__DIR__) . '/data/v3');
    }

    /**
     * Every published dossier on the car's model, resolved against the facts,
     * in id order. Empty when the model is not recognised.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<Resolution>
     */
    public static function resolveDefects(array $facts, ?DefectsCanon $canon = null): array
    {
        return ($canon ?? self::canon())->resolveDefects($facts);
    }

    /**
     * Same as {@see resolveDefects()}.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<Resolution>
     */
    public static function resolveV3(array $facts, ?DefectsCanon $canon = null): array
    {
        return ($canon ?? self::canon())->resolveDefects($facts);
    }

    /**
     * One dossier resolved against the facts; null if no published dossier
     * has that id. Old ids are not followed — map them with {@see servedId()}.
     *
     * @param array<string, mixed> $facts
     */
    public static function resolveDefect(string $defectId, array $facts, ?DefectsCanon $canon = null): ?Resolution
    {
        return ($canon ?? self::canon())->resolveDefect($defectId, $facts);
    }

    /**
     * The served dossier id for a defect id, following `aliases`; null for a
     * deprecated or unknown id.
     */
    public static function servedId(string $defectId, ?DefectsCanon $canon = null): ?string
    {
        return ($canon ?? self::canon())->servedId($defectId);
    }

    /**
     * The checklist for a car described by facts; see
     * {@see DefectsCanon::assembleV3()}.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<array<string, mixed>>
     */
    public static function assembleV3(array $facts, ?DefectsCanon $canon = null): array
    {
        return ($canon ?? self::canon())->assembleV3($facts);
    }

    /**
     * The dictionary's make id and model id for the facts, or null.
     *
     * @param array<string, mixed> $facts
     *
     * @return array{make: ?string, model: ?string}
     */
    public static function resolvedModel(array $facts, ?DefectsCanon $canon = null): array
    {
        return ($canon ?? self::canon())->resolvedModel($facts);
    }

    /** casefold -> strip diacritics -> '-' and '_' to spaces -> collapse whitespace. */
    public static function normalizeName(?string $s): string
    {
        return DefectsCanon::normalizeName($s);
    }

    public static function normalizeMake(?string $s, ?DefectsCanon $canon = null): ?string
    {
        return ($canon ?? self::canon())->normalizeMake($s);
    }

    public static function normalizeModel(?string $makeId, ?string $s, ?DefectsCanon $canon = null): ?string
    {
        return ($canon ?? self::canon())->normalizeModel($makeId, $s);
    }

    /** The make id for a VIN's world manufacturer identifier, offline. */
    public static function makeFromWmi(?string $vin, ?DefectsCanon $canon = null): ?string
    {
        return ($canon ?? self::canon())->makeFromWmi($vin);
    }
}
