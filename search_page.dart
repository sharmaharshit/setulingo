import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'pages.dart';
import 'store.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

/// Search icon for AppBars — drop next to [ScriptToggleAction] on any
/// primary screen.
class SearchEntryAction extends StatelessWidget {
  const SearchEntryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Search everything',
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GlobalSearchPage())),
    );
  }
}

enum _ResultKind { situation, sentence, cognate, vaultWord, vaultSentence }

class _SearchResult {
  final _ResultKind kind;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _SearchResult({required this.kind, required this.title, required this.subtitle, required this.onTap});
}

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  bool _matches(String query, List<String> haystacks) {
    final q = query.toLowerCase();
    return haystacks.any((h) => h.toLowerCase().contains(q));
  }

  List<_SearchResult> _search(String query, BuildContext context) {
    if (query.trim().length < 2) return const [];
    final results = <_SearchResult>[];

    // Situations & their sentences, across every category.
    for (final cat in categories) {
      for (final sit in cat.situations) {
        if (_matches(query, [sit.title, sit.hindiTitle, sit.description])) {
          results.add(_SearchResult(
            kind: _ResultKind.situation,
            title: sit.title,
            subtitle: '${cat.emoji} ${cat.title} · ${sit.hindiTitle}',
            onTap: () => _open(context, SituationDetailPage(situation: sit)),
          ));
        }
        for (final sentence in sit.sentences) {
          if (_matches(query, [sentence.roman, sentence.deva, sentence.hindi])) {
            results.add(_SearchResult(
              kind: _ResultKind.sentence,
              title: sentence.roman,
              subtitle: '${sentence.hindi} · in ${sit.title}',
              onTap: () => _open(context, SituationDetailPage(situation: sit)),
            ));
          }
        }
      }
    }

    // Sanskrit cognates.
    for (final c in connections) {
      if (_matches(query, [c.hindi, c.kannadaRoman, c.kannadaDeva, c.type])) {
        results.add(_SearchResult(
          kind: _ResultKind.cognate,
          title: '${c.hindi} → ${c.kannadaRoman}',
          subtitle: c.type,
          onTap: () {},
        ));
      }
    }

    // Vault: saved words.
    for (final w in MyWordsStore.instance.words) {
      if (_matches(query, [w.roman, w.deva, w.hindi])) {
        results.add(_SearchResult(
          kind: _ResultKind.vaultWord,
          title: w.roman,
          subtitle: '${w.hindi} · saved from ${w.source}',
          onTap: () {},
        ));
      }
    }

    // Vault: saved sentences.
    for (final s in MySentencesStore.instance.sentences) {
      if (_matches(query, [s.roman, s.deva, s.hindi])) {
        results.add(_SearchResult(
          kind: _ResultKind.vaultSentence,
          title: s.roman,
          subtitle: '${s.hindi} · saved sentence',
          onTap: () {},
        ));
      }
    }

    return results;
  }

  IconData _iconFor(_ResultKind k) => switch (k) {
        _ResultKind.situation => Icons.grid_view_rounded,
        _ResultKind.sentence => Icons.chat_bubble_outline,
        _ResultKind.cognate => Icons.account_balance,
        _ResultKind.vaultWord => Icons.bookmark,
        _ResultKind.vaultSentence => Icons.bookmark,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final results = _search(_query, context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: AppColors.textHigh, fontWeight: FontWeight.w700),
          decoration: const InputDecoration(
            hintText: 'Search categories, sentences, words…',
            hintStyle: TextStyle(color: AppColors.textFaint),
            border: InputBorder.none,
          ),
          onChanged: (v) => setState(() => _query = v),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() { _controller.clear(); _query = ''; })),
        ],
      ),
      body: _query.trim().length < 2
          ? const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Text(
                  'Type at least 2 letters to search across situations, sentences, Sanskrit roots, and your Vault.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textFaint),
                ),
              ),
            )
          : results.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: Text('No matches found.', style: TextStyle(color: AppColors.textFaint))),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final r = results[i];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: Icon(_iconFor(r.kind), color: scheme.primary),
                        title: Text(r.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                        subtitle: Text(r.subtitle, style: const TextStyle(color: AppColors.textMid), maxLines: 2, overflow: TextOverflow.ellipsis),
                        onTap: r.onTap,
                      ),
                    );
                  },
                ),
    );
  }
}

