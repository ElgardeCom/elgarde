# Changelog

## 1.2.0

- Known defects v3. `resolveDefects(facts)` (also `resolveV3`) resolves what is known about a
  car (`CarFacts`: year, production month, fuel, engine and gearbox codes, displacement, power,
  the VIN's make) to `applies`, `possible` with the facts that would settle it, or
  `not_applicable` with the facts that ruled it out, for every dossier on the model.
  `resolveDefect(id, facts)` does one dossier; `resolvedModel(facts)` shows how the make and
  model were understood.
- `assembleV3(facts)`: the checklist with a defects group built the way `GET /v1/defects` builds
  it: v2 rows keep their ids and texts, rows whose dossier is ruled out are dropped, dossiers
  without a v2 row are added. Items carry the new optional `status`, `needs`, `dossierId` and
  `hint`; the group carries `ruleId`. They stay unset on everything `assemble` returns.
- `servedId(id)` follows `aliases`: `m271.balanceshaft` now resolves to `m271.timingchain`.
- Ships the v3 `vehicles.json` and `defects.json` of release 2026.10.1: 15 published dossiers
  and 11 deprecated v2 ids. Evidence and prevalence are not bundled; the free API serves them at
  `https://api.elgarde.com/api/v1/defects/{id}`.
- Defect canon v2 (released as 1.1.0 in the other ports): all 25 defect texts and all 8 rule
  labels are now authored in Russian, Ukrainian and French as well; until now those fell back to
  English. `canonVersion()['defects']` is now `2`.
- New conformance sections (`resolveV3`, `resolveDefect`, `v3Names`, `v3ServedIds`,
  `assembleV3`), shared with the other ports.
- The v2 API (`assemble`, `matchDefectRule`, scoring) is unchanged.

## 1.0.0

First release.

- The Elgarde inspection canon: 25 base checklist items plus 10 across four fuel
  modules, authored in English, Portuguese, Russian, Ukrainian and French.
- 8 ordered make/model match rules covering 25 curated known defects.
- Scoring per `inspection-core/spec/SCORING.md`: `average`, `weighted` and
  `worst_case` group rollups, and the critical clamp on the overall verdict.
- Passes the shared conformance vectors, the same ones every other Elgarde port
  runs.
