/** Language code to text. `en` is always present and is the fallback. */
export type LocalizedText = Record<string, string> & { en: string };

export type Aggregation = 'average' | 'weighted' | 'worst_case';

export interface ChecklistItem {
  id: string;
  order: number;
  prompt: LocalizedText;
  /** Relative weight under `weighted` aggregation. Defaults to 1. */
  weight?: number;
  /** A failing score on a critical item clamps the overall verdict down. */
  critical?: boolean;
  /** Provenance back to the defect record that generated this item. */
  sourceDefectId?: string;
}

/** A defects-group item built by `assembleV3`: a v2 item plus its v3 resolution. */
export interface ChecklistItemV3 extends ChecklistItem {
  sourceDefectId: string;
  critical: boolean;
  /** The served dossier this row is linked to, or null for a `legacy` row. */
  dossierId: string | null;
  status: DefectStatus | 'legacy';
  needs: FactName[];
  hint: LocalizedText | null;
}

export interface ChecklistGroup {
  id: string;
  order: number;
  title: LocalizedText;
  /** On the `defects` group from `assembleV3`: the matched v2 rule id, or null. */
  ruleId?: string | null;
  aggregation?: Aggregation;
  children?: ChecklistGroup[];
  items?: ChecklistItem[];
}

export interface LocalizedItem {
  id: string;
  order: number;
  prompt: string;
  critical: boolean;
  weight?: number;
  sourceDefectId?: string;
  /** Present on `assembleV3` defect items only. */
  dossierId?: string | null;
  status?: DefectStatus | 'legacy';
  needs?: FactName[];
  hint?: string | null;
}

export interface LocalizedGroup {
  id: string;
  order: number;
  title: string;
  aggregation: Aggregation;
  children?: LocalizedGroup[];
  items?: LocalizedItem[];
}

export interface Defect {
  id: string;
  text: LocalizedText;
  critical?: boolean;
}

export interface MatchClause {
  makeAny: string[];
  modelAny?: string[];
}

export interface DefectRule {
  id: string;
  label: LocalizedText;
  match: MatchClause[];
  defects: Defect[];
}

export type FuelType = 'petrol' | 'diesel' | 'hybrid' | 'ev' | 'other';

export interface Car {
  make?: string | null;
  model?: string | null;
  fuelType?: FuelType | string | null;
}

/**
 * Answers keyed by checklist item id: 1–5 rates the item, -1 marks it not
 * applicable, -2 not inspected. An absent key means unanswered.
 */
export type Scores = Record<string, number | null | undefined>;

export interface Canon {
  checklist: {
    version: number;
    languages: string[];
    base: ChecklistGroup[];
    modules: { fuel: Record<string, ChecklistGroup> };
  };
  defects: { version: number; languages: string[]; rules: DefectRule[] };
}

export const SCORE_NOT_APPLICABLE: -1;
export const SCORE_NOT_INSPECTED: -2;
export const CRITICAL_THRESHOLD: number;
export const FUEL_TYPES: readonly FuelType[];

export function canon(): Canon;
export function canonVersion(): { checklist: number; defects: number };

export function matchDefectRule(
  make?: string | null,
  model?: string | null,
): DefectRule | null;
export function defectGroup(rule: DefectRule): ChecklistGroup;

export function assemble(car?: Car): ChecklistGroup[];
export function allItems(groups: ChecklistGroup[]): ChecklistItem[];

export function isRealScore(score: number | null | undefined): boolean;
export function groupScore(group: ChecklistGroup, scores: Scores): number | null;
export function criticalItems(groups: ChecklistGroup[]): ChecklistItem[];
export function overallBeforeClamp(
  groups: ChecklistGroup[],
  scores: Scores,
): number | null;
export function overall(
  groups: ChecklistGroup[],
  scores: Scores,
  criticalThreshold?: number,
): number | null;
export function progress(
  groups: ChecklistGroup[],
  scores: Scores,
): [answered: number, total: number];

export function pick(text: LocalizedText, lang: string): string;
export function localize(groups: ChecklistGroup[], lang: string): LocalizedGroup[];

// ---------------------------------------------------------------------------
// Known defects v3
// ---------------------------------------------------------------------------

export type DefectStatus = 'applies' | 'possible' | 'not_applicable';

/** Fact names as `needs` and `excludedBy` report them. */
export type FactName =
  | 'model'
  | 'year'
  | 'fuel'
  | 'gearbox'
  | 'gearboxCode'
  | 'engineCode'
  | 'productionDate'
  | 'make'
  | 'engineFamily'
  | 'cc'
  | 'powerKw'
  | (string & {});

export type ResolutionWarning =
  | 'facts_not_in_fitment_table'
  | 'unrecognised_engine_code'
  | 'unrecognised_gearbox_code'
  | 'unrecognised_model'
  | (string & {});

/**
 * What is known about one car, with the API's names. Every field is optional;
 * an empty string counts as absent. The three codes are compared trimmed and
 * upper-case. The VIN is only used for its first three characters (the WMI),
 * to find the make when none is given.
 */
export interface Facts {
  make?: string | null;
  model?: string | null;
  /** Model year / year of manufacture. */
  year?: number | null;
  /** `YYYY-MM`. */
  productionDate?: string | null;
  fuel?: 'petrol' | 'diesel' | 'hybrid' | 'ev' | 'other' | (string & {}) | null;
  /** e.g. `HNZ`, `N47D20`. */
  engineCode?: string | null;
  /** e.g. `EB2`, `N47`. */
  engineFamily?: string | null;
  gearbox?: 'manual' | 'automatic' | 'dct' | 'cvt' | (string & {}) | null;
  /** A code (`0AM`) or a family (`DQ200`). */
  gearboxCode?: string | null;
  cc?: number | null;
  powerKw?: number | null;
  vin?: string | null;
}

export interface Resolution {
  defectId: string;
  status: DefectStatus;
  /** Facts that would settle a `possible`, in `NEEDS_ORDER`. */
  needs: FactName[];
  /** Facts that ruled out a `not_applicable`, in `NEEDS_ORDER`. */
  excludedBy: FactName[];
  warnings: ResolutionWarning[];
}

/** `vehicles.json` + `defects.json` (format 3), indexed for resolving. */
export class DefectsCanon {
  constructor(vehicles: any, defects: any);
  static fromData(vehicles: any, defects: any): DefectsCanon;
  readonly vehicles: any;
  readonly defects: any;
  /** Published dossiers by id. */
  readonly defectsById: Map<string, any>;
  /** Old (renamed) defect id -> served dossier id. */
  readonly aliasOf: Map<string, string>;
  readonly format: number;
  readonly questions: Record<string, any>;
  servedId(defectId: string): string | null;
  normalizeMake(s?: string | null): string | null;
  normalizeModel(makeId: string | null | undefined, s?: string | null): string | null;
  makeFromWmi(vin?: string | null): string | null;
  resolvedModel(facts: Facts): { make: string | null; model: string | null };
  resolveDefect(defectId: string, facts: Facts): Resolution | null;
  resolveDefects(facts: Facts): Resolution[];
  resolveV3(facts: Facts): Resolution[];
  assembleV3(facts: Facts): ChecklistGroup[];
}

/** A `when` condition outside the closed condition language. */
export class ConditionError extends Error {}

export const NEEDS_ORDER: readonly FactName[];
export const GEARBOX_COARSE: readonly ['manual', 'automatic', 'dct', 'cvt'];
export const FUEL_TYPES_V3: readonly FuelType[];
export const STATUSES: readonly DefectStatus[];
export const KNOWN_DEFECTS_TITLE: Readonly<LocalizedText>;

/** casefold -> strip diacritics -> '-' and '_' to spaces -> collapse spaces. */
export function normalizeName(s?: string | null): string;

export function createDefectsCanon(vehicles: any, defects: any): DefectsCanon;
/** The v3 canon shipped with this package, parsed and indexed once. */
export function canonV3(): DefectsCanon;

/** Every published dossier on the car's model, resolved, in id order. */
export function resolveDefects(facts: Facts, canon?: DefectsCanon): Resolution[];
/** Same as `resolveDefects`. */
export function resolveV3(facts: Facts, canon?: DefectsCanon): Resolution[];
/** One dossier resolved against the facts; null if no such served dossier. */
export function resolveDefect(
  defectId: string,
  facts: Facts,
  canon?: DefectsCanon,
): Resolution | null;
/** The served dossier id for a defect id, following `aliases`; else null. */
export function servedId(defectId: string, canon?: DefectsCanon): string | null;
/** Base groups, the fuel module for `facts.fuel`, and the resolved `defects` group. */
export function assembleV3(facts: Facts, canon?: DefectsCanon): ChecklistGroup[];
export function resolvedModel(
  facts: Facts,
  canon?: DefectsCanon,
): { make: string | null; model: string | null };
export function normalizeMake(s?: string | null, canon?: DefectsCanon): string | null;
export function normalizeModel(
  makeId: string | null | undefined,
  s?: string | null,
  canon?: DefectsCanon,
): string | null;
export function makeFromWmi(vin?: string | null, canon?: DefectsCanon): string | null;
