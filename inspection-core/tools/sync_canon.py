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
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
CANON = ROOT / "inspection-core" / "data"
VECTORS = ROOT / "inspection-core" / "conformance" / "vectors.json"

# package directory -> where its copy of checklist.json / defects.json lives
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
            # No trailing blank line: dart format would strip it, and CI runs
            # `dart format --set-exit-if-changed` over the generated file too.
            literal("defectsCanonJson", defects),
        ]
    ) + "\n"


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

    for package, subpath in VECTOR_TARGETS.items():
        write(ROOT / package / subpath, VECTORS.read_text("utf-8"))

    write(ROOT / DART_GENERATED, dart_source())

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
