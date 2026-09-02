// The shared conformance suite. vectors.json is copied from
// inspection-core/conformance/ by inspection-core/tools/sync_canon.py; every
// port must pass exactly these vectors. A failure here means this port
// disagrees with the canon, not that the vectors need updating.

import 'dart:convert';
import 'dart:io';

import 'package:elgarde_inspection/elgarde_inspection.dart';
import 'package:test/test.dart';

Map<String, dynamic> _loadVectors() {
  final raw = File('test/vectors.json').readAsStringSync();
  return jsonDecode(raw) as Map<String, dynamic>;
}

Car _car(Map<String, dynamic> spec) {
  return Car(
    make: spec['make'] as String?,
    model: spec['model'] as String?,
    fuelType: spec['fuelType'] as String?,
  );
}

Map<String, int?> _scores(Map<String, dynamic> raw) {
  return raw.map((key, value) => MapEntry(key, value as int?));
}

void main() {
  final vectors = _loadVectors();
  final tolerance = (vectors['notes']['tolerance'] as num).toDouble();

  Matcher closeToOrNull(Object? expected) {
    if (expected == null) return isNull;
    return closeTo((expected as num).toDouble(), tolerance);
  }

  group('scoring vectors', () {
    for (final raw in vectors['scoring'] as List) {
      final vector = raw as Map<String, dynamic>;
      test(vector['name'] as String, () {
        final fixture = vectors['fixtures'][vector['fixture']];
        final groups = <InspectionGroup>[
          for (final group in fixture['groups'] as List)
            InspectionGroup.fromJson(group as Map<String, dynamic>),
        ];
        final scores = _scores(vector['scores'] as Map<String, dynamic>);
        final expected = vector['expect'] as Map<String, dynamic>;

        final groupScores = expected['groupScores'] as Map<String, dynamic>;
        groupScores.forEach((id, want) {
          final group = groups.firstWhere((group) => group.id == id);
          expect(groupScore(group, scores), closeToOrNull(want), reason: id);
        });

        expect(
          overallBeforeClamp(groups, scores),
          closeToOrNull(expected['overallBeforeClamp']),
        );
        expect(overall(groups, scores), closeToOrNull(expected['overall']));

        final (answered, total) = progress(groups, scores);
        expect([answered, total], equals(expected['progress']));
      });
    }
  });

  group('assembly vectors', () {
    for (final raw in vectors['assembly'] as List) {
      final vector = raw as Map<String, dynamic>;
      test(vector['name'] as String, () {
        final groups = assemble(_car(vector['car'] as Map<String, dynamic>));
        final expected = vector['expect'] as Map<String, dynamic>;

        expect(
          groups.map((group) => group.id).toList(),
          equals(expected['groupIds']),
        );
        expect(allItems(groups).length, expected['itemCount']);

        final rule = matchDefectRule(
          vector['car']['make'] as String?,
          vector['car']['model'] as String?,
        );
        expect(rule?.id, expected['defectRuleId']);
      });
    }
  });

  group('matching vectors', () {
    for (final raw in vectors['matching'] as List) {
      final vector = raw as Map<String, dynamic>;
      final label = '${vector['make']} ${vector['model']}';
      test('$label matches ${vector['expect'] ?? 'no rule'}', () {
        final rule = matchDefectRule(
          vector['make'] as String?,
          vector['model'] as String?,
        );
        expect(rule?.id, vector['expect']);
      });
    }
  });

  group('canon scoring vectors', () {
    for (final raw in vectors['canonScoring'] as List) {
      final vector = raw as Map<String, dynamic>;
      test(vector['name'] as String, () {
        final groups = assemble(_car(vector['car'] as Map<String, dynamic>));
        final fill = vector['fillAll'] as int;
        final scores = <String, int?>{
          for (final item in allItems(groups)) item.id: fill,
        };
        scores.addAll(_scores(vector['override'] as Map<String, dynamic>));
        final expected = vector['expect'] as Map<String, dynamic>;

        if (expected.containsKey('overallBeforeClamp')) {
          expect(
            overallBeforeClamp(groups, scores),
            closeToOrNull(expected['overallBeforeClamp']),
          );
        }
        expect(overall(groups, scores), closeToOrNull(expected['overall']));

        final (answered, total) = progress(groups, scores);
        expect([answered, total], equals(expected['progress']));
      });
    }
  });

  group('the embedded canon', () {
    test('carries every language on every item', () {
      final canon = InspectionCanon.instance;
      expect(canon.languages, equals(['en', 'pt', 'ru', 'uk', 'fr']));
      expect(canonVersion(), equals({'checklist': 1, 'defects': 1}));

      for (final item in allItems([...canon.base, ...canon.fuelModules.values])) {
        expect(
          item.prompt.toMap().keys.toSet(),
          containsAll(canon.languages),
          reason: item.id,
        );
      }
    });

    test('defect text falls back to English', () {
      final groups = assemble(const Car(make: 'BMW', model: '320d'));
      final defects = groups.firstWhere((group) => group.id == 'defects');
      final prompt = defects.children.single.items.first.prompt;
      expect(prompt.resolve('uk'), contains('N47'));
      expect(prompt.resolve('pt'), contains('Corrente N47'));
    });

    test('the documented example holds', () {
      final groups = assemble(
        const Car(make: 'Volkswagen', model: 'Golf', fuelType: 'diesel'),
      );
      final scores = <String, int?>{
        for (final item in allItems(groups)) item.id: 5,
      };
      scores['docs.all.mileage'] = 1;
      expect(overall(groups, scores), 1.0);
    });
  });
}
