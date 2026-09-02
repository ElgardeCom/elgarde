# Changelog

## 1.0.0

First release.

- Four tools — `get_inspection_checklist`, `get_known_defects`, `score_inspection`
  and `decode_vin` — over both stdio and streamable HTTP.
- The inspection canon ships inside the `elgarde-inspection` dependency, so the
  first three tools work with no network at all.
- Every tool response carries the disclaimer, so an assistant relaying the output
  cannot quietly overstate what Elgarde is.
