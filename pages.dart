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
// 1. Communicate Page (Daily Scenario + Categories + Quick Search)
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  void _showSurvivalSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const SurvivalSearchSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    final dailyScenario = getDailyScenario();

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SetuLingo', style: TextStyle(fontWeight: FontWeight.w900)),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: 'स्ट्रीट सर्च',
                onPressed: () => _showSurvivalSearch(context),
              ),
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
              // Daily Scenario Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E1C0C), Color(0xFF1B1B1E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFF9800).withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🔥 आज का परिदृश्य (Daily 2-min Goal)',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFFFB74D))),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF9800),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text('New', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.black)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(dailyScenario.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    Text(dailyScenario.hindiTitle, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () => _open(context, SituationDetailPage(situation: dailyScenario)),
                        icon: const Icon(Icons.play_arrow, size: 18),
                        label: const Text('2-Minute Practice शुरू करें', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'परिस्थितियाँ (Categories)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'ज़रूरत के अनुसार कैटेगरी चुनें:',
                style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
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

// ---------------------------------------------------------------------------
// Street Survival Quick-Search Sheet
// ---------------------------------------------------------------------------

class SurvivalSearchSheet extends StatefulWidget {
  const SurvivalSearchSheet({super.key});

  @override
  State<SurvivalSearchSheet> createState() => _SurvivalSearchSheetState();
}

class _SurvivalSearchSheetState extends State<SurvivalSearchSheet> {
  String _query = '';
  final TextEditingController _controller = TextEditingController();

  final List<String> _quickTags = ['Auto', 'Coffee', 'Stop', 'Chutta', 'Help', 'Price'];

  @override
  Widget build(BuildContext context) {
    final allSentences = categories.expand((c) => c.situations).expand((s) => s.sentences).toList();

    final results = allSentences.where((s) {
      final q = _query.toLowerCase().trim();
      if (q.isEmpty) return false;
      return s.roman.toLowerCase().contains(q) ||
          s.deva.contains(q) ||
          s.hindi.contains(q) ||
          s.searchTags.any((t) => t.toLowerCase().contains(q));
    }).toList();

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('⚡ Street Survival Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'सर्च करें: "meter", "chutta", "stop", "कॉफ़ी"...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
            onChanged: (val) => setState(() => _query = val),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _quickTags.map((tag) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ActionChip(
                    label: Text(tag),
                    onPressed: () {
                      _controller.text = tag;
                      setState(() => _query = tag);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.45),
            child: results.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        _query.isEmpty ? 'सर्च बॉक्स में कुछ लिखें...' : 'कोई वाक्य नहीं मिला।',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (context, i) => SentenceCard(sentence: results[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Category & Situation Details
// ---------------------------------------------------------------------------

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

class SituationDetailPage extends StatefulWidget {
  final KSituation situation;

  const SituationDetailPage({super.key, required this.situation});

  @override
  State<SituationDetailPage> createState() => _SituationDetailPageState();
}

class _SituationDetailPageState extends State<SituationDetailPage> {
  int _viewIndex = 0; // 0: Sentences, 1: Roleplay Dialogue

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    final situation = widget.situation;
    final hasDialogue = situation.dialogue != null;

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
              if (hasDialogue) ...[
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('वाक्य सूची')),
                    ButtonSegment(value: 1, label: Text('रोलप्ले बातचीत (Dialogue)')),
                  ],
                  selected: {_viewIndex},
                  onSelectionChanged: (val) => setState(() => _viewIndex = val.first),
                ),
                const SizedBox(height: 16),
              ],
              if (_viewIndex == 0 || !hasDialogue) ...[
                for (final s in situation.sentences) SentenceCard(sentence: s),
              ] else ...[
                RoleplayDialogueWidget(dialogue: situation.dialogue!),
              ],
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Sentence Lab (3 Dropdowns)
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
// 3. Learn Words & Cognates Page
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
// 4. Saved Bookmarks & Active Recall Flashcards
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;
    final sentencesStore = MySentencesStore.instance;
    final settings = AppSettingsStore.instance;

    return DefaultTabController(
      length: 3,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved & Practice'),
              actions: [
                TextButton.icon(
                  onPressed: () => settings.toggleMode(),
                  icon: const Icon(Icons.translate, size: 16),
                  label: Text(settings.isDevanagari ? 'अ Hindi' : '🔤 Eng'),
                ),
              ],
              bottom: const TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'सहेजे शब्द'),
                  Tab(text: 'सहेजे वाक्य'),
                  Tab(text: '🎯 फ़्लैशकार्ड अभ्यास'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Words
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
                // Sentences
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
                // Flashcards Active Recall Mode
                const ActiveRecallFlashcards(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ActiveRecallFlashcards extends StatefulWidget {
  const ActiveRecallFlashcards({super.key});

  @override
  State<ActiveRecallFlashcards> createState() => _ActiveRecallFlashcardsState();
}

class _ActiveRecallFlashcardsState extends State<ActiveRecallFlashcards> {
  int _cardIndex = 0;
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final sentences = MySentencesStore.instance.sentences;
    final settings = AppSettingsStore.instance;

    if (sentences.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'फ़्लैशकार्ड के लिए पहले Communicate या Sentence Lab से कुछ वाक्य बुकमार्क करें!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final current = sentences[_cardIndex % sentences.length];
    final displaySpoken = settings.isDevanagari ? current.deva : current.roman;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'कार्ड ${_cardIndex + 1} / ${sentences.length}',
                style: TextStyle(fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary),
              ),
              const Spacer(),
              if (current.mastered)
                const Chip(
                  label: Text('याद हो गया ✓', style: TextStyle(fontSize: 11)),
                  backgroundColor: Color(0xFF1B382B),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _revealed = !_revealed),
              child: Card(
                elevation: 2,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('हिंदी अर्थ (दिमाग पर ज़ोर दें):', style: TextStyle(fontSize: 13)),
                      const SizedBox(height: 8),
                      Text(
                        current.hindi,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      const Divider(height: 36),
                      if (!_revealed) ...[
                        const Icon(Icons.touch_app, size: 36, color: Colors.white38),
                        const SizedBox(height: 8),
                        const Text('कन्नड़ देखने के लिए टैप करें', style: TextStyle(fontSize: 13, color: Colors.white54)),
                      ] else ...[
                        Text(
                          displaySpoken,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary),
                        ),
                        const SizedBox(height: 14),
                        IconButton.filledTonal(
                          icon: const Icon(Icons.volume_up),
                          onPressed: () => TtsService.instance.speak(current.roman),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    MySentencesStore.instance.markReviewed(current.id, false);
                    setState(() {
                      _revealed = false;
                      _cardIndex = (_cardIndex + 1) % sentences.length;
                    });
                  },
                  child: const Text('फिर से अभ्यास'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    MySentencesStore.instance.markReviewed(current.id, true);
                    setState(() {
                      _revealed = false;
                      _cardIndex = (_cardIndex + 1) % sentences.length;
                    });
                  },
                  child: const Text('याद रहा ✓'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
