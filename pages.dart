import 'package:flutter/material.dart';

import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}

// ---------------------------------------------------------------------------
// Home
// ---------------------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final store = MyWordsStore.instance;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 8),
            Text(
              'SetuLingo',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                color: scheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'हिंदी से बेंगलुरु की कन्नड़ तक',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 28),
            const Text(
              'आज क्या सीखना है?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            _HomeCard(
              emoji: '🆕',
              title: 'Learn New Words',
              subtitle: 'नए कन्नड़ शब्द, जो असल में बोले जाते हैं',
              onTap: () => _open(context, const LearnWordsPage()),
            ),
            ListenableBuilder(
              listenable: store,
              builder: (context, _) {
                final n = store.ids.length;
                return _HomeCard(
                  emoji: '🧠',
                  title: 'My Words',
                  subtitle: n == 0
                      ? 'आपके सहेजे शब्द और हिंदी से जुड़े शब्द'
                      : '$n शब्द सहेजे हैं, और हिंदी से जुड़े शब्द',
                  onTap: () => _open(context, const MyWordsPage()),
                );
              },
            ),
            _HomeCard(
              emoji: '🗣️',
              title: 'Communicate',
              subtitle: 'बेंगलुरु में क्या बोलना है: ऑटो, बाज़ार, ऑफ़िस और बहुत कुछ',
              onTap: () => _open(context, const CommunicatePage()),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HomeCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 34)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Learn New Words
// ---------------------------------------------------------------------------

class LearnWordsPage extends StatelessWidget {
  const LearnWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn New Words')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Food & Darshini के शब्द। जो पसंद आए, उसे My Words में जोड़िए।',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
          for (final w in allWords) WordCard(word: w),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// My Words
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = MyWordsStore.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('My Words')),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final saved =
              allWords.where((w) => store.contains(w.id)).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'मेरे शब्द',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              if (saved.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'अभी कोई शब्द सहेजा नहीं है। Learn New Words या किसी lesson में "Add to My Words" दबाइए।',
                    ),
                  ),
                ),
              for (final w in saved)
                Card(
                  child: ListTile(
                    title: Text(
                      '${w.roman}   ${w.script}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Text(w.hindi),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => store.remove(w.id),
                    ),
                  ),
                ),
              const SizedBox(height: 28),
              const Text(
                'जिनसे आपका पहले से रिश्ता है',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6),
              const Text(
                'हिंदी और कन्नड़ में संस्कृत से आए कई शब्द साझा हैं। यहाँ कुछ हैं, और बताया गया है कि रिश्ता किस तरह का है।',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              for (final c in connections) _ConnectionCard(connection: c),
            ],
          );
        },
      ),
    );
  }
}

class _ConnectionCard extends StatelessWidget {
  final WordConnection connection;

  const _ConnectionCard({required this.connection});

  @override
  Widget build(BuildContext context) {
    final c = connection;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${c.hindi}  →  ${c.kannada}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${c.hindiRoman}  ·  ${c.kannadaRoman}',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Chip(label: Text(c.type)),
              const SizedBox(height: 4),
              Text(c.note),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Communicate
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communicate')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'सीखिए कि बेंगलुरु में असल में क्या बोला जाता है।',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
          for (final cat in categories) _CategoryCard(category: cat),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final Category category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    final lesson = category.lesson;
    final live = lesson != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (lesson != null) {
            _open(context, LessonPage(lesson: lesson));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('यह हिस्सा जल्द आ रहा है।')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(category.emoji, style: const TextStyle(fontSize: 30)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      category.hindiTitle,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.blurb,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              if (live)
                const Icon(Icons.chevron_right)
              else
                const Chip(label: Text('जल्द')),
            ],
          ),
        ),
      ),
    );
  }
}
