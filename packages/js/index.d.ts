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

export interface ChecklistGroup {
  id: string;
  order: number;
  title: LocalizedText;
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
