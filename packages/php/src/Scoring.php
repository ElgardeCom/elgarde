<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * Group rollups and the overall verdict.
 *
 * Implements `inspection-core/spec/SCORING.md`; the conformance vectors in
 * `tests/vectors.json` are what prove it.
 *
 * Scores are keyed by checklist item id: 1-5 rates the item, -1 marks it not
 * applicable, -2 not inspected, and an absent key means unanswered.
 */
final class Scoring
{
    /** True only for a real 1-5 rating. */
    public static function isRealScore(?int $score): bool
    {
        return $score !== null && $score > 0;
    }

    /**
     * The rolled-up 1-5 score for a group, or null when nothing real is
     * answered underneath it. Child groups contribute with weight 1.
     *
     * @param array<string, mixed>    $group
     * @param array<string, int|null> $scores
     */
    public static function groupScore(array $group, array $scores): ?float
    {
        /** @var list<array{value: float, weight: float}> $parts */
        $parts = [];

        foreach ($group['items'] ?? [] as $item) {
            $score = $scores[$item['id']] ?? null;
            if (self::isRealScore($score)) {
                $parts[] = [
                    'value' => (float) $score,
                    'weight' => (float) ($item['weight'] ?? 1),
                ];
            }
        }
        foreach ($group['children'] ?? [] as $child) {
            $childScore = self::groupScore($child, $scores);
            if ($childScore !== null) {
                $parts[] = ['value' => $childScore, 'weight' => 1.0];
            }
        }
        if ($parts === []) {
            return null;
        }

        $values = array_column($parts, 'value');

        return match ($group['aggregation'] ?? 'average') {
            'worst_case' => min($values),
            'weighted' => self::weightedMean($parts),
            default => array_sum($values) / \count($values),
        };
    }

    /**
     * The mean of the top-level group scores, before the critical clamp.
     *
     * @param list<array<string, mixed>> $groups
     * @param array<string, int|null>    $scores
     */
    public static function overallBeforeClamp(array $groups, array $scores): ?float
    {
        $tops = [];
        foreach ($groups as $group) {
            $score = self::groupScore($group, $scores);
            if ($score !== null) {
                $tops[] = $score;
            }
        }
        if ($tops === []) {
            return null;
        }

        return array_sum($tops) / \count($tops);
    }

    /**
     * The overall 1-5 verdict: the mean of the top-level group scores, then
     * clamped down by any answered critical item scoring at or below the
     * threshold. The clamp only ever lowers the verdict.
     *
     * @param list<array<string, mixed>> $groups
     * @param array<string, int|null>    $scores
     */
    public static function overall(
        array $groups,
        array $scores,
        int $criticalThreshold = Canon::CRITICAL_THRESHOLD,
    ): ?float {
        $verdict = self::overallBeforeClamp($groups, $scores);
        if ($verdict === null) {
            return null;
        }

        foreach (self::criticalItems($groups) as $item) {
            $score = $scores[$item['id']] ?? null;
            if (
                self::isRealScore($score)
                && $score <= $criticalThreshold
                && $score < $verdict
            ) {
                $verdict = (float) $score;
            }
        }

        return $verdict;
    }

    /**
     * @param list<array<string, mixed>> $groups
     *
     * @return list<array<string, mixed>>
     */
    public static function criticalItems(array $groups): array
    {
        return array_values(array_filter(
            Inspection::allItems($groups),
            static fn (array $item): bool => (bool) ($item['critical'] ?? false),
        ));
    }

    /**
     * `[answered, total]` over leaf items. Sentinels count as answered.
     *
     * @param list<array<string, mixed>> $groups
     * @param array<string, int|null>    $scores
     *
     * @return array{0: int, 1: int}
     */
    public static function progress(array $groups, array $scores): array
    {
        $items = Inspection::allItems($groups);
        $answered = 0;
        foreach ($items as $item) {
            if (($scores[$item['id']] ?? null) !== null) {
                ++$answered;
            }
        }

        return [$answered, \count($items)];
    }

    /** @param list<array{value: float, weight: float}> $parts */
    private static function weightedMean(array $parts): float
    {
        $total = array_sum(array_column($parts, 'weight'));
        if ($total === 0.0) {
            return 0.0;
        }

        $sum = 0.0;
        foreach ($parts as $part) {
            $sum += $part['value'] * $part['weight'];
        }

        return $sum / $total;
    }
}
