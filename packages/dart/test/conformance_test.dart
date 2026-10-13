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
      expect(canonVersion(), equals({'checklist': 1, 'defects': 2}));

      for (final item in allItems([
        ...canon.base,
        ...canon.fuelModules.values,
      ])) {
        expect(
          item.prompt.toMap().keys.toSet(),
          containsAll(canon.languages),
          reason: item.id,
        );
      }
    });

    test('defect text is authored in every language', () {
      final groups = assemble(const Car(make: 'BMW', model: '320d'));
      final defects = groups.firstWhere((group) => group.id == 'defects');
      final prompt = defects.children.single.items.first.prompt;
      final english = prompt.resolve('en');

      for (final lang in const ['pt', 'ru', 'uk', 'fr']) {
        expect(prompt.resolve(lang), isNot(english), reason: lang);
        expect(prompt.resolve(lang), contains('N47'), reason: lang);
      }
      expect(prompt.resolve('pt'), contains('Corrente N47'));
      // An unsupported language still falls back rather than coming back empty.
      expect(prompt.resolve('de'), english);
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

  group('known defects v3 vectors', () {
    final fixtures = <String, DefectsV3Canon>{
      for (final entry
          in (vectors['v3Fixtures'] as Map<String, dynamic>).entries)
        entry.key: DefectsV3Canon.fromJson(
          entry.value['vehicles'] as Map<String, dynamic>,
          entry.value['defects'] as Map<String, dynamic>,
        ),
    };
    DefectsV3Canon canonFor(Map<String, dynamic> vector) =>
        vector.containsKey('fixture')
            ? fixtures[vector['fixture']]!
            : DefectsV3Canon.bundled;

    for (final raw in vectors['resolveV3'] as List) {
      final vector = raw as Map<String, dynamic>;
      test('resolveV3 — ${vector['name']}', () {
        final got = resolveV3(
          CarFacts.fromJson(vector['facts'] as Map<String, dynamic>),
          canon: canonFor(vector),
        );
        expect(
          jsonDecode(jsonEncode(got.map((r) => r.toJson()).toList())),
          equals(vector['expect']),
        );
      });
    }

    for (final raw in vectors['resolveDefect'] as List) {
      final vector = raw as Map<String, dynamic>;
      test('resolveDefect — ${vector['name']}', () {
        final got = resolveDefect(
          vector['defectId'] as String,
          CarFacts.fromJson(vector['facts'] as Map<String, dynamic>),
          canon: canonFor(vector),
        );
        expect(
          got == null ? null : jsonDecode(jsonEncode(got.toJson())),
          equals(vector['expect']),
        );
      });
    }

    for (final raw in vectors['v3Names'] as List) {
      final vector = raw as Map<String, dynamic>;
      test('names — ${vector['make']} / ${vector['model']}', () {
        final got = resolvedModel(CarFacts.fromJson(vector));
        expect(
          {'make': got.make, 'model': got.model},
          equals(vector['expect']),
        );
      });
    }

    for (final raw in vectors['v3ServedIds'] as List) {
      final vector = raw as Map<String, dynamic>;
      test('servedId — "${vector['id']}"', () {
        expect(servedId(vector['id'] as String), vector['expect']);
      });
    }

    for (final raw in vectors['assembleV3'] as List) {
      final vector = raw as Map<String, dynamic>;
      test('assembleV3 — ${vector['name']}', () {
        final groups = assembleV3(
          CarFacts.fromJson(vector['facts'] as Map<String, dynamic>),
        );
        final expected = vector['expect'] as Map<String, dynamic>;
        expect(groups.map((g) => g.id).toList(), equals(expected['groupIds']));
        expect(allItems(groups).length, expected['itemCount']);

        final group = groups.where((g) => g.id == 'defects').firstOrNull;
        if (group == null) {
          expect(expected['defectsTitle'], isNull);
          expect(expected['defects'], isEmpty);
          return;
        }
        expect(group.ruleId, expected['defectRuleId']);
        expect(group.title.resolve('en'), expected['defectsTitle']);
        final items = allItems([group]);
        final rows = [
          for (final i in items)
            {
              'id': i.id,
              'sourceDefectId': i.sourceDefectId,
              'dossierId': i.dossierId,
              'status': i.status,
              'needs': i.needs,
              'critical': i.critical,
              'prompt': i.prompt.resolve('en'),
              'hint': i.hint?.resolve('en'),
            },
        ];
        expect(rows, equals(expected['defects']));
        expect(
          items.map((i) => i.order).toList(),
          equals(List.generate(rows.length, (i) => i)),
        );
      });
    }

    test('assembleV3 keeps an aliased v2 id and scores like any item', () {
      final groups = assembleV3(
        const CarFacts(make: 'Mercedes-Benz', model: 'C-Class'),
      );
      final rows = groups.last.children.single.items;
      final alias = rows.firstWhere(
        (i) => i.sourceDefectId == 'm271.balanceshaft',
      );
      expect(alias.id, 'defect.m271.balanceshaft');
      expect(alias.dossierId, 'm271.timingchain');
      expect(alias.status, 'possible');
      expect(alias.needs, ['year', 'engineCode']);
      expect(alias.prompt.resolve('fr'), isNot(alias.prompt.resolve('en')));
      expect(alias.hint, isNotNull);
      // A 'possible' item answered "not applicable" is just a -1 to scoring.
      final scores = <String, int?>{
        for (final item in allItems(groups)) item.id: 4,
      };
      scores[alias.id] = kScoreNotApplicable;
      expect(overall(groups, scores), closeTo(4.0, tolerance));
    });

    test('the v2 API is untouched by v3', () {
      final groups = assemble(
        const Car(make: 'Mercedes-Benz', model: 'C-Class', fuelType: 'petrol'),
      );
      final items = allItems([groups.last]);
      expect(items.map((i) => i.sourceDefectId).toList(), [
        'om651.injectors',
        'm271.balanceshaft',
        'rust',
      ]);
      expect(items.every((i) => i.status == null), isTrue);
      expect(items.every((i) => i.dossierId == null && i.hint == null), isTrue);
      expect(items.every((i) => i.needs.isEmpty), isTrue);
      expect(groups.every((g) => g.ruleId == null), isTrue);
    });

    test('resolveDefects is resolveV3', () {
      const facts = CarFacts(make: 'BMW', model: '320d', year: 2010);
      expect(
        resolveDefects(facts).map((r) => r.toJson()).toList(),
        equals(resolveV3(facts).map((r) => r.toJson()).toList()),
      );
    });

    test('typed facts match the JSON form', () {
      const typed = CarFacts(
        make: 'BMW',
        model: '320d',
        engineCode: 'n47d20',
        year: 2010,
      );
      final loose = CarFacts.fromJson({
        'make': 'BMW',
        'model': '320d',
        'engineCode': 'n47d20',
        'year': 2010,
      });
      expect(
        resolveV3(typed).map((r) => r.toJson()).toList(),
        equals(resolveV3(loose).map((r) => r.toJson()).toList()),
      );
      expect(resolveDefect('n47.chain', typed)?.status, 'applies');
    });

    test('the packaged canon', () {
      final canon = DefectsV3Canon.bundled;
      expect(canon.format, 3);
      expect(
        canon.defectsById.keys,
        containsAll(['dsg.dq200', 'n47.chain', 'puretech.wetbelt']),
      );
      expect(canon.defectsById, hasLength(15));
      expect(canon.aliasOf, equals({'m271.balanceshaft': 'm271.timingchain'}));
    });

    test('names fold case, diacritics and decomposed marks', () {
      expect(normalizeName('  Škoda_Octavia '), 'skoda octavia');
      expect(normalizeName('S\u030Ckoda'), 'skoda');
      expect(normalizeName('Straße'), 'strasse');
      expect(normalizeName('Citroën C4'), 'citroen c4');
    });

    test('the condition language is closed', () {
      final canon = DefectsV3Canon.fromJson(
        vectors['v3Fixtures']['synthetic']['vehicles'] as Map<String, dynamic>,
        {
          'format': 3,
          'defects': [
            {
              'id': 'x',
              'status': 'published',
              'applicability': {
                'models': ['testa.alpha'],
                'when': {
                  'market': ['EU'],
                },
              },
            },
          ],
        },
      );
      expect(
        () => canon.resolveV3(const CarFacts(make: 'testa', model: 'alpha')),
        throwsA(isA<ConditionError>()),
      );
    });

    test('the documented example holds', () {
      final dq200 = resolveDefects(
        const CarFacts(make: 'VW', model: 'Golf', gearbox: 'manual'),
      ).first;
      expect(dq200.defectId, 'dsg.dq200');
      expect(dq200.status, 'not_applicable');
      expect(dq200.excludedBy, ['gearbox']);
    });
  });
}
