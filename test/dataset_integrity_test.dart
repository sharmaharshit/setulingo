import 'package:flutter_test/flutter_test.dart';
import 'package:setulingo/data/lessons_data.dart';
import 'package:setulingo/data/numbers_data.dart';
import 'package:setulingo/data/real_spaces_data.dart';
import 'package:setulingo/data/root_bridge_data.dart';
import 'package:setulingo/data/sentence_lab_data.dart';
import 'package:setulingo/models/reading_mode.dart';

bool _containsKannadaScript(String text) {
  return RegExp(r'[\u0C80-\u0CFF]').hasMatch(text);
}

void _assertTriScriptValid(TriScriptText t, String contextLabel) {
  expect(t.hindi.trim(), isNotEmpty, reason: '$contextLabel missing hindi');
  expect(t.devanagari.trim(), isNotEmpty,
      reason: '$contextLabel missing devanagari');
  expect(t.romanHindi.trim(), isNotEmpty,
      reason: '$contextLabel missing romanHindi');
  expect(_containsKannadaScript(t.hindi), isFalse,
      reason: '$contextLabel contains Kannada script in hindi');
  expect(_containsKannadaScript(t.devanagari), isFalse,
      reason: '$contextLabel contains Kannada script in devanagari');
  expect(_containsKannadaScript(t.romanHindi), isFalse,
      reason: '$contextLabel contains Kannada script in romanHindi');
}

void main() {
  group('SetuLingo Dataset Integrity', () {
    test('Real Spaces has exactly 8 spaces and 5 scenarios each (40 total)', () {
      expect(RealSpacesData.spaces.length, 8);
      for (final space in RealSpacesData.spaces) {
        expect(space.scenarios.length, 5,
            reason: '${space.title} should have 5 scenarios');
        for (final scenario in space.scenarios) {
          expect(scenario.phrases, isNotEmpty);
          for (final phrase in scenario.phrases) {
            _assertTriScriptValid(phrase.text, '${scenario.id}:${phrase.id}');
          }
          for (final vocab in scenario.vocabulary) {
            _assertTriScriptValid(vocab.text, '${scenario.id}:${vocab.id}');
          }
        }
      }
      expect(RealSpacesData.allScenarios.length, 40);
    });

    test('Sentence Lab has exactly 22 anchors, 32 nouns, 27 verbs (81 total)', () {
      expect(SentenceLabData.anchors.length, 22);
      expect(SentenceLabData.nouns.length, 32);
      expect(SentenceLabData.verbs.length, 27);
      expect(
        SentenceLabData.anchors.length +
            SentenceLabData.nouns.length +
            SentenceLabData.verbs.length,
        81,
      );

      for (final a in SentenceLabData.anchors) {
        _assertTriScriptValid(a.text, a.id);
      }
      for (final n in SentenceLabData.nouns) {
        _assertTriScriptValid(n.text, n.id);
      }
      for (final v in SentenceLabData.verbs) {
        _assertTriScriptValid(v.text, v.id);
      }
    });

    test('Root Bridge has between 30 and 50 curated connections', () {
      expect(RootBridgeData.connections.length, inInclusiveRange(30, 50));
      for (final c in RootBridgeData.connections) {
        _assertTriScriptValid(c.kannadaForm, '${c.id}:form');
        _assertTriScriptValid(c.exampleUsage, '${c.id}:example');
      }
    });

    test('Numbers and Lessons have valid three-way reading support', () {
      expect(NumbersData.numbers.length, greaterThanOrEqualTo(30));
      for (final n in NumbersData.numbers) {
        _assertTriScriptValid(n.text, n.id);
      }
      expect(LessonsData.lessons, isNotEmpty);
    });
  });
}
