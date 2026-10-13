# Changelog

## 1.2.0

- Known defects v3. `resolve_defects(facts)` (also `resolve_v3`) resolves what is known about a
  car (year, production month, fuel, engine and gearbox codes, displacement, power, the VIN's
  make) to `applies`, `possible` with the facts that would settle it, or `not_applicable` with
  the facts that ruled it out, for every dossier on the model. `resolve_defect(id, facts)` does
  one dossier.
- `assemble_v3(facts)`: the checklist with a defects group built the way `GET /v1/defects`
  builds it: v2 rows keep their ids and texts, rows whose dossier is ruled out are dropped,
  dossiers without a v2 row are added. Items carry `status`, `needs`, `dossierId` and `hint`;
  `localize` passes them through.
- `served_id(id)` follows `aliases`: `m271.balanceshaft` now resolves to `m271.timingchain`.
- Ships `data/v3/vehicles.json` and `data/v3/defects.json` of release 2026.10.1: 15 published
  dossiers and 11 deprecated v2 ids. Evidence and prevalence are not bundled; the free API serves
  them at `https://api.elgarde.com/api/v1/defects/{id}`.
- New conformance sections (`resolveV3`, `resolveDefect`, `v3Names`, `v3ServedIds`,
  `assembleV3`), generated from the implementation behind the API.
- The v2 API (`assemble`, `match_defect_rule`, scoring) is unchanged.

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
