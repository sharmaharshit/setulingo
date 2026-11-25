import 'reading_mode.dart';

enum AnchorType {
  dative,
  possessive,
  modifier,
  quantifier,
  nominative,
  locative,
  temporal,
  interrogative;

  String get label {
    switch (this) {
      case AnchorType.dative:
        return 'Dative (मुझे / आपको)';
      case AnchorType.possessive:
        return 'Possessive (मेरा / आपका)';
      case AnchorType.modifier:
        return 'Modifier (यह / वह / नया)';
      case AnchorType.quantifier:
        return 'Quantifier (एक / थोड़ा / बहुत)';
      case AnchorType.nominative:
        return 'Nominative (मैं / हम / आप)';
      case AnchorType.locative:
        return 'Locative (यहाँ / वहाँ / पास)';
      case AnchorType.temporal:
        return 'Temporal (अभी / आज / कल)';
      case AnchorType.interrogative:
        return 'Interrogative (कौनसा / कितना)';
    }
  }
}

enum NounCategory {
  drinks,
  food,
  objects,
  places,
  travel,
  work,
  information,
  peopleAndTime;

  String get label {
    switch (this) {
      case NounCategory.drinks:
        return 'Drinks';
      case NounCategory.food:
        return 'Food';
      case NounCategory.objects:
        return 'Objects';
      case NounCategory.places:
        return 'Places';
      case NounCategory.travel:
        return 'Travel';
      case NounCategory.work:
        return 'Work';
      case NounCategory.information:
        return 'Information';
      case NounCategory.peopleAndTime:
        return 'People & Time';
    }
  }
}

enum VerbCategory {
  needsAndDesires,
  knowledge,
  existenceAndAvailability,
  quality,
  imperatives,
  requests,
  questions,
  presentActions;

  String get label {
    switch (this) {
      case VerbCategory.needsAndDesires:
        return 'Needs & Desires';
      case VerbCategory.knowledge:
        return 'Knowledge';
      case VerbCategory.existenceAndAvailability:
        return 'Existence & Availability';
      case VerbCategory.quality:
        return 'Quality';
      case VerbCategory.imperatives:
        return 'Imperatives';
      case VerbCategory.requests:
        return 'Requests';
      case VerbCategory.questions:
        return 'Questions';
      case VerbCategory.presentActions:
        return 'Present Actions';
    }
  }
}

class AnchorWord {
  final String id;
  final TriScriptText text;
  final AnchorType anchorType;
  final Set<String> allowedNounTags;

  const AnchorWord({
    required this.id,
    required this.text,
    required this.anchorType,
    required this.allowedNounTags,
  });
}

class NounWord {
  final String id;
  final NounCategory category;
  final TriScriptText text;
  final bool isCountable;
  final Set<String> semanticTags;

  const NounWord({
    required this.id,
    required this.category,
    required this.text,
    required this.isCountable,
    required this.semanticTags,
  });
}

class VerbWord {
  final String id;
  final VerbCategory category;
  final TriScriptText text;
  final Set<AnchorType> allowedAnchorTypes;
  final Set<String> requiredNounTags;

  const VerbWord({
    required this.id,
    required this.category,
    required this.text,
    required this.allowedAnchorTypes,
    required this.requiredNounTags,
  });
}

class AssembledSentence {
  final AnchorWord anchor;
  final NounWord noun;
  final VerbWord verb;
  final TriScriptText assembledText;
  final String grammarNote;

  const AssembledSentence({
    required this.anchor,
    required this.noun,
    required this.verb,
    required this.assembledText,
    required this.grammarNote,
  });
}
