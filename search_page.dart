import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'pages.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

class SearchEntryAction extends StatelessWidget {
  const SearchEntryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Search SetuLingo',
      onPressed: () => _open(context, const GlobalSearchPage()),
    );
  }
}

class GlobalSearchPage extends StatefulWidget {
  const GlobalSearchPage({super.key});

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();

    // Gather matches across Vault words/sentences, situations, and Sanskrit roots
    final results = <_SearchResult>[];

    if (q.length >= 2) {
      // 1. Situations & Sentences
      for (final cat in categories) {
        for (final sit in cat.situations) {
          if (sit.title.toLowerCase().contains(q) || sit.hindiTitle.toLowerCase().contains(q)) {
            results.add(_SearchResult(
              title: '${cat.emoji} ${sit.title}',
              subtitle: sit.hindiTitle,
              type: 'Situation · ${cat.title}',
              onTap: (context) => _open(context, SituationDetailPage(situation: sit)),
            ));
          }
          for (final sent in sit.sentences) {
            if (sent.roman.toLowerCase().contains(q) || sent.hindi.toLowerCase().contains(q)) {
              results.add(_SearchResult(
                title: sent.roman,
                subtitle: sent.hindi,
                type: 'Sentence · ${sit.title}',
                onTap: (context) => _open(context, SituationDetailPage(situation: sit)),
              ));
            }
          }
        }
      }

      // 2. Sanskrit Roots / Tatsama Bridge
      for (final conn in connections) {
        if (conn.hindi.toLowerCase().contains(q) || conn.kannadaRoman.toLowerCase().contains(q)) {
          results.add(_SearchResult(
            title: '${conn.hindi} → ${conn.kannadaRoman} (${conn.kannadaDeva})',
            subtitle: conn.note,
            type: 'Sanskrit Root · ${conn.type}',
            onTap: (context) => _open(context, const ForYouPage()),
          ));
        }
      }

      // 3. Saved Vault Words & Sentences
      for (final w in MyWordsStore.instance.words) {
        if (w.roman.toLowerCase().contains(q) || w.hindi.toLowerCase().contains(q)) {
          results.add(_SearchResult(
            title: '${w.roman} = ${w.hindi}',
            subtitle: 'Saved word from ${w.source}',
            type: 'Vault Word',
            onTap: (context) => _open(context, const MyWordsPage()),
          ));
        }
      }
      for (final s in MySentencesStore.instance.sentences) {
        if (s.roman.toLowerCase().contains(q) || s.hindi.toLowerCase().contains(q)) {
          results.add(_SearchResult(
            title: s.roman,
            subtitle: s.hindi,
            type: 'Saved Sentence',
            onTap: (context) => _open(context, const MyWordsPage()),
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (val) => setState(() => _query = val),
          style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh),
          decoration: const InputDecoration(
            hintText: 'Search situations, words, roots...',
            hintStyle: TextStyle(color: AppColors.textFaint, fontWeight: FontWeight.w500),
            border: InputBorder.none,
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear, size: 20),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.trim().length < 2
          ? PolishedEmptyState(
              icon: Icons.search,
              title: 'Search SetuLingo',
              message: 'Type at least 2 letters to search situations, sentences, Sanskrit roots and your Vault.',
              primaryLabel: 'Browse Situations',
              onPrimary: () => HomeTabs.go(context, HomeTabs.situations),
              secondaryLabel: 'Open Sentence Lab',
              onSecondary: () => HomeTabs.go(context, HomeTabs.sentenceLab),
            )
          : results.isEmpty
              ? PolishedEmptyState(
                  icon: Icons.search_off,
                  title: 'No matches for "${_query.trim()}"',
                  message: 'Try a shorter spelling, or a Hindi word. You can also browse Situations '
                      'or build your own sentence in Sentence Lab.',
                  primaryLabel: 'Explore Situations',
                  onPrimary: () => HomeTabs.go(context, HomeTabs.situations),
                  secondaryLabel: 'Try Sentence Lab',
                  onSecondary: () => HomeTabs.go(context, HomeTabs.sentenceLab),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final r = results[i];
                    return Card(
                      child: ListTile(
                        title: Text(r.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Text(r.subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                            const SizedBox(height: 4),
                            Text(r.type, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.marigold)),
                          ],
                        ),
                        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textFaint),
                        onTap: () => r.onTap(context),
                      ),
                    );
                  },
                ),
    );
  }
}

class _SearchResult {
  final String title;
  final String subtitle;
  final String type;
  final void Function(BuildContext context) onTap;

  const _SearchResult({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.onTap,
  });
}
