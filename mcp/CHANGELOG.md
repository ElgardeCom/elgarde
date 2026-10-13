# Changelog

## 1.1.0

- `get_known_defects` uses known defects v3 (`elgarde-inspection` 1.2.0). It takes optional
  facts — `year`, `productionDate`, `fuel`, `engineCode`, `engineFamily`, `gearbox`,
  `gearboxCode` — and says for each entry whether it applies, is possible (and which fact would
  settle it), or was ruled out by the facts given. Every entry with a sourced dossier links to it
  (`/v1/defects/{id}` on the free API). The list is the one `/v1/defects` returns for the same
  facts: v2 entries keep their wording, renamed ones (`m271.balanceshaft`) link to their new
  dossier, and entries with no dossier yet are marked as such.
- `get_known_defects` accepts all five languages (it was limited to English and Portuguese).
- `get_inspection_checklist`, `score_inspection` and `decode_vin` are unchanged.

## 1.0.1

- Declare `mcpName: com.elgarde/inspection` in `package.json`. The official MCP
  Registry verifies that the npm package it is asked to list really belongs to
  the server name being claimed, and refuses the publish without it.

## 1.0.0

First release.

- Four tools — `get_inspection_checklist`, `get_known_defects`, `score_inspection`
  and `decode_vin` — over both stdio and streamable HTTP.
- The inspection canon ships inside the `elgarde-inspection` dependency, so the
  first three tools work with no network at all.
- Every tool response carries the disclaimer, so an assistant relaying the output
  cannot quietly overstate what Elgarde is.
