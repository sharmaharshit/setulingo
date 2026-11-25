import '../data/sentence_lab_data.dart';
import '../models/reading_mode.dart';
import '../models/sentence_lab.dart';

/// Tag-based linguistic compatibility engine for the 81-word Sentence Lab.
class SentenceEngine {
  SentenceEngine._();

  static List<AnchorWord> get allAnchors => SentenceLabData.anchors;
  static List<NounWord> get allNouns => SentenceLabData.nouns;
  static List<VerbWord> get allVerbs => SentenceLabData.verbs;

  /// Filters nouns that are semantically and grammatically compatible with [anchor].
  static List<NounWord> compatibleNounsFor(AnchorWord? anchor) {
    if (anchor == null) return allNouns;
    return allNouns.where((noun) {
      return noun.semanticTags.any(anchor.allowedNounTags.contains);
    }).toList();
  }

  /// Filters verbs compatible with [anchor] and optionally [noun].
  static List<VerbWord> compatibleVerbsFor({
    AnchorWord? anchor,
    NounWord? noun,
  }) {
    return allVerbs.where((verb) {
      if (anchor != null &&
          !verb.allowedAnchorTypes.contains(anchor.anchorType)) {
        return false;
      }
      if (noun != null &&
          !noun.semanticTags.any(verb.requiredNounTags.contains)) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Validates whether the three selected slots form a valid spoken Kannada
  /// construction according to the dataset tags.
  static bool isValidCombination(
    AnchorWord anchor,
    NounWord noun,
    VerbWord verb,
  ) {
    final nounCompatible =
        noun.semanticTags.any(anchor.allowedNounTags.contains);
    final verbAllowsAnchor =
        verb.allowedAnchorTypes.contains(anchor.anchorType);
    final verbRequiresNoun =
        noun.semanticTags.any(verb.requiredNounTags.contains);
    return nounCompatible && verbAllowsAnchor && verbRequiresNoun;
  }

  /// Assembles a natural spoken Kannada sentence in all 3 representations.
  /// Returns `null` if the combination is not linguistically valid.
  static AssembledSentence? assemble(
    AnchorWord anchor,
    NounWord noun,
    VerbWord verb,
  ) {
    if (!isValidCombination(anchor, noun, verb)) {
      return null;
    }

    // Handle natural spoken Kannada dative/allative suffix for 'place' when going
    final isMotionToPlace = verb.id == 'verb_25' &&
        noun.semanticTags.contains('place');
    final devanagariNoun = isMotionToPlace
        ? '${noun.text.devanagari} को (गे)'
        : noun.text.devanagari;
    final romanNoun = isMotionToPlace
        ? '${noun.text.romanHindi}-ge'
        : noun.text.romanHindi;

    final devanagari =
        '${anchor.text.devanagari} $devanagariNoun ${verb.text.devanagari}';
    final romanHindi =
        '${anchor.text.romanHindi} $romanNoun ${verb.text.romanHindi}';
    final hindi =
        '${anchor.text.hindi} ${noun.text.hindi} ${verb.text.hindi}';

    final grammarNote = _buildGrammarNote(anchor, noun, verb, isMotionToPlace);

    return AssembledSentence(
      anchor: anchor,
      noun: noun,
      verb: verb,
      assembledText: TriScriptText(
        hindi: hindi,
        devanagari: devanagari,
        romanHindi: romanHindi,
      ),
      grammarNote: grammarNote,
    );
  }

  static String _buildGrammarNote(
    AnchorWord anchor,
    NounWord noun,
    VerbWord verb,
    bool isMotionToPlace,
  ) {
    if (isMotionToPlace) {
      return 'Motion verbs like "${verb.text.romanHindi}" attach "-ge" (को/तक) to the destination noun.';
    }
    if (anchor.anchorType == AnchorType.dative) {
      return 'Dative anchor "${anchor.text.romanHindi}" pairs naturally with ${verb.category.label.toLowerCase()} predicates like "${verb.text.romanHindi}".';
    }
    if (anchor.anchorType == AnchorType.quantifier) {
      return 'Quantifier "${anchor.text.romanHindi}" matches ${noun.isCountable ? 'countable' : 'mass'} noun "${noun.text.romanHindi}".';
    }
    return '${anchor.anchorType.label} + ${noun.category.label} + ${verb.category.label} — valid spoken Kannada order (Subject/Anchor → Object → Verb).';
  }
}
