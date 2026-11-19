import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'grammar_content.dart';
import 'learning_path.dart';
import 'lesson_page.dart';
import 'profile_settings.dart';
import 'quiz_page.dart';
import 'search_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

/// Lets any screen (empty-state CTAs, Search) jump to a bottom-nav tab.
class HomeTabs {
  static const int situations = 0;
  static const int forYou = 1;
  static const int sentenceLab = 2;
  static const int vault = 3;

  static final ValueNotifier<int?> request = ValueNotifier<int?>(null);

  /// Pops back to the home shell and switches to [tab].
  static void go(BuildContext context, int tab) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    request.value = tab;
  }
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
    ForYouPage(),
    SentenceLabPage(),
    MyWordsPage(),
  ];

  void _onTabRequest() {
    final requested = HomeTabs.request.value;
    if (requested == null) return;
    HomeTabs.request.value = null; // consume
    if (!mounted || requested < 0 || requested >= _pages.length) return;
    setState(() => _tab = requested);
  }

  @override
  void dispose() {
    HomeTabs.request.removeListener(_onTabRequest);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    HomeTabs.request.addListener(_onTabRequest);
  }

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
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Situations',
          ),
          NavigationDestination(
            icon: Icon(Icons.stars_outlined),
            selectedIcon: Icon(Icons.stars),
            label: 'For You',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Sentence Lab',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Vault',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Communicate Page (Situations & Spoken Tools)
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

  Widget _extraTile(BuildContext context, String emoji, String label, Widget page) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _open(context, page),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outline),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textHigh),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    final daily = getDailyScenario();
    final scheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('SetuLingo', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.6)),
            actions: [
              TextButton.icon(
                onPressed: () => settings.toggleMode(),
                icon: const Icon(Icons.translate, size: 16),
                label: Text(
                  settings.isDevanagari ? 'अ Hindi' : '🔤 Eng',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              const SearchEntryAction(),
              const ProfileEntryAction(),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.surfaceElevated, AppColors.surfaceElevated],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: scheme.primary.withValues(alpha: 0.35)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '⚡ 2-MIN DAILY SCENARIO',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: scheme.primary,
                                  ),
                                ),
                                const Spacer(),
                                ListenableBuilder(
                                  listenable: GamificationStore.instance,
                                  builder: (context, _) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('🔥', style: TextStyle(fontSize: 12)),
                                        const SizedBox(width: 2),
                                        Text('${GamificationStore.instance.streak}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                                        const SizedBox(width: 8),
                                        const Text('⚡', style: TextStyle(fontSize: 12)),
                                        const SizedBox(width: 2),
                                        Text('${GamificationStore.instance.xp}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: scheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('TODAY', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Colors.black)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              daily.title,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
                            ),
                            Text(daily.hindiTitle, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                style: FilledButton.styleFrom(
                                  backgroundColor: scheme.primary,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () => _open(context, SituationDetailPage(situation: daily)),
                                icon: const Icon(Icons.play_arrow_rounded, size: 20),
                                label: const Text('Practice Scenario', style: TextStyle(fontWeight: FontWeight.w900)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Spoken Tools',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 2.4,
                        children: [
                          _extraTile(context, '🔢', 'Numbers', const NumbersPage()),
                          _extraTile(context, '🧠', 'Vault Quiz', const VaultQuizPage()),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Text(
                            'Real Spaces',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
                          ),
                          const Spacer(),
                          Text(
                            '${categories.length} Categories',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: scheme.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.15,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final cat = categories[i];
                      return BentoCategoryCard(
                        category: cat,
                        onTap: () => _open(context, CategorySituationsPage(category: cat)),
                      );
                    },
                    childCount: categories.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// 2. For You Page (Sanskrit Tatsama Bridge)
// ---------------------------------------------------------------------------

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;

    return ListenableBuilder(
      listenable: wordsStore,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('For You ✨', style: TextStyle(fontWeight: FontWeight.w900)),
            actions: const [SearchEntryAction(), ScriptToggleAction()],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Row(
                children: [
                  Text('🏛️', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8),
                  Text(
                    'Sanskrit Roots · Tatsama Bridge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outline),
                ),
                child: const Row(
                  children: [
                    Text('🏛️', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Many Hindi and Kannada words share identical Sanskrit roots, making them instantly recognizable. Tap the bookmark on any pair to save it to your Vault.',
                        style: TextStyle(fontSize: 12, color: AppColors.textFaint),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final c in connections)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '${c.hindi}  →  ${c.kannadaRoman}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textHigh),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(c.type, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.marigold)),
                        const SizedBox(height: 4),
                        Text(c.note, style: const TextStyle(fontSize: 13, color: AppColors.textFaint)),
                      ],
                    ),
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
// 3. Sentence Lab Page (Using 81-Word Tagged Matrix)
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  late LabAnchor _selectedAnchor;
  late LabNoun _selectedNoun;
  late LabVerb _selectedVerb;

  @override
  void initState() {
    super.initState();
    _selectedAnchor = labAnchors.first;
    final validNouns = getValidNounsForAnchor(_selectedAnchor);
    _selectedNoun = validNouns.isNotEmpty ? validNouns.first : labNouns.first;
    final validVerbs = getValidVerbsForPair(_selectedAnchor, _selectedNoun);
    _selectedVerb = validVerbs.isNotEmpty ? validVerbs.first : labVerbs.first;
  }

  void _onAnchorChanged(LabAnchor? anchor) {
    if (anchor == null) return;
    setState(() {
      _selectedAnchor = anchor;
      final validNouns = getValidNounsForAnchor(_selectedAnchor);
      _selectedNoun = validNouns.contains(_selectedNoun) ? _selectedNoun : validNouns.first;
      final validVerbs = getValidVerbsForPair(_selectedAnchor, _selectedNoun);
      _selectedVerb = validVerbs.contains(_selectedVerb) ? _selectedVerb : validVerbs.first;
    });
  }

  void _onNounChanged(LabNoun? noun) {
    if (noun == null) return;
    setState(() {
      _selectedNoun = noun;
      final validVerbs = getValidVerbsForPair(_selectedAnchor, _selectedNoun);
      _selectedVerb = validVerbs.contains(_selectedVerb) ? _selectedVerb : validVerbs.first;
    });
  }

  void _onVerbChanged(LabVerb? verb) {
    if (verb == null) return;
    setState(() {
      _selectedVerb = verb;
    });
  }

  String get _currentRoman => '${_selectedAnchor.roman} ${_selectedNoun.roman} ${_selectedVerb.roman}.';
  String get _currentHindi => '${_selectedAnchor.hindi} ${_selectedNoun.hindi} ${_selectedVerb.hindi}';

  @override
  Widget build(BuildContext context) {
    const primaryMint = AppColors.marigold;
    final scheme = Theme.of(context).colorScheme;
    final sentencesStore = MySentencesStore.instance;

    final validNouns = getValidNounsForAnchor(_selectedAnchor);
    final validVerbs = getValidVerbsForPair(_selectedAnchor, _selectedNoun);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Lab ⚡', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.4)),
        actions: const [SearchEntryAction()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Tagged Sentence Engine',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
          ),
          const SizedBox(height: 4),
          Text(
            'Select words from the 81-word matrix. Incompatible combinations are filtered automatically.',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.outline, width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('1. ANCHOR / SUBJECT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.jacaranda)),
                const SizedBox(height: 6),
                DropdownButtonFormField<LabAnchor>(
                  value: _selectedAnchor,
                  dropdownColor: AppColors.surfaceHighest,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceHighest,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: labAnchors.map((a) => DropdownMenuItem(value: a, child: Text('${a.roman} (${a.hindi})', style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: _onAnchorChanged,
                ),
                const SizedBox(height: 16),
                const Text('2. NOUN / OBJECT (Filtered)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.jacaranda)),
                const SizedBox(height: 6),
                DropdownButtonFormField<LabNoun>(
                  value: validNouns.contains(_selectedNoun) ? _selectedNoun : validNouns.first,
                  dropdownColor: AppColors.surfaceHighest,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceHighest,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: validNouns.map((n) => DropdownMenuItem(value: n, child: Text('${n.roman} — ${n.hindi}', style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: _onNounChanged,
                ),
                const SizedBox(height: 16),
                const Text('3. PREDICATE / VERB (Grammar Locked)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.jacaranda)),
                const SizedBox(height: 6),
                DropdownButtonFormField<LabVerb>(
                  value: validVerbs.contains(_selectedVerb) ? _selectedVerb : validVerbs.first,
                  dropdownColor: AppColors.surfaceHighest,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceHighest,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: validVerbs.map((v) => DropdownMenuItem(value: v, child: Text('${v.roman} (${v.hindi})', style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: _onVerbChanged,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.successSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryMint.withValues(alpha: 0.5), width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('✨ GENERATED SENTENCE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: primaryMint)),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: primaryMint),
                      onPressed: () => TtsService.instance.speak(_currentRoman),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _currentRoman,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textHigh, letterSpacing: -0.4),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentHindi,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: primaryMint),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: primaryMint, foregroundColor: Colors.black),
                    onPressed: () {
                      sentencesStore.addSentence(
                        SavedSentence(
                          id: 'lab_${DateTime.now().millisecondsSinceEpoch}',
                          roman: _currentRoman,
                          deva: _currentRoman,
                          hindi: _currentHindi,
                          createdAt: DateTime.now(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved sentence to Vault!')));
                    },
                    icon: const Icon(Icons.bookmark_add, size: 18),
                    label: const Text('Save Sentence to Vault', style: TextStyle(fontWeight: FontWeight.w900)),
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
// 4. Saved Vault Page
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sentencesStore = MySentencesStore.instance;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vault'),
          actions: const [SearchEntryAction()],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Saved Sentences'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListenableBuilder(
              listenable: sentencesStore,
              builder: (context, _) {
                final saved = sentencesStore.sentences;
                if (saved.isEmpty) {
                  return PolishedEmptyState(
                    icon: Icons.chat_bubble_outline,
                    title: 'No sentences saved yet',
                    message: 'Tap the bookmark on any sentence in a Situation or Sentence Lab to save it here.',
                    primaryLabel: 'Explore Situations',
                    onPrimary: () => HomeTabs.go(context, HomeTabs.situations),
                    secondaryLabel: 'Open Sentence Lab',
                    onSecondary: () => HomeTabs.go(context, HomeTabs.sentenceLab),
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
                        title: Text(item.roman, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                        subtitle: Text(item.hindi),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => sentencesStore.removeSentence(item.id)),
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

// ---------------------------------------------------------------------------
// Category & Situation Details Stubs
// ---------------------------------------------------------------------------

class CategorySituationsPage extends StatelessWidget {
  final Category category;

  const CategorySituationsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final gami = GamificationStore.instance;
    return ListenableBuilder(
      listenable: gami,
      builder: (context, _) {
        final total = category.situations.length;
        final done = gami.completedCountFor(category);
        return Scaffold(
          appBar: AppBar(
            title: Text('${category.emoji} ${category.title}'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final situation in category.situations)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      gami.isSituationCompleted(situation.id) ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: gami.isSituationCompleted(situation.id) ? AppColors.success : AppColors.textFaint,
                    ),
                    title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                    subtitle: Text(situation.hindiTitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _open(context, SituationDetailPage(situation: situation)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

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
          FilledButton.icon(
            onPressed: () => _open(context, LessonPage(lesson: generateLessonFromSituation(situation))),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Guided Practice'),
          ),
          const SizedBox(height: 16),
          for (final s in situation.sentences) SentenceCard(sentence: s),
        ],
      ),
    );
  }
}
