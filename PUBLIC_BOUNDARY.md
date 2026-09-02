# What belongs in this repository — and what must never enter it

This repository is **public**. The Elgarde product — the mobile app, the marketing site and the
backend service — lives in a **separate private repository**. Read this before adding anything.

## The rule

> Public code is code that runs on **other people's machines**, or data that other people are
> asked to trust. Everything else stays private.

That is the whole test, and it is not about secrecy for its own sake. An MCP server runs on
somebody's laptop, a WordPress plugin runs on somebody's site, a browser extension runs in
somebody's browser, a package runs inside somebody's build. Nobody should have to take those on
faith, and WordPress.org requires the source in any case. The inspection data and the scoring
specification are published for the same reason: the numbers Elgarde produces should be
checkable by the people relying on them.

## Belongs here

| | Why |
|---|---|
| `inspection-core/` — checklist data, defect rules, scoring spec, conformance vectors | The data and the algorithm others are asked to trust |
| `openapi/` — the published contract of the free `/v1` API | Consumers need the contract; directories index it |
| `packages/` — Dart · Python · JS · PHP ports of the core | They run inside other people's builds |
| `mcp/` — the Elgarde MCP server | Runs on the user's own machine |
| `plugins/wordpress/` | Runs on the user's own site; GPL source is required by WordPress.org |
| `extension/` — the browser extension | Runs in the user's own browser |

## Must never enter this repository

- The **Flutter application** — source, assets, signing config, store metadata.
- The **marketing site** (elgarde.com) and its content.
- The **backend service**: authentication, reports, drafts, organisations, admin, entitlements,
  billing, attachment storage, email. The public `/v1` tier is served by that private service;
  publishing its source would add nothing a caller cannot already see over HTTP, while creating
  a permanent two-repo synchronisation burden.
- Anything with a **secret**: `.env` files, JWT secrets, API keys (Vincario, Sentry, SMTP, S3,
  affiliate ids), SSH keys, deploy keys.
- **Infrastructure**: nginx configs, compose files, host names, IP addresses, backup and
  monitoring scripts, database schemas and dumps.
- **Personal or customer data** of any kind — VINs, emails, inspection reports, user ids.
- Internal planning: the Linear backlog, roadmaps, pricing strategy, partner agreements.

## The one direction data flows

The checklist content and defect rules are authored in the private app and extracted into
`inspection-core/data/` by a tool that **stays private** (it reads the app's source). Only the
output — language-neutral JSON — is published. Nothing in this repository imports from, or knows
the layout of, the private one.

## Before every push

```bash
git diff --stat origin/main..HEAD          # know exactly what is going out
grep -rniE 'secret|api[_-]?key|password|token|BEGIN [A-Z ]*PRIVATE KEY' \
  --exclude-dir=.git .                     # expect zero real hits
```

A secret that reaches a public repository is compromised the moment it is pushed, even if the
commit is removed afterwards. If it happens: rotate the credential first, rewrite history second.
