<?php

declare(strict_types=1);

namespace Elgarde\Inspection;

/**
 * A known-defects v3 `when` condition outside the closed condition language
 * (an unknown leaf such as `market`, or a node without exactly one key).
 */
final class ConditionError extends \InvalidArgumentException
{
}
