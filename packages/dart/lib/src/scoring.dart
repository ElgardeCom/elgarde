/// Scoring: group rollups, the overall verdict and its critical clamp.
///
/// Implements `inspection-core/spec/SCORING.md`; the conformance vectors in
/// `test/vectors.json` are what prove it.
library;

import 'canon.dart';
import 'models.dart';

/// True only for a real 1–5 rating. Sentinels and unanswered items are false.
bool isRealScore(int? score) => score != null && score > 0;

/// The rolled-up 1–5 score for [group], or null when nothing real is answered
/// underneath it. Child groups contribute with weight 1, whatever they hold.
double? groupScore(InspectionGroup group, Map<String, int?> scores) {
  final parts = <({double value, double weight})>[];

  for (final item in group.items) {
    final score = scores[item.id];
    if (isRealScore(score)) {
      parts.add((value: score!.toDouble(), weight: item.weight));
    }
  }
  for (final child in group.children) {
    final childScore = groupScore(child, scores);
    if (childScore != null) parts.add((value: childScore, weight: 1.0));
  }
  if (parts.isEmpty) return null;

  switch (group.aggregation) {
    case ScoreAggregation.worstCase:
      return parts.map((part) => part.value).reduce((a, b) => a < b ? a : b);
    case ScoreAggregation.weighted:
      final total = parts.fold<double>(0, (sum, part) => sum + part.weight);
      if (total == 0) return 0;
      return parts.fold<double>(
            0,
            (sum, part) => sum + part.value * part.weight,
          ) /
          total;
    case ScoreAggregation.average:
      return parts.fold<double>(0, (sum, part) => sum + part.value) /
          parts.length;
  }
}

/// Every critical item under [groups].
List<InspectionItem> criticalItems(List<InspectionGroup> groups) {
  return allItems(groups).where((item) => item.critical).toList();
}

/// The mean of the top-level group scores, before the critical clamp.
double? overallBeforeClamp(
  List<InspectionGroup> groups,
  Map<String, int?> scores,
) {
  final tops = <double>[];
  for (final group in groups) {
    final score = groupScore(group, scores);
    if (score != null) tops.add(score);
  }
  if (tops.isEmpty) return null;
  return tops.reduce((a, b) => a + b) / tops.length;
}

/// The overall 1–5 verdict.
///
/// The mean of the top-level group scores, then clamped down by any answered
/// critical item scoring at or below [criticalThreshold] — a failed safety or
/// provenance item caps the whole verdict. The clamp only ever lowers it, and
/// an unanswered critical item has no effect.
double? overall(
  List<InspectionGroup> groups,
  Map<String, int?> scores, {
  int criticalThreshold = kCriticalThreshold,
}) {
  final unclamped = overallBeforeClamp(groups, scores);
  if (unclamped == null) return null;

  var verdict = unclamped;
  for (final item in criticalItems(groups)) {
    final score = scores[item.id];
    if (isRealScore(score) && score! <= criticalThreshold && score < verdict) {
      verdict = score.toDouble();
    }
  }
  return verdict;
}

/// `(answered, total)` over leaf items. Sentinels count as answered.
(int answered, int total) progress(
  List<InspectionGroup> groups,
  Map<String, int?> scores,
) {
  final items = allItems(groups);
  var answered = 0;
  for (final item in items) {
    if (scores[item.id] != null) answered++;
  }
  return (answered, items.length);
}
