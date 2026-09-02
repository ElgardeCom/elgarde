# elgarde-inspection-core

The canonical data and specification behind [Elgarde](https://elgarde.com/) — a structured
pre-purchase used-car inspection.

Three things live here, and nothing else:

| Path | What it is |
|---|---|
| [`data/checklist.json`](data/checklist.json) | The inspection checklist: grouped items with 1–5 scoring and criticality, authored in **English, Portuguese, Russian, Ukrainian and French**, plus per-fuel modules (petrol · diesel · hybrid · EV). |
| [`data/defects.json`](data/defects.json) | Curated **model-specific known weak points** for common European used models — the DQ200 dry clutch, the PureTech wet belt, the N47 timing chain — with declarative make/model match rules. |
| [`spec/SCORING.md`](spec/SCORING.md) | How answers roll up into group scores and one overall verdict, including the critical clamp. |
| [`conformance/vectors.json`](conformance/vectors.json) | The test vectors every implementation must pass. |

This repository is the **single source of truth**. The Elgarde app, the public API and every
language port are thin wrappers over this data, and each one runs the same conformance vectors in
CI. A port that disagrees with the vectors is a broken port.

## Try it without cloning anything

The data is served live, free and unauthenticated:

```bash
curl "https://api.elgarde.com/api/v1/checklist?fuel=diesel&make=Volkswagen&model=Golf&lang=en"
curl "https://api.elgarde.com/api/v1/defects?make=Peugeot&model=208"
```

Full reference: **<https://elgarde.com/api/>** · OpenAPI 3.1:
<https://api.elgarde.com/api/openapi.json>

## Shape

A **group** holds child groups or items:

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

A **defect rule** matches when any of its clauses matches — the make contains one of `makeAny`,
and, when present, the model contains one of `modelAny`:

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

Rules are **ordered** and the first match wins; at most one defect group is ever appended to a
checklist. Item ids are permanent — they are what makes an inspection comparable over time.

JSON Schemas for both files are in [`data/schema/`](data/schema/).

## Porting

1. Load the two JSON files.
2. Implement [`spec/SCORING.md`](spec/SCORING.md).
3. Run [`conformance/vectors.json`](conformance/vectors.json) in your test suite — all four
   sections (`scoring`, `assembly`, `matching`, `canonScoring`). Compare floats with a tolerance
   of `1e-9`.

Reference implementations: Python (Elgarde's API backend) and Dart (the Elgarde app).

## Honest limits

Elgarde is a self-service checklist. It is **not** a certified, mechanical or legal inspection,
not professional advice, and not a vehicle-history or title service. A defect entry describes a
**known weak point on a model** — something worth checking — and is never a claim about any
individual car. An empty defect result means nothing is curated for that model yet, not that the
model is trouble-free.

## Licence

- **Data** (`data/`, `conformance/`) — [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/).
  Use it commercially, embed it, ship it; keep the attribution to <https://elgarde.com/>.
- **Tooling** (`tools/`) — [MIT](LICENSE).

Elgarde is made in Porto, Portugal by TransparentCaprice, Lda. (NIPC 517840642).
Corrections and additional model defects are welcome — open an issue or a pull request.
