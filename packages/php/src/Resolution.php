<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * Whether one known-defects v3 dossier applies to a car.
 *
 * `status` is `applies`, `possible` (and `needs` lists the facts that would
 * settle it) or `not_applicable` (and `excludedBy` lists the facts that ruled
 * it out). `toArray()` is the API's JSON shape.
 */
final class Resolution implements \JsonSerializable
{
    /**
     * @param list<string> $needs
     * @param list<string> $excludedBy
     * @param list<string> $warnings
     */
    public function __construct(
        public readonly string $defectId,
        public readonly string $status,
        public readonly array $needs = [],
        public readonly array $excludedBy = [],
        public readonly array $warnings = [],
    ) {
    }

    /**
     * @return array{defectId: string, status: string, needs: list<string>, excludedBy: list<string>, warnings: list<string>}
     */
    public function toArray(): array
    {
        return [
            'defectId' => $this->defectId,
            'status' => $this->status,
            'needs' => $this->needs,
            'excludedBy' => $this->excludedBy,
            'warnings' => $this->warnings,
        ];
    }

    /** @return array<string, mixed> */
    public function jsonSerialize(): array
    {
        return $this->toArray();
    }
}
