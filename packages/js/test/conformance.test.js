// The shared conformance suite. vectors.json is copied from
// inspection-core/conformance/ by inspection-core/tools/sync_canon.py; every
// port must pass exactly these vectors. A failure here means this port
// disagrees with the canon, not that the vectors need updating.

import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import test from 'node:test';
import { fileURLToPath } from 'node:url';

import {
  allItems,
  assemble,
  canon,
  canonVersion,
  groupScore,
  localize,
  matchDefectRule,
  overall,
  overallBeforeClamp,
  progress,
} from '../index.js';

const HERE = dirname(fileURLToPath(import.meta.url));
const vectors = JSON.parse(readFileSync(join(HERE, 'vectors.json'), 'utf8'));
const TOLERANCE = vectors.notes.tolerance;

function near(actual, expected, message) {
  if (expected === null || actual === null) {
    assert.equal(actual, expected, message);
    return;
  }
  assert.ok(
    Math.abs(actual - expected) <= TOLERANCE,
    `${message}: got ${actual}, want ${expected}`,
  );
}

const carOf = (spec) => ({
  make: spec.make,
  model: spec.model,
  fuelType: spec.fuelType,
});

for (const vector of vectors.scoring) {
  test(`scoring — ${vector.name}`, () => {
    const groups = vectors.fixtures[vector.fixture].groups;
    const { scores, expect } = vector;

    for (const [id, want] of Object.entries(expect.groupScores)) {
      const group = groups.find((g) => g.id === id);
      near(groupScore(group, scores), want, id);
    }
    near(
      overallBeforeClamp(groups, scores),
      expect.overallBeforeClamp,
      'overallBeforeClamp',
    );
    near(overall(groups, scores), expect.overall, 'overall');
    assert.deepEqual(progress(groups, scores), expect.progress);
  });
}

for (const vector of vectors.assembly) {
  test(`assembly — ${vector.name}`, () => {
    const groups = assemble(carOf(vector.car));
    assert.deepEqual(
      groups.map((g) => g.id),
      vector.expect.groupIds,
    );
    assert.equal(allItems(groups).length, vector.expect.itemCount);

    const rule = matchDefectRule(vector.car.make, vector.car.model);
    assert.equal(rule ? rule.id : null, vector.expect.defectRuleId);
  });
}

for (const vector of vectors.matching) {
  test(`matching — ${vector.make} ${vector.model}`, () => {
    const rule = matchDefectRule(vector.make, vector.model);
    assert.equal(rule ? rule.id : null, vector.expect);
  });
}

for (const vector of vectors.canonScoring) {
  test(`canon scoring — ${vector.name}`, () => {
    const groups = assemble(carOf(vector.car));
    const scores = Object.fromEntries(
      allItems(groups).map((item) => [item.id, vector.fillAll]),
    );
    Object.assign(scores, vector.override);

    if ('overallBeforeClamp' in vector.expect) {
      near(
        overallBeforeClamp(groups, scores),
        vector.expect.overallBeforeClamp,
        'overallBeforeClamp',
      );
    }
    near(overall(groups, scores), vector.expect.overall, 'overall');
    assert.deepEqual(progress(groups, scores), vector.expect.progress);
  });
}

test('the packaged canon is complete', () => {
  const { checklist, defects } = canon();
  assert.deepEqual(checklist.languages, ['en', 'pt', 'ru', 'uk', 'fr']);
  assert.ok(defects.rules.length >= 8);
  assert.deepEqual(canonVersion(), { checklist: 1, defects: 1 });
});

test('localize falls back to English', () => {
  const groups = assemble({ make: 'BMW', model: '320d' });
  const defects = groups.find((g) => g.id === 'defects');
  const localized = localize([defects], 'uk')[0];
  assert.match(localized.children[0].items[0].prompt, /N47/);
});

test('the README example holds', () => {
  const groups = assemble({
    make: 'Volkswagen',
    model: 'Golf',
    fuelType: 'diesel',
  });
  assert.deepEqual(
    groups.map((g) => g.id),
    ['ext', 'int', 'eng', 'road', 'docs', 'fuel.diesel', 'defects'],
  );
  assert.equal(allItems(groups).length, 33);
  assert.equal(overall(groups, { 'docs.all.mileage': 1 }), 1);
});
