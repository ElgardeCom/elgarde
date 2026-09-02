/// A structured pre-purchase used-car inspection: a multilingual checklist,
/// curated model-specific known defects, and 1–5 scoring.
///
/// The canon is data, not code — the checklist content and defect rules are
/// embedded from `inspection-core/data/` and shared with every other Elgarde
/// port, all of them pinned by the same conformance vectors.
///
/// ```dart
/// final groups = assemble(
///   const Car(make: 'Volkswagen', model: 'Golf', fuelType: 'diesel'),
/// );
/// final scores = {for (final item in allItems(groups)) item.id: 5};
/// scores['docs.all.mileage'] = 1; // odometer does not match the records
/// overall(groups, scores); // 1.0 — a failed critical item clamps the verdict
/// ```
///
/// Elgarde is a self-service checklist, not a certified, mechanical or legal
/// inspection and not professional advice. A defect entry describes a known
/// weak point on a *model* — never a claim about an individual car.
library;

export 'src/canon.dart'
    show
        InspectionCanon,
        allItems,
        assemble,
        canonVersion,
        defectGroup,
        matchDefectRule;
export 'src/models.dart';
export 'src/scoring.dart';
