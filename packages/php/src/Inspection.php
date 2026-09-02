<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * Checklist assembly and defect-rule matching.
 *
 * Groups and items are plain arrays in the canon's own shape, so what you get
 * back matches `inspection-core/data/schema/` and the JSON the Elgarde API
 * returns.
 */
final class Inspection
{
    /**
     * The checklist for a car: the base groups, then the fuel module, then the
     * model's known defects when a rule matches.
     *
     * @return list<array<string, mixed>>
     */
    public static function assemble(
        ?string $make = null,
        ?string $model = null,
        ?string $fuelType = null,
    ): array {
        $checklist = Canon::checklist();

        /** @var list<array<string, mixed>> $groups */
        $groups = $checklist['base'];

        $module = $checklist['modules']['fuel'][$fuelType ?? ''] ?? null;
        if ($module !== null) {
            $groups[] = $module;
        }

        $rule = self::matchDefectRule($make, $model);
        if ($rule !== null) {
            $groups[] = self::defectGroup($rule);
        }

        return $groups;
    }

    /**
     * The first rule matching the make and model, or null. Rules are ordered
     * and at most one ever applies; matching is case-insensitive.
     *
     * @return array<string, mixed>|null
     */
    public static function matchDefectRule(?string $make, ?string $model): ?array
    {
        $mk = mb_strtolower($make ?? '');
        $md = mb_strtolower($model ?? '');
        if ($mk === '' && $md === '') {
            return null;
        }

        foreach (Canon::defects()['rules'] as $rule) {
            foreach ($rule['match'] as $clause) {
                if (self::clauseMatches($clause, $mk, $md)) {
                    return $rule;
                }
            }
        }

        return null;
    }

    /**
     * A matched rule rendered as the top-level `defects` group.
     *
     * @param array<string, mixed> $rule
     *
     * @return array<string, mixed>
     */
    public static function defectGroup(array $rule): array
    {
        $items = [];
        foreach (array_values($rule['defects']) as $index => $defect) {
            $items[] = [
                'id' => "defect.{$defect['id']}",
                'order' => $index,
                'prompt' => $defect['text'],
                'critical' => (bool) ($defect['critical'] ?? false),
                'sourceDefectId' => $defect['id'],
            ];
        }

        return [
            'id' => 'defects',
            'order' => 6,
            'title' => $rule['label'],
            'children' => [[
                'id' => 'defects.g',
                'order' => 0,
                'title' => $rule['label'],
                'items' => $items,
            ]],
        ];
    }

    /**
     * Every leaf item under the given groups, depth-first.
     *
     * @param list<array<string, mixed>> $groups
     *
     * @return list<array<string, mixed>>
     */
    public static function allItems(array $groups): array
    {
        $out = [];
        foreach ($groups as $group) {
            foreach ($group['items'] ?? [] as $item) {
                $out[] = $item;
            }
            foreach (self::allItems($group['children'] ?? []) as $item) {
                $out[] = $item;
            }
        }

        return $out;
    }

    /**
     * The assembled tree with one language resolved per title and prompt.
     *
     * @param list<array<string, mixed>> $groups
     *
     * @return list<array<string, mixed>>
     */
    public static function localize(array $groups, string $lang): array
    {
        $out = [];
        foreach ($groups as $group) {
            $localized = [
                'id' => $group['id'],
                'order' => $group['order'] ?? 0,
                'title' => Canon::pick($group['title'], $lang),
                'aggregation' => $group['aggregation'] ?? 'average',
            ];

            if (($group['children'] ?? []) !== []) {
                $localized['children'] = self::localize($group['children'], $lang);
            }
            if (($group['items'] ?? []) !== []) {
                $items = [];
                foreach ($group['items'] as $item) {
                    $items[] = [
                        'id' => $item['id'],
                        'order' => $item['order'] ?? 0,
                        'prompt' => Canon::pick($item['prompt'], $lang),
                        'critical' => (bool) ($item['critical'] ?? false),
                    ];
                }
                $localized['items'] = $items;
            }

            $out[] = $localized;
        }

        return $out;
    }

    /** @param array<string, mixed> $clause */
    private static function clauseMatches(array $clause, string $make, string $model): bool
    {
        $makeHit = false;
        foreach ($clause['makeAny'] as $token) {
            if (str_contains($make, $token)) {
                $makeHit = true;
                break;
            }
        }
        if (!$makeHit) {
            return false;
        }

        if (!isset($clause['modelAny'])) {
            return true;
        }
        foreach ($clause['modelAny'] as $token) {
            if (str_contains($model, $token)) {
                return true;
            }
        }

        return false;
    }
}
