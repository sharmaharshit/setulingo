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
// Home Navigation Root
// ---------------------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  final List<Widget> _pages = const [
    CommunicatePage(),
    SentenceLabPage(),
    LearnWordsPage(),
    MyWordsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Communicate',
          ),
          NavigationDestination(
            icon: Icon(Icons.science_outlined),
            selectedIcon: Icon(Icons.science),
            label: 'Sentence Lab',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school),
            label: 'Words',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Communicate Categories Page
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SetuLingo',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'बेंगलुरु बोलचाल की कन्नड़',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'कैटेगरी चुनें और रोज़मर्रा की स्थितियों के वाक्य सीखें:',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _open(context, CategorySituationsPage(category: category)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(category.emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
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
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.blurb,
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
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
// Category → Situations List Page
// ---------------------------------------------------------------------------

class CategorySituationsPage extends StatelessWidget {
  final Category category;

  const CategorySituationsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.title}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${category.hindiTitle} — स्थिति चुनें:',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          for (final situation in category.situations)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  situation.title,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
                subtitle: Text(
                  '${situation.hindiTitle} · ${situation.sentences.length} वाक्य',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _open(context, SituationDetailPage(situation: situation)),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Situation → Sentences List & Guided Practice
// ---------------------------------------------------------------------------

class SituationDetailPage extends StatelessWidget {
  final KSituation situation;

  const SituationDetailPage({super.key, required this.situation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(situation.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  situation.hindiTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(situation.description),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      final lesson = generateLessonFromSituation(situation);
                      _open(context, LessonPage(lesson: lesson));
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Guided Practice शुरू करें'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'इस स्थिति के वाक्य',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          for (final s in situation.sentences) SentenceCard(sentence: s),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Sentence Lab Page (Pattern-based Sentence Builder)
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  int _selectedPatternIndex = 0;
  LabSlotOption? _selectedOption;

  LabPattern get _currentPattern => labPatterns[_selectedPatternIndex];

  @override
  void initState() {
    super.initState();
    _selectedOption = _currentPattern.slotOptions.first;
  }

  void _onPatternChange(int index) {
    setState(() {
      _selectedPatternIndex = index;
      _selectedOption = labPatterns[index].slotOptions.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final slot = _selectedOption;

    final resultRoman = slot == null
        ? _currentPattern.templateRoman
        : _currentPattern.templateRoman.replaceAll('{slot}', slot.kannada);

    final resultHindi = slot == null
        ? _currentPattern.templateHindi
        : _currentPattern.templateHindi.replaceAll('{slot}', slot.hindi);

    final sentencesStore = MySentencesStore.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Sentence Lab 🧪')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'पैटर्न चुनकर नए वाक्य बनाएँ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'कन्नड़ वाक्य संरचना को समझें और अपना वाक्य तैयार करें:',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          // Pattern dropdown
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedPatternIndex,
                  items: [
                    for (int i = 0; i < labPatterns.length; i++)
                      DropdownMenuItem(
                        value: i,
                        child: Text(
                          labPatterns[i].title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                  ],
                  onChanged: (val) {
                    if (val != null) _onPatternChange(val);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${_currentPattern.slotPlaceholder} चुनें:',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _currentPattern.slotOptions.map((opt) {
              final isSelected = _selectedOption?.id == opt.id;
              return ChoiceChip(
                label: Text('${opt.kannada} (${opt.hindi})'),
                selected: isSelected,
                onSelected: (val) {
                  if (val) setState(() => _selectedOption = opt);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          // Live preview card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: scheme.primary.withValues(alpha: 0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'तैयार वाक्य',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: scheme.primary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.bookmark_add),
                      tooltip: 'My Sentences में सहेजें',
                      onPressed: () {
                        final sentenceId = 'lab_${DateTime.now().millisecondsSinceEpoch}';
                        sentencesStore.addSentence(
                          SavedSentence(
                            id: sentenceId,
                            roman: resultRoman,
                            script: '',
                            hindi: resultHindi,
                            createdAt: DateTime.now(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('वाक्य Saved Sentences में जुड़ गया!')),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  resultRoman,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Divider(height: 20),
                Text(
                  resultHindi,
                  style: TextStyle(
                    fontSize: 18,
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Learn New Words List
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
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'बेंगलुरु में रोज़ काम आने वाले आवश्यक शब्द:',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          for (final w in allWords) WordCard(word: w),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Saved Words & Saved Sentences Page
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;
    final sentencesStore = MySentencesStore.instance;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Saved Collection'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'मेरे शब्द (Words)'),
              Tab(text: 'मेरे वाक्य (Sentences)'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Words Tab
            ListenableBuilder(
              listenable: wordsStore,
              builder: (context, _) {
                final saved = allWords.where((w) => wordsStore.contains(w.id)).toList();

                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (saved.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'अभी कोई शब्द सहेजा नहीं है। Words टैब में जाकर शब्द जोड़ें।',
                          ),
                        ),
                      ),
                    for (final w in saved)
                      Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            '${w.roman}  ·  ${w.script}',
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(w.hindi),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => wordsStore.remove(w.id),
                          ),
                        ),
                      ),
                    const SizedBox(height: 28),
                    const Text(
                      'संस्कृत संबंध (Tatsama / Cognates)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'हिंदी और कन्नड़ दोनों में संस्कृत से आए कई शब्द बिल्कुल एक जैसे हैं:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final c in connections)
                      Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${c.hindi}  →  ${c.kannada}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${c.hindiRoman}  ·  ${c.kannadaRoman}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(c.note),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            // Sentences Tab
            ListenableBuilder(
              listenable: sentencesStore,
              builder: (context, _) {
                final saved = sentencesStore.sentences;

                if (saved.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'अभी कोई वाक्य सहेजा नहीं है। Communicate या Sentence Lab में बुकमार्क का निशान दबाएँ।',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: saved.length,
                  itemBuilder: (context, i) {
                    final item = saved[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          item.roman,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                        subtitle: Text(item.hindi),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => sentencesStore.removeSentence(item.id),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
