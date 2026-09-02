# Elgarde — open inspection data and tools

Open pieces of [**Elgarde**](https://elgarde.com/), a structured pre-purchase used-car inspection:
the inspection data itself, the scoring specification, the API contract, and every tool that runs
on somebody else's machine.

The mobile app, the marketing site and the backend service are not here — see
[PUBLIC_BOUNDARY.md](PUBLIC_BOUNDARY.md) for what belongs in this repository and why.

## What's inside

| Path | What it is | Status |
|---|---|---|
| [`inspection-core/`](inspection-core/) | The canon: checklist content in five languages, curated model-specific defect rules, the scoring specification, and the conformance vectors every implementation must pass | ✅ |
| [`openapi/`](openapi/) | The published contract of the free `/v1` API | ✅ |
| `packages/` | Ports of the core for Dart, Python, JS and PHP | planned |
| `mcp/` | MCP server — ask an assistant what to check on a given car | planned |
| `plugins/wordpress/` | WordPress plugin embedding the inspection checklist | planned |
| `extension/` | Browser extension surfacing known defects on used-car listings | planned |

## The free API

No key, no sign-up, CORS open, rate-limited per IP:

```bash
curl "https://api.elgarde.com/api/v1/checklist?fuel=diesel&make=Volkswagen&model=Golf&lang=en"
curl "https://api.elgarde.com/api/v1/defects?make=Peugeot&model=208"
```

Reference: **<https://elgarde.com/api/>** · spec: <https://api.elgarde.com/api/openapi.json>
(a snapshot is committed at [`openapi/elgarde-api.json`](openapi/elgarde-api.json)).

## The canon

`inspection-core/` is the single source of truth. The Elgarde app, the API and every language
port are thin wrappers over it, and each runs the same
[`conformance/vectors.json`](inspection-core/conformance/vectors.json) in CI — so a score
computed in the app and a score computed through the API are the same number.

- 25 base checklist items plus 10 across four fuel modules, authored in **English, Portuguese,
  Russian, Ukrainian and French**
- 8 ordered make/model match rules covering 25 curated known defects — the DQ200 dry clutch, the
  PureTech wet belt, the N47 timing chain
- [`spec/SCORING.md`](inspection-core/spec/SCORING.md): group rollups (average, weighted,
  worst-case) and the critical clamp that stops one failed safety item from averaging away

A group holds child groups or items:

```json
{
  "id": "ext.body",
  "order": 0,
  "title": { "en": "Body & paint", "pt": "Carroçaria e pintura", "…": "…" },
  "aggregation": "average",
  "items": [
    {
      "id": "ext.body.rust",
      "order": 2,
      "prompt": { "en": "No rust or corrosion", "…": "…" },
      "critical": true
    }
  ]
}
```

A defect rule matches when any of its clauses matches — the make contains one of `makeAny`, and,
when present, the model contains one of `modelAny`. Rules are **ordered**, the first match wins,
and at most one defect group is ever appended:

```json
{
  "id": "ford-known-issues",
  "label": { "en": "Ford known issues", "pt": "Problemas conhecidos Ford" },
  "match": [{ "makeAny": ["ford"], "modelAny": ["focus", "fiesta", "ecosport", "puma"] }],
  "defects": [
    {
      "id": "ecoboost.coolant",
      "critical": true,
      "text": {
        "en": "1.0 EcoBoost coolant/overheating (degas hose, head) — check history",
        "pt": "1.0 EcoBoost sobreaquecimento/líquido — verificar histórico"
      }
    }
  ]
}
```

Item ids are permanent — they are what makes an inspection comparable over time. JSON Schemas for
both files are in [`inspection-core/data/schema/`](inspection-core/data/schema/).

Self-check, before you rely on any of it:

```bash
python3 inspection-core/tools/check.py     # schemas, structure, all 32 vectors
```

## Porting the core

1. Load `inspection-core/data/checklist.json` and `inspection-core/data/defects.json`.
2. Implement [`spec/SCORING.md`](inspection-core/spec/SCORING.md).
3. Run all four sections of `conformance/vectors.json` in your test suite — `scoring`,
   `assembly`, `matching`, `canonScoring`. Compare floats with a tolerance of `1e-9`.

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
**known weak point on a model** — something worth checking — and is never a claim about any
individual car. An empty defect result means nothing is curated for that model yet, not that the
model is trouble-free.

## Licence

- **Data** (`inspection-core/data/`, `inspection-core/conformance/`) —
  [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/). Commercial use is fine; keep the
  attribution to <https://elgarde.com/>.
- **Code and tooling** — [MIT](LICENSE).

Corrections and additional model defects are welcome — open an issue or a pull request. Elgarde is
made in Porto, Portugal by TransparentCaprice, Lda. (NIPC 517840642).
