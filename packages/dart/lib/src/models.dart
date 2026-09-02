/// Types for the Elgarde inspection canon.
library;

/// Not applicable — the item does not apply to this car.
const int kScoreNotApplicable = -1;

/// Not inspected — the inspector explicitly skipped it.
const int kScoreNotInspected = -2;

/// A critical item at or below this score clamps the overall verdict.
const int kCriticalThreshold = 2;

/// Fuel types that select a checklist module. `other` selects none.
const List<String> kFuelTypes = [
  'petrol',
  'diesel',
  'hybrid',
  'ev',
  'other',
];

/// An immutable `{languageCode: text}` map. English is always present and is
/// the fallback for any language the canon does not carry.
class LocalizedText {
  const LocalizedText(this._byLocale);

  factory LocalizedText.fromJson(Map<String, dynamic> json) {
    return LocalizedText(
      json.map((key, value) => MapEntry(key, value as String)),
    );
  }

  final Map<String, String> _byLocale;

  /// The best text for [locale], falling back to English, then to anything.
  String resolve(String locale) {
    return _byLocale[locale] ??
        _byLocale['en'] ??
        (_byLocale.isEmpty ? '' : _byLocale.values.first);
  }

  String? operator [](String locale) => _byLocale[locale];

  Map<String, String> toMap() => Map.unmodifiable(_byLocale);

  @override
  String toString() => resolve('en');
}

/// How a group's score is derived from what sits under it.
enum ScoreAggregation {
  /// Mean of the answered contributions.
  average('average'),

  /// Weight-adjusted mean, using [InspectionItem.weight].
  weighted('weighted'),

  /// The single lowest contribution.
  worstCase('worst_case');

  const ScoreAggregation(this.wireValue);

  final String wireValue;

  static ScoreAggregation fromWire(String? value) {
    return ScoreAggregation.values.firstWhere(
      (aggregation) => aggregation.wireValue == value,
      orElse: () => ScoreAggregation.average,
    );
  }
}

/// One question, answered 1–5 or with a sentinel.
class InspectionItem {
  const InspectionItem({
    required this.id,
    required this.prompt,
    required this.order,
    this.weight = 1.0,
    this.critical = false,
    this.sourceDefectId,
  });

  factory InspectionItem.fromJson(Map<String, dynamic> json) {
    return InspectionItem(
      id: json['id'] as String,
      prompt: LocalizedText.fromJson(json['prompt'] as Map<String, dynamic>),
      order: json['order'] as int? ?? 0,
      weight: (json['weight'] as num? ?? 1).toDouble(),
      critical: json['critical'] as bool? ?? false,
      sourceDefectId: json['sourceDefectId'] as String?,
    );
  }

  /// Stable and permanent — an inspection stays comparable through it.
  final String id;
  final LocalizedText prompt;
  final int order;

  /// Relative weight under [ScoreAggregation.weighted].
  final double weight;

  /// A failing score here clamps the overall verdict down.
  final bool critical;

  /// Provenance back to the defect record that generated this item.
  final String? sourceDefectId;
}

/// A checklist section: child groups, items, or both.
class InspectionGroup {
  const InspectionGroup({
    required this.id,
    required this.title,
    required this.order,
    this.aggregation = ScoreAggregation.average,
    this.children = const [],
    this.items = const [],
  });

  factory InspectionGroup.fromJson(Map<String, dynamic> json) {
    return InspectionGroup(
      id: json['id'] as String,
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>),
      order: json['order'] as int? ?? 0,
      aggregation: ScoreAggregation.fromWire(json['aggregation'] as String?),
      children: [
        for (final child in (json['children'] as List? ?? const []))
          InspectionGroup.fromJson(child as Map<String, dynamic>),
      ],
      items: [
        for (final item in (json['items'] as List? ?? const []))
          InspectionItem.fromJson(item as Map<String, dynamic>),
      ],
    );
  }

  final String id;
  final LocalizedText title;
  final int order;
  final ScoreAggregation aggregation;
  final List<InspectionGroup> children;
  final List<InspectionItem> items;

  bool get isLeaf => children.isEmpty;
}

/// One curated known weak point on a model.
class Defect {
  const Defect({required this.id, required this.text, this.critical = false});

  factory Defect.fromJson(Map<String, dynamic> json) {
    return Defect(
      id: json['id'] as String,
      text: LocalizedText.fromJson(json['text'] as Map<String, dynamic>),
      critical: json['critical'] as bool? ?? false,
    );
  }

  final String id;
  final LocalizedText text;
  final bool critical;
}

/// One make/model condition. Matches when the make contains any [makeAny]
/// token and — when [modelAny] is present — the model contains one of those.
class MatchClause {
  const MatchClause({required this.makeAny, this.modelAny});

  factory MatchClause.fromJson(Map<String, dynamic> json) {
    final models = json['modelAny'] as List?;
    return MatchClause(
      makeAny: (json['makeAny'] as List).cast<String>(),
      modelAny: models?.cast<String>(),
    );
  }

  final List<String> makeAny;
  final List<String>? modelAny;

  bool matches(String make, String model) {
    if (!makeAny.any(make.contains)) return false;
    final models = modelAny;
    if (models == null) return true;
    return models.any(model.contains);
  }
}

/// A group of defects plus the cars it applies to.
class DefectRule {
  const DefectRule({
    required this.id,
    required this.label,
    required this.match,
    required this.defects,
  });

  factory DefectRule.fromJson(Map<String, dynamic> json) {
    return DefectRule(
      id: json['id'] as String,
      label: LocalizedText.fromJson(json['label'] as Map<String, dynamic>),
      match: [
        for (final clause in (json['match'] as List))
          MatchClause.fromJson(clause as Map<String, dynamic>),
      ],
      defects: [
        for (final defect in (json['defects'] as List))
          Defect.fromJson(defect as Map<String, dynamic>),
      ],
    );
  }

  final String id;
  final LocalizedText label;
  final List<MatchClause> match;
  final List<Defect> defects;

  bool matches(String make, String model) {
    return match.any((clause) => clause.matches(make, model));
  }
}

/// The car being inspected. Every field is optional: an unknown fuel type adds
/// no module, and an unknown model adds no defect group.
class Car {
  const Car({this.make, this.model, this.fuelType});

  final String? make;
  final String? model;

  /// One of [kFuelTypes].
  final String? fuelType;
}
