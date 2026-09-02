# OpenAPI contract

[`elgarde-api.json`](elgarde-api.json) is a committed snapshot of the **public `/v1` tier** of the
Elgarde API — the five free, unauthenticated endpoints and nothing else. The authenticated routes
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
import json
from app.main import app
spec = app.openapi()
spec["paths"] = {p: v for p, v in spec["paths"].items() if p.startswith("/v1")}
used = json.dumps(spec["paths"])
schemas = spec["components"]["schemas"]
spec["components"]["schemas"] = {
    k: v for k, v in schemas.items()
    if f'"#/components/schemas/{k}"' in used or k in ("HTTPValidationError", "ValidationError")
}
print(json.dumps(spec, indent=2, ensure_ascii=False))
PY
```

## Compatibility

`/v1` is additive: new fields and new endpoints may appear; existing fields will not change
meaning or disappear. A breaking change would ship as `/v2`, with `/v1` kept alive. Checklist item
ids are permanent.
