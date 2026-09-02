/**
 * Elgarde inspection core — checklist assembly, defect-rule matching, scoring.
 *
 * The canon is data, not code: `data/checklist.json` and `data/defects.json`
 * ship with this package, copied from `inspection-core/data/` by
 * `inspection-core/tools/sync_canon.py`. The algorithm here implements
 * `inspection-core/spec/SCORING.md`, and correctness is pinned by the shared
 * conformance vectors every port must pass.
 *
 * Zero dependencies, no network, no configuration.
 */

import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const DATA_DIR = join(dirname(fileURLToPath(import.meta.url)), 'data');

const readCanon = (name) =>
  JSON.parse(readFileSync(join(DATA_DIR, `${name}.json`), 'utf8'));

/** @type {{checklist: any, defects: any} | null} */
let cached = null;

/** The parsed canon, read once. */
export function canon() {
  if (cached === null) {
    cached = { checklist: readCanon('checklist'), defects: readCanon('defects') };
  }
  return cached;
}

export function canonVersion() {
  const { checklist, defects } = canon();
  return { checklist: checklist.version, defects: defects.version };
}

/** Not applicable — the item does not apply to this car. */
export const SCORE_NOT_APPLICABLE = -1;
/** Not inspected — the inspector explicitly skipped it. */
export const SCORE_NOT_INSPECTED = -2;
/** A critical item at or below this score clamps the overall verdict. */
export const CRITICAL_THRESHOLD = 2;

export const FUEL_TYPES = ['petrol', 'diesel', 'hybrid', 'ev', 'other'];

// ---------------------------------------------------------------------------
// Defect matching
// ---------------------------------------------------------------------------

function clauseMatches(clause, make, model) {
  if (!(clause.makeAny ?? []).some((token) => make.includes(token))) return false;
  if (clause.modelAny === undefined) return true;
  return clause.modelAny.some((token) => model.includes(token));
}

/**
 * The first matching rule from the ordered rule list, or null. At most one rule
 * ever applies.
 */
export function matchDefectRule(make, model) {
  const mk = (make ?? '').toLowerCase();
  const md = (model ?? '').toLowerCase();
  if (!mk && !md) return null;
  for (const rule of canon().defects.rules) {
    if (rule.match.some((clause) => clauseMatches(clause, mk, md))) return rule;
  }
  return null;
}

/** A matched rule rendered as the top-level `defects` group. */
export function defectGroup(rule) {
  return {
    id: 'defects',
    order: 6,
    title: rule.label,
    children: [
      {
        id: 'defects.g',
        order: 0,
        title: rule.label,
        items: rule.defects.map((defect, index) => ({
          id: `defect.${defect.id}`,
          order: index,
          prompt: defect.text,
          critical: Boolean(defect.critical),
          sourceDefectId: defect.id,
        })),
      },
    ],
  };
}

// ---------------------------------------------------------------------------
// Assembly
// ---------------------------------------------------------------------------

/**
 * Base groups, plus the fuel module, plus the known-defect group when the
 * make/model matches a curated rule.
 */
export function assemble(car = {}) {
  const { checklist } = canon();
  const groups = [...checklist.base];

  const module = checklist.modules.fuel[car.fuelType ?? ''];
  if (module !== undefined) groups.push(module);

  const rule = matchDefectRule(car.make, car.model);
  if (rule !== null) groups.push(defectGroup(rule));
  return groups;
}

/** Every leaf item under `groups`, depth-first. */
export function allItems(groups) {
  const out = [];
  const walk = (group) => {
    out.push(...(group.items ?? []));
    (group.children ?? []).forEach(walk);
  };
  groups.forEach(walk);
  return out;
}

// ---------------------------------------------------------------------------
// Scoring
// ---------------------------------------------------------------------------

/** True only for a real 1–5 rating — sentinels and nulls are excluded. */
export function isRealScore(score) {
  return score !== null && score !== undefined && score > 0;
}

/**
 * The rolled-up 1–5 score for a group, or null when nothing real is answered
 * underneath it. Child groups contribute with weight 1.
 */
export function groupScore(group, scores) {
  const parts = [];

  for (const item of group.items ?? []) {
    const score = scores[item.id];
    if (isRealScore(score)) parts.push([score, item.weight ?? 1]);
  }
  for (const child of group.children ?? []) {
    const childScore = groupScore(child, scores);
    if (childScore !== null) parts.push([childScore, 1]);
  }
  if (parts.length === 0) return null;

  switch (group.aggregation ?? 'average') {
    case 'worst_case':
      return Math.min(...parts.map(([value]) => value));
    case 'weighted': {
      const total = parts.reduce((sum, [, weight]) => sum + weight, 0);
      if (total === 0) return 0;
      return parts.reduce((sum, [value, weight]) => sum + value * weight, 0) / total;
    }
    default:
      return parts.reduce((sum, [value]) => sum + value, 0) / parts.length;
  }
}

export function criticalItems(groups) {
  return allItems(groups).filter((item) => item.critical);
}

/** The mean of the top-level group scores, before the critical clamp. */
export function overallBeforeClamp(groups, scores) {
  const tops = groups
    .map((group) => groupScore(group, scores))
    .filter((score) => score !== null);
  if (tops.length === 0) return null;
  return tops.reduce((sum, score) => sum + score, 0) / tops.length;
}

/**
 * The overall 1–5 verdict: the mean of the top-level group scores, then clamped
 * down by any answered critical item scoring at or below `criticalThreshold`.
 * The clamp only ever lowers the verdict.
 */
export function overall(groups, scores, criticalThreshold = CRITICAL_THRESHOLD) {
  let verdict = overallBeforeClamp(groups, scores);
  if (verdict === null) return null;
  for (const item of criticalItems(groups)) {
    const score = scores[item.id];
    if (isRealScore(score) && score <= criticalThreshold && score < verdict) {
      verdict = score;
    }
  }
  return verdict;
}

/** `[answered, total]` over leaf items. Sentinels count as answered. */
export function progress(groups, scores) {
  const items = allItems(groups);
  const answered = items.filter(
    (item) => scores[item.id] !== undefined && scores[item.id] !== null,
  ).length;
  return [answered, items.length];
}

// ---------------------------------------------------------------------------
// Localisation
// ---------------------------------------------------------------------------

/** One language out of a `{lang: text}` map, falling back to English. */
export function pick(text, lang) {
  return text[lang] ?? text.en ?? Object.values(text)[0] ?? '';
}

/** The assembled tree with one language resolved per title and prompt. */
export function localize(groups, lang) {
  const localizeItem = (item) => {
    const out = {
      id: item.id,
      order: item.order ?? 0,
      prompt: pick(item.prompt, lang),
      critical: Boolean(item.critical),
    };
    if ((item.weight ?? 1) !== 1) out.weight = item.weight;
    if (item.sourceDefectId) out.sourceDefectId = item.sourceDefectId;
    return out;
  };

  const localizeGroup = (group) => {
    const out = {
      id: group.id,
      order: group.order ?? 0,
      title: pick(group.title, lang),
      aggregation: group.aggregation ?? 'average',
    };
    if (group.children?.length) out.children = group.children.map(localizeGroup);
    if (group.items?.length) out.items = group.items.map(localizeItem);
    return out;
  };

  return groups.map(localizeGroup);
}
