# elgarde-mcp

An MCP server that answers **"what should I check before buying this used car?"**

Give an assistant a make and model and it comes back with a real inspection checklist for *that*
car — plus the model's documented weak points, and a scoring pass that tells you what the answers
add up to.

```
You: I'm looking at a 2015 Golf 1.6 TDI tomorrow. What should I check?

Claude: [get_inspection_checklist make="Volkswagen" model="Golf" fuelType="diesel"]
        33 items. Beyond the usual — panel gaps, tyre wear, service history — this
        car has known weak points worth budgeting for: the DQ200 dry-clutch DSG,
        the 1.4 TSI chain tensioner, and TDI EGR/DPF clogging on short trips…
```

## Tools

| Tool | What it does |
|---|---|
| `get_inspection_checklist` | The checklist for a specific car: base items, fuel-specific items, and the model's known defects. Five languages. |
| `get_known_defects` | Just the curated weak points for a make and model. |
| `score_inspection` | Rolls 1–5 answers into per-section scores and one verdict, with the critical clamp applied. |
| `decode_vin` | A 17-character VIN → make, model, year, fuel type (free NHTSA vPIC data). |

The first three run **entirely offline** — the inspection data ships inside the package. Only
`decode_vin` touches the network, calling the free public Elgarde API with no key and nothing
about you attached.

## Install

Claude Desktop, Claude Code, or any MCP client that spawns a process:

```json
{
  "mcpServers": {
    "elgarde": {
      "command": "npx",
      "args": ["-y", "elgarde-mcp"]
    }
  }
}
```

In Claude Code:

```bash
claude mcp add elgarde -- npx -y elgarde-mcp
```

### Remote

The same four tools over streamable HTTP, for clients that connect to a URL:

```bash
npx elgarde-mcp-http           # or: PORT=9000 node http.js
# POST http://127.0.0.1:8200/mcp
```

Stateless by design — a fresh server per request, no session store, nothing to expire. The tools
are read-only and hold no user state.

## What it is not

Elgarde is a self-service checklist, **not** a certified, mechanical or legal inspection, not
professional advice, and not a vehicle-history or title service. A defect entry describes a known
weak point on a *model* — something worth checking — and is never a claim about an individual car.
An empty defect result means nothing is curated for that model yet, not that the model is
trouble-free. Every tool response repeats this, so an assistant relaying the output has no excuse
for overstating it.

## Where the data comes from

The open [Elgarde inspection canon](https://github.com/ElgardeCom/elgarde): checklist content
authored in English, Portuguese, Russian, Ukrainian and French, curated defect rules for common
European used models, and a written scoring specification pinned by conformance vectors that every
Elgarde implementation must pass.

Code MIT; the inspection data is [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) —
attribution to <https://elgarde.com/> is the only condition.
