# Changelog

## 1.2.0

- Known defects v3. `resolveDefects(facts)` (alias `resolveV3`) resolves every published
  dossier on the car's model against what is known about the car — make, model, year,
  production date, fuel, engine and gearbox codes, displacement, power, VIN — as `applies`,
  `possible` (with the facts that would settle it) or `not_applicable` (with the facts that
  ruled it out). Conditions are evaluated in three-valued logic: a missing fact never rules a
  dossier out.
- `assembleV3(facts)`: the checklist with the defects group narrowed to the car. Items keep
  their v2 ids and carry `status`, `needs`, `dossierId` and `hint`; `localize()` passes those
  through for v3 items.
- Also `resolveDefect`, `servedId`, `resolvedModel`, `normalizeName`, `normalizeMake`,
  `normalizeModel`, `makeFromWmi`, `canonV3`, `createDefectsCanon` / `DefectsCanon`,
  `ConditionError`, `NEEDS_ORDER`, `GEARBOX_COARSE` and `KNOWN_DEFECTS_TITLE`.
- Ships `data/v3/vehicles.json` and `data/v3/defects.json` of release 2026.10.1: 15 published
  dossiers, 11 deprecated records, and the alias `m271.balanceshaft` → `m271.timingchain`.
  Evidence and prevalence are not bundled; they are served by the free `/v1` API at
  `https://api.elgarde.com/api/v1/defects/{id}`.
- The v2 API (`assemble`, `matchDefectRule`, `defectGroup`, scoring, `localize` for v2 items)
  is unchanged.

## 1.1.0

- Defect canon v2: all 25 defect texts and all 8 rule labels are now authored in
  Russian, Ukrainian and French as well. Until now those three languages fell back
  to English. Component names (DQ200, TSI, EGR, VANOS, N47, PureTech) stay as they are.
- `canonVersion().defects` is now `2`. The rules, matching and scoring are unchanged.

## 1.0.0

First release.

- The Elgarde inspection canon: 25 base checklist items plus 10 across four fuel
  modules, authored in English, Portuguese, Russian, Ukrainian and French.
- 8 ordered make/model match rules covering 25 curated known defects.
- Scoring per `inspection-core/spec/SCORING.md`: `average`, `weighted` and
  `worst_case` group rollups, and the critical clamp on the overall verdict.
- Passes the shared conformance vectors, the same ones every other Elgarde port
  runs.
