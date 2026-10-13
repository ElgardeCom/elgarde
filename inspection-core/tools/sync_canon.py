#!/usr/bin/env python3
"""Copy the canon into every package that ships it.

One canon, many thin ports — but a published package has to carry its own copy
of the data, because a consumer installing `elgarde-inspection` from PyPI has no
access to this repository's layout. This script is what keeps those copies from
drifting.

    python3 inspection-core/tools/sync_canon.py            # write the copies
    python3 inspection-core/tools/sync_canon.py --check     # fail if stale (CI)

Never edit a package's copy by hand: change `inspection-core/data/`, run this,
and commit the result.
"""

from __future__ import annotations

import json
import sys
import unicodedata
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
CANON = ROOT / "inspection-core" / "data"
VECTORS = ROOT / "inspection-core" / "conformance" / "vectors.json"

# package directory -> where its copy of checklist.json / defects.json lives.
# The known-defects v3 files a port needs to resolve facts go to `v3/` beneath
# it. Only these two: evidence, prevalence and the disclaimer are served by the
# API and the dossier pages, and a port has no use for them.
V3_FILES = ("vehicles.json", "defects.json")

DATA_TARGETS = {
    "packages/python": "src/elgarde_inspection/data",
    "packages/js": "data",
    "packages/php": "data",
}

# The MCP server is deliberately absent: it depends on the published
# `elgarde-inspection` npm package and reads the canon through it, so a second
# copy would only be one more thing to keep in sync.

# package directory -> where its copy of vectors.json lives
VECTOR_TARGETS = {
    "packages/python": "tests/vectors.json",
    "packages/js": "test/vectors.json",
    "packages/php": "tests/vectors.json",
    "packages/dart": "test/vectors.json",
}

# Dart has no notion of a runtime data file in a pure package, so the canon is
# generated into source as raw strings.
DART_GENERATED = "packages/dart/lib/src/canon.g.dart"


def dart_source() -> str:
    checklist = (CANON / "checklist.json").read_text("utf-8").strip()
    defects = (CANON / "defects.json").read_text("utf-8").strip()
    vehicles_v3 = (CANON / "v3" / "vehicles.json").read_text("utf-8").strip()
    defects_v3 = (CANON / "v3" / "defects.json").read_text("utf-8").strip()

    def literal(name: str, payload: str) -> str:
        # r''' … ''' keeps the JSON verbatim; assert no delimiter collision.
        assert "'''" not in payload, f"{name} contains a raw-string delimiter"
        assert "$" not in payload, f"{name} contains $, which Dart interpolates"
        return f"const String {name} = r'''\n{payload}\n''';"

    return "\n\n".join(
        [
            "// GENERATED FILE — DO NOT EDIT.",
            "//",
            "// Written by inspection-core/tools/sync_canon.py from",
            "// inspection-core/data/. Change the canon there and re-run it.",
            "//",
            "// The canon is data, but a pure Dart package cannot ship a runtime",
            "// data file, so it is embedded here as raw JSON strings.",
            literal("checklistCanonJson", checklist),
            literal("defectsCanonJson", defects),
            literal("vehiclesV3CanonJson", vehicles_v3),
            # No trailing blank line: dart format would strip it, and CI runs
            # `dart format --set-exit-if-changed` over the generated file too.
            literal("defectsV3CanonJson", defects_v3),
        ]
    ) + "\n"


# Name matching folds case and strips diacritics: casefold -> NFKD -> drop
# combining marks. Python and JS have Unicode normalisation built in; Dart has
# none, and PHP only with ext-intl. Those two get this table instead, generated
# from Python's own `unicodedata` so every port folds the same way. It covers
# the Latin, Greek and Cyrillic blocks (plus compatibility spaces and the Latin
# ligatures) and lists only the code points whose fold is not their plain
# lower case. Combining marks are dropped separately, so decomposed input
# ("S" + U+030C) folds too.
FOLD_RANGES = (
    (0x00A0, 0x024F),
    (0x0370, 0x03FF),
    (0x0400, 0x04FF),
    (0x1E00, 0x1EFF),
    (0x2000, 0x200A),
    (0x202F, 0x202F),
    (0xFB00, 0xFB06),
)
DART_FOLD = "packages/dart/lib/src/fold.g.dart"
PHP_FOLD = "packages/php/src/FoldTable.php"


def fold_table() -> dict[int, str]:
    table: dict[int, str] = {}
    for lo, hi in FOLD_RANGES:
        for cp in range(lo, hi + 1):
            ch = chr(cp)
            if unicodedata.category(ch) == "Cn":
                continue
            folded = unicodedata.normalize("NFKD", ch.casefold())
            folded = "".join(c for c in folded if not unicodedata.combining(c))
            if folded != ch.lower() or len(ch.lower()) != 1:
                table[cp] = folded
    return table


def _escaped(text: str, style: str) -> str:
    out = []
    for c in text:
        if c.isascii() and (c.isalnum() or c == " "):
            out.append(c)
        else:
            out.append(f"\\u{{{ord(c):x}}}")
    return "".join(out)


def dart_fold_source() -> str:
    lines = [
        "// GENERATED FILE — DO NOT EDIT.",
        "//",
        "// Written by inspection-core/tools/sync_canon.py from Python's",
        "// unicodedata: code point -> casefold + NFKD + combining marks dropped,",
        "// for the code points where that differs from plain lower case.",
        "",
        "/// What name matching folds a code point to, where that is not simply",
        "/// its lower case.",
        "const Map<int, String> foldTable = {",
    ]
    for cp, folded in fold_table().items():
        lines.append(f"  0x{cp:04X}: '{_escaped(folded, 'dart')}',")
    lines.append("};")
    return "\n".join(lines) + "\n"


def php_fold_source() -> str:
    lines = [
        "<?php",
        "",
        "// GENERATED FILE — DO NOT EDIT.",
        "//",
        "// Written by inspection-core/tools/sync_canon.py from Python's",
        "// unicodedata: character -> casefold + NFKD + combining marks dropped,",
        "// for the characters where that differs from plain lower case. Used",
        "// only when ext-intl (Normalizer) is not available.",
        "",
        "declare(strict_types=1);",
        "",
        "namespace Elgarde\\Inspection;",
        "",
        "/** @internal */",
        "final class FoldTable",
        "{",
        "    public const MAP = [",
    ]
    for cp, folded in fold_table().items():
        lines.append(f'        "\\u{{{cp:x}}}" => "{_escaped(folded, "php")}",')
    lines += ["    ];", "}"]
    return "\n".join(lines) + "\n"


def sync(check: bool) -> int:
    stale: list[str] = []

    def write(target: Path, content: str) -> None:
        rel = target.relative_to(ROOT)
        if check:
            current = target.read_text("utf-8") if target.exists() else None
            if current != content:
                stale.append(str(rel))
            return
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(content, encoding="utf-8")
        print(f"  {rel}")

    for package, subdir in DATA_TARGETS.items():
        for name in ("checklist.json", "defects.json"):
            source = (CANON / name).read_text("utf-8")
            write(ROOT / package / subdir / name, source)
        for name in V3_FILES:
            source = (CANON / "v3" / name).read_text("utf-8")
            write(ROOT / package / subdir / "v3" / name, source)

    for package, subpath in VECTOR_TARGETS.items():
        write(ROOT / package / subpath, VECTORS.read_text("utf-8"))

    write(ROOT / DART_GENERATED, dart_source())
    write(ROOT / DART_FOLD, dart_fold_source())
    write(ROOT / PHP_FOLD, php_fold_source())

    if check:
        if stale:
            print("Canon copies are stale — run sync_canon.py and commit:")
            for path in stale:
                print(f"  - {path}")
            return 1
        print("All canon copies are in sync.")
        return 0

    checklist = json.loads((CANON / "checklist.json").read_text("utf-8"))
    print(f"\nSynced canon v{checklist['version']} to {len(DATA_TARGETS)} packages.")
    return 0


if __name__ == "__main__":
    flag = sys.argv[1] if len(sys.argv) > 1 else ""
    if flag not in ("", "--check"):
        raise SystemExit(__doc__)
    sys.exit(sync(check=flag == "--check"))
