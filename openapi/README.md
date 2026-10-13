# OpenAPI contract

[`elgarde-api.json`](elgarde-api.json) is a committed snapshot of the **public `/v1` tier** of the
Elgarde API — the seven free, unauthenticated endpoints (`/v1/meta`, `/v1/checklist`, `/v1/defects`, `/v1/defects/{defect_id}`, `/v1/catalog`, `/v1/score`, `/v1/vin/{vin}`) and nothing else. The authenticated routes
of the service are not part of this contract and are not published.

The live spec, always current, is served at:

```
https://api.elgarde.com/api/openapi.json
```

Submit the live URL to API directories; this file exists so the contract is versioned alongside
the data it describes, and so anyone can diff two releases.

## Refreshing after an API change

Regenerate from the service (private repo) and commit the result here:

```bash
python - <<'PY'
import json, re
from app.main import app
spec = app.openapi()
spec["paths"] = {p: v for p, v in spec["paths"].items() if p.startswith("/v1")}
schemas = spec["components"]["schemas"]
refs = lambda o: re.findall(r'#/components/schemas/([^"]+)', json.dumps(o))
# Keep every schema reachable from the /v1 paths, transitively, so no $ref dangles.
keep, queue = set(), refs(spec["paths"])
while queue:
    name = queue.pop()
    if name not in keep:
        keep.add(name)
        queue += refs(schemas[name])
spec["components"]["schemas"] = {k: v for k, v in schemas.items() if k in keep}
assert set(refs(spec)) <= keep, "dangling $ref"
print(json.dumps(spec, indent=2, ensure_ascii=False))
PY
```

The same filter works on the live document: load `https://api.elgarde.com/api/openapi.json`
instead of `app.openapi()`.

## Compatibility

`/v1` is additive: new fields and new endpoints may appear; existing fields will not change
meaning or disappear. A breaking change would ship as `/v2`, with `/v1` kept alive. Checklist item
ids are permanent.
