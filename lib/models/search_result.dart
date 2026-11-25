import 'reading_mode.dart';

enum SearchCategory {
  anchor,
  noun,
  verb,
  realSpace,
  scenario,
  phrase,
  rootBridge,
  vault;

  String get label {
    switch (this) {
      case SearchCategory.anchor:
        return 'Sentence Lab · Anchor';
      case SearchCategory.noun:
        return 'Sentence Lab · Noun';
      case SearchCategory.verb:
        return 'Sentence Lab · Verb';
      case SearchCategory.realSpace:
        return 'Real Space';
      case SearchCategory.scenario:
        return 'Scenario';
      case SearchCategory.phrase:
        return 'Spoken Phrase';
      case SearchCategory.rootBridge:
        return 'Root Bridge';
      case SearchCategory.vault:
        return 'Saved Vault';
    }
  }
}

class SearchResultItem {
  final String id;
  final SearchCategory category;
  final String title;
  final String subtitle;
  final TriScriptText? triScript;
  final String targetId;
  final String? parentId;

  const SearchResultItem({
    required this.id,
    required this.category,
    required this.title,
    required this.subtitle,
    this.triScript,
    required this.targetId,
    this.parentId,
  });
}
