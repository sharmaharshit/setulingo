import 'package:flutter_test/flutter_test.dart';
import 'package:setulingo/data/sentence_lab_data.dart';
import 'package:setulingo/services/sentence_engine.dart';

void main() {
  group('SentenceEngine Tag Compatibility', () {
    test('Filters compatible nouns for quantifier "Ondu" (only countable)', () {
      final ondu =
          SentenceLabData.anchors.firstWhere((a) => a.id == 'anc_11');
      final nouns = SentenceEngine.compatibleNounsFor(ondu);
      expect(nouns, isNotEmpty);
      expect(nouns.every((n) => n.semanticTags.contains('countable')), isTrue);
    });

    test('Assembles valid Dative + Consumable + Beku sentence', () {
      final nanage =
          SentenceLabData.anchors.firstWhere((a) => a.id == 'anc_01');
      final coffee =
          SentenceLabData.nouns.firstWhere((n) => n.id == 'noun_02');
      final beku = SentenceLabData.verbs.firstWhere((v) => v.id == 'verb_01');

      final assembled = SentenceEngine.assemble(nanage, coffee, beku);
      expect(assembled, isNotNull);
      expect(assembled!.assembledText.romanHindi, 'Nanage Coffee Beku');
      expect(assembled.assembledText.devanagari, 'ननगे कॉफी बेकु');
    });

    test('Rejects incompatible Anchor + Noun + Verb combinations', () {
      final ondu =
          SentenceLabData.anchors.firstWhere((a) => a.id == 'anc_11');
      final neeru =
          SentenceLabData.nouns.firstWhere((n) => n.id == 'noun_01');
      final hogteeni =
          SentenceLabData.verbs.firstWhere((v) => v.id == 'verb_25');

      expect(SentenceEngine.isValidCombination(ondu, neeru, hogteeni), isFalse);
      expect(SentenceEngine.assemble(ondu, neeru, hogteeni), isNull);
    });
  });
}
