"""Known defects v3: which curated weak points apply to one particular car.

A v3 dossier names the models it concerns and, optionally, a ``when`` condition
over the powertrain and the build date (``inspection-core/data/v3/``). Given the
facts known about a car, :func:`resolve_v3` says for every dossier on that model
whether it ``applies``, is ``possible`` (and which facts would settle it), or is
``not_applicable`` (and which facts ruled it out).

Conditions are evaluated in three-valued (Kleene) logic: true, false or
unknown. Unknown is never rounded down to "not applicable" — a false
"possible" costs the buyer one question, a false "not applicable" can cost
them an engine.

The data ships with this package (``data/v3/vehicles.json`` and
``data/v3/defects.json``), copied from ``inspection-core/data/v3/`` by
``inspection-core/tools/sync_canon.py``. The shared conformance vectors pin the
behaviour; every port — Python, Dart, JS, PHP — must pass them.

No network: a VIN is only used for its first three characters (the WMI), to
find the make when none is given.
"""

from __future__ import annotations

import json
import unicodedata
from dataclasses import dataclass, field, replace
from functools import lru_cache
from pathlib import Path
from typing import Any

from . import core as _core

V3_DIR = Path(__file__).parent / "data" / "v3"

FUEL_TYPES_V3 = ("petrol", "diesel", "hybrid", "ev", "other")

#: Query-parameter names in the order ``needs`` and ``excluded_by`` list them.
NEEDS_ORDER = (
    "model",
    "year",
    "fuel",
    "gearbox",
    "gearboxCode",
    "engineCode",
    "productionDate",
)

#: The coarse gearbox answers a buyer can give.
GEARBOX_COARSE = ("manual", "automatic", "dct", "cvt")

STATUSES = ("applies", "possible", "not_applicable")

#: Title of the assembled ``defects`` group when no v2 rule matched the car.
KNOWN_DEFECTS_TITLE = {
    "en": "Known defects",
    "pt": "Defeitos conhecidos",
    "ru": "Известные дефекты",
    "uk": "Відомі дефекти",
    "fr": "Défauts connus",
}


def _is_critical(defect: dict) -> bool:
    if "critical" in defect:
        return bool(defect["critical"])
    return defect.get("severity") == "critical"


# Closed gearbox.type enum -> the coarse answers that describe it.
_GEARBOX_TYPE_COARSE: dict[str, frozenset[str]] = {
    "manual": frozenset({"manual"}),
    "automatic_tc": frozenset({"automatic"}),
    "cvt": frozenset({"automatic", "cvt"}),
    "dct_dry": frozenset({"automatic", "dct"}),
    "dct_wet": frozenset({"automatic", "dct"}),
    "amt": frozenset({"automatic"}),
    "single_speed_ev": frozenset({"automatic"}),
}

_CC_TOLERANCE = 50
_KW_TOLERANCE = 3
# Fuel facts that say which engine is fitted. A hybrid runs a petrol or diesel
# engine and "other" is mostly LPG/CNG conversions of petrol engines, so
# neither may rule an engine out.
_ENGINE_FUELS = frozenset({"petrol", "diesel", "ev"})

_CODE_FIELDS = ("engine_code", "engine_family", "gearbox_code")


class ConditionError(ValueError):
    """A ``when`` condition outside the closed condition language."""


@dataclass(frozen=True)
class Facts:
    """What is known about one car. Every field is optional; unknown is None.

    Codes are compared upper-case and an empty string counts as unknown, so
    ``Facts(engine_code=" hnz ")`` is the same as ``Facts(engine_code="HNZ")``.
    """

    make: str | None = None
    model: str | None = None
    year: int | None = None  # model year / year of manufacture
    production_date: str | None = None  # "YYYY-MM"
    fuel: str | None = None  # petrol | diesel | hybrid | ev | other
    engine_code: str | None = None  # e.g. "HNZ", "N47D20"
    engine_family: str | None = None  # e.g. "EB2", "N47"
    gearbox: str | None = None  # manual | automatic | dct | cvt
    gearbox_code: str | None = None  # a code ("0AM") or a family ("DQ200")
    cc: int | None = None
    power_kw: int | None = None
    vin: str | None = None  # only the WMI is used, for the make

    @classmethod
    def from_dict(cls, data: dict[str, Any]) -> Facts:
        """From the API's camelCase names (``productionDate``, ``powerKw``…)."""
        return cls(
            make=data.get("make"),
            model=data.get("model"),
            year=data.get("year"),
            production_date=data.get("productionDate"),
            fuel=data.get("fuel"),
            engine_code=data.get("engineCode"),
            engine_family=data.get("engineFamily"),
            gearbox=data.get("gearbox"),
            gearbox_code=data.get("gearboxCode"),
            cc=data.get("cc"),
            power_kw=data.get("powerKw"),
            vin=data.get("vin"),
        )


@dataclass(frozen=True)
class Resolution:
    defect_id: str
    status: str  # "applies" | "possible" | "not_applicable"
    needs: tuple[str, ...] = ()  # facts that would settle a "possible"
    excluded_by: tuple[str, ...] = ()  # facts that ruled out a "not_applicable"
    warnings: tuple[str, ...] = ()

    def to_dict(self) -> dict[str, Any]:
        """The API's JSON shape (camelCase)."""
        return {
            "defectId": self.defect_id,
            "status": self.status,
            "needs": list(self.needs),
            "excludedBy": list(self.excluded_by),
            "warnings": list(self.warnings),
        }


# ---------------------------------------------------------------------------
# Name normalisation
# ---------------------------------------------------------------------------


def normalize_name(s: str | None) -> str:
    """casefold -> strip diacritics -> '-' and '_' to spaces -> collapse spaces."""
    if not s:
        return ""
    folded = unicodedata.normalize("NFKD", s.casefold())
    folded = "".join(ch for ch in folded if not unicodedata.combining(ch))
    folded = folded.replace("-", " ").replace("_", " ")
    return " ".join(folded.split())


def _name_matches(value: str, names) -> bool:
    for name in names:
        n = normalize_name(name)
        if n and (value == n or value.startswith(n + " ")):
            return True
    return False


def _upper_set(values) -> set[str]:
    return {v.upper() for v in values or ()}


def _family(entity: dict) -> str:
    return (entity.get("family") or "").upper()


def _in_years(year: int | None, span: dict | None) -> bool:
    if year is None or not span:
        return True
    lo, hi = span.get("from"), span.get("to")
    return (lo is None or year >= lo) and (hi is None or year <= hi)


def _over(values: list[bool]) -> bool | None:
    """True if every candidate satisfies, False if none does, else unknown.
    An empty candidate set is unknown, never False."""
    if not values:
        return None
    if all(values):
        return True
    if not any(values):
        return False
    return None


def _ordered(names) -> tuple[str, ...]:
    order = {n: i for i, n in enumerate(NEEDS_ORDER)}
    return tuple(sorted(names, key=lambda n: (order.get(n, len(order)), n)))


def _dedupe(items) -> tuple[str, ...]:
    return tuple(dict.fromkeys(items))


@dataclass(frozen=True)
class _Value:
    value: bool | None
    needs: frozenset[str] = frozenset()
    used: frozenset[str] = frozenset()  # facts that decided a False
    warnings: tuple[str, ...] = ()


@dataclass(frozen=True)
class _Context:
    facts: Facts
    model_id: str | None
    # (engine, gearbox-or-None) pairs still consistent with the facts. Empty
    # means "nothing known", never "nothing fits".
    candidates: tuple[tuple[dict, dict | None], ...]
    warnings: tuple[str, ...]


# ---------------------------------------------------------------------------
# The indexed canon
# ---------------------------------------------------------------------------


@dataclass
class DefectsCanon:
    """``vehicles.json`` + ``defects.json`` (format 3), indexed for resolving.

    Only dossiers whose ``status`` is ``published`` are served. The canon
    guarantees that every published dossier clears the evidence threshold
    (``inspection-core/tools/check.py`` enforces it), so the ports need not
    carry the evidence file to decide that.
    """

    vehicles: dict
    defects: dict
    defects_by_id: dict[str, dict] = field(init=False)

    def __post_init__(self) -> None:
        v = self.vehicles
        self.defects_by_id = {
            d["id"]: d
            for d in self.defects.get("defects", ())
            if d.get("status") == "published"
        }
        self._makes = list(v.get("makes", ()))
        self._models = list(v.get("models", ()))
        self._models_by_id = {m["id"]: m for m in self._models}
        self._generations_by_model: dict[str, list[dict]] = {}
        for g in v.get("generations", ()):
            self._generations_by_model.setdefault(g.get("model"), []).append(g)
        self._fitments_by_generation: dict[str, list[dict]] = {}
        for f in v.get("fitments", ()):
            self._fitments_by_generation.setdefault(f["generation"], []).append(f)
        self._engines = list(v.get("engines", ()))
        self._gearboxes = list(v.get("gearboxes", ()))
        self._engines_by_id = {e["id"]: e for e in self._engines}
        self._gearboxes_by_id = {g["id"]: g for g in self._gearboxes}
        # Later entries win on a duplicated code, as in the reference.
        self._engines_by_code = {
            c.upper(): e for e in self._engines for c in e.get("codes", ())
        }
        self._gearboxes_by_code = {
            c.upper(): g for g in self._gearboxes for c in g.get("codes", ())
        }
        self._engine_families = {_family(e) for e in self._engines} - {""}
        # Old id -> served id, from the ``aliases`` of served dossiers: a
        # renamed defect keeps its old id (stored ``defect.<old id>`` answers
        # and the v2 rules still use it) and reaches the new dossier.
        self.alias_of = {
            alias: did
            for did, d in self.defects_by_id.items()
            for alias in d.get("aliases", ())
            if alias not in self.defects_by_id
        }

    @classmethod
    def from_data(cls, vehicles: dict, defects: dict) -> DefectsCanon:
        return cls(vehicles=vehicles, defects=defects)

    @property
    def format(self) -> int:
        return int(self.defects.get("format", 3))

    @property
    def questions(self) -> dict:
        return self.defects.get("questions", {})

    def served_id(self, defect_id: str) -> str | None:
        """The served dossier id for a defect id: itself when it is a
        published dossier, the dossier that lists it in ``aliases`` when it
        was renamed, else None (deprecated or unknown)."""
        if defect_id in self.defects_by_id:
            return defect_id
        return self.alias_of.get(defect_id)

    # --- names ---------------------------------------------------------------

    def normalize_make(self, s: str | None) -> str | None:
        value = normalize_name(s)
        if not value:
            return None
        for make in self._makes:
            if _name_matches(value, [*make.get("names", ()), make["id"]]):
                return make["id"]
        return None

    def normalize_model(self, make_id: str | None, s: str | None) -> str | None:
        value = normalize_name(s)
        if not make_id or not value:
            return None
        for model in self._models:
            if model.get("make") != make_id:
                continue
            if _name_matches(value, model.get("excludeNames", ())):
                continue
            if _name_matches(value, model.get("names", ())):
                return model["id"]
        return None

    def make_from_wmi(self, vin: str | None) -> str | None:
        wmi = (vin or "").strip().upper()[:3]
        if not wmi:
            return None
        for make in self._makes:
            if wmi in _upper_set(make.get("wmi")):
                return make["id"]
        return None

    def resolved_model(self, facts: Facts | dict) -> tuple[str | None, str | None]:
        """(make id, model id) as the dictionary understands them."""
        f = self._prepare(facts)
        make_id = self.normalize_make(f.make)
        return make_id, self.normalize_model(make_id, f.model)

    # --- resolving -------------------------------------------------------------

    def resolve_defect(self, defect_id: str, facts: Facts | dict) -> Resolution | None:
        """Status of one served dossier for these facts; None if there is none."""
        defect = self.defects_by_id.get(defect_id)
        if defect is None:
            return None
        return self._resolve(defect, self._context(facts))

    def resolve_defects(self, facts: Facts | dict) -> list[Resolution]:
        """Same as :meth:`resolve_v3`."""
        return self.resolve_v3(facts)

    def resolve_v3(self, facts: Facts | dict) -> list[Resolution]:
        """Every served dossier whose ``applicability.models`` contains the
        car's model, in id order. Empty when the model is not recognised."""
        ctx = self._context(facts)
        if ctx.model_id is None:
            return []
        return [
            self._resolve(d, ctx)
            for did, d in sorted(self.defects_by_id.items())
            if ctx.model_id in d.get("applicability", {}).get("models", ())
        ]

    # --- internals -------------------------------------------------------------

    def assemble_v3(self, facts: Facts | dict) -> list[dict]:
        """The checklist for a car described by facts: the base groups, the
        fuel module for ``facts.fuel``, and a ``defects`` group built the way
        ``GET /v1/defects`` builds its list when facts are given.

        The v2 rule's rows come first, in rule order, keeping their v2 id
        (``defect.<v2 id>``), text and critical flag so stored answers stay
        valid. Each is linked to its served dossier (itself, or the dossier
        that lists it in ``aliases``) and dropped when that dossier is
        ``not_applicable``; a row with no dossier stays, with status
        ``legacy``. Then every other dossier on the model that applies or is
        possible, in id order. Items carry ``status``, ``needs``,
        ``dossierId`` and ``hint`` on top of the v2 item fields; the group
        carries the matched v2 ``ruleId``. No defects group when it would be
        empty.
        """
        checklist, _ = _core.canon()
        groups: list[dict] = [dict(g) for g in checklist["base"]]
        f = self._prepare(facts)
        module = checklist["modules"]["fuel"].get(f.fuel or "")
        if module is not None:
            groups.append(module)

        rule = _core.match_defect_rule(f.make, f.model)
        raw_make = facts.get("make") if isinstance(facts, dict) else facts.make
        if rule is None and raw_make in (None, "") and f.make is not None:
            # A make id from the VIN's WMI, spelled the way v2 rules expect.
            make = next((m for m in self._makes if m["id"] == f.make), {})
            rule = _core.match_defect_rule((make.get("names") or [f.make])[0], f.model)

        ctx = self._context(f)
        items: list[dict] = []
        covered: set[str] = set()
        for d in rule["defects"] if rule else ():
            sid = self.served_id(d["id"])
            r = None
            if sid is not None:
                covered.add(sid)
                r = self._resolve(self.defects_by_id[sid], ctx)
                if r.status == "not_applicable":
                    continue
            items.append(
                self._item(d["id"], d["text"], bool(d.get("critical", False)), sid, r)
            )
        if ctx.model_id is not None:
            for did, dossier in sorted(self.defects_by_id.items()):
                if did in covered or ctx.model_id not in dossier.get(
                    "applicability", {}
                ).get("models", ()):
                    continue
                r = self._resolve(dossier, ctx)
                if r.status == "not_applicable":
                    continue
                prompt = dossier.get("checklistPrompt") or dossier.get("title") or {}
                items.append(self._item(did, prompt, _is_critical(dossier), did, r))
        if not items:
            return groups
        for i, item in enumerate(items):
            item["order"] = i
        title = rule["label"] if rule else dict(KNOWN_DEFECTS_TITLE)
        groups.append(
            {
                "id": "defects",
                "order": 6,
                "title": title,
                "ruleId": rule["id"] if rule else None,
                "children": [
                    {"id": "defects.g", "order": 0, "title": title, "items": items}
                ],
            }
        )
        return groups

    def _item(
        self,
        defect_id: str,
        prompt: dict,
        critical: bool,
        dossier_id: str | None,
        r: Resolution | None,
    ) -> dict:
        hint = None
        if dossier_id is not None:
            hint = self.defects_by_id[dossier_id].get("applicability", {}).get("hint")
        return {
            "id": f"defect.{defect_id}",
            "order": 0,
            "prompt": prompt,
            "critical": critical,
            "sourceDefectId": defect_id,
            "dossierId": dossier_id,
            "status": r.status if r is not None else "legacy",
            "needs": list(r.needs) if r is not None else [],
            "hint": hint,
        }

    def _prepare(self, facts: Facts | dict) -> Facts:
        if isinstance(facts, dict):
            facts = Facts.from_dict(facts)

        def blank(v):
            return None if v == "" else v

        def code(v):
            v = v.strip().upper() if isinstance(v, str) else v
            return blank(v)

        make = blank(facts.make)
        vin = code(facts.vin)
        if make is None and vin is not None:
            make = self.make_from_wmi(vin)
        return Facts(
            make=make,
            model=blank(facts.model),
            year=facts.year,
            production_date=blank(facts.production_date),
            fuel=blank(facts.fuel),
            engine_code=code(facts.engine_code),
            engine_family=code(facts.engine_family),
            gearbox=blank(facts.gearbox),
            gearbox_code=code(facts.gearbox_code),
            cc=facts.cc,
            power_kw=facts.power_kw,
            vin=vin,
        )

    def _disambiguate_engine(self, f: Facts) -> Facts:
        """Read an engine code that is really a family name ("EB2") as a
        family, and an "engine family" that is really a code ("N47D20") as that
        code. Taken literally, either mix-up rules out the buyer's own engine."""
        code, family = f.engine_code, f.engine_family
        if code is not None and code in self._engine_families:
            return replace(f, engine_code=None, engine_family=family or code)
        if (
            code is None
            and family is not None
            and family not in self._engine_families
            and family in self._engines_by_code
        ):
            return replace(f, engine_code=family, engine_family=None)
        return f

    def _context(self, facts: Facts | dict) -> _Context:
        f = self._disambiguate_engine(self._prepare(facts))
        make_id = self.normalize_make(f.make)
        model_id = self.normalize_model(make_id, f.model)
        candidates, warnings = self._candidates(model_id, f)
        return _Context(f, model_id, candidates, warnings)

    def _engine_fits(self, engine: dict, f: Facts) -> bool:
        if f.fuel in _ENGINE_FUELS and engine.get("fuel") and engine["fuel"] != f.fuel:
            return False
        cc = engine.get("displacementCc")
        if f.cc is not None and cc is not None and abs(f.cc - cc) > _CC_TOLERANCE:
            return False
        powers = engine.get("powerKw") or []
        if (
            f.power_kw is not None
            and powers
            and min(abs(f.power_kw - p) for p in powers) > _KW_TOLERANCE
        ):
            return False
        if f.engine_code is not None and f.engine_code not in _upper_set(
            engine.get("codes")
        ):
            return False
        return f.engine_family is None or _family(engine) == f.engine_family

    def _gearbox_fits(self, gearbox: dict, f: Facts) -> bool:
        if f.gearbox is not None and f.gearbox not in _GEARBOX_TYPE_COARSE.get(
            gearbox.get("type", ""), frozenset()
        ):
            return False
        return (
            f.gearbox_code is None
            or f.gearbox_code in _upper_set(gearbox.get("codes"))
            or f.gearbox_code == _family(gearbox)
        )

    def _candidates(self, model_id: str | None, f: Facts):
        if model_id is None:
            return (), ()
        all_gens = self._generations_by_model.get(model_id, [])
        gens = [g for g in all_gens if _in_years(f.year, g.get("years"))]
        fitments = [
            x for g in gens for x in self._fitments_by_generation.get(g["id"], [])
        ]
        has_table = any(self._fitments_by_generation.get(g["id"]) for g in all_gens)

        pairs: list[tuple[dict, dict | None]] = []
        for fit in fitments:
            if not _in_years(f.year, fit.get("years")):
                continue
            engine = self._engines_by_id.get(fit.get("engine"))
            if engine is None or not self._engine_fits(engine, f):
                continue
            boxes = [
                self._gearboxes_by_id[g]
                for g in fit.get("gearboxes", ())
                if g in self._gearboxes_by_id
            ]
            if not boxes:
                pairs.append((engine, None))  # gearbox not recorded: unknown
                continue
            for box in boxes:
                if self._gearbox_fits(box, f):
                    pairs.append((engine, box))

        if has_table and not pairs:
            return (), ("facts_not_in_fitment_table",)
        return tuple(pairs), ()

    # --- condition leaves --------------------------------------------------------

    @staticmethod
    def _engine_matches(engine: dict, leaf: dict) -> bool:
        if engine["id"] in leaf.get("ids", ()):
            return True
        if _family(engine) in _upper_set(leaf.get("family")):
            return True
        return bool(_upper_set(leaf.get("codes")) & _upper_set(engine.get("codes")))

    @staticmethod
    def _gearbox_matches(gearbox: dict, leaf: dict) -> bool:
        if gearbox["id"] in leaf.get("ids", ()):
            return True
        if _family(gearbox) in _upper_set(leaf.get("family")):
            return True
        if gearbox.get("type") in leaf.get("type", ()):
            return True
        return bool(_upper_set(leaf.get("codes")) & _upper_set(gearbox.get("codes")))

    @staticmethod
    def _candidate_facts_used(ctx: _Context) -> frozenset[str]:
        f = ctx.facts
        used = {"model"}
        for name, val in (
            ("year", f.year),
            ("fuel", f.fuel),
            ("cc", f.cc),
            ("powerKw", f.power_kw),
            ("gearbox", f.gearbox),
            ("gearboxCode", f.gearbox_code),
        ):
            if val is not None:
                used.add(name)
        return frozenset(used)

    def _eval_engine(self, leaf: dict, ctx: _Context) -> _Value:
        f = ctx.facts
        if f.engine_code is not None:
            if f.engine_code in _upper_set(leaf.get("codes")):
                return _Value(True)
            engine = self._engines_by_code.get(f.engine_code)
            if engine is None:
                return _Value(None, warnings=("unrecognised_engine_code",))
            if self._engine_matches(engine, leaf):
                return _Value(True)
            return _Value(False, used=frozenset({"engineCode"}))

        known = [e for e in self._engines if self._engine_matches(e, leaf)]
        if f.engine_family is not None:
            families = _upper_set(leaf.get("family")) | {_family(e) for e in known}
            if f.engine_family not in families:
                return _Value(False, used=frozenset({"engineFamily"}))
            if leaf.get("family") and not leaf.get("codes") and not leaf.get("ids"):
                return _Value(True)

        # Fuel can rule an engine out without a fitment table; power and
        # displacement cannot (the dictionary lists confirmed ratings, not all).
        if (
            known
            and f.fuel in _ENGINE_FUELS
            and all(e.get("fuel") and e["fuel"] != f.fuel for e in known)
        ):
            return _Value(False, used=frozenset({"fuel"}))

        if ctx.candidates:
            verdict = _over([self._engine_matches(e, leaf) for e, _ in ctx.candidates])
            if verdict is False:
                return _Value(False, used=self._candidate_facts_used(ctx))
            if verdict is True:
                return _Value(True)
        return _Value(None, frozenset({"engineCode"}))

    def _eval_gearbox(self, leaf: dict, ctx: _Context) -> _Value:
        f = ctx.facts
        if f.gearbox_code is not None:
            if f.gearbox_code in _upper_set(leaf.get("codes")) | _upper_set(
                leaf.get("family")
            ):
                return _Value(True)
            box = self._gearboxes_by_code.get(f.gearbox_code) or next(
                (g for g in self._gearboxes if _family(g) == f.gearbox_code), None
            )
            if box is None:
                return _Value(None, warnings=("unrecognised_gearbox_code",))
            if self._gearbox_matches(box, leaf):
                return _Value(True)
            return _Value(False, used=frozenset({"gearboxCode"}))

        known = [g for g in self._gearboxes if self._gearbox_matches(g, leaf)]
        types = set(leaf.get("type", ())) | {g.get("type") for g in known}
        if f.gearbox is not None and types:
            coarse: set[str] = set()
            for t in types:
                coarse |= _GEARBOX_TYPE_COARSE.get(t, frozenset())
            if f.gearbox not in coarse:
                return _Value(False, used=frozenset({"gearbox"}))

        if ctx.candidates and all(box is not None for _, box in ctx.candidates):
            verdict = _over(
                [self._gearbox_matches(box, leaf) for _, box in ctx.candidates]
            )
            if verdict is False:
                return _Value(False, used=self._candidate_facts_used(ctx))
            if verdict is True:
                return _Value(True)
        return _Value(
            None, frozenset({"gearboxCode" if f.gearbox is not None else "gearbox"})
        )

    def _eval_fuel(self, leaf, ctx: _Context) -> _Value:
        wanted = set(leaf if isinstance(leaf, list) else leaf.get("in", ()))
        if ctx.facts.fuel is not None:
            if ctx.facts.fuel in wanted:
                return _Value(True)
            return _Value(False, used=frozenset({"fuel"}))
        if ctx.candidates:
            verdict = _over([e.get("fuel") in wanted for e, _ in ctx.candidates])
            if verdict is False:
                return _Value(False, used=self._candidate_facts_used(ctx))
            if verdict is True:
                return _Value(True)
        return _Value(None, frozenset({"fuel"}))

    @staticmethod
    def _eval_model_year(leaf: dict, ctx: _Context) -> _Value:
        year = ctx.facts.year
        if year is None:
            return _Value(None, frozenset({"year"}))
        if _in_years(year, leaf):
            return _Value(True)
        return _Value(False, used=frozenset({"year"}))

    @staticmethod
    def _eval_production_date(leaf: dict, ctx: _Context) -> _Value:
        lo, hi = leaf.get("from"), leaf.get("to")
        pd = ctx.facts.production_date
        if pd is not None:
            if (lo is None or pd >= lo) and (hi is None or pd <= hi):
                return _Value(True)
            return _Value(False, used=frozenset({"productionDate"}))
        year = ctx.facts.year
        if year is None:
            return _Value(None, frozenset({"year"}))
        lo_y = int(lo[:4]) if lo else None
        hi_y = int(hi[:4]) if hi else None
        # A year is never earlier than the build year, but it can be one later
        # (model years run ahead, and first registration can trail the build).
        # So one year past the window is unknown; only a year before it, or two
        # past it, rules the car out.
        if (lo_y is not None and year < lo_y) or (hi_y is not None and year > hi_y + 1):
            return _Value(False, used=frozenset({"year"}))
        # A year on a boundary month is ambiguous unless the boundary is a
        # whole calendar year (from January / to December).
        on_lo = lo_y is not None and year == lo_y and not lo.endswith("-01")
        on_hi = hi_y is not None and (
            year == hi_y + 1 or (year == hi_y and not hi.endswith("-12"))
        )
        if on_lo or on_hi:
            return _Value(None, frozenset({"productionDate"}))
        return _Value(True)

    def _eval_ids(self, kind: str, leaf, ctx: _Context) -> _Value:
        """``make`` / ``model`` / ``generation`` leaves: lists of dictionary ids."""
        wanted = set(leaf if isinstance(leaf, list) else leaf.get("ids", ()))
        if ctx.model_id is None:
            return _Value(None, frozenset({"model"}))
        if kind == "make":
            make = self._models_by_id[ctx.model_id].get("make")
            if make in wanted:
                return _Value(True)
            return _Value(False, used=frozenset({"make"}))
        if kind == "model":
            if ctx.model_id in wanted:
                return _Value(True)
            return _Value(False, used=frozenset({"model"}))
        gens = [
            g
            for g in self._generations_by_model.get(ctx.model_id, [])
            if _in_years(ctx.facts.year, g.get("years"))
        ]
        verdict = _over([g["id"] in wanted for g in gens])
        if verdict is False:
            used = {"model", "year"} if ctx.facts.year else {"model"}
            return _Value(False, used=frozenset(used))
        if verdict is True:
            return _Value(True)
        return _Value(None, frozenset({"year"}))

    @staticmethod
    def _combine(kind: str, parts: list[_Value]) -> _Value:
        warnings = tuple(w for p in parts for w in p.warnings)
        values = [p.value for p in parts]
        if kind == "all":
            if any(v is False for v in values):
                used = frozenset().union(*(p.used for p in parts if p.value is False))
                return _Value(False, used=used, warnings=warnings)
            if all(v is True for v in values):
                return _Value(True, warnings=warnings)
        else:
            if any(v is True for v in values):
                return _Value(True, warnings=warnings)
            if all(v is False for v in values):
                used = frozenset().union(*(p.used for p in parts))
                return _Value(False, used=used, warnings=warnings)
        needs = frozenset().union(*(p.needs for p in parts if p.value is None))
        return _Value(None, needs, warnings=warnings)

    def _eval(self, node: Any, ctx: _Context) -> _Value:
        if not isinstance(node, dict) or len(node) != 1:
            raise ConditionError(f"condition node must have exactly one key: {node!r}")
        ((kind, arg),) = node.items()
        if kind in ("all", "any"):
            return self._combine(kind, [self._eval(n, ctx) for n in arg])
        if kind == "not":
            inner = self._eval(arg, ctx)
            if inner.value is None:
                return inner
            if inner.value:
                return _Value(False, used=frozenset({"model"}), warnings=inner.warnings)
            return _Value(True, warnings=inner.warnings)
        if kind == "engine":
            return self._eval_engine(arg, ctx)
        if kind == "gearbox":
            return self._eval_gearbox(arg, ctx)
        if kind == "fuel":
            return self._eval_fuel(arg, ctx)
        if kind == "modelYear":
            return self._eval_model_year(arg, ctx)
        if kind == "productionDate":
            return self._eval_production_date(arg, ctx)
        if kind in ("make", "model", "generation"):
            return self._eval_ids(kind, arg, ctx)
        # `market` is deliberately absent: facts carry no market (format 3).
        raise ConditionError(f"unknown condition leaf: {kind}")

    def _resolve(self, defect: dict, ctx: _Context) -> Resolution:
        did = defect["id"]
        applicability = defect.get("applicability", {})
        if ctx.model_id is None:
            warnings = ("unrecognised_model",) if ctx.facts.model else ()
            return Resolution(did, "possible", ("model",), (), warnings)
        if ctx.model_id not in applicability.get("models", ()):
            return Resolution(did, "not_applicable", (), ("model",), ())
        when = applicability.get("when")
        if not when:
            return Resolution(did, "applies", (), (), ctx.warnings)
        result = self._eval(when, ctx)
        warnings = _dedupe(ctx.warnings + result.warnings)
        if result.value is True:
            return Resolution(did, "applies", (), (), warnings)
        if result.value is False:
            return Resolution(
                did, "not_applicable", (), _ordered(result.used), warnings
            )
        return Resolution(did, "possible", _ordered(result.needs), (), warnings)


# ---------------------------------------------------------------------------
# The bundled canon and module-level shortcuts
# ---------------------------------------------------------------------------


@lru_cache(maxsize=1)
def canon_v3() -> DefectsCanon:
    """The v3 canon shipped with this package, parsed and indexed once."""
    vehicles = json.loads((V3_DIR / "vehicles.json").read_text("utf-8"))
    defects = json.loads((V3_DIR / "defects.json").read_text("utf-8"))
    return DefectsCanon.from_data(vehicles, defects)


def resolve_v3(
    facts: Facts | dict, canon: DefectsCanon | None = None
) -> list[Resolution]:
    """Every published v3 dossier on the car's model, resolved against the
    facts, in id order. Empty when the model is not recognised."""
    return (canon or canon_v3()).resolve_v3(facts)


def resolve_defects(
    facts: Facts | dict, canon: DefectsCanon | None = None
) -> list[Resolution]:
    """Same as :func:`resolve_v3`: every published dossier on the car's model,
    resolved against the facts, in id order."""
    return (canon or canon_v3()).resolve_v3(facts)


def assemble_v3(facts: Facts | dict, canon: DefectsCanon | None = None) -> list[dict]:
    """The checklist for a car described by facts; see
    :meth:`DefectsCanon.assemble_v3`."""
    return (canon or canon_v3()).assemble_v3(facts)


def served_id(defect_id: str, canon: DefectsCanon | None = None) -> str | None:
    """The served dossier id for a defect id, following ``aliases``; None
    for a deprecated or unknown id."""
    return (canon or canon_v3()).served_id(defect_id)


def resolve_defect(
    defect_id: str, facts: Facts | dict, canon: DefectsCanon | None = None
) -> Resolution | None:
    """One dossier resolved against the facts; None if no such dossier."""
    return (canon or canon_v3()).resolve_defect(defect_id, facts)


def normalize_make(s: str | None, canon: DefectsCanon | None = None) -> str | None:
    return (canon or canon_v3()).normalize_make(s)


def normalize_model(
    make_id: str | None, s: str | None, canon: DefectsCanon | None = None
) -> str | None:
    return (canon or canon_v3()).normalize_model(make_id, s)


def make_from_wmi(vin: str | None, canon: DefectsCanon | None = None) -> str | None:
    """The make id for a VIN's world manufacturer identifier, offline."""
    return (canon or canon_v3()).make_from_wmi(vin)


def resolved_model(
    facts: Facts | dict, canon: DefectsCanon | None = None
) -> tuple[str | None, str | None]:
    return (canon or canon_v3()).resolved_model(facts)
