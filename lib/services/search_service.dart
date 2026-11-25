import '../data/numbers_data.dart';
import '../data/real_spaces_data.dart';
import '../data/root_bridge_data.dart';
import '../data/sentence_lab_data.dart';
import '../models/search_result.dart';
import '../models/vault_entry.dart';

class SearchService {
  SearchService._();

  /// Instant search across Anchors, Nouns, Verbs, Real Spaces, Scenarios,
  /// Individual Phrases, Sanskrit Roots, and Saved Vault entries.
  /// Matches across Hindi, Devanagari, and Roman Hindi.
  static List<SearchResultItem> search({
    required String query,
    required List<VaultEntry> vaultEntries,
  }) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];

    final results = <SearchResultItem>[];

    // 1. Saved Vault entries
    for (final entry in vaultEntries) {
      if (entry.text.matchesQuery(q) ||
          entry.sourceTitle.toLowerCase().contains(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_vault_${entry.id}',
            category: SearchCategory.vault,
            title: entry.text.romanHindi,
            subtitle: '${entry.text.hindi} · ${entry.sourceTitle}',
            triScript: entry.text,
            targetId: entry.id,
          ),
        );
      }
    }

    // 2. Real Spaces & Scenarios & Individual Phrases
    for (final space in RealSpacesData.spaces) {
      if (space.title.toLowerCase().contains(q) ||
          space.hindiSubtitle.toLowerCase().contains(q) ||
          space.description.toLowerCase().contains(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_space_${space.id}',
            category: SearchCategory.realSpace,
            title: space.title,
            subtitle: space.hindiSubtitle,
            targetId: space.id,
          ),
        );
      }

      for (final scenario in space.scenarios) {
        if (scenario.title.toLowerCase().contains(q) ||
            scenario.hindiTitle.toLowerCase().contains(q) ||
            scenario.situationalContext.toLowerCase().contains(q)) {
          results.add(
            SearchResultItem(
              id: 'sr_scen_${scenario.id}',
              category: SearchCategory.scenario,
              title: scenario.title,
              subtitle: '${scenario.hindiTitle} · ${space.title}',
              targetId: scenario.id,
              parentId: space.id,
            ),
          );
        }

        for (final phrase in scenario.phrases) {
          if (phrase.text.matchesQuery(q)) {
            results.add(
              SearchResultItem(
                id: 'sr_phrase_${phrase.id}',
                category: SearchCategory.phrase,
                title: phrase.text.romanHindi,
                subtitle: '${phrase.text.hindi} · ${scenario.title}',
                triScript: phrase.text,
                targetId: scenario.id,
                parentId: space.id,
              ),
            );
          }
        }
      }
    }

    // 3. Sentence Lab Anchors, Nouns, Verbs
    for (final anchor in SentenceLabData.anchors) {
      if (anchor.text.matchesQuery(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_${anchor.id}',
            category: SearchCategory.anchor,
            title: anchor.text.romanHindi,
            subtitle: '${anchor.text.hindi} · ${anchor.anchorType.label}',
            triScript: anchor.text,
            targetId: anchor.id,
          ),
        );
      }
    }

    for (final noun in SentenceLabData.nouns) {
      if (noun.text.matchesQuery(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_${noun.id}',
            category: SearchCategory.noun,
            title: noun.text.romanHindi,
            subtitle: '${noun.text.hindi} · ${noun.category.label}',
            triScript: noun.text,
            targetId: noun.id,
          ),
        );
      }
    }

    for (final verb in SentenceLabData.verbs) {
      if (verb.text.matchesQuery(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_${verb.id}',
            category: SearchCategory.verb,
            title: verb.text.romanHindi,
            subtitle: '${verb.text.hindi} · ${verb.category.label}',
            triScript: verb.text,
            targetId: verb.id,
          ),
        );
      }
    }

    // 4. Sanskrit Roots / Tatsama Bridge
    for (final root in RootBridgeData.connections) {
      if (root.rootOrWord.toLowerCase().contains(q) ||
          root.hindiCognateOrMeaning.toLowerCase().contains(q) ||
          root.kannadaForm.matchesQuery(q) ||
          root.exampleUsage.matchesQuery(q)) {
        results.add(
          SearchResultItem(
            id: 'sr_${root.id}',
            category: SearchCategory.rootBridge,
            title: root.rootOrWord,
            subtitle:
                '${root.kannadaForm.romanHindi} (${root.kannadaForm.hindi})',
            triScript: root.kannadaForm,
            targetId: root.id,
          ),
        );
      }
    }

    // 5. Kannada Numbers (included as phrases)
    for (final numItem in NumbersData.numbers) {
      if (numItem.text.matchesQuery(q) || numItem.displayDigit == q) {
        results.add(
          SearchResultItem(
            id: 'sr_${numItem.id}',
            category: SearchCategory.phrase,
            title: '${numItem.displayDigit} · ${numItem.text.romanHindi}',
            subtitle: numItem.text.hindi,
            triScript: numItem.text,
            targetId: numItem.id,
          ),
        );
      }
    }

    return results;
  }
}
