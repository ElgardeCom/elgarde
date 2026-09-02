/// The canon itself: parsing, checklist assembly and defect-rule matching.
library;

import 'dart:convert';

import 'canon.g.dart';
import 'models.dart';

/// The inspection data shipped with this package, parsed once on first use.
class InspectionCanon {
  InspectionCanon._({
    required this.version,
    required this.languages,
    required this.base,
    required this.fuelModules,
    required this.defectRules,
    required this.defectVersion,
    required this.defectLanguages,
  });

  factory InspectionCanon._parse() {
    final checklist = jsonDecode(checklistCanonJson) as Map<String, dynamic>;
    final defects = jsonDecode(defectsCanonJson) as Map<String, dynamic>;
    final modules =
        (checklist['modules'] as Map<String, dynamic>)['fuel']
            as Map<String, dynamic>;

    return InspectionCanon._(
      version: checklist['version'] as int,
      languages: (checklist['languages'] as List).cast<String>(),
      base: [
        for (final group in (checklist['base'] as List))
          InspectionGroup.fromJson(group as Map<String, dynamic>),
      ],
      fuelModules: {
        for (final entry in modules.entries)
          entry.key: InspectionGroup.fromJson(
            entry.value as Map<String, dynamic>,
          ),
      },
      defectRules: [
        for (final rule in (defects['rules'] as List))
          DefectRule.fromJson(rule as Map<String, dynamic>),
      ],
      defectVersion: defects['version'] as int,
      defectLanguages: (defects['languages'] as List).cast<String>(),
    );
  }

  static InspectionCanon? _instance;

  /// The canon, parsed on first access and cached.
  static InspectionCanon get instance =>
      _instance ??= InspectionCanon._parse();

  /// Checklist data version.
  final int version;

  /// Languages the checklist content carries.
  final List<String> languages;

  /// Top-level groups applicable to every car, in display order.
  final List<InspectionGroup> base;

  /// Fuel type to the module appended for it.
  final Map<String, InspectionGroup> fuelModules;

  /// Ordered defect rules; the first match wins.
  final List<DefectRule> defectRules;

  /// Defect data version.
  final int defectVersion;

  /// Languages the defect text carries.
  final List<String> defectLanguages;
}

/// `{checklist: n, defects: n}` — the data versions this package ships.
Map<String, int> canonVersion() {
  final canon = InspectionCanon.instance;
  return {'checklist': canon.version, 'defects': canon.defectVersion};
}

/// The first rule matching [make] and [model], or null. At most one rule ever
/// applies, and matching is case-insensitive.
DefectRule? matchDefectRule(String? make, String? model) {
  final mk = (make ?? '').toLowerCase();
  final md = (model ?? '').toLowerCase();
  if (mk.isEmpty && md.isEmpty) return null;

  for (final rule in InspectionCanon.instance.defectRules) {
    if (rule.matches(mk, md)) return rule;
  }
  return null;
}

/// A matched rule rendered as the top-level `defects` group.
InspectionGroup defectGroup(DefectRule rule) {
  final items = <InspectionItem>[
    for (var i = 0; i < rule.defects.length; i++)
      InspectionItem(
        id: 'defect.${rule.defects[i].id}',
        prompt: rule.defects[i].text,
        order: i,
        critical: rule.defects[i].critical,
        sourceDefectId: rule.defects[i].id,
      ),
  ];

  return InspectionGroup(
    id: 'defects',
    title: rule.label,
    order: 6,
    children: [
      InspectionGroup(
        id: 'defects.g',
        title: rule.label,
        order: 0,
        items: items,
      ),
    ],
  );
}

/// The checklist for [car]: the base groups, then the fuel module, then the
/// model's known defects when a rule matches.
List<InspectionGroup> assemble(Car car) {
  final canon = InspectionCanon.instance;
  final groups = <InspectionGroup>[...canon.base];

  final module = canon.fuelModules[car.fuelType ?? ''];
  if (module != null) groups.add(module);

  final rule = matchDefectRule(car.make, car.model);
  if (rule != null) groups.add(defectGroup(rule));

  return groups;
}

/// Every leaf item under [groups], depth-first.
List<InspectionItem> allItems(List<InspectionGroup> groups) {
  final out = <InspectionItem>[];
  void walk(InspectionGroup group) {
    out.addAll(group.items);
    group.children.forEach(walk);
  }

  groups.forEach(walk);
  return out;
}
