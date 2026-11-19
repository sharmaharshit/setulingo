import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

class SearchEntryAction extends StatelessWidget {
  const SearchEntryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      tooltip: 'Roman-Hindi Dictionary Search',
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

    // Dictionary and content search results
    final results = <_DictionaryResult>[];

    if (q.length >= 1) {
      // 1. Search across Sentence Lab Anchors, Nouns, and Verbs (Roman & Hindi Meaning)
      for (final a in labAnchors) {
        if (a.roman.toLowerCase().contains(q) || a.hindi.toLowerCase().contains(q)) {
          results.add(_DictionaryResult(
            title: '${a.roman} = ${a.hindi}',
            subtitle: 'Sentence Lab Anchor (${a.anchorType})',
            type: 'Anchor (Slot 1)',
          ));
        }
      }

      for (final n in labNouns) {
        if (n.roman.toLowerCase().contains(q) || n.hindi.toLowerCase().contains(q)) {
          results.add(_DictionaryResult(
            title: '${n.roman} = ${n.hindi}',
            subtitle: 'Category: ${n.category} (${n.countability})',
            type: 'Noun (Slot 2)',
          ));
        }
      }

      for (final v in labVerbs) {
        if (v.roman.toLowerCase().contains(q) || v.hindi.toLowerCase().contains(q)) {
          results.add(_DictionaryResult(
            title: '${v.roman} = ${v.hindi}',
            subtitle: 'Predicate / Action Verb',
            type: 'Verb (Slot 3)',
          ));
        }
      }

      // 2. Search across Situations and Sentences
      for (final cat in categories) {
        for (final sit in cat.situations) {
          for (final sent in sit.sentences) {
            if (sent.roman.toLowerCase().contains(q) || sent.hindi.toLowerCase().contains(q)) {
              results.add(_DictionaryResult(
                title: sent.roman,
                subtitle: sent.hindi,
                type: 'Situation · ${cat.title}',
              ));
            }
          }
        }
      }

      // 3. Search Sanskrit Tatsama Bridge
      for (final conn in connections) {
        if (conn.hindi.toLowerCase().contains(q) || conn.kannadaRoman.toLowerCase().contains(q)) {
          results.add(_DictionaryResult(
            title: '${conn.hindi} → ${conn.kannadaRoman}',
            subtitle: conn.note,
            type: 'Sanskrit Root',
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
            hintText: 'Type Roman Hindi (e.g. paani, chahiye)...',
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
      body: q.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  '📖 Roman-Hindi Dictionary\nType any word (e.g. "paani", "beku", "coffee") to lookup its Kannada meaning instantly.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textFaint, height: 1.5),
                ),
              ),
            )
          : results.isEmpty
              ? Center(
                  child: Text(
                    'No dictionary matches for "$_query"',
                    style: const TextStyle(color: AppColors.textFaint),
                  ),
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
                      ),
                    );
                  },
                ),
    );
  }
}

class _DictionaryResult {
  final String title;
  final String subtitle;
  final String type;

  const _DictionaryResult({
    required this.title,
    required this.subtitle,
    required this.type,
  });
}
