/// Known defects v3: which curated weak points apply to one particular car.
///
/// A v3 dossier names the models it concerns and, optionally, a `when`
/// condition over the powertrain and the build date. Given what is known about
/// a car, [resolveDefects] says for every dossier on that model whether it
/// `applies`, is `possible` (and which facts would settle it), or is
/// `not_applicable` (and which facts ruled it out).
///
/// Conditions are evaluated in three-valued (Kleene) logic. Unknown is never
/// rounded down to "not applicable": a false "possible" costs the buyer one
/// question, a false "not applicable" can cost them an engine.
library;

import 'dart:convert';

import 'canon.dart';
import 'canon.g.dart';
import 'fold.g.dart';
import 'models.dart';

/// Query-parameter names in the order `needs` and `excludedBy` list them.
const List<String> kNeedsOrder = [
  'model',
  'year',
  'fuel',
  'gearbox',
  'gearboxCode',
  'engineCode',
  'productionDate',
];

/// Title of the assembled `defects` group when no v2 rule matched the car.
const LocalizedText kKnownDefectsTitle = LocalizedText({
  'en': 'Known defects',
  'pt': 'Defeitos conhecidos',
  'ru': 'Известные дефекты',
  'uk': 'Відомі дефекти',
  'fr': 'Défauts connus',
});

/// The coarse gearbox answers a buyer can give.
const List<String> kGearboxCoarse = ['manual', 'automatic', 'dct', 'cvt'];

// Closed gearbox.type enum -> the coarse answers that describe it.
const Map<String, Set<String>> _gearboxTypeCoarse = {
  'manual': {'manual'},
  'automatic_tc': {'automatic'},
  'cvt': {'automatic', 'cvt'},
  'dct_dry': {'automatic', 'dct'},
  'dct_wet': {'automatic', 'dct'},
  'amt': {'automatic'},
  'single_speed_ev': {'automatic'},
};

const int _ccTolerance = 50;
const int _kwTolerance = 3;

// Fuel facts that say which engine is fitted. A hybrid runs a petrol or diesel
// engine and "other" is mostly LPG/CNG conversions, so neither may rule an
// engine out.
const Set<String> _engineFuels = {'petrol', 'diesel', 'ev'};

/// A `when` condition outside the closed condition language.
class ConditionError implements Exception {
  ConditionError(this.message);

  final String message;

  @override
  String toString() => 'ConditionError: $message';
}

/// What is known about one car. Every field is optional; unknown is null.
///
/// Codes are compared upper-case and an empty string counts as unknown. A
/// [vin] is only used for its first three characters (the WMI), to find the
/// make when none is given — nothing is decoded over the network.
class CarFacts {
  const CarFacts({
    this.make,
    this.model,
    this.year,
    this.productionDate,
    this.fuel,
    this.engineCode,
    this.engineFamily,
    this.gearbox,
    this.gearboxCode,
    this.cc,
    this.powerKw,
    this.vin,
  });

  /// From the API's parameter names (`productionDate`, `powerKw`, …).
  factory CarFacts.fromJson(Map<String, dynamic> json) {
    return CarFacts(
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: json['year'] as int?,
      productionDate: json['productionDate'] as String?,
      fuel: json['fuel'] as String?,
      engineCode: json['engineCode'] as String?,
      engineFamily: json['engineFamily'] as String?,
      gearbox: json['gearbox'] as String?,
      gearboxCode: json['gearboxCode'] as String?,
      cc: json['cc'] as int?,
      powerKw: json['powerKw'] as int?,
      vin: json['vin'] as String?,
    );
  }

  final String? make;
  final String? model;

  /// Model year / year of manufacture.
  final int? year;

  /// Production month, `YYYY-MM`.
  final String? productionDate;

  /// `petrol` · `diesel` · `hybrid` · `ev` · `other`.
  final String? fuel;

  /// Engine code from the plate or data sticker, e.g. `HNZ`, `N47D20`.
  final String? engineCode;

  /// Engine family, e.g. `EB2`, `N47`.
  final String? engineFamily;

  /// Coarse gearbox type: `manual` · `automatic` · `dct` · `cvt`.
  final String? gearbox;

  /// Gearbox code (`0AM`) or family (`DQ200`).
  final String? gearboxCode;

  /// Displacement in cm³.
  final int? cc;

  /// Power in kW (registration field P.2).
  final int? powerKw;

  final String? vin;

  CarFacts _copy({
    String? make,
    Object? engineCode = _keep,
    Object? engineFamily = _keep,
  }) {
    return CarFacts(
      make: make ?? this.make,
      model: model,
      year: year,
      productionDate: productionDate,
      fuel: fuel,
      engineCode: identical(engineCode, _keep)
          ? this.engineCode
          : engineCode as String?,
      engineFamily: identical(engineFamily, _keep)
          ? this.engineFamily
          : engineFamily as String?,
      gearbox: gearbox,
      gearboxCode: gearboxCode,
      cc: cc,
      powerKw: powerKw,
      vin: vin,
    );
  }
}

const Object _keep = Object();

/// The status of one dossier for one car.
class DefectResolution {
  const DefectResolution({
    required this.defectId,
    required this.status,
    this.needs = const [],
    this.excludedBy = const [],
    this.warnings = const [],
  });

  final String defectId;

  /// `applies` · `possible` · `not_applicable`.
  final String status;

  /// For `possible`: the facts that would settle it, in [kNeedsOrder] order.
  final List<String> needs;

  /// For `not_applicable`: the facts that ruled it out.
  final List<String> excludedBy;

  /// `unrecognised_model`, `unrecognised_engine_code`,
  /// `unrecognised_gearbox_code`, `facts_not_in_fitment_table`.
  final List<String> warnings;

  /// The API's JSON shape.
  Map<String, Object> toJson() => {
        'defectId': defectId,
        'status': status,
        'needs': needs,
        'excludedBy': excludedBy,
        'warnings': warnings,
      };

  @override
  String toString() => jsonEncode(toJson());
}

// ---------------------------------------------------------------------------
// Name normalisation
// ---------------------------------------------------------------------------

// The code points Python's unicodedata.combining() reports as combining marks
// (canonical combining class > 0) in the blocks the fold table covers. They
// are dropped after folding, so decomposed input ("S" + U+030C) folds too.
final RegExp _combining = RegExp(
  '[̀-͎͐-ͯ҃-֑҇-ֽֿׁ-ׂ'
  'ׄ-ׇׅ᪰-᪽ᪿ-ᫎ᷀-᷿⃐-⃜'
  '⃥⃡-⃰︠-︯]',
);
final RegExp _whitespace = RegExp(r'\s+');

/// casefold → strip diacritics → `-` and `_` to spaces → collapse whitespace.
String normalizeName(String? s) {
  if (s == null || s.isEmpty) return '';
  final buffer = StringBuffer();
  for (final rune in s.runes) {
    buffer.write(foldTable[rune] ?? String.fromCharCode(rune).toLowerCase());
  }
  final folded = buffer
      .toString()
      .replaceAll(_combining, '')
      .replaceAll('-', ' ')
      .replaceAll('_', ' ');
  return folded.split(_whitespace).where((w) => w.isNotEmpty).join(' ');
}

bool _nameMatches(String value, Iterable<String> names) {
  for (final name in names) {
    final n = normalizeName(name);
    if (n.isNotEmpty && (value == n || value.startsWith('$n '))) return true;
  }
  return false;
}

// ---------------------------------------------------------------------------
// JSON helpers
// ---------------------------------------------------------------------------

typedef _Json = Map<String, dynamic>;

List<_Json> _objects(Object? value) =>
    value is List ? value.cast<_Json>() : const [];

List<String> _strings(Object? value) =>
    value is List ? value.cast<String>() : const [];

Set<String> _upper(Object? value) =>
    {for (final s in _strings(value)) s.toUpperCase()};

String _family(_Json entity) =>
    ((entity['family'] as String?) ?? '').toUpperCase();

bool _inYears(int? year, Object? span) {
  if (year == null || span is! Map || span.isEmpty) return true;
  final lo = span['from'] as int?;
  final hi = span['to'] as int?;
  return (lo == null || year >= lo) && (hi == null || year <= hi);
}

/// True if every candidate satisfies, false if none does, else unknown. An
/// empty candidate set is unknown, never false.
bool? _over(List<bool> values) {
  if (values.isEmpty) return null;
  if (values.every((v) => v)) return true;
  if (!values.any((v) => v)) return false;
  return null;
}

List<String> _ordered(Set<String> names) {
  int rank(String n) {
    final i = kNeedsOrder.indexOf(n);
    return i < 0 ? kNeedsOrder.length : i;
  }

  return names.toList()
    ..sort((a, b) {
      final byRank = rank(a).compareTo(rank(b));
      return byRank != 0 ? byRank : a.compareTo(b);
    });
}

List<String> _dedupe(Iterable<String> items) => {...items}.toList();

class _Value {
  const _Value(
    this.value, {
    this.needs = const {},
    this.used = const {},
    this.warnings = const [],
  });

  final bool? value;
  final Set<String> needs;
  final Set<String> used; // facts that decided a false
  final List<String> warnings;
}

class _Pair {
  const _Pair(this.engine, this.gearbox);

  final _Json engine;
  final _Json? gearbox;
}

class _Context {
  const _Context(this.facts, this.modelId, this.candidates, this.warnings);

  final CarFacts facts;
  final String? modelId;

  // (engine, gearbox-or-null) pairs still consistent with the facts. Empty
  // means "nothing known", never "nothing fits".
  final List<_Pair> candidates;
  final List<String> warnings;
}

// ---------------------------------------------------------------------------
// The indexed canon
// ---------------------------------------------------------------------------

/// `vehicles.json` + `defects.json` (format 3), indexed for resolving.
///
/// Only dossiers whose `status` is `published` are served. The canon
/// guarantees every published dossier clears the evidence threshold, so a
/// port need not carry the evidence file to decide that.
class DefectsV3Canon {
  DefectsV3Canon._(this.vehicles, this.defects) {
    for (final d in _objects(defects['defects'])) {
      if (d['status'] == 'published') defectsById[d['id'] as String] = d;
    }
    defectsById.forEach((id, d) {
      for (final alias in _strings(d['aliases'])) {
        if (!defectsById.containsKey(alias)) aliasOf[alias] = id;
      }
    });
    _makes = _objects(vehicles['makes']);
    _models = _objects(vehicles['models']);
    for (final m in _models) {
      _modelsById[m['id'] as String] = m;
    }
    for (final g in _objects(vehicles['generations'])) {
      (_generationsByModel[g['model'] as String?] ??= []).add(g);
    }
    for (final f in _objects(vehicles['fitments'])) {
      (_fitmentsByGeneration[f['generation'] as String] ??= []).add(f);
    }
    _engines = _objects(vehicles['engines']);
    _gearboxes = _objects(vehicles['gearboxes']);
    for (final e in _engines) {
      _enginesById[e['id'] as String] = e;
      // Later entries win on a duplicated code, as in the reference.
      for (final c in _strings(e['codes'])) {
        _enginesByCode[c.toUpperCase()] = e;
      }
      final family = _family(e);
      if (family.isNotEmpty) _engineFamilies.add(family);
    }
    for (final g in _gearboxes) {
      _gearboxesById[g['id'] as String] = g;
      for (final c in _strings(g['codes'])) {
        _gearboxesByCode[c.toUpperCase()] = g;
      }
    }
  }

  /// From the parsed `vehicles.json` and `defects.json`.
  factory DefectsV3Canon.fromJson(
    Map<String, dynamic> vehicles,
    Map<String, dynamic> defects,
  ) =>
      DefectsV3Canon._(vehicles, defects);

  static DefectsV3Canon? _bundled;

  /// The v3 canon shipped with this package, parsed on first use.
  static DefectsV3Canon get bundled => _bundled ??= DefectsV3Canon._(
        jsonDecode(vehiclesV3CanonJson) as _Json,
        jsonDecode(defectsV3CanonJson) as _Json,
      );

  /// The parsed `vehicles.json`.
  final Map<String, dynamic> vehicles;

  /// The parsed `defects.json`.
  final Map<String, dynamic> defects;

  /// Served (published) dossiers by id.
  final Map<String, Map<String, dynamic>> defectsById = {};

  /// Old id -> served id, from the `aliases` of served dossiers: a renamed
  /// defect keeps its old id (stored `defect.<old id>` answers and the v2
  /// rules still use it) and reaches the new dossier.
  final Map<String, String> aliasOf = {};

  late final List<_Json> _makes;
  late final List<_Json> _models;
  final Map<String, _Json> _modelsById = {};
  final Map<String?, List<_Json>> _generationsByModel = {};
  final Map<String, List<_Json>> _fitmentsByGeneration = {};
  late final List<_Json> _engines;
  late final List<_Json> _gearboxes;
  final Map<String, _Json> _enginesById = {};
  final Map<String, _Json> _gearboxesById = {};
  final Map<String, _Json> _enginesByCode = {};
  final Map<String, _Json> _gearboxesByCode = {};
  final Set<String> _engineFamilies = {};

  /// Data format (3).
  int get format => (defects['format'] as int?) ?? 3;

  /// The question texts keyed by fact name, as in `defects.json`.
  Map<String, dynamic> get questions =>
      (defects['questions'] as Map<String, dynamic>?) ?? const {};

  // --- names ----------------------------------------------------------------

  /// The make id for a free-text make, or null.
  String? normalizeMake(String? s) {
    final value = normalizeName(s);
    if (value.isEmpty) return null;
    for (final make in _makes) {
      final names = [..._strings(make['names']), make['id'] as String];
      if (_nameMatches(value, names)) return make['id'] as String;
    }
    return null;
  }

  /// The model id for a free-text model of the make [makeId], or null.
  String? normalizeModel(String? makeId, String? s) {
    final value = normalizeName(s);
    if (makeId == null || makeId.isEmpty || value.isEmpty) return null;
    for (final model in _models) {
      if (model['make'] != makeId) continue;
      if (_nameMatches(value, _strings(model['excludeNames']))) continue;
      if (_nameMatches(value, _strings(model['names']))) {
        return model['id'] as String;
      }
    }
    return null;
  }

  /// The make id for a VIN's world manufacturer identifier, offline.
  String? makeFromWmi(String? vin) {
    final normalized = (vin ?? '').trim().toUpperCase();
    if (normalized.isEmpty) return null;
    final wmi = normalized.length > 3 ? normalized.substring(0, 3) : normalized;
    for (final make in _makes) {
      if (_upper(make['wmi']).contains(wmi)) return make['id'] as String;
    }
    return null;
  }

  /// (make id, model id) as the dictionary understands them.
  ({String? make, String? model}) resolvedModel(CarFacts facts) {
    final f = _prepare(facts);
    final makeId = normalizeMake(f.make);
    return (make: makeId, model: normalizeModel(makeId, f.model));
  }

  // --- resolving ------------------------------------------------------------

  /// The served dossier id for [defectId]: itself when it is a published
  /// dossier, the dossier that lists it in `aliases` when it was renamed,
  /// else null (deprecated or unknown).
  String? servedId(String defectId) =>
      defectsById.containsKey(defectId) ? defectId : aliasOf[defectId];

  /// Same as [resolveV3].
  List<DefectResolution> resolveDefects(CarFacts facts) => resolveV3(facts);

  /// Every served dossier whose `applicability.models` contains the car's
  /// model, in id order. Empty when the model is not recognised.
  List<DefectResolution> resolveV3(CarFacts facts) {
    final ctx = _context(facts);
    final modelId = ctx.modelId;
    if (modelId == null) return const [];
    final ids = defectsById.keys.toList()..sort();
    return [
      for (final id in ids)
        if (_strings(_applicability(defectsById[id]!)['models'])
            .contains(modelId))
          _resolve(defectsById[id]!, ctx),
    ];
  }

  /// One served dossier resolved against [facts]; null if there is none.
  DefectResolution? resolveDefect(String defectId, CarFacts facts) {
    final defect = defectsById[defectId];
    if (defect == null) return null;
    return _resolve(defect, _context(facts));
  }

  /// The checklist for a car described by [facts]: the base groups, the fuel
  /// module for `facts.fuel`, and a `defects` group built the way
  /// `GET /v1/defects` builds its list when facts are given.
  ///
  /// The v2 rule's rows come first, in rule order, keeping their v2 id
  /// (`defect.<v2 id>`), text and critical flag so stored answers stay valid.
  /// Each is linked to its served dossier ([servedId]) and dropped when that
  /// dossier is `not_applicable`; a row with no dossier stays, with status
  /// `legacy`. Then every other dossier on the model that applies or is
  /// possible, in id order. Items carry [InspectionItem.status],
  /// [InspectionItem.needs], [InspectionItem.dossierId] and
  /// [InspectionItem.hint]; the group carries the matched v2
  /// [InspectionGroup.ruleId]. No defects group when it would be empty.
  List<InspectionGroup> assembleV3(CarFacts facts) {
    final checklist = InspectionCanon.instance;
    final groups = <InspectionGroup>[...checklist.base];
    final f = _prepare(facts);
    final module = checklist.fuelModules[f.fuel ?? ''];
    if (module != null) groups.add(module);

    var rule = matchDefectRule(f.make, f.model);
    final rawMake = facts.make;
    if (rule == null &&
        (rawMake == null || rawMake.isEmpty) &&
        f.make != null) {
      // A make id from the VIN's WMI, spelled the way v2 rules expect.
      final names = [
        for (final m in _makes)
          if (m['id'] == f.make) ..._strings(m['names']),
      ];
      rule = matchDefectRule(names.isEmpty ? f.make : names.first, f.model);
    }

    final ctx = _context(f);
    final items = <InspectionItem>[];
    final covered = <String>{};
    for (final d in rule?.defects ?? const <Defect>[]) {
      final sid = servedId(d.id);
      DefectResolution? r;
      if (sid != null) {
        covered.add(sid);
        r = _resolve(defectsById[sid]!, ctx);
        if (r.status == 'not_applicable') continue;
      }
      items.add(_item(items.length, d.id, d.text, d.critical, sid, r));
    }
    final modelId = ctx.modelId;
    if (modelId != null) {
      final ids = defectsById.keys.toList()..sort();
      for (final id in ids) {
        final dossier = defectsById[id]!;
        if (covered.contains(id) ||
            !_strings(_applicability(dossier)['models']).contains(modelId)) {
          continue;
        }
        final r = _resolve(dossier, ctx);
        if (r.status == 'not_applicable') continue;
        final prompt = _localized(dossier['checklistPrompt']) ??
            _localized(dossier['title']) ??
            const LocalizedText({});
        items.add(_item(items.length, id, prompt, _isCritical(dossier), id, r));
      }
    }
    if (items.isEmpty) return groups;

    final title = rule?.label ?? kKnownDefectsTitle;
    groups.add(
      InspectionGroup(
        id: 'defects',
        title: title,
        order: 6,
        ruleId: rule?.id,
        children: [
          InspectionGroup(
            id: 'defects.g',
            title: title,
            order: 0,
            items: items,
          ),
        ],
      ),
    );
    return groups;
  }

  // --- internals ------------------------------------------------------------

  static bool _isCritical(Map<String, dynamic> dossier) =>
      dossier.containsKey('critical')
          ? dossier['critical'] == true
          : dossier['severity'] == 'critical';

  static LocalizedText? _localized(Object? value) =>
      value is Map && value.isNotEmpty
          ? LocalizedText.fromJson(value.cast<String, dynamic>())
          : null;

  InspectionItem _item(
    int order,
    String defectId,
    LocalizedText prompt,
    bool critical,
    String? dossierId,
    DefectResolution? r,
  ) {
    final hint = dossierId == null
        ? null
        : _localized(_applicability(defectsById[dossierId]!)['hint']);
    return InspectionItem(
      id: 'defect.$defectId',
      prompt: prompt,
      order: order,
      critical: critical,
      sourceDefectId: defectId,
      dossierId: dossierId,
      status: r?.status ?? 'legacy',
      needs: r?.needs ?? const [],
      hint: hint,
    );
  }

  static _Json _applicability(_Json defect) =>
      (defect['applicability'] as _Json?) ?? const {};

  CarFacts _prepare(CarFacts facts) {
    String? blank(String? v) => v == '' ? null : v;
    String? code(String? v) => blank(v?.trim().toUpperCase());

    var make = blank(facts.make);
    final vin = code(facts.vin);
    if (make == null && vin != null) make = makeFromWmi(vin);
    return CarFacts(
      make: make,
      model: blank(facts.model),
      year: facts.year,
      productionDate: blank(facts.productionDate),
      fuel: blank(facts.fuel),
      engineCode: code(facts.engineCode),
      engineFamily: code(facts.engineFamily),
      gearbox: blank(facts.gearbox),
      gearboxCode: code(facts.gearboxCode),
      cc: facts.cc,
      powerKw: facts.powerKw,
      vin: vin,
    );
  }

  /// Read an engine code that is really a family name ("EB2") as a family,
  /// and an "engine family" that is really a code ("N47D20") as that code.
  /// Taken literally, either mix-up rules out the buyer's own engine.
  CarFacts _disambiguateEngine(CarFacts f) {
    final code = f.engineCode;
    final family = f.engineFamily;
    if (code != null && _engineFamilies.contains(code)) {
      return f._copy(engineCode: null, engineFamily: family ?? code);
    }
    if (code == null &&
        family != null &&
        !_engineFamilies.contains(family) &&
        _enginesByCode.containsKey(family)) {
      return f._copy(engineCode: family, engineFamily: null);
    }
    return f;
  }

  _Context _context(CarFacts facts) {
    final f = _disambiguateEngine(_prepare(facts));
    final makeId = normalizeMake(f.make);
    final modelId = normalizeModel(makeId, f.model);
    if (modelId == null) return _Context(f, null, const [], const []);
    return _candidates(f, modelId);
  }

  bool _engineFits(_Json engine, CarFacts f) {
    final fuel = engine['fuel'] as String?;
    if (_engineFuels.contains(f.fuel) &&
        fuel != null &&
        fuel.isNotEmpty &&
        fuel != f.fuel) {
      return false;
    }
    final cc = engine['displacementCc'] as num?;
    if (f.cc != null && cc != null && (f.cc! - cc).abs() > _ccTolerance) {
      return false;
    }
    final powers = engine['powerKw'] is List
        ? (engine['powerKw'] as List).cast<num>()
        : const <num>[];
    if (f.powerKw != null &&
        powers.isNotEmpty &&
        powers
                .map((p) => (f.powerKw! - p).abs())
                .reduce((a, b) => a < b ? a : b) >
            _kwTolerance) {
      return false;
    }
    if (f.engineCode != null &&
        !_upper(engine['codes']).contains(f.engineCode)) {
      return false;
    }
    return f.engineFamily == null || _family(engine) == f.engineFamily;
  }

  bool _gearboxFits(_Json gearbox, CarFacts f) {
    if (f.gearbox != null &&
        !(_gearboxTypeCoarse[gearbox['type']] ?? const <String>{})
            .contains(f.gearbox)) {
      return false;
    }
    return f.gearboxCode == null ||
        _upper(gearbox['codes']).contains(f.gearboxCode) ||
        f.gearboxCode == _family(gearbox);
  }

  _Context _candidates(CarFacts f, String modelId) {
    final allGens = _generationsByModel[modelId] ?? const <_Json>[];
    final gens = allGens.where((g) => _inYears(f.year, g['years']));
    final hasTable = allGens.any(
      (g) => (_fitmentsByGeneration[g['id']] ?? const []).isNotEmpty,
    );

    final pairs = <_Pair>[];
    for (final g in gens) {
      for (final fit in _fitmentsByGeneration[g['id']] ?? const <_Json>[]) {
        if (!_inYears(f.year, fit['years'])) continue;
        final engine = _enginesById[fit['engine']];
        if (engine == null || !_engineFits(engine, f)) continue;
        final boxes = [
          for (final id in _strings(fit['gearboxes']))
            if (_gearboxesById.containsKey(id)) _gearboxesById[id]!,
        ];
        if (boxes.isEmpty) {
          pairs.add(_Pair(engine, null)); // gearbox not recorded: unknown
          continue;
        }
        for (final box in boxes) {
          if (_gearboxFits(box, f)) pairs.add(_Pair(engine, box));
        }
      }
    }

    if (hasTable && pairs.isEmpty) {
      return _Context(
          f, modelId, const [], const ['facts_not_in_fitment_table']);
    }
    return _Context(f, modelId, pairs, const []);
  }

  // --- condition leaves -----------------------------------------------------

  static bool _engineMatches(_Json engine, _Json leaf) {
    if (_strings(leaf['ids']).contains(engine['id'])) return true;
    if (_upper(leaf['family']).contains(_family(engine))) return true;
    return _upper(leaf['codes'])
        .intersection(_upper(engine['codes']))
        .isNotEmpty;
  }

  static bool _gearboxMatches(_Json gearbox, _Json leaf) {
    if (_strings(leaf['ids']).contains(gearbox['id'])) return true;
    if (_upper(leaf['family']).contains(_family(gearbox))) return true;
    if (_strings(leaf['type']).contains(gearbox['type'])) return true;
    return _upper(leaf['codes'])
        .intersection(_upper(gearbox['codes']))
        .isNotEmpty;
  }

  static Set<String> _candidateFactsUsed(_Context ctx) {
    final f = ctx.facts;
    return {
      'model',
      if (f.year != null) 'year',
      if (f.fuel != null) 'fuel',
      if (f.cc != null) 'cc',
      if (f.powerKw != null) 'powerKw',
      if (f.gearbox != null) 'gearbox',
      if (f.gearboxCode != null) 'gearboxCode',
    };
  }

  static bool _truthy(Object? v) =>
      v != null && !(v is List && v.isEmpty) && !(v is String && v.isEmpty);

  _Value _evalEngine(_Json leaf, _Context ctx) {
    final f = ctx.facts;
    final code = f.engineCode;
    if (code != null) {
      if (_upper(leaf['codes']).contains(code)) return const _Value(true);
      final engine = _enginesByCode[code];
      if (engine == null) {
        return const _Value(null, warnings: ['unrecognised_engine_code']);
      }
      if (_engineMatches(engine, leaf)) return const _Value(true);
      return const _Value(false, used: {'engineCode'});
    }

    final known = _engines.where((e) => _engineMatches(e, leaf)).toList();
    if (f.engineFamily != null) {
      final families = {..._upper(leaf['family']), ...known.map(_family)};
      if (!families.contains(f.engineFamily)) {
        return const _Value(false, used: {'engineFamily'});
      }
      if (_truthy(leaf['family']) &&
          !_truthy(leaf['codes']) &&
          !_truthy(leaf['ids'])) {
        return const _Value(true);
      }
    }

    // Fuel can rule an engine out without a fitment table; power and
    // displacement cannot (the dictionary lists confirmed ratings, not all).
    if (known.isNotEmpty &&
        _engineFuels.contains(f.fuel) &&
        known.every((e) {
          final fuel = e['fuel'] as String?;
          return fuel != null && fuel.isNotEmpty && fuel != f.fuel;
        })) {
      return const _Value(false, used: {'fuel'});
    }

    if (ctx.candidates.isNotEmpty) {
      final verdict = _over([
        for (final c in ctx.candidates) _engineMatches(c.engine, leaf),
      ]);
      if (verdict == false) {
        return _Value(false, used: _candidateFactsUsed(ctx));
      }
      if (verdict == true) return const _Value(true);
    }
    return const _Value(null, needs: {'engineCode'});
  }

  _Value _evalGearbox(_Json leaf, _Context ctx) {
    final f = ctx.facts;
    final code = f.gearboxCode;
    if (code != null) {
      if ({..._upper(leaf['codes']), ..._upper(leaf['family'])}
          .contains(code)) {
        return const _Value(true);
      }
      _Json? box = _gearboxesByCode[code];
      if (box == null) {
        for (final g in _gearboxes) {
          if (_family(g) == code) {
            box = g;
            break;
          }
        }
      }
      if (box == null) {
        return const _Value(null, warnings: ['unrecognised_gearbox_code']);
      }
      if (_gearboxMatches(box, leaf)) return const _Value(true);
      return const _Value(false, used: {'gearboxCode'});
    }

    final known = _gearboxes.where((g) => _gearboxMatches(g, leaf));
    final types = <String?>{
      ..._strings(leaf['type']),
      ...known.map((g) => g['type'] as String?),
    };
    if (f.gearbox != null && types.isNotEmpty) {
      final coarse = <String>{
        for (final t in types) ...?_gearboxTypeCoarse[t],
      };
      if (!coarse.contains(f.gearbox)) {
        return const _Value(false, used: {'gearbox'});
      }
    }

    if (ctx.candidates.isNotEmpty &&
        ctx.candidates.every((c) => c.gearbox != null)) {
      final verdict = _over([
        for (final c in ctx.candidates) _gearboxMatches(c.gearbox!, leaf),
      ]);
      if (verdict == false) {
        return _Value(false, used: _candidateFactsUsed(ctx));
      }
      if (verdict == true) return const _Value(true);
    }
    return _Value(null, needs: {f.gearbox != null ? 'gearboxCode' : 'gearbox'});
  }

  _Value _evalFuel(Object? leaf, _Context ctx) {
    final wanted =
        leaf is Map ? _strings(leaf['in']).toSet() : _strings(leaf).toSet();
    final fuel = ctx.facts.fuel;
    if (fuel != null) {
      if (wanted.contains(fuel)) return const _Value(true);
      return const _Value(false, used: {'fuel'});
    }
    if (ctx.candidates.isNotEmpty) {
      final verdict = _over([
        for (final c in ctx.candidates) wanted.contains(c.engine['fuel']),
      ]);
      if (verdict == false) {
        return _Value(false, used: _candidateFactsUsed(ctx));
      }
      if (verdict == true) return const _Value(true);
    }
    return const _Value(null, needs: {'fuel'});
  }

  static _Value _evalModelYear(_Json leaf, _Context ctx) {
    final year = ctx.facts.year;
    if (year == null) return const _Value(null, needs: {'year'});
    if (_inYears(year, leaf)) return const _Value(true);
    return const _Value(false, used: {'year'});
  }

  static _Value _evalProductionDate(_Json leaf, _Context ctx) {
    final lo = leaf['from'] as String?;
    final hi = leaf['to'] as String?;
    final pd = ctx.facts.productionDate;
    if (pd != null) {
      if ((lo == null || pd.compareTo(lo) >= 0) &&
          (hi == null || pd.compareTo(hi) <= 0)) {
        return const _Value(true);
      }
      return const _Value(false, used: {'productionDate'});
    }
    final year = ctx.facts.year;
    if (year == null) return const _Value(null, needs: {'year'});
    final loY = lo == null || lo.isEmpty ? null : int.parse(lo.substring(0, 4));
    final hiY = hi == null || hi.isEmpty ? null : int.parse(hi.substring(0, 4));
    // A year is never earlier than the build year, but it can be one later
    // (model years run ahead, and first registration can trail the build). So
    // one year past the window is unknown; only a year before it, or two past
    // it, rules the car out.
    if ((loY != null && year < loY) || (hiY != null && year > hiY + 1)) {
      return const _Value(false, used: {'year'});
    }
    // A year on a boundary month is ambiguous unless the boundary is a whole
    // calendar year (from January / to December).
    final onLo = loY != null && year == loY && !lo!.endsWith('-01');
    final onHi = hiY != null &&
        (year == hiY + 1 || (year == hiY && !hi!.endsWith('-12')));
    if (onLo || onHi) return const _Value(null, needs: {'productionDate'});
    return const _Value(true);
  }

  _Value _evalIds(String kind, Object? leaf, _Context ctx) {
    final wanted =
        leaf is Map ? _strings(leaf['ids']).toSet() : _strings(leaf).toSet();
    final modelId = ctx.modelId;
    if (modelId == null) return const _Value(null, needs: {'model'});
    if (kind == 'make') {
      if (wanted.contains(_modelsById[modelId]!['make'])) {
        return const _Value(true);
      }
      return const _Value(false, used: {'make'});
    }
    if (kind == 'model') {
      if (wanted.contains(modelId)) return const _Value(true);
      return const _Value(false, used: {'model'});
    }
    final gens = (_generationsByModel[modelId] ?? const <_Json>[])
        .where((g) => _inYears(ctx.facts.year, g['years']));
    final verdict = _over([for (final g in gens) wanted.contains(g['id'])]);
    if (verdict == false) {
      final year = ctx.facts.year;
      return _Value(
        false,
        used: year != null && year != 0 ? {'model', 'year'} : {'model'},
      );
    }
    if (verdict == true) return const _Value(true);
    return const _Value(null, needs: {'year'});
  }

  static _Value _combine(String kind, List<_Value> parts) {
    final warnings = [for (final p in parts) ...p.warnings];
    if (kind == 'all') {
      if (parts.any((p) => p.value == false)) {
        return _Value(
          false,
          used: {
            for (final p in parts)
              if (p.value == false) ...p.used,
          },
          warnings: warnings,
        );
      }
      if (parts.every((p) => p.value == true)) {
        return _Value(true, warnings: warnings);
      }
    } else {
      if (parts.any((p) => p.value == true)) {
        return _Value(true, warnings: warnings);
      }
      if (parts.every((p) => p.value == false)) {
        return _Value(
          false,
          used: {for (final p in parts) ...p.used},
          warnings: warnings,
        );
      }
    }
    return _Value(
      null,
      needs: {
        for (final p in parts)
          if (p.value == null) ...p.needs,
      },
      warnings: warnings,
    );
  }

  _Value _eval(Object? node, _Context ctx) {
    if (node is! Map || node.length != 1) {
      throw ConditionError('condition node must have exactly one key: $node');
    }
    final kind = node.keys.first as String;
    final arg = node.values.first;
    switch (kind) {
      case 'all':
      case 'any':
        return _combine(kind, [
          for (final n in (arg as List)) _eval(n, ctx),
        ]);
      case 'not':
        final inner = _eval(arg, ctx);
        if (inner.value == null) return inner;
        if (inner.value!) {
          return _Value(false, used: const {'model'}, warnings: inner.warnings);
        }
        return _Value(true, warnings: inner.warnings);
      case 'engine':
        return _evalEngine(arg as _Json, ctx);
      case 'gearbox':
        return _evalGearbox(arg as _Json, ctx);
      case 'fuel':
        return _evalFuel(arg, ctx);
      case 'modelYear':
        return _evalModelYear(arg as _Json, ctx);
      case 'productionDate':
        return _evalProductionDate(arg as _Json, ctx);
      case 'make':
      case 'model':
      case 'generation':
        return _evalIds(kind, arg, ctx);
    }
    // `market` is deliberately absent: facts carry no market (format 3).
    throw ConditionError('unknown condition leaf: $kind');
  }

  DefectResolution _resolve(_Json defect, _Context ctx) {
    final id = defect['id'] as String;
    final applicability = _applicability(defect);
    final modelId = ctx.modelId;
    if (modelId == null) {
      final model = ctx.facts.model;
      return DefectResolution(
        defectId: id,
        status: 'possible',
        needs: const ['model'],
        warnings: model != null && model.isNotEmpty
            ? const ['unrecognised_model']
            : const [],
      );
    }
    if (!_strings(applicability['models']).contains(modelId)) {
      return DefectResolution(
        defectId: id,
        status: 'not_applicable',
        excludedBy: const ['model'],
      );
    }
    final when = applicability['when'];
    if (when == null || (when is Map && when.isEmpty)) {
      return DefectResolution(
        defectId: id,
        status: 'applies',
        warnings: ctx.warnings,
      );
    }
    final result = _eval(when, ctx);
    final warnings = _dedupe([...ctx.warnings, ...result.warnings]);
    if (result.value == true) {
      return DefectResolution(
        defectId: id,
        status: 'applies',
        warnings: warnings,
      );
    }
    if (result.value == false) {
      return DefectResolution(
        defectId: id,
        status: 'not_applicable',
        excludedBy: _ordered(result.used),
        warnings: warnings,
      );
    }
    return DefectResolution(
      defectId: id,
      status: 'possible',
      needs: _ordered(result.needs),
      warnings: warnings,
    );
  }
}

/// Every published v3 dossier on the car's model, resolved against [facts],
/// in id order. Empty when the model is not recognised.
List<DefectResolution> resolveDefects(
  CarFacts facts, {
  DefectsV3Canon? canon,
}) =>
    (canon ?? DefectsV3Canon.bundled).resolveV3(facts);

/// Same as [resolveDefects].
List<DefectResolution> resolveV3(CarFacts facts, {DefectsV3Canon? canon}) =>
    resolveDefects(facts, canon: canon);

/// The checklist for a car described by [facts]; see
/// [DefectsV3Canon.assembleV3].
List<InspectionGroup> assembleV3(CarFacts facts, {DefectsV3Canon? canon}) =>
    (canon ?? DefectsV3Canon.bundled).assembleV3(facts);

/// The served dossier id for [defectId], following `aliases`; null for a
/// deprecated or unknown id.
String? servedId(String defectId, {DefectsV3Canon? canon}) =>
    (canon ?? DefectsV3Canon.bundled).servedId(defectId);

/// (make id, model id) as the v3 dictionary understands [facts].
({String? make, String? model}) resolvedModel(
  CarFacts facts, {
  DefectsV3Canon? canon,
}) =>
    (canon ?? DefectsV3Canon.bundled).resolvedModel(facts);

/// One dossier resolved against [facts]; null if there is no such dossier.
DefectResolution? resolveDefect(
  String defectId,
  CarFacts facts, {
  DefectsV3Canon? canon,
}) =>
    (canon ?? DefectsV3Canon.bundled).resolveDefect(defectId, facts);
