#!/usr/bin/env python3
"""One-way provenance extractor: Elgarde's Dart seed content -> canonical JSON.

The JSON under ``data/`` is the canon from here on. This script exists so the
first generation is auditable and so a later Dart-side edit that has not been
mirrored into the canon fails loudly instead of drifting silently.

Usage:
    python3 tools/extract_from_dart.py /path/to/elgarde-app

Reads:
    lib/src/features/inspection/checklist/seed_templates.dart
    lib/src/features/inspection/checklist/model_defects.dart
Writes:
    data/checklist.json
    data/defects.json

The defect *match rules* are Dart closures and cannot be machine-translated to
declarative JSON. They are hand-translated in MATCH_RULES below, and each entry
records the exact closure source it was translated from: if the Dart changes,
the source no longer matches and extraction aborts.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

LANGS = ["en", "pt", "ru", "uk", "fr"]


# --------------------------------------------------------------------------
# Minimal Dart-expression helpers. The seed files use only single-quoted
# strings with no escapes (asserted below), so scanning is unambiguous.
# --------------------------------------------------------------------------


def strip_comments(src: str) -> str:
    """Drop // line comments. Safe here: no // occurs inside any seed string."""
    out = []
    for line in src.splitlines():
        depth_ok = True
        idx = line.find("//")
        while idx != -1:
            # Only a comment if not inside a string literal.
            if line[:idx].count("'") % 2 == 0:
                line = line[:idx]
                break
            idx = line.find("//", idx + 2)
        if depth_ok:
            out.append(line)
    return "\n".join(out)


def split_top_level(s: str) -> list[str]:
    """Split on commas at bracket depth 0, ignoring commas inside strings."""
    parts, buf, depth, in_str = [], [], 0, False
    for ch in s:
        if in_str:
            buf.append(ch)
            if ch == "'":
                in_str = False
            continue
        if ch == "'":
            in_str = True
            buf.append(ch)
        elif ch in "([{":
            depth += 1
            buf.append(ch)
        elif ch in ")]}":
            depth -= 1
            buf.append(ch)
        elif ch == "," and depth == 0:
            parts.append("".join(buf).strip())
            buf = []
        else:
            buf.append(ch)
    tail = "".join(buf).strip()
    if tail:
        parts.append(tail)
    return parts


def call_body(src: str, start: int) -> tuple[str, int]:
    """Given ``src`` and the index of an opening bracket, return (inner, index
    after the matching closer)."""
    assert src[start] in "(["
    depth, in_str, i = 0, False, start
    while i < len(src):
        ch = src[i]
        if in_str:
            if ch == "'":
                in_str = False
        elif ch == "'":
            in_str = True
        elif ch in "([{":
            depth += 1
        elif ch in ")]}":
            depth -= 1
            if depth == 0:
                return src[start + 1 : i], i + 1
        i += 1
    raise ValueError("unbalanced call")


def find_call(src: str, name: str, from_idx: int = 0) -> tuple[str, int] | None:
    """Find the next ``name(`` call; return (inner args, index after it)."""
    pat = re.compile(r"\b" + re.escape(name) + r"\s*\(")
    m = pat.search(src, from_idx)
    if not m:
        return None
    inner, end = call_body(src, m.end() - 1)
    return inner, end


def dart_str(tok: str) -> str:
    tok = tok.strip()
    if not (tok.startswith("'") and tok.endswith("'")):
        raise ValueError(f"not a string literal: {tok[:60]!r}")
    return tok[1:-1]


def named_args(args: list[str]) -> dict[str, str]:
    out = {}
    for a in args:
        m = re.match(r"^([A-Za-z_]\w*)\s*:\s*(.+)$", a, re.S)
        if m:
            out[m.group(1)] = m.group(2).strip()
    return out


def positional(args: list[str]) -> list[str]:
    return [a for a in args if not re.match(r"^[A-Za-z_]\w*\s*:", a, re.S)]


def localized(values: list[str]) -> dict[str, str]:
    return {lang: dart_str(v) for lang, v in zip(LANGS, values, strict=True)}


# --------------------------------------------------------------------------
# checklist.json
# --------------------------------------------------------------------------


def parse_item(inner: str) -> dict:
    args = split_top_level(inner)
    pos, named = positional(args), named_args(args)
    item = {
        "id": dart_str(pos[0]),
        "order": int(named.get("order", "0")),
        "prompt": localized(pos[1:6]),
    }
    if named.get("critical") == "true":
        item["critical"] = True
    return item


def parse_group(inner: str, *, kind: str) -> dict:
    """``_leaf`` and ``_top`` share a signature: id, 5 titles, order, children."""
    args = split_top_level(inner)
    pos = positional(args)
    group = {
        "id": dart_str(pos[0]),
        "order": int(pos[6]),
        "title": localized(pos[1:6]),
    }
    body = pos[7]
    if kind == "leaf":
        group["items"] = parse_calls(body, "_item", parse_item)
    else:
        group["children"] = parse_calls(body, "_leaf", lambda s: parse_group(s, kind="leaf"))
    return group


def parse_calls(src: str, name: str, fn):
    """Parse every ``name(...)`` call in ``src``, in source order."""
    out, idx = [], 0
    while True:
        found = find_call(src, name, idx)
        if not found:
            return out
        inner, idx = found
        out.append(fn(inner))


def extract_checklist(app_root: Path) -> dict:
    path = app_root / "lib/src/features/inspection/checklist/seed_templates.dart"
    src = strip_comments(path.read_text(encoding="utf-8"))
    assert "\\'" not in src, "escaped quotes present — the scanner assumes none"

    # Base: everything between `baseChecklist() => [` and the closing `];`.
    m = re.search(r"baseChecklist\(\)\s*=>\s*\[", src)
    if not m:
        raise SystemExit("baseChecklist() not found")
    body, _ = call_body(src, m.end() - 1)
    base = parse_calls(body, "_top", lambda s: parse_group(s, kind="top"))

    # Fuel modules: one `_top(...)` per `case FuelType.x:` in fuelModule().
    fuel_src = src[src.index("ChecklistGroup? fuelModule") :]
    modules = {}
    for m in re.finditer(r"case FuelType\.(\w+):", fuel_src):
        fuel = m.group(1)
        nxt = re.search(r"case FuelType\.(\w+):", fuel_src[m.end() :])
        segment = fuel_src[m.end() : m.end() + (nxt.start() if nxt else len(fuel_src))]
        found = find_call(segment, "_top")
        if found:
            modules[fuel] = parse_group(found[0], kind="top")

    return {
        "version": 1,
        "languages": LANGS,
        "base": base,
        "modules": {"fuel": modules},
    }


# --------------------------------------------------------------------------
# defects.json
# --------------------------------------------------------------------------

# Hand-translated match rules, keyed by the Dart rule's English label. `source`
# is the exact closure text in model_defects.dart, whitespace-normalised; if it
# changes, extraction aborts rather than emitting a stale translation.
#
# A rule matches when ANY clause matches. A clause matches when the (lowercased)
# make contains any of `makeAny` AND — if present — the model contains any of
# `modelAny`. This is exactly what the Dart closures do.
MATCH_RULES: dict[str, dict] = {
    "VAG known issues": {
        "source": (
            "(mk, md) => _vag(mk) && (md.contains('golf') || md.contains('passat') || "
            "md.contains('polo') || md.contains('leon') || md.contains('ibiza') || "
            "md.contains('octavia') || md.contains('fabia') || md.contains('a3') || "
            "md.contains('a1'))"
        ),
        "clauses": [
            {
                "makeAny": ["volkswagen", "vw", "audi", "seat", "skoda", "škoda"],
                "modelAny": [
                    "golf", "passat", "polo", "leon", "ibiza", "octavia", "fabia", "a3", "a1",
                ],
            }
        ],
    },
    "BMW known issues": {
        "source": "(mk, md) => mk.contains('bmw')",
        "clauses": [{"makeAny": ["bmw"]}],
    },
    "PSA known issues": {
        "source": (
            "(mk, md) => mk.contains('peugeot') || mk.contains('citro') || mk.contains('ds ')"
        ),
        "clauses": [{"makeAny": ["peugeot", "citro", "ds "]}],
    },
    "Ford known issues": {
        "source": (
            "(mk, md) => mk.contains('ford') && (md.contains('focus') || "
            "md.contains('fiesta') || md.contains('ecosport') || md.contains('puma'))"
        ),
        "clauses": [
            {"makeAny": ["ford"], "modelAny": ["focus", "fiesta", "ecosport", "puma"]}
        ],
    },
    "Renault/Nissan 1.5 dCi known issues": {
        "source": (
            "(mk, md) => mk.contains('renault') || mk.contains('dacia') || "
            "(mk.contains('nissan') && (md.contains('qashqai') || md.contains('juke') || "
            "md.contains('micra')))"
        ),
        "clauses": [
            {"makeAny": ["renault", "dacia"]},
            {"makeAny": ["nissan"], "modelAny": ["qashqai", "juke", "micra"]},
        ],
    },
    "Opel known issues": {
        "source": (
            "(mk, md) => (mk.contains('opel') || mk.contains('vauxhall')) && "
            "(md.contains('astra') || md.contains('corsa') || md.contains('insignia'))"
        ),
        "clauses": [
            {
                "makeAny": ["opel", "vauxhall"],
                "modelAny": ["astra", "corsa", "insignia"],
            }
        ],
    },
    "Mercedes known issues": {
        "source": "(mk, md) => mk.contains('mercedes')",
        "clauses": [{"makeAny": ["mercedes"]}],
    },
    "Fiat known issues": {
        "source": (
            "(mk, md) => mk.contains('fiat') && (md.contains('500') || "
            "md.contains('panda') || md.contains('punto'))"
        ),
        "clauses": [{"makeAny": ["fiat"], "modelAny": ["500", "panda", "punto"]}],
    },
}


def parse_defect(inner: str) -> dict:
    args = split_top_level(inner)
    pos, named = positional(args), named_args(args)
    out = {
        "id": dart_str(pos[0]),
        "text": {"en": dart_str(pos[1]), "pt": dart_str(pos[2])},
    }
    if named.get("critical") == "true":
        out["critical"] = True
    return out


def extract_defects(app_root: Path) -> dict:
    path = app_root / "lib/src/features/inspection/checklist/model_defects.dart"
    src = strip_comments(path.read_text(encoding="utf-8"))
    assert "\\'" not in src, "escaped quotes present — the scanner assumes none"

    # Shared defect lists declared as `const _name = [ _Defect(...), ... ];`
    shared: dict[str, list[dict]] = {}
    for m in re.finditer(r"const (_\w+) = \[", src):
        body, _ = call_body(src, m.end() - 1)
        shared[m.group(1)] = parse_calls(body, "_Defect", parse_defect)

    rules, idx = [], src.index("final List<_Rule> _rules")
    while True:
        found = find_call(src, "_Rule", idx)
        if not found:
            break
        inner, idx = found
        args = split_top_level(inner)
        closure, label, label_pt, defect_list = args[0], args[1], args[2], args[3]

        label_en = dart_str(label)
        rule = MATCH_RULES.get(label_en)
        if rule is None:
            raise SystemExit(f"no hand-translated match rule for {label_en!r}")
        norm = " ".join(closure.split())
        if norm != rule["source"]:
            raise SystemExit(
                f"closure for {label_en!r} changed — re-translate it.\n"
                f"  dart: {norm}\n  json: {rule['source']}"
            )

        defects: list[dict] = []
        for part in split_top_level(defect_list.strip()[1:-1]):
            part = part.strip()
            if part.startswith("..."):
                key = part[3:].strip()
                if key not in shared:
                    raise SystemExit(f"unknown spread {key}")
                defects.extend(shared[key])
            elif "_Defect(" in part:
                body, _ = call_body(part, part.index("_Defect(") + len("_Defect"))
                defects.append(parse_defect(body))
        rules.append(
            {
                "id": re.sub(r"[^a-z0-9]+", "-", label_en.lower()).strip("-"),
                "label": {"en": label_en, "pt": dart_str(label_pt)},
                "match": rule["clauses"],
                "defects": defects,
            }
        )

    return {"version": 1, "languages": ["en", "pt"], "rules": rules}


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    app_root = Path(sys.argv[1]).expanduser()
    here = Path(__file__).resolve().parent.parent

    checklist = extract_checklist(app_root)
    defects = extract_defects(app_root)

    for name, payload in (("checklist", checklist), ("defects", defects)):
        out = here / "data" / f"{name}.json"
        out.write_text(
            json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
        )
        print(f"wrote {out}")

    items = sum(
        len(leaf.get("items", []))
        for top in checklist["base"] + list(checklist["modules"]["fuel"].values())
        for leaf in top.get("children", [])
    )
    print(f"  base top-level groups: {len(checklist['base'])}")
    print(f"  fuel modules:          {sorted(checklist['modules']['fuel'])}")
    print(f"  checklist items:       {items}")
    print(f"  defect rules:          {len(defects['rules'])}")
    print(f"  defect entries:        {sum(len(r['defects']) for r in defects['rules'])}")


if __name__ == "__main__":
    main()
