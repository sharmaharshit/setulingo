import 'package:flutter/material.dart';
import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

/// Self-contained multi-script search helper
List<KSentence> _searchSentences(String query) {
  final clean = query.toLowerCase().trim();
  if (clean.isEmpty) return [];

  final all = categories.expand((c) => c.situations).expand((s) => s.sentences).toList();
  return all.where((s) {
    if (s.roman.toLowerCase().contains(clean)) return true;
    if (s.deva.contains(clean)) return true;
    if (s.hindi.contains(clean)) return true;
    try {
      return s.hinglishKeywords.any((k) => k.toLowerCase().contains(clean) || clean.contains(k.toLowerCase()));
    } catch (_) {
      return false;
    }
  }).toList();
}

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
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _pages[_tab],
      ),
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
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
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
// 1. Communicate Page
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  void _showSurvivalSearch(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const SurvivalSearchSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    final dailyScenario = getDailyScenario();
    final scheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SetuLingo', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.6)),
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
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF2A1B0E), scheme.surfaceContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: scheme.primary.withValues(alpha: 0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('🔥 2-MIN DAILY GOAL',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: scheme.primary)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: scheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('Today', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.black)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(dailyScenario.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                    Text(dailyScenario.hindiTitle, style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: scheme.primary,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        onPressed: () => _open(context, SituationDetailPage(situation: dailyScenario)),
                        icon: const Icon(Icons.play_arrow_rounded, size: 20),
                        label: const Text('Start 2-Min Practice', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Situations (परिस्थितियाँ)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'ज़रूरत के अनुसार रियल-लाइफ़ कैटेगरी चुनें:',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              for (final cat in categories)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Text(cat.emoji, style: const TextStyle(fontSize: 28)),
                    title: Text(cat.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: -0.2)),
                    subtitle: Text('${cat.hindiTitle} · ${cat.situations.length} परिस्थितियाँ',
                        style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                    trailing: const Icon(Icons.chevron_right, size: 20),
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
// 2. Sentence Lab: Instant Hinglish-to-Kannada Generator
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  final TextEditingController _controller = TextEditingController();
  String _input = '';

  final List<String> _promptPills = [
    'paani chahiye',
    'chalo',
    'kitna hua',
    'bill kodi',
    'yahan roko',
    'coffee beku',
    'thoda kam karo',
    'i love you',
    'miss you',
    'chhutti chahiye',
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettingsStore.instance;
    final sentencesStore = MySentencesStore.instance;

    final results = _searchSentences(_input.isEmpty ? 'coffee' : _input);

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sentence Lab ⚡', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.4)),
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
                'Type in Hinglish (हिंग्लिश में लिखें)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'रोमन हिंदी में लिखें (उदा: "paani chahiye", "yahan roko", "i love you"):',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: scheme.primary.withValues(alpha: 0.4), width: 1.2),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: 'उदा. "chalo", "paani do", "kitna hua"...',
                    hintStyle: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 15),
                    prefixIcon: Icon(Icons.keyboard_outlined, color: scheme.primary),
                    suffixIcon: _input.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              _controller.clear();
                              setState(() => _input = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onChanged: (val) => setState(() => _input = val),
                ),
              ),
              const SizedBox(height: 12),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _promptPills.map((pill) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        label: Text(pill, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        onPressed: () {
                          _controller.text = pill;
                          setState(() => _input = pill);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'कन्नड़ अनुवाद व उच्चारण',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.2, color: scheme.onSurface),
              ),
              const SizedBox(height: 10),

              if (results.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'कोई मिलता-जुलता वाक्य नहीं मिला। ऊपर दिए गए किसी शब्द पर टैप करें।',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ] else ...[
                for (final item in results) ...[
                  Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  settings.isDevanagari ? item.deva : item.roman,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.3),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up_outlined),
                                tooltip: 'उच्चारण सुनें',
                                onPressed: () => TtsService.instance.speak(item.roman),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_add_outlined),
                                tooltip: 'Save to My Sentences',
                                onPressed: () {
                                  sentencesStore.addSentence(
                                    SavedSentence(
                                      id: 'lab_${DateTime.now().millisecondsSinceEpoch}',
                                      roman: item.roman,
                                      deva: item.deva,
                                      hindi: item.hindi,
                                      createdAt: DateTime.now(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Saved to My Sentences!')),
                                  );
                                },
                              ),
                            ],
                          ),
                          Text(
                            settings.isDevanagari ? item.roman : item.deva,
                            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
                          ),
                          const Divider(height: 18, color: Color(0xFF272733)),
                          Text(
                            item.hindi,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: scheme.primary),
                          ),
                          if (item.streetCode != null) ...[
                            const SizedBox(height: 8),
                            Text(item.streetCode!, style: const TextStyle(fontSize: 11, color: Color(0xFFFFB74D))),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Street Survival Search Bottom Sheet
// ---------------------------------------------------------------------------

class SurvivalSearchSheet extends StatefulWidget {
  const SurvivalSearchSheet({super.key});

  @override
  State<SurvivalSearchSheet> createState() => _SurvivalSearchSheetState();
}

class _SurvivalSearchSheetState extends State<SurvivalSearchSheet> {
  String _query = '';
  final TextEditingController _controller = TextEditingController();
  final List<String> _quickTags = ['Auto', 'Coffee', 'Stop', 'Chutta', 'Help', 'Price', 'Love'];

  @override
  Widget build(BuildContext context) {
    final results = _searchSentences(_query);

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
              const Text('⚡ Street Survival Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'सर्च करें: "meter", "chutta", "stop", "coffee"...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
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
// Category Situations & Detail Pages
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
                title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2)),
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
  int _viewIndex = 0;

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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      situation.hindiTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.2),
                    ),
                    const SizedBox(height: 3),
                    Text(situation.description, style: const TextStyle(fontSize: 13)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final lesson = generateLessonFromSituation(situation);
                          _open(context, LessonPage(lesson: lesson));
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 20),
                        label: const Text('Guided Practice शुरू करें', style: TextStyle(fontWeight: FontWeight.w800)),
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
                    ButtonSegment(value: 1, label: Text('रोलप्ले (Dialogue)')),
                  ],
                  selected: {_viewIndex},
                  onSelectionChanged: (val) => setState(() => _viewIndex = val.first),
                ),
                const SizedBox(height: 14),
              ],
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: KeyedSubtree(
                  key: ValueKey<int>(_viewIndex),
                  child: (_viewIndex == 0 || !hasDialogue)
                      ? Column(
                          children: [
                            for (final s in situation.sentences) SentenceCard(sentence: s),
                          ],
                        )
                      : RoleplayDialogueWidget(dialogue: situation.dialogue!),
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
                  Tab(text: '🎯 फ़्लैशकार्ड'),
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation), child: child),
                  );
                },
                child: Card(
                  key: ValueKey<bool>(_revealed),
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
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.3),
                        ),
                        const Divider(height: 36, color: Color(0xFF272733)),
                        if (!_revealed) ...[
                          const Icon(Icons.touch_app, size: 36, color: Colors.white38),
                          const SizedBox(height: 8),
                          const Text('कन्नड़ देखने के लिए टैप करें', style: TextStyle(fontSize: 13, color: Colors.white54)),
                        ] else ...[
                          Text(
                            displaySpoken,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Theme.of(context).colorScheme.primary),
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
