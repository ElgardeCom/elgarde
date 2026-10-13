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
  assembleV3,
  canon,
  canonV3,
  canonVersion,
  ConditionError,
  createDefectsCanon,
  groupScore,
  localize,
  matchDefectRule,
  normalizeName,
  overall,
  overallBeforeClamp,
  pick,
  progress,
  resolveDefect,
  resolveDefects,
  resolvedModel,
  resolveV3,
  SCORE_NOT_APPLICABLE,
  servedId,
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
  assert.deepEqual(canonVersion(), { checklist: 1, defects: 2 });
});

test('defect text is authored in every language, not fallen back on', () => {
  const groups = assemble({ make: 'BMW', model: '320d' });
  const defects = groups.find((g) => g.id === 'defects');
  const item = defects.children[0].items[0];
  const english = pick(item.prompt, 'en');

  for (const lang of ['pt', 'ru', 'uk', 'fr']) {
    const translated = pick(item.prompt, lang);
    assert.notEqual(translated, english, `${lang} still falls back to English`);
    assert.match(translated, /N47/, `${lang} lost the engine code`);
  }

  // An unsupported language still falls back rather than coming back empty.
  assert.equal(pick(item.prompt, 'de'), english);
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

// ---------------------------------------------------------------------------
// Known defects v3
// ---------------------------------------------------------------------------

const V3_FIXTURES = Object.fromEntries(
  Object.entries(vectors.v3Fixtures).map(([name, fx]) => [
    name,
    createDefectsCanon(fx.vehicles, fx.defects),
  ]),
);

const canonFor = (vec) => (vec.fixture !== undefined ? V3_FIXTURES[vec.fixture] : canonV3());

for (const vec of vectors.resolveV3) {
  test(`resolveV3 — ${vec.name}`, () => {
    assert.deepEqual(resolveV3(vec.facts, canonFor(vec)), vec.expect);
  });
}

for (const vec of vectors.resolveDefect) {
  test(`resolveDefect — ${vec.name}`, () => {
    assert.deepEqual(resolveDefect(vec.defectId, vec.facts, canonFor(vec)), vec.expect);
  });
}

for (const vec of vectors.v3Names) {
  test(`v3Names — ${vec.make} / ${vec.model} / ${vec.vin ?? ''}`, () => {
    assert.deepEqual(resolvedModel(vec), vec.expect);
  });
}

for (const vec of vectors.v3ServedIds) {
  test(`v3ServedIds — ${vec.id || 'empty'}`, () => {
    assert.equal(servedId(vec.id), vec.expect);
  });
}

for (const vec of vectors.assembleV3) {
  test(`assembleV3 — ${vec.name}`, () => {
    const groups = assembleV3(vec.facts);
    const { expect } = vec;
    assert.deepEqual(
      groups.map((g) => g.id),
      expect.groupIds,
    );
    assert.equal(allItems(groups).length, expect.itemCount);
    const group = groups.find((g) => g.id === 'defects');
    if (group === undefined) {
      assert.equal(expect.defectsTitle, null);
      assert.deepEqual(expect.defects, []);
      return;
    }
    assert.equal(group.ruleId, expect.defectRuleId);
    assert.equal(pick(group.title, 'en'), expect.defectsTitle);
    const items = allItems([group]);
    const rows = items.map((i) => ({
      id: i.id,
      sourceDefectId: i.sourceDefectId,
      dossierId: i.dossierId,
      status: i.status,
      needs: i.needs,
      critical: i.critical,
      prompt: pick(i.prompt, 'en'),
      hint: i.hint ? pick(i.hint, 'en') : null,
    }));
    assert.deepEqual(rows, expect.defects);
    assert.deepEqual(
      items.map((i) => i.order),
      rows.map((_, n) => n),
    );
  });
}

test('assembleV3 localizes and scores', () => {
  const groups = assembleV3({ make: 'Mercedes-Benz', model: 'C-Class' });
  const out = localize(groups, 'fr');
  const rows = out[out.length - 1].children[0].items;
  const alias = rows.find((r) => r.sourceDefectId === 'm271.balanceshaft');
  assert.equal(alias.id, 'defect.m271.balanceshaft');
  assert.equal(alias.dossierId, 'm271.timingchain');
  assert.equal(alias.status, 'possible');
  assert.deepEqual(alias.needs, ['year', 'engineCode']);
  assert.equal(typeof alias.hint, 'string');
  // A 'possible' item answered "not applicable" is just a -1 to scoring.
  const scores = Object.fromEntries(allItems(groups).map((i) => [i.id, 4]));
  scores[alias.id] = SCORE_NOT_APPLICABLE;
  near(overall(groups, scores), 4, 'overall');
});

test('the v2 API is untouched by v3', () => {
  const groups = assemble({ make: 'Mercedes-Benz', model: 'C-Class', fuelType: 'petrol' });
  const items = allItems([groups[groups.length - 1]]);
  assert.deepEqual(
    items.map((i) => i.sourceDefectId),
    ['om651.injectors', 'm271.balanceshaft', 'rust'],
  );
  assert.ok(items.every((i) => !('status' in i)));
  for (const item of localize(groups, 'en').at(-1).children[0].items) {
    assert.deepEqual(Object.keys(item), ['id', 'order', 'prompt', 'critical', 'sourceDefectId']);
  }
});

test('resolveDefects is resolveV3', () => {
  const facts = { make: 'BMW', model: '320d', year: 2010 };
  assert.equal(resolveDefects, resolveV3);
  assert.deepEqual(resolveDefects(facts), resolveV3(facts));
  const n47 = resolveDefect('n47.chain', { ...facts, engineCode: ' n47d20 ' });
  assert.equal(n47.status, 'applies');
});

test('the packaged v3 canon', () => {
  const v3 = canonV3();
  assert.equal(v3.format, 3);
  for (const id of ['dsg.dq200', 'n47.chain', 'puretech.wetbelt']) {
    assert.ok(v3.defectsById.has(id), id);
  }
  assert.equal(v3.defectsById.size, 15);
  assert.deepEqual(Object.fromEntries(v3.aliasOf), { 'm271.balanceshaft': 'm271.timingchain' });
});

test('the v3 condition language is closed', () => {
  const closed = createDefectsCanon(vectors.v3Fixtures.synthetic.vehicles, {
    format: 3,
    defects: [
      {
        id: 'x',
        status: 'published',
        applicability: { models: ['testa.alpha'], when: { market: ['EU'] } },
      },
    ],
  });
  assert.throws(() => closed.resolveV3({ make: 'testa', model: 'alpha' }), ConditionError);
  const twoKeys = createDefectsCanon(vectors.v3Fixtures.synthetic.vehicles, {
    format: 3,
    defects: [
      {
        id: 'x',
        status: 'published',
        applicability: {
          models: ['testa.alpha'],
          when: { modelYear: { from: 2000 }, fuel: ['petrol'] },
        },
      },
    ],
  });
  assert.throws(() => twoKeys.resolveV3({ make: 'testa', model: 'alpha' }), ConditionError);
});

test('names fold like Python casefold + NFKD', () => {
  assert.equal(normalizeName('  STRASSE-Straße_ΟΔΟΣ  Citroën\u00a0C4 '), 'strasse strasse οδοσ citroen c4');
  assert.equal(normalizeName('ﬁat ᾈ'), 'fiat αι');
  assert.equal(normalizeName(''), '');
  assert.equal(normalizeName(null), '');
});

test('the v3 README example holds', () => {
  const facts = { make: 'VW', model: 'Golf', gearbox: 'manual', fuel: 'diesel' };
  const got = resolveDefects(facts);
  assert.deepEqual([got[0].defectId, got[0].status], ['dsg.dq200', 'not_applicable']);

  assert.deepEqual(
    resolveDefects({ make: 'Peugeot', model: '208', engineCode: 'HNZ', productionDate: '2015-06' }),
    [{ defectId: 'puretech.wetbelt', status: 'applies', needs: [], excludedBy: [], warnings: [] }],
  );
  assert.deepEqual(
    resolveDefects({ make: 'VW', model: 'Golf', year: 2014 }).map((r) => [r.defectId, r.status, r.needs]),
    [
      ['dsg.dq200', 'possible', ['gearbox']],
      ['tdi.egr', 'possible', ['engineCode']],
      ['tsi.chain', 'possible', ['engineCode']],
      ['tsi.oil', 'not_applicable', []],
    ],
  );
  const groups = assembleV3({ make: 'Volkswagen', model: 'Golf', fuel: 'petrol', year: 2012 });
  assert.deepEqual(
    localize(groups, 'en').at(-1).children[0].items.map((i) => [i.id, i.status, i.needs]),
    [
      ['defect.dsg.dq200', 'possible', ['gearbox']],
      ['defect.tsi.chain', 'possible', ['engineCode', 'productionDate']],
      ['defect.tsi.oil', 'possible', ['engineCode', 'productionDate']],
    ],
  );
  assert.equal(servedId('m271.balanceshaft'), 'm271.timingchain');
});
