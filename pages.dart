import 'package:flutter/material.dart';
import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

// ---------------------------------------------------------------------------
// Root Navigation Container
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
// 1. Communicate Page (Categories)
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SetuLingo', style: TextStyle(fontWeight: FontWeight.w900)),
            actions: [
              TextButton.icon(
                onPressed: () => settings.toggleMode(),
                icon: const Icon(Icons.translate, size: 16),
                label: Text(
                  settings.isDevanagari ? 'अ Hindi' : '🔤 Eng',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'बेंगलुरु बोलचाल की कन्नड़',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'कैटेगरी चुनें और 5 महत्वपूर्ण परिस्थितियों के वाक्य सीखें:',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 14),
              for (final cat in categories)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Text(cat.emoji, style: const TextStyle(fontSize: 28)),
                    title: Text(cat.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('${cat.hindiTitle} · ${cat.situations.length} परिस्थितियाँ'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _open(context, CategorySituationsPage(category: cat)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class CategorySituationsPage extends StatelessWidget {
  final Category category;

  const CategorySituationsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${category.emoji} ${category.title}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${category.hindiTitle} — स्थिति चुनें:',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          for (final situation in category.situations)
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                subtitle: Text('${situation.hindiTitle} · ${situation.sentences.length} वाक्य'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _open(context, SituationDetailPage(situation: situation)),
              ),
            ),
        ],
      ),
    );
  }
}

class SituationDetailPage extends StatelessWidget {
  final KSituation situation;

  const SituationDetailPage({super.key, required this.situation});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(situation.title),
            actions: [
              TextButton.icon(
                onPressed: () => settings.toggleMode(),
                icon: const Icon(Icons.translate, size: 16),
                label: Text(settings.isDevanagari ? 'अ Hindi' : '🔤 Eng'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      situation.hindiTitle,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(situation.description, style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final lesson = generateLessonFromSituation(situation);
                          _open(context, LessonPage(lesson: lesson));
                        },
                        icon: const Icon(Icons.play_arrow, size: 18),
                        label: const Text('Guided Practice शुरू करें'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'वाक्य सूची (Sentences)',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              for (final s in situation.sentences) SentenceCard(sentence: s),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Sentence Lab (3 Modular Dropdowns)
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  int _starterIndex = 0;
  int _topicIndex = 0;
  int _endingIndex = 0;

  DropdownOption get _starter => startersList[_starterIndex];
  DropdownOption get _topic => topicsList[_topicIndex];
  DropdownOption get _ending => endingsList[_endingIndex];

  String get _builtRoman => '${_starter.roman} ${_topic.roman} ${_ending.roman}';
  String get _builtDeva => '${_starter.deva} ${_topic.deva} ${_ending.deva}';
  String get _builtHindi => '${_starter.hindi} ${_topic.hindi} ${_ending.hindi}';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettingsStore.instance;
    final sentencesStore = MySentencesStore.instance;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final displaySpoken = settings.isDevanagari ? _builtDeva : _builtRoman;
        final secondarySpoken = settings.isDevanagari ? _builtRoman : _builtDeva;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Sentence Lab 🧪'),
            actions: [
              TextButton.icon(
                onPressed: () => settings.toggleMode(),
                icon: const Icon(Icons.translate, size: 16),
                label: Text(settings.isDevanagari ? 'अ Hindi' : '🔤 Eng'),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '3 ड्रॉपडाउन से नया वाक्य बनाएँ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'कर्ता, विषय और क्रिया चुनकर अपना व्यावहारिक वाक्य तैयार करें:',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),

              _buildDropdownSection(
                title: '1. कर्ता / शुरुआत (Subject)',
                value: _starterIndex,
                items: startersList,
                onChanged: (val) => setState(() => _starterIndex = val!),
                isDeva: settings.isDevanagari,
              ),
              const SizedBox(height: 10),

              _buildDropdownSection(
                title: '2. विषय / वस्तु / स्थान (Topic)',
                value: _topicIndex,
                items: topicsList,
                onChanged: (val) => setState(() => _topicIndex = val!),
                isDeva: settings.isDevanagari,
              ),
              const SizedBox(height: 10),

              _buildDropdownSection(
                title: '3. क्रिया / अंत (Verb / Request)',
                value: _endingIndex,
                items: endingsList,
                onChanged: (val) => setState(() => _endingIndex = val!),
                isDeva: settings.isDevanagari,
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: scheme.primary.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'तैयार वाक्य (Generated Sentence)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: scheme.primary,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.volume_up_outlined, size: 20),
                          tooltip: 'उच्चारण सुनें',
                          onPressed: () => TtsService.instance.speak(_builtRoman),
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_add, size: 20),
                          tooltip: 'My Sentences में सहेजें',
                          onPressed: () {
                            final sentenceId = 'lab_${DateTime.now().millisecondsSinceEpoch}';
                            sentencesStore.addSentence(
                              SavedSentence(
                                id: sentenceId,
                                roman: _builtRoman,
                                deva: _builtDeva,
                                hindi: _builtHindi,
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
                    const SizedBox(height: 6),
                    Text(
                      displaySpoken,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      secondarySpoken,
                      style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
                    ),
                    const Divider(height: 18),
                    Text(
                      _builtHindi,
                      style: TextStyle(
                        fontSize: 17,
                        color: scheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdownSection({
    required String title,
    required int value,
    required List<DropdownOption> items,
    required ValueChanged<int?> onChanged,
    required bool isDeva,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                value: value,
                items: [
                  for (int i = 0; i < items.length; i++)
                    DropdownMenuItem(
                      value: i,
                      child: Text(
                        '${isDeva ? items[i].deva : items[i].roman}  (${items[i].hindi})',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Learn Words Page (Includes Sanskrit Cognates Segment)
// ---------------------------------------------------------------------------

class LearnWordsPage extends StatelessWidget {
  const LearnWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;

    return DefaultTabController(
      length: 2,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Words & Connections'),
              actions: [
                TextButton.icon(
                  onPressed: () => settings.toggleMode(),
                  icon: const Icon(Icons.translate, size: 16),
                  label: Text(settings.isDevanagari ? 'अ Hindi' : '🔤 Eng'),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'शब्दावली (Words)'),
                  Tab(text: 'संस्कृत संबंध (Cognates)'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    for (final w in allWords) WordCard(word: w),
                  ],
                ),
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        'हिंदी और कन्नड़ दोनों में संस्कृत से आए कई शब्द बिल्कुल समान हैं:',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                    for (final c in connections)
                      Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${c.hindi}  →  ${settings.isDevanagari ? c.kannadaDeva : c.kannadaRoman}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                c.type,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(c.note, style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Saved Collection Page (Clean Personal Bookmarks Only)
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;
    final sentencesStore = MySentencesStore.instance;
    final settings = AppSettingsStore.instance;

    return DefaultTabController(
      length: 2,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Bookmarks'),
              actions: [
                TextButton.icon(
                  onPressed: () => settings.toggleMode(),
                  icon: const Icon(Icons.translate, size: 16),
                  label: Text(settings.isDevanagari ? 'अ Hindi' : '🔤 Eng'),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'सहेजे शब्द (Words)'),
                  Tab(text: 'सहेजे वाक्य (Sentences)'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListenableBuilder(
                  listenable: wordsStore,
                  builder: (context, _) {
                    final saved = allWords.where((w) => wordsStore.contains(w.id)).toList();
                    if (saved.isEmpty) {
                      return const Center(child: Text('अभी कोई शब्द सहेजा नहीं है।'));
                    }
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        for (final w in saved)
                          Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                settings.isDevanagari ? w.deva : w.roman,
                                style: const TextStyle(fontWeight: FontWeight.w800),
                              ),
                              subtitle: Text(w.hindi),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => wordsStore.remove(w.id),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                ListenableBuilder(
                  listenable: sentencesStore,
                  builder: (context, _) {
                    final saved = sentencesStore.sentences;
                    if (saved.isEmpty) {
                      return const Center(child: Text('अभी कोई वाक्य सहेजा नहीं है।'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: saved.length,
                      itemBuilder: (context, i) {
                        final item = saved[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              settings.isDevanagari ? item.deva : item.roman,
                              style: const TextStyle(fontWeight: FontWeight.w800),
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
          );
        },
      ),
    );
  }
}
