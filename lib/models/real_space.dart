import 'reading_mode.dart';

class PhraseChunk {
  final TriScriptText text;
  final String roleNote;

  const PhraseChunk({
    required this.text,
    required this.roleNote,
  });
}

class PhraseItem {
  final String id;
  final String speakerRole;
  final TriScriptText text;
  final List<PhraseChunk> chunks;
  final String? usageTip;

  const PhraseItem({
    required this.id,
    required this.speakerRole,
    required this.text,
    required this.chunks,
    this.usageTip,
  });
}

class VocabItem {
  final String id;
  final TriScriptText text;
  final String partOfSpeech;

  const VocabItem({
    required this.id,
    required this.text,
    required this.partOfSpeech,
  });
}

class Scenario {
  final String id;
  final String spaceId;
  final String title;
  final String hindiTitle;
  final String situationalContext;
  final String learningObjective;
  final int estimatedMinutes;
  final List<PhraseItem> phrases;
  final List<VocabItem> vocabulary;
  final List<String> usageTips;

  const Scenario({
    required this.id,
    required this.spaceId,
    required this.title,
    required this.hindiTitle,
    required this.situationalContext,
    required this.learningObjective,
    this.estimatedMinutes = 2,
    required this.phrases,
    required this.vocabulary,
    required this.usageTips,
  });
}

enum SpaceLayoutStyle {
  counterService,
  transitRoute,
  marketStall,
  officeDesk,
  neighbourhoodDoor,
  clinicTriage,
  socialCircle,
  problemResolver,
}

class RealSpace {
  final String id;
  final int order;
  final String title;
  final String hindiSubtitle;
  final String description;
  final String badgeLabel;
  final SpaceLayoutStyle layoutStyle;
  final List<Scenario> scenarios;

  const RealSpace({
    required this.id,
    required this.order,
    required this.title,
    required this.hindiSubtitle,
    required this.description,
    required this.badgeLabel,
    required this.layoutStyle,
    required this.scenarios,
  });
}
