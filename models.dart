// Part 1: Base Data Models
class KWord {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final String? note;
  final String? streetCode;

  const KWord({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    this.note,
    this.streetCode,
  });
}

class Chunk {
  final String roman;
  final String deva;
  final String hindi;

  const Chunk(this.roman, this.deva, this.hindi);
}

class DialogueTurn {
  final String speaker;
  final bool isUser;
  final String roman;
  final String deva;
  final String hindi;
  final String? tip;

  const DialogueTurn({
    required this.speaker,
    required this.isUser,
    required this.roman,
    required this.deva,
    required this.hindi,
    this.tip,
  });
}

class RoleplayDialogue {
  final String id;
  final String title;
  final String contextDescription;
  final List<DialogueTurn> turns;

  const RoleplayDialogue({
    required this.id,
    required this.title,
    required this.contextDescription,
    required this.turns,
  });
}

sealed class LessonStep {
  const LessonStep();
}

class PhraseStep extends LessonStep {
  final String roman;
  final String deva;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;
  final String? streetCode;

  const PhraseStep({
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
  });
}

class SpeakPracticeStep extends LessonStep {
  final String promptHindi;
  final String targetRoman;
  final String targetDeva;
  final String tip;

  const SpeakPracticeStep({
    required this.promptHindi,
    required this.targetRoman,
    required this.targetDeva,
    required this.tip,
  });
}

class BuildStep extends LessonStep {
  final String promptHindi;
  final List<String> answerRoman;
  final List<String> answerDeva;
  final List<String> tilesRoman;
  final List<String> tilesDeva;
  final String revealRoman;
  final String revealDeva;

  const BuildStep({
    required this.promptHindi,
    required this.answerRoman,
    required this.answerDeva,
    required this.tilesRoman,
    required this.tilesDeva,
    required this.revealRoman,
    required this.revealDeva,
  });
}

class UseStep extends LessonStep {
  final String situation;
  final String question;
  final List<String> optionsRoman;
  final List<String> optionsDeva;
  final int answerIndex;
  final String reveal;

  const UseStep({
    required this.situation,
    required this.question,
    required this.optionsRoman,
    required this.optionsDeva,
    required this.answerIndex,
    required this.reveal,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final List<LessonStep> steps;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.steps,
  });
}

class KSentence {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;
  final String? streetCode;

  const KSentence({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
  });
}

class KSituation {
  final String id;
  final String title;
  final String hindiTitle;
  final String description;
  final List<KSentence> sentences;
  final RoleplayDialogue? dialogue;

  const KSituation({
    required this.id,
    required this.title,
    required this.hindiTitle,
    required this.description,
    required this.sentences,
    this.dialogue,
  });
}

class Category {
  final String id;
  final String emoji;
  final String title;
  final String hindiTitle;
  final String blurb;
  final List<KSituation> situations;

  const Category({
    required this.id,
    required this.emoji,
    required this.title,
    required this.hindiTitle,
    required this.blurb,
    required this.situations,
  });
}

class WordConnection {
  final String hindi;
  final String kannadaRoman;
  final String kannadaDeva;
  final String type;
  final String note;
  final String category;

  const WordConnection({
    required this.hindi,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.type,
    required this.note,
    this.category = 'General',
  });
}
