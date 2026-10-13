# Changelog

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
