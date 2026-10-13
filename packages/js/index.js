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
    // Known-defects v3 items (assembleV3) carry their resolution too.
    if ('status' in item) {
      out.dossierId = item.dossierId ?? null;
      out.status = item.status;
      out.needs = [...(item.needs ?? [])];
      out.hint = truthy(item.hint) ? pick(item.hint, lang) : null;
    }
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

// ---------------------------------------------------------------------------
// Known defects v3
// ---------------------------------------------------------------------------
//
// A v3 dossier names the models it concerns and, optionally, a `when`
// condition over the powertrain and the build date (`data/v3/`, copied from
// `inspection-core/data/v3/`). Given the facts known about a car,
// `resolveDefects` says for every dossier on that model whether it `applies`,
// is `possible` (and which facts would settle it), or is `not_applicable` (and
// which facts ruled it out).
//
// Conditions are evaluated in three-valued (Kleene) logic: true, false or
// unknown (null). Unknown is never rounded down to "not applicable" — a false
// "possible" costs the buyer one question, a false "not applicable" can cost
// them an engine.
//
// No network: a VIN is only used for its first three characters (the WMI), to
// find the make when none is given.

/** Query-parameter names in the order `needs` and `excludedBy` list them. */
export const NEEDS_ORDER = Object.freeze([
  'model',
  'year',
  'fuel',
  'gearbox',
  'gearboxCode',
  'engineCode',
  'productionDate',
]);

/** The coarse gearbox answers a buyer can give. */
export const GEARBOX_COARSE = Object.freeze(['manual', 'automatic', 'dct', 'cvt']);

export const FUEL_TYPES_V3 = Object.freeze(['petrol', 'diesel', 'hybrid', 'ev', 'other']);

export const STATUSES = Object.freeze(['applies', 'possible', 'not_applicable']);

/** Title of the assembled `defects` group when no v2 rule matched the car. */
export const KNOWN_DEFECTS_TITLE = Object.freeze({
  en: 'Known defects',
  pt: 'Defeitos conhecidos',
  ru: 'Известные дефекты',
  uk: 'Відомі дефекти',
  fr: 'Défauts connus',
});

/** A `when` condition outside the closed condition language. */
export class ConditionError extends Error {
  constructor(message) {
    super(message);
    this.name = 'ConditionError';
  }
}

// Closed gearbox.type enum -> the coarse answers that describe it.
const GEARBOX_TYPE_COARSE = new Map([
  ['manual', new Set(['manual'])],
  ['automatic_tc', new Set(['automatic'])],
  ['cvt', new Set(['automatic', 'cvt'])],
  ['dct_dry', new Set(['automatic', 'dct'])],
  ['dct_wet', new Set(['automatic', 'dct'])],
  ['amt', new Set(['automatic'])],
  ['single_speed_ev', new Set(['automatic'])],
]);
const EMPTY_SET = new Set();

const CC_TOLERANCE = 50;
const KW_TOLERANCE = 3;
// Fuel facts that say which engine is fitted. A hybrid runs a petrol or diesel
// engine and "other" is mostly LPG/CNG conversions of petrol engines, so
// neither may rule an engine out.
const ENGINE_FUELS = new Set(['petrol', 'diesel', 'ev']);

/** Python truthiness: null, undefined, false, 0, '' and empty lists/objects are falsy. */
function truthy(value) {
  if (value === null || value === undefined) return false;
  if (Array.isArray(value) || typeof value === 'string') return value.length > 0;
  if (typeof value === 'object') return Object.keys(value).length > 0;
  return Boolean(value);
}

const has = (object, key) =>
  object !== null && object !== undefined && Object.prototype.hasOwnProperty.call(object, key);

/** Code-point order, like Python's `sorted()` on strings (not localeCompare). */
function byCodePoint(a, b) {
  const x = Array.from(a);
  const y = Array.from(b);
  const n = Math.min(x.length, y.length);
  for (let i = 0; i < n; i++) {
    const d = x[i].codePointAt(0) - y[i].codePointAt(0);
    if (d !== 0) return d;
  }
  return x.length - y.length;
}

// Python's str.isspace() set, for strip() and split().
const PY_SPACE = '\\t\\n\\v\\f\\r\\x1c-\\x1f \\x85\\xa0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000';
const PY_SPLIT = new RegExp(`[${PY_SPACE}]+`, 'u');
const PY_STRIP = new RegExp(`^[${PY_SPACE}]+|[${PY_SPACE}]+$`, 'gu');
const pyStrip = (s) => s.replace(PY_STRIP, '');

// Where Python's str.casefold() differs from toLowerCase() (Unicode 16), after
// the NFKD and the combining-mark drop that follow. U+0345 (iota subscript)
// is folded separately, on the canonical decomposition.
const CASEFOLD = {
  'ß': 'ss',
  'ς': 'σ',
  'ᲀ': 'в',
  'ᲁ': 'д',
  'ᲂ': 'о',
  'ᲃ': 'с',
  'ᲄ': 'т',
  'ᲅ': 'т',
  'ᲆ': 'ъ',
  'ᲇ': 'ѣ',
  'ᲈ': 'ꙋ',
};
// Cherokee small letters casefold to the capitals.
const CASEFOLD_CHARS = /[ßςᲀ-ᲈᏸ-ᏽꭰ-ꮿ]/gu;

const combiningCache = new Map();
/**
 * True for a code point with a non-zero canonical combining class (what
 * Python's `unicodedata.combining()` tests). JS has no direct API, so this
 * asks NFD: canonical reordering moves U+0316 (class 220) in front of U+0301
 * (class 230) only when the code point between them is not a starter.
 */
function isCombining(mark) {
  let value = combiningCache.get(mark);
  if (value === undefined) {
    const s = `á${mark}̖`.normalize('NFD');
    value = s.indexOf('̖') < s.indexOf('́');
    combiningCache.set(mark, value);
  }
  return value;
}

/** casefold -> strip diacritics -> '-' and '_' to spaces -> collapse spaces. */
export function normalizeName(s) {
  if (!s) return '';
  const folded = s
    .toLowerCase()
    .replace(CASEFOLD_CHARS, (c) => CASEFOLD[c] ?? c.toUpperCase())
    .normalize('NFD')
    .replace(/ͅ/g, 'ι')
    .normalize('NFKD')
    .replace(/\p{M}/gu, (m) => (isCombining(m) ? '' : m))
    .replace(/[-_]/g, ' ');
  return folded.split(PY_SPLIT).filter((w) => w !== '').join(' ');
}

function nameMatches(value, names) {
  for (const name of names) {
    const n = normalizeName(name);
    if (n && (value === n || value.startsWith(`${n} `))) return true;
  }
  return false;
}

const upperSet = (values) => new Set(Array.from(values || [], (v) => v.toUpperCase()));
const family = (entity) => (entity.family || '').toUpperCase();
const isNone = (v) => v === null || v === undefined;
const intersects = (a, b) => [...a].some((v) => b.has(v));

function inYears(year, span) {
  if (isNone(year) || !truthy(span)) return true;
  const lo = span.from;
  const hi = span.to;
  return (isNone(lo) || year >= lo) && (isNone(hi) || year <= hi);
}

/**
 * True if every candidate satisfies, false if none does, else unknown (null).
 * An empty candidate set is unknown, never false.
 */
function over(values) {
  if (values.length === 0) return null;
  if (values.every(Boolean)) return true;
  if (!values.some(Boolean)) return false;
  return null;
}

const NEEDS_INDEX = new Map(NEEDS_ORDER.map((n, i) => [n, i]));
function ordered(names) {
  const rank = (n) => NEEDS_INDEX.get(n) ?? NEEDS_ORDER.length;
  return [...new Set(names)].sort((a, b) => rank(a) - rank(b) || byCodePoint(a, b));
}

const dedupe = (items) => [...new Set(items)];

const value = (v, needs = [], used = [], warnings = []) => ({
  value: v,
  needs: new Set(needs),
  used: new Set(used),
  warnings,
});

const resolution = (defectId, status, needs = [], excludedBy = [], warnings = []) => ({
  defectId,
  status,
  needs: [...needs],
  excludedBy: [...excludedBy],
  warnings: [...warnings],
});

/** Facts with the API's camelCase names; anything else is ignored. */
function factsOf(data) {
  const d = data ?? {};
  const get = (k) => (d[k] === undefined ? null : d[k]);
  return {
    make: get('make'),
    model: get('model'),
    year: get('year'),
    productionDate: get('productionDate'),
    fuel: get('fuel'),
    engineCode: get('engineCode'),
    engineFamily: get('engineFamily'),
    gearbox: get('gearbox'),
    gearboxCode: get('gearboxCode'),
    cc: get('cc'),
    powerKw: get('powerKw'),
    vin: get('vin'),
  };
}

const blank = (v) => (v === '' ? null : v);
const code = (v) => blank(typeof v === 'string' ? pyStrip(v).toUpperCase() : v);

/**
 * `vehicles.json` + `defects.json` (format 3), indexed for resolving.
 *
 * Only dossiers whose `status` is `published` are served. The canon
 * guarantees that every published dossier clears the evidence threshold, so
 * this package need not carry the evidence file to decide that.
 */
export class DefectsCanon {
  /**
   * @param {any} vehicles parsed `vehicles.json`
   * @param {any} defects parsed `defects.json`
   */
  constructor(vehicles, defects) {
    this.vehicles = vehicles;
    this.defects = defects;
    const v = vehicles;
    /** @type {Map<string, any>} served dossiers by id */
    this.defectsById = new Map();
    for (const d of defects.defects ?? []) {
      if (d.status === 'published') this.defectsById.set(d.id, d);
    }
    this._makes = [...(v.makes ?? [])];
    this._models = [...(v.models ?? [])];
    this._modelsById = new Map(this._models.map((m) => [m.id, m]));
    this._generationsByModel = new Map();
    for (const g of v.generations ?? []) {
      if (!this._generationsByModel.has(g.model)) this._generationsByModel.set(g.model, []);
      this._generationsByModel.get(g.model).push(g);
    }
    this._fitmentsByGeneration = new Map();
    for (const f of v.fitments ?? []) {
      if (!this._fitmentsByGeneration.has(f.generation)) {
        this._fitmentsByGeneration.set(f.generation, []);
      }
      this._fitmentsByGeneration.get(f.generation).push(f);
    }
    this._engines = [...(v.engines ?? [])];
    this._gearboxes = [...(v.gearboxes ?? [])];
    this._enginesById = new Map(this._engines.map((e) => [e.id, e]));
    this._gearboxesById = new Map(this._gearboxes.map((g) => [g.id, g]));
    // Later entries win on a duplicated code, as in the reference.
    this._enginesByCode = new Map();
    for (const e of this._engines) {
      for (const c of e.codes ?? []) this._enginesByCode.set(c.toUpperCase(), e);
    }
    this._gearboxesByCode = new Map();
    for (const g of this._gearboxes) {
      for (const c of g.codes ?? []) this._gearboxesByCode.set(c.toUpperCase(), g);
    }
    this._engineFamilies = new Set(this._engines.map(family));
    this._engineFamilies.delete('');
    // Old id -> served id, from the `aliases` of served dossiers: a renamed
    // defect keeps its old id (stored `defect.<old id>` answers and the v2
    // rules still use it) and reaches the new dossier.
    /** @type {Map<string, string>} */
    this.aliasOf = new Map();
    for (const [did, d] of this.defectsById) {
      for (const alias of d.aliases ?? []) {
        if (!this.defectsById.has(alias)) this.aliasOf.set(alias, did);
      }
    }
  }

  /** Same as `new DefectsCanon(vehicles, defects)`. */
  static fromData(vehicles, defects) {
    return new DefectsCanon(vehicles, defects);
  }

  get format() {
    return Number(this.defects.format ?? 3);
  }

  get questions() {
    return this.defects.questions ?? {};
  }

  /**
   * The served dossier id for a defect id: itself when it is a published
   * dossier, the dossier that lists it in `aliases` when it was renamed, else
   * null (deprecated or unknown).
   */
  servedId(defectId) {
    if (this.defectsById.has(defectId)) return defectId;
    return this.aliasOf.get(defectId) ?? null;
  }

  // --- names ---------------------------------------------------------------

  normalizeMake(s) {
    const v = normalizeName(s);
    if (!v) return null;
    for (const make of this._makes) {
      if (nameMatches(v, [...(make.names ?? []), make.id])) return make.id;
    }
    return null;
  }

  normalizeModel(makeId, s) {
    const v = normalizeName(s);
    if (!makeId || !v) return null;
    for (const model of this._models) {
      if (model.make !== makeId) continue;
      if (nameMatches(v, model.excludeNames ?? [])) continue;
      if (nameMatches(v, model.names ?? [])) return model.id;
    }
    return null;
  }

  makeFromWmi(vin) {
    const wmi = Array.from(pyStrip(vin || '').toUpperCase()).slice(0, 3).join('');
    if (!wmi) return null;
    for (const make of this._makes) {
      if (upperSet(make.wmi).has(wmi)) return make.id;
    }
    return null;
  }

  /** `{make, model}`: the make id and model id as the dictionary understands them. */
  resolvedModel(facts) {
    const f = this._prepare(facts);
    const make = this.normalizeMake(f.make);
    return { make, model: this.normalizeModel(make, f.model) };
  }

  // --- resolving -------------------------------------------------------------

  /** Status of one served dossier for these facts; null if there is none. */
  resolveDefect(defectId, facts) {
    const defect = this.defectsById.get(defectId);
    if (defect === undefined) return null;
    return this._resolve(defect, this._context(facts));
  }

  /** Same as `resolveV3`. */
  resolveDefects(facts) {
    return this.resolveV3(facts);
  }

  /**
   * Every served dossier whose `applicability.models` contains the car's
   * model, in id order. Empty when the model is not recognised.
   */
  resolveV3(facts) {
    const ctx = this._context(facts);
    if (ctx.modelId === null) return [];
    return this._sortedDossiers()
      .filter(([, d]) => (d.applicability?.models ?? []).includes(ctx.modelId))
      .map(([, d]) => this._resolve(d, ctx));
  }

  /**
   * The checklist for a car described by facts: the base groups, the fuel
   * module for `facts.fuel`, and a `defects` group built the way
   * `GET /v1/defects` builds its list when facts are given.
   *
   * The v2 rule's rows come first, in rule order, keeping their v2 id
   * (`defect.<v2 id>`), text and critical flag so stored answers stay valid.
   * Each is linked to its served dossier (itself, or the dossier that lists it
   * in `aliases`) and dropped when that dossier is `not_applicable`; a row
   * with no dossier stays, with status `legacy`. Then every other dossier on
   * the model that applies or is possible, in id order. Items carry `status`,
   * `needs`, `dossierId` and `hint` on top of the v2 item fields; the group
   * carries the matched v2 `ruleId`. No defects group when it would be empty.
   */
  assembleV3(facts) {
    const { checklist } = canon();
    const groups = checklist.base.map((g) => ({ ...g }));
    const f = this._prepare(facts);
    const fuel = checklist.modules.fuel;
    const key = f.fuel || '';
    if (has(fuel, key)) groups.push(fuel[key]);

    let rule = matchDefectRule(f.make, f.model);
    const rawMake = facts?.make;
    if (rule === null && (isNone(rawMake) || rawMake === '') && f.make !== null) {
      // A make id from the VIN's WMI, spelled the way v2 rules expect.
      const make = this._makes.find((m) => m.id === f.make) ?? {};
      const names = truthy(make.names) ? make.names : [f.make];
      rule = matchDefectRule(names[0], f.model);
    }

    const ctx = this._context(f);
    const items = [];
    const covered = new Set();
    for (const d of rule ? rule.defects : []) {
      const sid = this.servedId(d.id);
      let r = null;
      if (sid !== null) {
        covered.add(sid);
        r = this._resolve(this.defectsById.get(sid), ctx);
        if (r.status === 'not_applicable') continue;
      }
      items.push(this._item(d.id, d.text, Boolean(d.critical ?? false), sid, r));
    }
    if (ctx.modelId !== null) {
      for (const [did, dossier] of this._sortedDossiers()) {
        if (covered.has(did) || !(dossier.applicability?.models ?? []).includes(ctx.modelId)) {
          continue;
        }
        const r = this._resolve(dossier, ctx);
        if (r.status === 'not_applicable') continue;
        const prompt = [dossier.checklistPrompt, dossier.title].find(truthy) ?? {};
        items.push(this._item(did, prompt, isCritical(dossier), did, r));
      }
    }
    if (items.length === 0) return groups;
    items.forEach((item, i) => {
      item.order = i;
    });
    const title = rule ? rule.label : { ...KNOWN_DEFECTS_TITLE };
    groups.push({
      id: 'defects',
      order: 6,
      title,
      ruleId: rule ? rule.id : null,
      children: [{ id: 'defects.g', order: 0, title, items }],
    });
    return groups;
  }

  // --- internals -------------------------------------------------------------

  _sortedDossiers() {
    return [...this.defectsById].sort(([a], [b]) => byCodePoint(a, b));
  }

  _item(defectId, prompt, critical, dossierId, r) {
    let hint = null;
    if (dossierId !== null) {
      hint = this.defectsById.get(dossierId).applicability?.hint ?? null;
    }
    return {
      id: `defect.${defectId}`,
      order: 0,
      prompt,
      critical,
      sourceDefectId: defectId,
      dossierId,
      status: r !== null ? r.status : 'legacy',
      needs: r !== null ? [...r.needs] : [],
      hint,
    };
  }

  _prepare(facts) {
    const f = factsOf(facts);
    let make = blank(f.make);
    const vin = code(f.vin);
    if (make === null && vin !== null) make = this.makeFromWmi(vin);
    return {
      make,
      model: blank(f.model),
      year: f.year,
      productionDate: blank(f.productionDate),
      fuel: blank(f.fuel),
      engineCode: code(f.engineCode),
      engineFamily: code(f.engineFamily),
      gearbox: blank(f.gearbox),
      gearboxCode: code(f.gearboxCode),
      cc: f.cc,
      powerKw: f.powerKw,
      vin,
    };
  }

  /**
   * Read an engine code that is really a family name ("EB2") as a family, and
   * an "engine family" that is really a code ("N47D20") as that code. Taken
   * literally, either mix-up rules out the buyer's own engine.
   */
  _disambiguateEngine(f) {
    const { engineCode, engineFamily } = f;
    if (engineCode !== null && this._engineFamilies.has(engineCode)) {
      return { ...f, engineCode: null, engineFamily: engineFamily || engineCode };
    }
    if (
      engineCode === null &&
      engineFamily !== null &&
      !this._engineFamilies.has(engineFamily) &&
      this._enginesByCode.has(engineFamily)
    ) {
      return { ...f, engineCode: engineFamily, engineFamily: null };
    }
    return f;
  }

  _context(facts) {
    const f = this._disambiguateEngine(this._prepare(facts));
    const makeId = this.normalizeMake(f.make);
    const modelId = this.normalizeModel(makeId, f.model);
    const [candidates, warnings] = this._candidates(modelId, f);
    return { facts: f, modelId, candidates, warnings };
  }

  _engineFits(engine, f) {
    if (ENGINE_FUELS.has(f.fuel) && engine.fuel && engine.fuel !== f.fuel) return false;
    const cc = engine.displacementCc;
    if (!isNone(f.cc) && !isNone(cc) && Math.abs(f.cc - cc) > CC_TOLERANCE) return false;
    const powers = engine.powerKw || [];
    if (
      !isNone(f.powerKw) &&
      powers.length > 0 &&
      Math.min(...powers.map((p) => Math.abs(f.powerKw - p))) > KW_TOLERANCE
    ) {
      return false;
    }
    if (f.engineCode !== null && !upperSet(engine.codes).has(f.engineCode)) return false;
    return f.engineFamily === null || family(engine) === f.engineFamily;
  }

  _gearboxFits(gearbox, f) {
    if (
      f.gearbox !== null &&
      !(GEARBOX_TYPE_COARSE.get(gearbox.type ?? '') ?? EMPTY_SET).has(f.gearbox)
    ) {
      return false;
    }
    return (
      f.gearboxCode === null ||
      upperSet(gearbox.codes).has(f.gearboxCode) ||
      f.gearboxCode === family(gearbox)
    );
  }

  _candidates(modelId, f) {
    if (modelId === null) return [[], []];
    const allGens = this._generationsByModel.get(modelId) ?? [];
    const gens = allGens.filter((g) => inYears(f.year, g.years));
    const fitments = gens.flatMap((g) => this._fitmentsByGeneration.get(g.id) ?? []);
    const hasTable = allGens.some((g) => truthy(this._fitmentsByGeneration.get(g.id)));

    const pairs = [];
    for (const fit of fitments) {
      if (!inYears(f.year, fit.years)) continue;
      const engine = this._enginesById.get(fit.engine);
      if (engine === undefined || !this._engineFits(engine, f)) continue;
      const boxes = (fit.gearboxes ?? [])
        .filter((g) => this._gearboxesById.has(g))
        .map((g) => this._gearboxesById.get(g));
      if (boxes.length === 0) {
        pairs.push([engine, null]); // gearbox not recorded: unknown
        continue;
      }
      for (const box of boxes) {
        if (this._gearboxFits(box, f)) pairs.push([engine, box]);
      }
    }

    if (hasTable && pairs.length === 0) return [[], ['facts_not_in_fitment_table']];
    return [pairs, []];
  }

  // --- condition leaves ------------------------------------------------------

  static _engineMatches(engine, leaf) {
    if ((leaf.ids ?? []).includes(engine.id)) return true;
    if (upperSet(leaf.family).has(family(engine))) return true;
    return intersects(upperSet(leaf.codes), upperSet(engine.codes));
  }

  static _gearboxMatches(gearbox, leaf) {
    if ((leaf.ids ?? []).includes(gearbox.id)) return true;
    if (upperSet(leaf.family).has(family(gearbox))) return true;
    if ((leaf.type ?? []).includes(gearbox.type)) return true;
    return intersects(upperSet(leaf.codes), upperSet(gearbox.codes));
  }

  static _candidateFactsUsed(ctx) {
    const f = ctx.facts;
    const used = ['model'];
    for (const [name, val] of [
      ['year', f.year],
      ['fuel', f.fuel],
      ['cc', f.cc],
      ['powerKw', f.powerKw],
      ['gearbox', f.gearbox],
      ['gearboxCode', f.gearboxCode],
    ]) {
      if (!isNone(val)) used.push(name);
    }
    return used;
  }

  _evalEngine(leaf, ctx) {
    const f = ctx.facts;
    if (f.engineCode !== null) {
      if (upperSet(leaf.codes).has(f.engineCode)) return value(true);
      const engine = this._enginesByCode.get(f.engineCode);
      if (engine === undefined) return value(null, [], [], ['unrecognised_engine_code']);
      if (DefectsCanon._engineMatches(engine, leaf)) return value(true);
      return value(false, [], ['engineCode']);
    }

    const known = this._engines.filter((e) => DefectsCanon._engineMatches(e, leaf));
    if (f.engineFamily !== null) {
      const families = upperSet(leaf.family);
      for (const e of known) families.add(family(e));
      if (!families.has(f.engineFamily)) return value(false, [], ['engineFamily']);
      if (truthy(leaf.family) && !truthy(leaf.codes) && !truthy(leaf.ids)) return value(true);
    }

    // Fuel can rule an engine out without a fitment table; power and
    // displacement cannot (the dictionary lists confirmed ratings, not all).
    if (
      known.length > 0 &&
      ENGINE_FUELS.has(f.fuel) &&
      known.every((e) => e.fuel && e.fuel !== f.fuel)
    ) {
      return value(false, [], ['fuel']);
    }

    if (ctx.candidates.length > 0) {
      const verdict = over(ctx.candidates.map(([e]) => DefectsCanon._engineMatches(e, leaf)));
      if (verdict === false) return value(false, [], DefectsCanon._candidateFactsUsed(ctx));
      if (verdict === true) return value(true);
    }
    return value(null, ['engineCode']);
  }

  _evalGearbox(leaf, ctx) {
    const f = ctx.facts;
    if (f.gearboxCode !== null) {
      const named = upperSet(leaf.codes);
      for (const c of upperSet(leaf.family)) named.add(c);
      if (named.has(f.gearboxCode)) return value(true);
      const box =
        this._gearboxesByCode.get(f.gearboxCode) ??
        this._gearboxes.find((g) => family(g) === f.gearboxCode) ??
        null;
      if (box === null) return value(null, [], [], ['unrecognised_gearbox_code']);
      if (DefectsCanon._gearboxMatches(box, leaf)) return value(true);
      return value(false, [], ['gearboxCode']);
    }

    const known = this._gearboxes.filter((g) => DefectsCanon._gearboxMatches(g, leaf));
    const types = new Set(leaf.type ?? []);
    for (const g of known) types.add(g.type ?? null);
    if (f.gearbox !== null && types.size > 0) {
      const coarse = new Set();
      for (const t of types) {
        for (const c of GEARBOX_TYPE_COARSE.get(t) ?? EMPTY_SET) coarse.add(c);
      }
      if (!coarse.has(f.gearbox)) return value(false, [], ['gearbox']);
    }

    if (ctx.candidates.length > 0 && ctx.candidates.every(([, box]) => box !== null)) {
      const verdict = over(
        ctx.candidates.map(([, box]) => DefectsCanon._gearboxMatches(box, leaf)),
      );
      if (verdict === false) return value(false, [], DefectsCanon._candidateFactsUsed(ctx));
      if (verdict === true) return value(true);
    }
    return value(null, [f.gearbox !== null ? 'gearboxCode' : 'gearbox']);
  }

  _evalFuel(leaf, ctx) {
    const wanted = new Set(Array.isArray(leaf) ? leaf : leaf.in ?? []);
    if (ctx.facts.fuel !== null) {
      if (wanted.has(ctx.facts.fuel)) return value(true);
      return value(false, [], ['fuel']);
    }
    if (ctx.candidates.length > 0) {
      const verdict = over(ctx.candidates.map(([e]) => wanted.has(e.fuel ?? null)));
      if (verdict === false) return value(false, [], DefectsCanon._candidateFactsUsed(ctx));
      if (verdict === true) return value(true);
    }
    return value(null, ['fuel']);
  }

  static _evalModelYear(leaf, ctx) {
    const { year } = ctx.facts;
    if (isNone(year)) return value(null, ['year']);
    if (inYears(year, leaf)) return value(true);
    return value(false, [], ['year']);
  }

  static _evalProductionDate(leaf, ctx) {
    const lo = leaf.from ?? null;
    const hi = leaf.to ?? null;
    const pd = ctx.facts.productionDate;
    if (pd !== null) {
      if ((lo === null || pd >= lo) && (hi === null || pd <= hi)) return value(true);
      return value(false, [], ['productionDate']);
    }
    const { year } = ctx.facts;
    if (isNone(year)) return value(null, ['year']);
    const loY = lo ? parseInt(lo.slice(0, 4), 10) : null;
    const hiY = hi ? parseInt(hi.slice(0, 4), 10) : null;
    // A year is never earlier than the build year, but it can be one later
    // (model years run ahead, and first registration can trail the build). So
    // one year past the window is unknown; only a year before it, or two past
    // it, rules the car out.
    if ((loY !== null && year < loY) || (hiY !== null && year > hiY + 1)) {
      return value(false, [], ['year']);
    }
    // A year on a boundary month is ambiguous unless the boundary is a whole
    // calendar year (from January / to December).
    const onLo = loY !== null && year === loY && !lo.endsWith('-01');
    const onHi = hiY !== null && (year === hiY + 1 || (year === hiY && !hi.endsWith('-12')));
    if (onLo || onHi) return value(null, ['productionDate']);
    return value(true);
  }

  /** `make` / `model` / `generation` leaves: lists of dictionary ids. */
  _evalIds(kind, leaf, ctx) {
    const wanted = new Set(Array.isArray(leaf) ? leaf : leaf.ids ?? []);
    if (ctx.modelId === null) return value(null, ['model']);
    if (kind === 'make') {
      const make = this._modelsById.get(ctx.modelId).make;
      if (wanted.has(make)) return value(true);
      return value(false, [], ['make']);
    }
    if (kind === 'model') {
      if (wanted.has(ctx.modelId)) return value(true);
      return value(false, [], ['model']);
    }
    const gens = (this._generationsByModel.get(ctx.modelId) ?? []).filter((g) =>
      inYears(ctx.facts.year, g.years),
    );
    const verdict = over(gens.map((g) => wanted.has(g.id)));
    if (verdict === false) {
      return value(false, [], truthy(ctx.facts.year) ? ['model', 'year'] : ['model']);
    }
    if (verdict === true) return value(true);
    return value(null, ['year']);
  }

  static _combine(kind, parts) {
    const warnings = parts.flatMap((p) => p.warnings);
    const union = (ps, field) => ps.flatMap((p) => [...p[field]]);
    const values = parts.map((p) => p.value);
    if (kind === 'all') {
      if (values.some((v) => v === false)) {
        return value(false, [], union(parts.filter((p) => p.value === false), 'used'), warnings);
      }
      if (values.every((v) => v === true)) return value(true, [], [], warnings);
    } else {
      if (values.some((v) => v === true)) return value(true, [], [], warnings);
      if (values.every((v) => v === false)) {
        return value(false, [], union(parts, 'used'), warnings);
      }
    }
    return value(null, union(parts.filter((p) => p.value === null), 'needs'), [], warnings);
  }

  _eval(node, ctx) {
    const isObject = node !== null && typeof node === 'object' && !Array.isArray(node);
    if (!isObject || Object.keys(node).length !== 1) {
      throw new ConditionError(
        `condition node must have exactly one key: ${JSON.stringify(node)}`,
      );
    }
    const [[kind, arg]] = Object.entries(node);
    switch (kind) {
      case 'all':
      case 'any':
        return DefectsCanon._combine(
          kind,
          arg.map((n) => this._eval(n, ctx)),
        );
      case 'not': {
        const inner = this._eval(arg, ctx);
        if (inner.value === null) return inner;
        if (inner.value) return value(false, [], ['model'], inner.warnings);
        return value(true, [], [], inner.warnings);
      }
      case 'engine':
        return this._evalEngine(arg, ctx);
      case 'gearbox':
        return this._evalGearbox(arg, ctx);
      case 'fuel':
        return this._evalFuel(arg, ctx);
      case 'modelYear':
        return DefectsCanon._evalModelYear(arg, ctx);
      case 'productionDate':
        return DefectsCanon._evalProductionDate(arg, ctx);
      case 'make':
      case 'model':
      case 'generation':
        return this._evalIds(kind, arg, ctx);
      default:
        // `market` is deliberately absent: facts carry no market (format 3).
        throw new ConditionError(`unknown condition leaf: ${kind}`);
    }
  }

  _resolve(defect, ctx) {
    const did = defect.id;
    const applicability = defect.applicability ?? {};
    if (ctx.modelId === null) {
      const warnings = truthy(ctx.facts.model) ? ['unrecognised_model'] : [];
      return resolution(did, 'possible', ['model'], [], warnings);
    }
    if (!(applicability.models ?? []).includes(ctx.modelId)) {
      return resolution(did, 'not_applicable', [], ['model'], []);
    }
    const when = applicability.when;
    if (!truthy(when)) return resolution(did, 'applies', [], [], ctx.warnings);
    const result = this._eval(when, ctx);
    const warnings = dedupe([...ctx.warnings, ...result.warnings]);
    if (result.value === true) return resolution(did, 'applies', [], [], warnings);
    if (result.value === false) {
      return resolution(did, 'not_applicable', [], ordered(result.used), warnings);
    }
    return resolution(did, 'possible', ordered(result.needs), [], warnings);
  }
}

function isCritical(defect) {
  if (has(defect, 'critical')) return Boolean(defect.critical);
  return defect.severity === 'critical';
}

/** Build a canon from parsed `vehicles.json` and `defects.json` (format 3). */
export function createDefectsCanon(vehicles, defects) {
  return new DefectsCanon(vehicles, defects);
}

/** @type {DefectsCanon | null} */
let cachedV3 = null;

/** The v3 canon shipped with this package, parsed and indexed once. */
export function canonV3() {
  if (cachedV3 === null) {
    cachedV3 = new DefectsCanon(readCanon('v3/vehicles'), readCanon('v3/defects'));
  }
  return cachedV3;
}

/**
 * Every published v3 dossier on the car's model, resolved against the facts,
 * in id order. Empty when the model is not recognised.
 */
export function resolveDefects(facts, defectsCanon) {
  return (defectsCanon ?? canonV3()).resolveV3(facts);
}

/** Same as `resolveDefects`. */
export const resolveV3 = resolveDefects;

/** One dossier resolved against the facts; null if no such served dossier. */
export function resolveDefect(defectId, facts, defectsCanon) {
  return (defectsCanon ?? canonV3()).resolveDefect(defectId, facts);
}

/**
 * The served dossier id for a defect id, following `aliases`; null for a
 * deprecated or unknown id.
 */
export function servedId(defectId, defectsCanon) {
  return (defectsCanon ?? canonV3()).servedId(defectId);
}

/** The checklist for a car described by facts; see `DefectsCanon#assembleV3`. */
export function assembleV3(facts, defectsCanon) {
  return (defectsCanon ?? canonV3()).assembleV3(facts);
}

/** `{make, model}`: the dictionary's make id and model id, or null. */
export function resolvedModel(facts, defectsCanon) {
  return (defectsCanon ?? canonV3()).resolvedModel(facts);
}

export function normalizeMake(s, defectsCanon) {
  return (defectsCanon ?? canonV3()).normalizeMake(s);
}

export function normalizeModel(makeId, s, defectsCanon) {
  return (defectsCanon ?? canonV3()).normalizeModel(makeId, s);
}

/** The make id for a VIN's world manufacturer identifier, offline. */
export function makeFromWmi(vin, defectsCanon) {
  return (defectsCanon ?? canonV3()).makeFromWmi(vin);
}
