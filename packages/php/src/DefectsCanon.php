<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * Known defects v3: `vehicles.json` + `defects.json` (format 3), indexed for
 * resolving which curated weak points apply to one particular car.
 *
 * A v3 dossier names the models it concerns and, optionally, a `when`
 * condition over the powertrain and the build date. Conditions are evaluated
 * in three-valued (Kleene) logic: true, false or unknown. Unknown is never
 * rounded down to "not applicable" — a false "possible" costs the buyer one
 * question, a false "not applicable" can cost them an engine.
 *
 * Only dossiers whose `status` is `published` are served. Use
 * {@see DefectsV3} for the canon bundled with this package; construct this
 * class directly for your own data (fixtures, a newer release).
 *
 * Facts are arrays with the API's camelCase names: make, model, year,
 * productionDate ("YYYY-MM"), fuel, engineCode, engineFamily, gearbox,
 * gearboxCode, cc, powerKw, vin. Every key is optional; an empty string
 * counts as absent. A VIN is only used for its first three characters (the
 * WMI), to find the make when none is given.
 */
final class DefectsCanon
{
    /** Closed gearbox.type enum -> the coarse answers that describe it. */
    private const GEARBOX_TYPE_COARSE = [
        'manual' => ['manual'],
        'automatic_tc' => ['automatic'],
        'cvt' => ['automatic', 'cvt'],
        'dct_dry' => ['automatic', 'dct'],
        'dct_wet' => ['automatic', 'dct'],
        'amt' => ['automatic'],
        'single_speed_ev' => ['automatic'],
    ];

    private const CC_TOLERANCE = 50;

    private const KW_TOLERANCE = 3;

    /**
     * Fuel facts that say which engine is fitted. A hybrid runs a petrol or
     * diesel engine and "other" is mostly LPG/CNG conversions of petrol
     * engines, so neither may rule an engine out.
     */
    private const ENGINE_FUELS = ['petrol', 'diesel', 'ev'];

    /** The characters Python's str.isspace() accepts, for split/strip parity. */
    private const WHITESPACE = '[\t\n\x0B\f\r\x1C-\x1F \x{85}\x{A0}\x{1680}\x{2000}-\x{200A}\x{2028}\x{2029}\x{202F}\x{205F}\x{3000}]';

    /** Combining marks dropped by the fallback fold (no ext-intl). */
    private const COMBINING = '/[\x{0300}-\x{036F}\x{0483}-\x{0489}\x{0591}-\x{05BD}\x{1AB0}-\x{1AFF}\x{1DC0}-\x{1DFF}\x{20D0}-\x{20FF}\x{FE20}-\x{FE2F}]/u';

    /** null = detect ext-intl; true/false forces it (tests only). */
    private static ?bool $intl = null;

    /** @var array<string, string> */
    private static array $nameCache = [];

    /** @var array<string, array<string, mixed>> served (published) dossiers by id */
    private array $defectsById = [];

    /** @var array<string, string> old id -> served dossier id */
    private array $aliasOf = [];

    /** @var list<array<string, mixed>> */
    private array $makes;

    /** @var list<array<string, mixed>> */
    private array $models;

    /** @var array<string, array<string, mixed>> */
    private array $modelsById = [];

    /** @var array<string, list<array<string, mixed>>> */
    private array $generationsByModel = [];

    /** @var array<string, list<array<string, mixed>>> */
    private array $fitmentsByGeneration = [];

    /** @var list<array<string, mixed>> */
    private array $engines;

    /** @var list<array<string, mixed>> */
    private array $gearboxes;

    /** @var array<string, array<string, mixed>> */
    private array $enginesById = [];

    /** @var array<string, array<string, mixed>> */
    private array $gearboxesById = [];

    /** @var array<string, array<string, mixed>> */
    private array $enginesByCode = [];

    /** @var array<string, array<string, mixed>> */
    private array $gearboxesByCode = [];

    /** @var array<string, true> */
    private array $engineFamilies = [];

    /**
     * @param array<string, mixed> $vehicles the parsed `vehicles.json`
     * @param array<string, mixed> $defects  the parsed `defects.json`
     */
    public function __construct(
        private readonly array $vehicles,
        private readonly array $defects,
    ) {
        foreach ($defects['defects'] ?? [] as $d) {
            if (($d['status'] ?? null) === 'published') {
                $this->defectsById[$d['id']] = $d;
            }
        }
        // Old id -> served id, from the `aliases` of served dossiers: a renamed
        // defect keeps its old id (stored `defect.<old id>` answers and the v2
        // rules still use it) and reaches the new dossier.
        foreach ($this->defectsById as $d) {
            foreach ($d['aliases'] ?? [] as $alias) {
                if (!isset($this->defectsById[$alias])) {
                    $this->aliasOf[$alias] = $d['id'];
                }
            }
        }

        $this->makes = array_values($vehicles['makes'] ?? []);
        $this->models = array_values($vehicles['models'] ?? []);
        foreach ($this->models as $m) {
            $this->modelsById[$m['id']] = $m;
        }
        foreach ($vehicles['generations'] ?? [] as $g) {
            $this->generationsByModel[(string) ($g['model'] ?? '')][] = $g;
        }
        foreach ($vehicles['fitments'] ?? [] as $f) {
            $this->fitmentsByGeneration[$f['generation']][] = $f;
        }
        $this->engines = array_values($vehicles['engines'] ?? []);
        $this->gearboxes = array_values($vehicles['gearboxes'] ?? []);
        foreach ($this->engines as $e) {
            $this->enginesById[$e['id']] = $e;
            // Later entries win on a duplicated code, as in the reference.
            foreach ($e['codes'] ?? [] as $c) {
                $this->enginesByCode[mb_strtoupper($c)] = $e;
            }
            $family = self::family($e);
            if ($family !== '') {
                $this->engineFamilies[$family] = true;
            }
        }
        foreach ($this->gearboxes as $g) {
            $this->gearboxesById[$g['id']] = $g;
            foreach ($g['codes'] ?? [] as $c) {
                $this->gearboxesByCode[mb_strtoupper($c)] = $g;
            }
        }
    }

    /**
     * @param array<string, mixed> $vehicles
     * @param array<string, mixed> $defects
     */
    public static function fromData(array $vehicles, array $defects): self
    {
        return new self($vehicles, $defects);
    }

    /** Read `vehicles.json` and `defects.json` from a directory. */
    public static function fromDirectory(string $dir): self
    {
        return new self(self::readJson("{$dir}/vehicles.json"), self::readJson("{$dir}/defects.json"));
    }

    public function format(): int
    {
        return (int) ($this->defects['format'] ?? 3);
    }

    /** @return array<string, mixed> */
    public function questions(): array
    {
        return $this->defects['questions'] ?? [];
    }

    /** @return array<string, mixed> the raw `vehicles.json` */
    public function vehicles(): array
    {
        return $this->vehicles;
    }

    /**
     * Served (published) dossiers by id.
     *
     * @return array<string, array<string, mixed>>
     */
    public function defectsById(): array
    {
        return $this->defectsById;
    }

    /**
     * Old (aliased) defect id -> served dossier id.
     *
     * @return array<string, string>
     */
    public function aliasOf(): array
    {
        return $this->aliasOf;
    }

    /**
     * The served dossier id for a defect id: itself when it is a published
     * dossier, the dossier that lists it in `aliases` when it was renamed,
     * else null (deprecated or unknown).
     */
    public function servedId(string $defectId): ?string
    {
        if (isset($this->defectsById[$defectId])) {
            return (string) $this->defectsById[$defectId]['id'];
        }

        return $this->aliasOf[$defectId] ?? null;
    }

    // --- names ---------------------------------------------------------------

    /** casefold -> strip diacritics -> '-' and '_' to spaces -> collapse whitespace. */
    public static function normalizeName(?string $s): string
    {
        if ($s === null || $s === '') {
            return '';
        }
        $intl = self::$intl ?? (class_exists(\Normalizer::class) && class_exists(\IntlChar::class));
        $key = ($intl ? 'i' : 'f') . $s;
        if (isset(self::$nameCache[$key])) {
            return self::$nameCache[$key];
        }

        if (preg_match('/[^\x00-\x7F]/', $s) !== 1) {
            $folded = strtolower($s); // ASCII: casefold is lower, NFKD a no-op
        } elseif ($intl) {
            $folded = self::foldIntl($s);
        } else {
            $folded = self::foldTable($s);
        }
        $folded = str_replace(['-', '_'], ' ', $folded);
        $parts = preg_split('/' . self::WHITESPACE . '+/u', $folded, -1, \PREG_SPLIT_NO_EMPTY);
        $out = implode(' ', $parts === false ? [] : $parts);

        if (\count(self::$nameCache) >= 4096) {
            self::$nameCache = [];
        }

        return self::$nameCache[$key] = $out;
    }

    /**
     * Force (true) or forbid (false) the ext-intl fold, or detect it (null).
     * Only for testing that both paths agree.
     *
     * @internal
     */
    public static function useIntl(?bool $enabled): void
    {
        self::$intl = $enabled;
        self::$nameCache = [];
    }

    public function normalizeMake(?string $s): ?string
    {
        $value = self::normalizeName($s);
        if ($value === '') {
            return null;
        }
        foreach ($this->makes as $make) {
            if (self::nameMatches($value, [...($make['names'] ?? []), $make['id']])) {
                return (string) $make['id'];
            }
        }

        return null;
    }

    public function normalizeModel(?string $makeId, ?string $s): ?string
    {
        $value = self::normalizeName($s);
        if ($makeId === null || $makeId === '' || $value === '') {
            return null;
        }
        foreach ($this->models as $model) {
            if (($model['make'] ?? null) !== $makeId) {
                continue;
            }
            if (self::nameMatches($value, $model['excludeNames'] ?? [])) {
                continue;
            }
            if (self::nameMatches($value, $model['names'] ?? [])) {
                return (string) $model['id'];
            }
        }

        return null;
    }

    /** The make id for a VIN's world manufacturer identifier, offline. */
    public function makeFromWmi(?string $vin): ?string
    {
        $wmi = mb_substr(mb_strtoupper(self::strip($vin ?? '')), 0, 3);
        if ($wmi === '') {
            return null;
        }
        foreach ($this->makes as $make) {
            if (\in_array($wmi, self::upperList($make['wmi'] ?? null), true)) {
                return (string) $make['id'];
            }
        }

        return null;
    }

    /**
     * The make id and model id as the dictionary understands them.
     *
     * @param array<string, mixed> $facts
     *
     * @return array{make: ?string, model: ?string}
     */
    public function resolvedModel(array $facts): array
    {
        $f = $this->prepare($facts);
        $makeId = $this->normalizeMake($f['make']);

        return ['make' => $makeId, 'model' => $this->normalizeModel($makeId, $f['model'])];
    }

    // --- resolving -------------------------------------------------------------

    /**
     * Status of one served dossier for these facts; null if there is no
     * published dossier with that id (aliases are not followed — see servedId).
     *
     * @param array<string, mixed> $facts
     */
    public function resolveDefect(string $defectId, array $facts): ?Resolution
    {
        $defect = $this->defectsById[$defectId] ?? null;
        if ($defect === null) {
            return null;
        }

        return $this->resolveOne($defect, $this->context($this->prepare($facts)));
    }

    /**
     * Every served dossier whose `applicability.models` contains the car's
     * model, in id order. Empty when the model is not recognised.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<Resolution>
     */
    public function resolveDefects(array $facts): array
    {
        $ctx = $this->context($this->prepare($facts));
        if ($ctx['modelId'] === null) {
            return [];
        }
        $out = [];
        foreach ($this->sortedDossiers() as $d) {
            if (\in_array($ctx['modelId'], $d['applicability']['models'] ?? [], true)) {
                $out[] = $this->resolveOne($d, $ctx);
            }
        }

        return $out;
    }

    /**
     * Same as {@see resolveDefects()}.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<Resolution>
     */
    public function resolveV3(array $facts): array
    {
        return $this->resolveDefects($facts);
    }

    /**
     * The checklist for a car described by facts: the base groups, the fuel
     * module for `facts['fuel']`, and a `defects` group built the way
     * `GET /v1/defects` builds its list when facts are given.
     *
     * The v2 rule's rows come first, in rule order, keeping their v2 id
     * (`defect.<v2 id>`), text and critical flag so stored answers stay valid.
     * Each is linked to its served dossier (itself, or the dossier that lists
     * it in `aliases`) and dropped when that dossier is `not_applicable`; a row
     * with no dossier stays, with status `legacy`. Then every other dossier on
     * the model that applies or is possible, in id order. Items carry
     * `status`, `needs`, `dossierId` and `hint` on top of the v2 item fields;
     * the group carries the matched v2 `ruleId`. No defects group when it
     * would be empty.
     *
     * @param array<string, mixed> $facts
     *
     * @return list<array<string, mixed>>
     */
    public function assembleV3(array $facts): array
    {
        $checklist = Canon::checklist();

        /** @var list<array<string, mixed>> $groups */
        $groups = array_values($checklist['base']);
        $f = $this->prepare($facts);
        $module = $checklist['modules']['fuel'][(string) ($f['fuel'] ?? '')] ?? null;
        if ($module !== null) {
            $groups[] = $module;
        }

        $rule = Inspection::matchDefectRule($f['make'], $f['model']);
        $rawMake = $facts['make'] ?? null;
        if ($rule === null && ($rawMake === null || $rawMake === '') && $f['make'] !== null) {
            // A make id from the VIN's WMI, spelled the way v2 rules expect.
            $names = [];
            foreach ($this->makes as $m) {
                if ($m['id'] === $f['make']) {
                    $names = $m['names'] ?? [];
                    break;
                }
            }
            $rule = Inspection::matchDefectRule($names !== [] ? $names[0] : $f['make'], $f['model']);
        }

        $ctx = $this->context($f);
        $items = [];
        $covered = [];
        foreach ($rule !== null ? $rule['defects'] : [] as $d) {
            $sid = $this->servedId($d['id']);
            $r = null;
            if ($sid !== null) {
                $covered[$sid] = true;
                $r = $this->resolveOne($this->defectsById[$sid], $ctx);
                if ($r->status === 'not_applicable') {
                    continue;
                }
            }
            $items[] = $this->item($d['id'], $d['text'], (bool) ($d['critical'] ?? false), $sid, $r);
        }
        if ($ctx['modelId'] !== null) {
            foreach ($this->sortedDossiers() as $dossier) {
                $did = (string) $dossier['id'];
                if (isset($covered[$did])
                    || !\in_array($ctx['modelId'], $dossier['applicability']['models'] ?? [], true)) {
                    continue;
                }
                $r = $this->resolveOne($dossier, $ctx);
                if ($r->status === 'not_applicable') {
                    continue;
                }
                $prompt = ($dossier['checklistPrompt'] ?? null) ?: (($dossier['title'] ?? null) ?: []);
                $items[] = $this->item($did, $prompt, self::isCritical($dossier), $did, $r);
            }
        }
        if ($items === []) {
            return $groups;
        }
        foreach ($items as $i => $_) {
            $items[$i]['order'] = $i;
        }
        $title = $rule !== null ? $rule['label'] : DefectsV3::KNOWN_DEFECTS_TITLE;
        $groups[] = [
            'id' => 'defects',
            'order' => 6,
            'title' => $title,
            'ruleId' => $rule !== null ? $rule['id'] : null,
            'children' => [[
                'id' => 'defects.g',
                'order' => 0,
                'title' => $title,
                'items' => $items,
            ]],
        ];

        return $groups;
    }

    // --- internals -------------------------------------------------------------

    /** @return list<array<string, mixed>> served dossiers in code-point id order */
    private function sortedDossiers(): array
    {
        $list = array_values($this->defectsById);
        usort($list, static fn (array $a, array $b): int => strcmp((string) $a['id'], (string) $b['id']));

        return $list;
    }

    /**
     * @param array<string, mixed>      $prompt
     * @param array<string, mixed>|null $hint
     *
     * @return array<string, mixed>
     */
    private function item(string $defectId, array $prompt, bool $critical, ?string $dossierId, ?Resolution $r): array
    {
        $hint = null;
        if ($dossierId !== null) {
            $hint = $this->defectsById[$dossierId]['applicability']['hint'] ?? null;
        }

        return [
            'id' => "defect.{$defectId}",
            'order' => 0,
            'prompt' => $prompt,
            'critical' => $critical,
            'sourceDefectId' => $defectId,
            'dossierId' => $dossierId,
            'status' => $r !== null ? $r->status : 'legacy',
            'needs' => $r !== null ? $r->needs : [],
            'hint' => $hint,
        ];
    }

    /** @param array<string, mixed> $defect */
    private static function isCritical(array $defect): bool
    {
        if (\array_key_exists('critical', $defect)) {
            return (bool) $defect['critical'];
        }

        return ($defect['severity'] ?? null) === 'critical';
    }

    /**
     * Normalise loose facts: empty strings are absent, codes trimmed and
     * upper-cased, the make taken from the VIN's WMI when none is given.
     *
     * @param array<string, mixed> $facts
     *
     * @return array<string, mixed>
     */
    private function prepare(array $facts): array
    {
        $blank = static fn (mixed $v): mixed => $v === '' ? null : $v;
        $code = static fn (mixed $v): mixed => $blank(\is_string($v) ? mb_strtoupper(self::strip($v)) : $v);

        $make = $blank($facts['make'] ?? null);
        $vin = $code($facts['vin'] ?? null);
        if ($make === null && $vin !== null) {
            $make = $this->makeFromWmi($vin);
        }

        return [
            'make' => $make,
            'model' => $blank($facts['model'] ?? null),
            'year' => $facts['year'] ?? null,
            'productionDate' => $blank($facts['productionDate'] ?? null),
            'fuel' => $blank($facts['fuel'] ?? null),
            'engineCode' => $code($facts['engineCode'] ?? null),
            'engineFamily' => $code($facts['engineFamily'] ?? null),
            'gearbox' => $blank($facts['gearbox'] ?? null),
            'gearboxCode' => $code($facts['gearboxCode'] ?? null),
            'cc' => $facts['cc'] ?? null,
            'powerKw' => $facts['powerKw'] ?? null,
            'vin' => $vin,
        ];
    }

    /**
     * Read an engine code that is really a family name ("EB2") as a family,
     * and an "engine family" that is really a code ("N47D20") as that code.
     * Taken literally, either mix-up rules out the buyer's own engine.
     *
     * @param array<string, mixed> $f
     *
     * @return array<string, mixed>
     */
    private function disambiguateEngine(array $f): array
    {
        $code = $f['engineCode'];
        $family = $f['engineFamily'];
        if ($code !== null && isset($this->engineFamilies[$code])) {
            $f['engineCode'] = null;
            $f['engineFamily'] = ($family !== null && $family !== '') ? $family : $code;

            return $f;
        }
        if ($code === null && $family !== null
            && !isset($this->engineFamilies[$family])
            && isset($this->enginesByCode[$family])) {
            $f['engineCode'] = $family;
            $f['engineFamily'] = null;
        }

        return $f;
    }

    /**
     * @param array<string, mixed> $prepared
     *
     * @return array{facts: array<string, mixed>, modelId: ?string, candidates: list<array{0: array<string, mixed>, 1: ?array<string, mixed>}>, warnings: list<string>}
     */
    private function context(array $prepared): array
    {
        $f = $this->disambiguateEngine($prepared);
        $makeId = $this->normalizeMake($f['make']);
        $modelId = $this->normalizeModel($makeId, $f['model']);
        [$candidates, $warnings] = $this->candidates($modelId, $f);

        return ['facts' => $f, 'modelId' => $modelId, 'candidates' => $candidates, 'warnings' => $warnings];
    }

    /**
     * @param array<string, mixed> $engine
     * @param array<string, mixed> $f
     */
    private function engineFits(array $engine, array $f): bool
    {
        $fuel = $engine['fuel'] ?? null;
        if (\in_array($f['fuel'], self::ENGINE_FUELS, true) && $fuel && $fuel !== $f['fuel']) {
            return false;
        }
        $cc = $engine['displacementCc'] ?? null;
        if ($f['cc'] !== null && $cc !== null && abs($f['cc'] - $cc) > self::CC_TOLERANCE) {
            return false;
        }
        $powers = ($engine['powerKw'] ?? null) ?: [];
        if ($f['powerKw'] !== null && $powers !== []) {
            $best = min(array_map(static fn ($p) => abs($f['powerKw'] - $p), $powers));
            if ($best > self::KW_TOLERANCE) {
                return false;
            }
        }
        if ($f['engineCode'] !== null
            && !\in_array($f['engineCode'], self::upperList($engine['codes'] ?? null), true)) {
            return false;
        }

        return $f['engineFamily'] === null || self::family($engine) === $f['engineFamily'];
    }

    /**
     * @param array<string, mixed> $gearbox
     * @param array<string, mixed> $f
     */
    private function gearboxFits(array $gearbox, array $f): bool
    {
        if ($f['gearbox'] !== null
            && !\in_array($f['gearbox'], self::GEARBOX_TYPE_COARSE[(string) ($gearbox['type'] ?? '')] ?? [], true)) {
            return false;
        }

        return $f['gearboxCode'] === null
            || \in_array($f['gearboxCode'], self::upperList($gearbox['codes'] ?? null), true)
            || $f['gearboxCode'] === self::family($gearbox);
    }

    /**
     * (engine, gearbox-or-null) pairs still consistent with the facts. Empty
     * means "nothing known", never "nothing fits".
     *
     * @param array<string, mixed> $f
     *
     * @return array{0: list<array{0: array<string, mixed>, 1: ?array<string, mixed>}>, 1: list<string>}
     */
    private function candidates(?string $modelId, array $f): array
    {
        if ($modelId === null) {
            return [[], []];
        }
        $allGens = $this->generationsByModel[$modelId] ?? [];
        $fitments = [];
        $hasTable = false;
        foreach ($allGens as $g) {
            if (($this->fitmentsByGeneration[$g['id']] ?? []) !== []) {
                $hasTable = true;
            }
            if (self::inYears($f['year'], $g['years'] ?? null)) {
                foreach ($this->fitmentsByGeneration[$g['id']] ?? [] as $fit) {
                    $fitments[] = $fit;
                }
            }
        }

        $pairs = [];
        foreach ($fitments as $fit) {
            if (!self::inYears($f['year'], $fit['years'] ?? null)) {
                continue;
            }
            $engineId = $fit['engine'] ?? null;
            $engine = \is_string($engineId) ? ($this->enginesById[$engineId] ?? null) : null;
            if ($engine === null || !$this->engineFits($engine, $f)) {
                continue;
            }
            $boxes = [];
            foreach ($fit['gearboxes'] ?? [] as $gid) {
                if (isset($this->gearboxesById[$gid])) {
                    $boxes[] = $this->gearboxesById[$gid];
                }
            }
            if ($boxes === []) {
                $pairs[] = [$engine, null]; // gearbox not recorded: unknown
                continue;
            }
            foreach ($boxes as $box) {
                if ($this->gearboxFits($box, $f)) {
                    $pairs[] = [$engine, $box];
                }
            }
        }

        if ($hasTable && $pairs === []) {
            return [[], ['facts_not_in_fitment_table']];
        }

        return [$pairs, []];
    }

    // --- condition leaves --------------------------------------------------------

    /**
     * A three-valued result: value true/false/null(unknown), the facts that
     * would settle an unknown, the facts that decided a false, and warnings.
     *
     * @param list<string> $needs
     * @param list<string> $used
     * @param list<string> $warnings
     *
     * @return array{value: ?bool, needs: array<string, true>, used: array<string, true>, warnings: list<string>}
     */
    private static function value(?bool $value, array $needs = [], array $used = [], array $warnings = []): array
    {
        return [
            'value' => $value,
            'needs' => array_fill_keys($needs, true),
            'used' => array_fill_keys($used, true),
            'warnings' => $warnings,
        ];
    }

    /**
     * @param array<string, mixed> $engine
     * @param array<string, mixed> $leaf
     */
    private static function engineMatches(array $engine, array $leaf): bool
    {
        if (\in_array($engine['id'], $leaf['ids'] ?? [], true)) {
            return true;
        }
        if (\in_array(self::family($engine), self::upperList($leaf['family'] ?? null), true)) {
            return true;
        }

        return array_intersect(self::upperList($leaf['codes'] ?? null), self::upperList($engine['codes'] ?? null)) !== [];
    }

    /**
     * @param array<string, mixed> $gearbox
     * @param array<string, mixed> $leaf
     */
    private static function gearboxMatches(array $gearbox, array $leaf): bool
    {
        if (\in_array($gearbox['id'], $leaf['ids'] ?? [], true)) {
            return true;
        }
        if (\in_array(self::family($gearbox), self::upperList($leaf['family'] ?? null), true)) {
            return true;
        }
        if (\in_array($gearbox['type'] ?? null, $leaf['type'] ?? [], true)) {
            return true;
        }

        return array_intersect(self::upperList($leaf['codes'] ?? null), self::upperList($gearbox['codes'] ?? null)) !== [];
    }

    /**
     * @param array<string, mixed> $ctx
     *
     * @return list<string>
     */
    private static function candidateFactsUsed(array $ctx): array
    {
        $f = $ctx['facts'];
        $used = ['model'];
        foreach (['year', 'fuel', 'cc', 'powerKw', 'gearbox', 'gearboxCode'] as $name) {
            if ($f[$name] !== null) {
                $used[] = $name;
            }
        }

        return $used;
    }

    /**
     * True if every candidate satisfies, false if none does, else unknown.
     * An empty candidate set is unknown, never false.
     *
     * @param list<bool> $values
     */
    private static function over(array $values): ?bool
    {
        if ($values === []) {
            return null;
        }
        if (!\in_array(false, $values, true)) {
            return true;
        }
        if (!\in_array(true, $values, true)) {
            return false;
        }

        return null;
    }

    /**
     * @param array<string, mixed> $leaf
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private function evalEngine(array $leaf, array $ctx): array
    {
        $f = $ctx['facts'];
        if ($f['engineCode'] !== null) {
            if (\in_array($f['engineCode'], self::upperList($leaf['codes'] ?? null), true)) {
                return self::value(true);
            }
            $engine = $this->enginesByCode[$f['engineCode']] ?? null;
            if ($engine === null) {
                return self::value(null, [], [], ['unrecognised_engine_code']);
            }
            if (self::engineMatches($engine, $leaf)) {
                return self::value(true);
            }

            return self::value(false, [], ['engineCode']);
        }

        $known = array_values(array_filter($this->engines, static fn (array $e): bool => self::engineMatches($e, $leaf)));
        if ($f['engineFamily'] !== null) {
            $families = self::upperList($leaf['family'] ?? null);
            foreach ($known as $e) {
                $families[] = self::family($e);
            }
            if (!\in_array($f['engineFamily'], $families, true)) {
                return self::value(false, [], ['engineFamily']);
            }
            if (!empty($leaf['family']) && empty($leaf['codes']) && empty($leaf['ids'])) {
                return self::value(true);
            }
        }

        // Fuel can rule an engine out without a fitment table; power and
        // displacement cannot (the dictionary lists confirmed ratings, not all).
        if ($known !== [] && \in_array($f['fuel'], self::ENGINE_FUELS, true)) {
            $allOther = true;
            foreach ($known as $e) {
                $fuel = $e['fuel'] ?? null;
                if (!($fuel && $fuel !== $f['fuel'])) {
                    $allOther = false;
                    break;
                }
            }
            if ($allOther) {
                return self::value(false, [], ['fuel']);
            }
        }

        if ($ctx['candidates'] !== []) {
            $verdict = self::over(array_map(
                static fn (array $pair): bool => self::engineMatches($pair[0], $leaf),
                $ctx['candidates'],
            ));
            if ($verdict === false) {
                return self::value(false, [], self::candidateFactsUsed($ctx));
            }
            if ($verdict === true) {
                return self::value(true);
            }
        }

        return self::value(null, ['engineCode']);
    }

    /**
     * @param array<string, mixed> $leaf
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private function evalGearbox(array $leaf, array $ctx): array
    {
        $f = $ctx['facts'];
        if ($f['gearboxCode'] !== null) {
            $codes = [...self::upperList($leaf['codes'] ?? null), ...self::upperList($leaf['family'] ?? null)];
            if (\in_array($f['gearboxCode'], $codes, true)) {
                return self::value(true);
            }
            $box = $this->gearboxesByCode[$f['gearboxCode']] ?? null;
            if (!$box) {
                $box = null;
                foreach ($this->gearboxes as $g) {
                    if (self::family($g) === $f['gearboxCode']) {
                        $box = $g;
                        break;
                    }
                }
            }
            if ($box === null) {
                return self::value(null, [], [], ['unrecognised_gearbox_code']);
            }
            if (self::gearboxMatches($box, $leaf)) {
                return self::value(true);
            }

            return self::value(false, [], ['gearboxCode']);
        }

        $types = array_values($leaf['type'] ?? []);
        foreach ($this->gearboxes as $g) {
            if (self::gearboxMatches($g, $leaf)) {
                $types[] = $g['type'] ?? null;
            }
        }
        if ($f['gearbox'] !== null && $types !== []) {
            $coarse = [];
            foreach ($types as $t) {
                if (\is_string($t)) {
                    foreach (self::GEARBOX_TYPE_COARSE[$t] ?? [] as $c) {
                        $coarse[] = $c;
                    }
                }
            }
            if (!\in_array($f['gearbox'], $coarse, true)) {
                return self::value(false, [], ['gearbox']);
            }
        }

        if ($ctx['candidates'] !== []) {
            $allBoxes = true;
            foreach ($ctx['candidates'] as $pair) {
                if ($pair[1] === null) {
                    $allBoxes = false;
                    break;
                }
            }
            if ($allBoxes) {
                $verdict = self::over(array_map(
                    static fn (array $pair): bool => self::gearboxMatches($pair[1], $leaf),
                    $ctx['candidates'],
                ));
                if ($verdict === false) {
                    return self::value(false, [], self::candidateFactsUsed($ctx));
                }
                if ($verdict === true) {
                    return self::value(true);
                }
            }
        }

        return self::value(null, [$f['gearbox'] !== null ? 'gearboxCode' : 'gearbox']);
    }

    /**
     * @param array<mixed>         $leaf a list of fuels, or {"in": [...]}
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private static function evalFuel(array $leaf, array $ctx): array
    {
        $wanted = array_is_list($leaf) ? $leaf : ($leaf['in'] ?? []);
        $fuel = $ctx['facts']['fuel'];
        if ($fuel !== null) {
            if (\in_array($fuel, $wanted, true)) {
                return self::value(true);
            }

            return self::value(false, [], ['fuel']);
        }
        if ($ctx['candidates'] !== []) {
            $verdict = self::over(array_map(
                static fn (array $pair): bool => \in_array($pair[0]['fuel'] ?? null, $wanted, true),
                $ctx['candidates'],
            ));
            if ($verdict === false) {
                return self::value(false, [], self::candidateFactsUsed($ctx));
            }
            if ($verdict === true) {
                return self::value(true);
            }
        }

        return self::value(null, ['fuel']);
    }

    /**
     * @param array<string, mixed> $leaf
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private static function evalModelYear(array $leaf, array $ctx): array
    {
        $year = $ctx['facts']['year'];
        if ($year === null) {
            return self::value(null, ['year']);
        }
        if (self::inYears($year, $leaf)) {
            return self::value(true);
        }

        return self::value(false, [], ['year']);
    }

    /**
     * @param array<string, mixed> $leaf
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private static function evalProductionDate(array $leaf, array $ctx): array
    {
        $lo = $leaf['from'] ?? null;
        $hi = $leaf['to'] ?? null;
        $pd = $ctx['facts']['productionDate'];
        if ($pd !== null) {
            $pd = (string) $pd;
            if (($lo === null || strcmp($pd, $lo) >= 0) && ($hi === null || strcmp($pd, $hi) <= 0)) {
                return self::value(true);
            }

            return self::value(false, [], ['productionDate']);
        }
        $year = $ctx['facts']['year'];
        if ($year === null) {
            return self::value(null, ['year']);
        }
        $loY = ($lo !== null && $lo !== '') ? (int) substr($lo, 0, 4) : null;
        $hiY = ($hi !== null && $hi !== '') ? (int) substr($hi, 0, 4) : null;
        // A year is never earlier than the build year, but it can be one later
        // (model years run ahead, and first registration can trail the build).
        // So one year past the window is unknown; only a year before it, or two
        // past it, rules the car out.
        if (($loY !== null && $year < $loY) || ($hiY !== null && $year > $hiY + 1)) {
            return self::value(false, [], ['year']);
        }
        // A year on a boundary month is ambiguous unless the boundary is a
        // whole calendar year (from January / to December).
        $onLo = $loY !== null && $year === $loY && !str_ends_with($lo, '-01');
        $onHi = $hiY !== null && ($year === $hiY + 1 || ($year === $hiY && !str_ends_with($hi, '-12')));
        if ($onLo || $onHi) {
            return self::value(null, ['productionDate']);
        }

        return self::value(true);
    }

    /**
     * `make` / `model` / `generation` leaves: lists of dictionary ids, or {"ids": [...]}.
     *
     * @param array<mixed>         $leaf
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private function evalIds(string $kind, array $leaf, array $ctx): array
    {
        $wanted = array_is_list($leaf) ? $leaf : ($leaf['ids'] ?? []);
        $modelId = $ctx['modelId'];
        if ($modelId === null) {
            return self::value(null, ['model']);
        }
        if ($kind === 'make') {
            $make = $this->modelsById[$modelId]['make'] ?? null;
            if (\in_array($make, $wanted, true)) {
                return self::value(true);
            }

            return self::value(false, [], ['make']);
        }
        if ($kind === 'model') {
            if (\in_array($modelId, $wanted, true)) {
                return self::value(true);
            }

            return self::value(false, [], ['model']);
        }
        $year = $ctx['facts']['year'];
        $hits = [];
        foreach ($this->generationsByModel[$modelId] ?? [] as $g) {
            if (self::inYears($year, $g['years'] ?? null)) {
                $hits[] = \in_array($g['id'], $wanted, true);
            }
        }
        $verdict = self::over($hits);
        if ($verdict === false) {
            return self::value(false, [], $year ? ['model', 'year'] : ['model']);
        }
        if ($verdict === true) {
            return self::value(true);
        }

        return self::value(null, ['year']);
    }

    /**
     * @param list<array<string, mixed>> $parts
     *
     * @return array<string, mixed>
     */
    private static function combine(string $kind, array $parts): array
    {
        $warnings = [];
        foreach ($parts as $p) {
            foreach ($p['warnings'] as $w) {
                $warnings[] = $w;
            }
        }
        $values = array_column($parts, 'value');
        $union = static function (array $parts, ?bool $only): array {
            $set = [];
            foreach ($parts as $p) {
                if ($only === null ? true : $p['value'] === false) {
                    $set += $p['used'];
                }
            }

            return $set;
        };
        if ($kind === 'all') {
            if (\in_array(false, $values, true)) {
                return ['value' => false, 'needs' => [], 'used' => $union($parts, false), 'warnings' => $warnings];
            }
            if (!\in_array(null, $values, true)) {
                return ['value' => true, 'needs' => [], 'used' => [], 'warnings' => $warnings];
            }
        } else {
            if (\in_array(true, $values, true)) {
                return ['value' => true, 'needs' => [], 'used' => [], 'warnings' => $warnings];
            }
            if (!\in_array(true, $values, true) && !\in_array(null, $values, true)) {
                return ['value' => false, 'needs' => [], 'used' => $union($parts, null), 'warnings' => $warnings];
            }
        }
        $needs = [];
        foreach ($parts as $p) {
            if ($p['value'] === null) {
                $needs += $p['needs'];
            }
        }

        return ['value' => null, 'needs' => $needs, 'used' => [], 'warnings' => $warnings];
    }

    /**
     * @param array<string, mixed> $ctx
     *
     * @return array<string, mixed>
     */
    private function evaluate(mixed $node, array $ctx): array
    {
        if (!\is_array($node) || \count($node) !== 1 || array_is_list($node)) {
            throw new ConditionError('condition node must have exactly one key: ' . json_encode($node));
        }
        $kind = (string) array_key_first($node);
        $arg = $node[$kind];
        switch ($kind) {
            case 'all':
            case 'any':
                $parts = [];
                foreach ((array) $arg as $n) {
                    $parts[] = $this->evaluate($n, $ctx);
                }

                return self::combine($kind, $parts);
            case 'not':
                $inner = $this->evaluate($arg, $ctx);
                if ($inner['value'] === null) {
                    return $inner;
                }
                if ($inner['value']) {
                    return self::value(false, [], ['model'], $inner['warnings']);
                }

                return self::value(true, [], [], $inner['warnings']);
            case 'engine':
                return $this->evalEngine(self::leaf($arg, $kind), $ctx);
            case 'gearbox':
                return $this->evalGearbox(self::leaf($arg, $kind), $ctx);
            case 'fuel':
                return self::evalFuel(self::leaf($arg, $kind), $ctx);
            case 'modelYear':
                return self::evalModelYear(self::leaf($arg, $kind), $ctx);
            case 'productionDate':
                return self::evalProductionDate(self::leaf($arg, $kind), $ctx);
            case 'make':
            case 'model':
            case 'generation':
                return $this->evalIds($kind, self::leaf($arg, $kind), $ctx);
        }
        // `market` is deliberately absent: facts carry no market (format 3).
        throw new ConditionError("unknown condition leaf: {$kind}");
    }

    /** @return array<mixed> */
    private static function leaf(mixed $arg, string $kind): array
    {
        if (!\is_array($arg)) {
            throw new ConditionError("condition leaf {$kind} must be a list or an object");
        }

        return $arg;
    }

    /**
     * @param array<string, mixed> $defect
     * @param array<string, mixed> $ctx
     */
    private function resolveOne(array $defect, array $ctx): Resolution
    {
        $did = (string) $defect['id'];
        $applicability = $defect['applicability'] ?? [];
        if ($ctx['modelId'] === null) {
            $model = $ctx['facts']['model'];
            $warnings = ($model !== null && $model !== '') ? ['unrecognised_model'] : [];

            return new Resolution($did, 'possible', ['model'], [], $warnings);
        }
        if (!\in_array($ctx['modelId'], $applicability['models'] ?? [], true)) {
            return new Resolution($did, 'not_applicable', [], ['model'], []);
        }
        $when = $applicability['when'] ?? null;
        if (!$when) {
            return new Resolution($did, 'applies', [], [], $ctx['warnings']);
        }
        $result = $this->evaluate($when, $ctx);
        $warnings = array_values(array_unique([...$ctx['warnings'], ...$result['warnings']]));
        if ($result['value'] === true) {
            return new Resolution($did, 'applies', [], [], $warnings);
        }
        if ($result['value'] === false) {
            return new Resolution($did, 'not_applicable', [], self::ordered($result['used']), $warnings);
        }

        return new Resolution($did, 'possible', self::ordered($result['needs']), [], $warnings);
    }

    // --- helpers -----------------------------------------------------------------

    /**
     * Fact names in NEEDS_ORDER, unknown names after them by code point.
     *
     * @param array<string, true> $set
     *
     * @return list<string>
     */
    private static function ordered(array $set): array
    {
        $names = array_map('strval', array_keys($set));
        $order = array_flip(DefectsV3::NEEDS_ORDER);
        $rank = static fn (string $n): int => $order[$n] ?? \count($order);
        usort($names, static fn (string $a, string $b): int => ($rank($a) <=> $rank($b)) ?: strcmp($a, $b));

        return $names;
    }

    /** @param list<string> $names */
    private static function nameMatches(string $value, array $names): bool
    {
        foreach ($names as $name) {
            $n = self::normalizeName((string) $name);
            if ($n !== '' && ($value === $n || str_starts_with($value, $n . ' '))) {
                return true;
            }
        }

        return false;
    }

    /** @return list<string> */
    private static function upperList(mixed $values): array
    {
        $out = [];
        foreach ((array) ($values ?? []) as $v) {
            $out[] = mb_strtoupper((string) $v);
        }

        return $out;
    }

    /** @param array<string, mixed> $entity */
    private static function family(array $entity): string
    {
        return mb_strtoupper((string) (($entity['family'] ?? null) ?: ''));
    }

    /** @param array<string, mixed>|null $span */
    private static function inYears(mixed $year, ?array $span): bool
    {
        if ($year === null || !$span) {
            return true;
        }
        $lo = $span['from'] ?? null;
        $hi = $span['to'] ?? null;

        return ($lo === null || $year >= $lo) && ($hi === null || $year <= $hi);
    }

    /** Python's str.strip(): Unicode whitespace from both ends. */
    private static function strip(string $s): string
    {
        return (string) preg_replace('/^' . self::WHITESPACE . '+|' . self::WHITESPACE . '+$/u', '', $s);
    }

    private static function foldIntl(string $s): string
    {
        $s = mb_scrub($s, 'UTF-8');
        $folded = \Normalizer::normalize(mb_convert_case($s, \MB_CASE_FOLD, 'UTF-8'), \Normalizer::FORM_KD);
        if ($folded === false) {
            return self::foldTable($s);
        }
        $out = '';
        foreach (mb_str_split($folded, 1, 'UTF-8') as $ch) {
            if (\strlen($ch) === 1 || \IntlChar::getCombiningClass($ch) === 0) {
                $out .= $ch;
            }
        }

        return $out;
    }

    private static function foldTable(string $s): string
    {
        $out = '';
        foreach (mb_str_split(mb_scrub($s, 'UTF-8'), 1, 'UTF-8') as $ch) {
            $out .= FoldTable::MAP[$ch] ?? mb_strtolower($ch, 'UTF-8');
        }

        return (string) preg_replace(self::COMBINING, '', $out);
    }

    /** @return array<string, mixed> */
    private static function readJson(string $path): array
    {
        $raw = file_get_contents($path);
        if ($raw === false) {
            throw new \RuntimeException("Canon file missing: {$path}");
        }

        /** @var array<string, mixed> $decoded */
        $decoded = json_decode($raw, true, 512, \JSON_THROW_ON_ERROR);

        return $decoded;
    }
}
