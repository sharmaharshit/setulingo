import 'reading_mode.dart';

enum ConnectionType {
  tatsama,
  sanskritDerived,
  directCognate,
  broaderRelationship;

  String get label {
    switch (this) {
      case ConnectionType.tatsama:
        return 'Tatsama (तत्सम)';
      case ConnectionType.sanskritDerived:
        return 'Sanskrit-Derived (तद्भव)';
      case ConnectionType.directCognate:
        return 'Direct Shared Form';
      case ConnectionType.broaderRelationship:
        return 'Broader Cultural/Linguistic Link';
    }
  }

  String get description {
    switch (this) {
      case ConnectionType.tatsama:
        return 'Sanskrit words adopted into both Hindi and Kannada with minimal phonological change.';
      case ConnectionType.sanskritDerived:
        return 'Words tracing to a shared Sanskrit root that evolved distinct spoken forms in Hindi and Kannada.';
      case ConnectionType.directCognate:
        return 'Shared vocabulary used across everyday speech in both languages.';
      case ConnectionType.broaderRelationship:
        return 'Areal or historical semantic parallels across Indian languages without claiming direct genetic descent.';
    }
  }
}

class RootConnection {
  final String id;
  final String rootOrWord;
  final TriScriptText kannadaForm;
  final String hindiCognateOrMeaning;
  final ConnectionType connectionType;
  final String linguisticExplanation;
  final TriScriptText exampleUsage;

  const RootConnection({
    required this.id,
    required this.rootOrWord,
    required this.kannadaForm,
    required this.hindiCognateOrMeaning,
    required this.connectionType,
    required this.linguisticExplanation,
    required this.exampleUsage,
  });
}
