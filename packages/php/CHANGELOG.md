# Changelog

## 1.2.0

- **Known defects v3.** `DefectsV3::resolveDefects($facts)` (alias `resolveV3`) says, for every
  sourced dossier on the car's model, whether it `applies`, is `possible` (with the facts that
  would settle it) or is `not_applicable` (with the facts that ruled it out), evaluating each
  dossier's condition in three-valued logic. Also `resolveDefect`, `servedId` (follows renamed
  ids), `assembleV3` (the checklist built from facts, with `status`/`needs`/`dossierId`/`hint` on
  each defect item), `resolvedModel`, `normalizeMake`/`normalizeModel`/`makeFromWmi`, and
  `DefectsCanon` for running against your own data. A `when` leaf outside the closed condition
  language throws `ConditionError`.
- Ships `data/v3/` (vehicles + defects) of release 2026.10.1: 15 published dossiers and 11
  deprecated ones; the old id `m271.balanceshaft` is an alias of `m271.timingchain`. Evidence and
  prevalence are not bundled — the free `/v1` API serves them at
  `https://api.elgarde.com/api/v1/defects/{id}`.
- `Inspection::localize()` passes `dossierId`, `status`, `needs` and `hint` (one language, or
  `null`) through for v3 items. Name matching uses `ext-intl` when present and a bundled fold
  table otherwise; `ext-intl` stays optional.
- Defect canon v2, which the other ports shipped as 1.1.0 and which had no PHP release of its own:
  all 25 defect texts and all 8 rule labels are now authored in Russian, Ukrainian and French too,
  instead of falling back to English. `Canon::version()['defects']` is `2`.
- The v2 API (`Inspection::assemble`, `matchDefectRule`, scoring) is unchanged.

## 1.0.0

First release.

- The Elgarde inspection canon: 25 base checklist items plus 10 across four fuel
  modules, authored in English, Portuguese, Russian, Ukrainian and French.
- 8 ordered make/model match rules covering 25 curated known defects.
- Scoring per `inspection-core/spec/SCORING.md`: `average`, `weighted` and
  `worst_case` group rollups, and the critical clamp on the overall verdict.
- Passes the shared conformance vectors, the same ones every other Elgarde port
  runs.
