import 'reading_mode.dart';
import 'real_space.dart';

sealed class LessonStep {
  final String id;
  final String promptTitle;

  const LessonStep({
    required this.id,
    required this.promptTitle,
  });
}

class PhraseStep extends LessonStep {
  final TriScriptText phrase;
  final List<PhraseChunk> chunks;
  final String culturalNote;

  const PhraseStep({
    required super.id,
    required super.promptTitle,
    required this.phrase,
    required this.chunks,
    required this.culturalNote,
  });
}

class SpeakPracticeStep extends LessonStep {
  final TriScriptText phrase;
  final String speakingGuidance;
  final String focusSound;

  const SpeakPracticeStep({
    required super.id,
    required super.promptTitle,
    required this.phrase,
    required this.speakingGuidance,
    required this.focusSound,
  });
}

class BuildStep extends LessonStep {
  final String targetHindiMeaning;
  final List<TriScriptText> availableTiles;
  final List<int> correctOrderIndices;
  final TriScriptText expectedSentence;
  final String explanation;

  const BuildStep({
    required super.id,
    required super.promptTitle,
    required this.targetHindiMeaning,
    required this.availableTiles,
    required this.correctOrderIndices,
    required this.expectedSentence,
    required this.explanation,
  });
}

class UseStepOption {
  final TriScriptText text;
  final bool isCorrect;
  final String feedback;

  const UseStepOption({
    required this.text,
    required this.isCorrect,
    required this.feedback,
  });
}

class UseStep extends LessonStep {
  final String situationDescription;
  final String question;
  final List<UseStepOption> options;

  const UseStep({
    required super.id,
    required super.promptTitle,
    required this.situationDescription,
    required this.question,
    required this.options,
  });
}

class Lesson {
  final String id;
  final int order;
  final String title;
  final String hindiSubtitle;
  final String focusSummary;
  final int estimatedMinutes;
  final List<LessonStep> steps;

  const Lesson({
    required this.id,
    required this.order,
    required this.title,
    required this.hindiSubtitle,
    required this.focusSummary,
    required this.estimatedMinutes,
    required this.steps,
  });
}
