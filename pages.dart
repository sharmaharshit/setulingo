import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'grammar_content.dart';
import 'learning_path.dart';
import 'lesson_page.dart';
import 'profile_settings.dart';
import 'quiz_page.dart';
import 'search_page.dart';
import 'sentence_lab_vocab.dart';
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
    HomeTabs.request.value = null; // consume so the same tab can be requested again
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!LearningPathStore.instance.isOnboarded) {
        Navigator.of(context).push(
          MaterialPageRoute(fullscreenDialog: true, builder: (_) => const OnboardingWizardPage()),
        );
      }
    });
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
// 1. Communicate Page
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
                            colors: [Color(0xFF0E222A), Color(0xFF0F1526)],
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
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Colors.white),
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.1,
                        children: [
                          _extraTile(context, '🔢', 'Numbers', const NumbersPage()),
                          _extraTile(context, '🎭', 'Roleplays', const RoleplayListPage()),
                          _extraTile(context, '🧠', 'Vault Quiz', const VaultQuizPage()),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          const Text(
                            'Real Spaces',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Colors.white),
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
// 2. For You Page
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
              RecommendedForYouSection(
                onTapSituation: (s) => _open(context, SituationDetailPage(situation: s)),
              ),
              const Row(
                children: [
                  Text('🏛️', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 8),
                  Text(
                    'Sanskrit Roots · Tatsama Bridge',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1526),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: const Row(
                  children: [
                    Text('🏛️', style: TextStyle(fontSize: 26)),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Many Hindi and Kannada words share identical Sanskrit roots, making them instantly recognizable. Tap the bookmark on any pair to save it to your Vault.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
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
                                '${c.hindi}  →  ${c.kannadaRoman} (${c.kannadaDeva})',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                              ),
                            ),
                            Builder(builder: (context) {
                              final id = 'cognate_${c.hindi}_${c.kannadaRoman}'.hashCode.toString();
                              final saved = wordsStore.contains(id);
                              return IconButton(
                                icon: Icon(
                                  saved ? Icons.bookmark : Icons.bookmark_border,
                                  color: saved ? AppColors.marigold : null,
                                  size: 21,
                                ),
                                tooltip: saved ? 'सहेजा गया' : 'Vault में सहेजें',
                                onPressed: () {
                                  if (saved) {
                                    wordsStore.removeWord(id);
                                  } else {
                                    wordsStore.addWord(SavedWord(
                                      id: id,
                                      roman: c.kannadaRoman,
                                      deva: c.kannadaDeva,
                                      hindi: c.hindi,
                                      source: 'Sanskrit Roots · ${c.type}',
                                      createdAt: DateTime.now(),
                                    ));
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(c.type, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF00E5A3))),
                        const SizedBox(height: 4),
                        Text(c.note, style: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8))),
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
// 3. Sentence Lab Page
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  String _slot1Key = 'Ondu';
  String _slot2Key = 'dose';
  String _slot3Key = 'kodi';

  final Map<String, String> _builtinSlot1Map = const {
    'Ondu': 'ओन्दु (एक)',
    'Swalpa': 'स्वल्प (थोड़ा)',
    'Nanage': 'ननगे (मुझे)',
    'Illi': 'इल्लि (यहाँ)',
    'Innondu': 'इन्नोन्दु (एक और)',
  };

  static String _customLabel(LabVocabEntry e, {required bool dash}) {
    if (e.hindi.isEmpty) return e.roman;
    return dash ? '${e.roman} — ${e.hindi}' : '${e.roman} (${e.hindi})';
  }

  Map<String, String> get _slot1Map => {
        ..._builtinSlot1Map,
        for (final e in SentenceLabVocabStore.instance.customAnchors)
          if (e.roman.isNotEmpty) e.roman: _customLabel(e, dash: false),
      };

  Map<String, String> get _builtinSlot2Map {
    switch (_slot1Key) {
      case 'Ondu':
      case 'Innondu':
        return {
          'dose': 'dose — डोसा',
          'coffee': 'coffee — कॉफ़ी',
          'tea': 'tea — चाय',
          'cover': 'cover — थैली',
          'bill': 'bill — बिल',
        };
      case 'Swalpa':
        return {
          'neeru': 'neeru — पानी',
          'sambar': 'sambar — सांभर',
          'jaga': 'jaga — जगह',
          'samaya': 'samaya — समय',
        };
      case 'Nanage':
        return {
          'coffee': 'coffee — कॉफ़ी',
          'tea': 'tea — चाय',
          'sahaya': 'sahaya — मदद',
          'bill': 'bill — बिल',
        };
      case 'Illi':
        return {
          'nilisi': 'nilisi — रोकिए',
          'banni': 'banni — आइए',
        };
      default:
        return {'dose': 'dose — डोसा'};
    }
  }

  Map<String, String> get _slot2Map => {
        ..._builtinSlot2Map,
        for (final e in SentenceLabVocabStore.instance.customNouns)
          if (e.roman.isNotEmpty) e.roman: _customLabel(e, dash: true),
      };

  static const Map<String, Map<String, String>> _slot3ComboOverrides = {
    'Illi|nilisi': {'saaku': 'saaku (बस)'},
    'Illi|banni': {'beku': 'beku (ज़रूरी है)'},
    'Nanage|sahaya': {'beku': 'beku (चाहिए)'},
  };

  Map<String, String> get _builtinSlot3Map {
    final comboKey = '$_slot1Key|$_slot2Key';
    if (_slot3ComboOverrides.containsKey(comboKey)) {
      return _slot3ComboOverrides[comboKey]!;
    }
    if (['dose', 'coffee', 'tea', 'cover', 'bill'].contains(_slot2Key)) {
      return {
        'kodi': 'kodi (दीजिए)',
        'beku': 'beku (चाहिए)',
        'beda': 'beda (नहीं चाहिए)',
      };
    }
    if (['neeru', 'sambar'].contains(_slot2Key)) {
      return {
        'haaki': 'haaki (डालिए)',
        'kodi': 'kodi (दीजिए)',
        'saaku': 'saaku (बस)',
        'beda': 'beda (नहीं चाहिए)',
      };
    }
    return {
      'kodi': 'kodi (दीजिए)',
      'beku': 'beku (चाहिए)',
    };
  }

  Map<String, String> get _slot3Map => {
        ..._builtinSlot3Map,
        for (final e in SentenceLabVocabStore.instance.customVerbs)
          if (e.roman.isNotEmpty) e.roman: _customLabel(e, dash: false),
      };

  @override
  void initState() {
    super.initState();
    _validateSlots();
  }

  void _validateSlots() {
    final slot1 = _slot1Map;
    if (!slot1.containsKey(_slot1Key)) {
      _slot1Key = slot1.containsKey('Ondu')
          ? 'Ondu'
          : (slot1.keys.isNotEmpty ? slot1.keys.first : 'Ondu');
    }
    final slot2 = _slot2Map;
    if (!slot2.containsKey(_slot2Key)) {
      _slot2Key = slot2.keys.isNotEmpty ? slot2.keys.first : 'dose';
    }
    final slot3 = _slot3Map;
    if (!slot3.containsKey(_slot3Key)) {
      _slot3Key = slot3.keys.isNotEmpty ? slot3.keys.first : 'kodi';
    }
  }

  Chunk _chunkFromSlot(String roman, String displayValue) {
    final parenMatch = RegExp(r'^(.*?)\s*\(([^)]+)\)\s*$').firstMatch(displayValue);
    if (parenMatch != null) {
      return Chunk(roman, parenMatch.group(1)!.trim(), parenMatch.group(2)!.trim());
    }
    if (displayValue.contains('—')) {
      final deva = displayValue.split('—').last.trim();
      return Chunk(roman, deva, deva);
    }
    return Chunk(roman, displayValue.trim(), displayValue.trim());
  }

  List<Chunk> get _currentChunks => [
        _chunkFromSlot(_slot1Key, _slot1Map[_slot1Key] ?? _slot1Key),
        _chunkFromSlot(_slot2Key, _slot2Map[_slot2Key] ?? _slot2Key),
        _chunkFromSlot(_slot3Key, _slot3Map[_slot3Key] ?? _slot3Key),
      ];

  String get _currentRoman => '$_slot1Key $_slot2Key $_slot3Key.';

  String get _currentHindi {
    final nounLabel = _slot2Map[_slot2Key] ?? _slot2Key;
    final nounName = nounLabel.split('—').last.trim();
    if (_slot1Key == 'Ondu' && _slot3Key == 'kodi') return 'एक $nounName दीजिए';
    if (_slot1Key == 'Nanage' && _slot3Key == 'beku') return 'मुझे एक $nounName चाहिए';
    if (_slot1Key == 'Swalpa' && _slot3Key == 'haaki') return 'थोड़ा $nounName डालिए';
    return '$_slot1Key $_slot2Key $_slot3Key';
  }

  @override
  Widget build(BuildContext context) {
    _validateSlots();
    const primaryMint = Color(0xFF00E5A3);
    final scheme = Theme.of(context).colorScheme;
    final sentencesStore = MySentencesStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentence Lab ⚡', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.4)),
        actions: const [SearchEntryAction(), ScriptToggleAction()],
      ),
      body: ListenableBuilder(
        listenable: SentenceLabVocabStore.instance,
        builder: (context, _) {
          _validateSlots();
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Cascading Sentence Builder',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                'Select bilingual options. The engine locks incompatible grammar pairings so every sentence is 100% natural.',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              const DismissibleHelperBanner(
                bannerId: 'sentence_lab_tagging_tip',
                title: 'Grow your sentence builder',
                message: 'Save any single word to your Vault, tap the ✨ icon beside it, and tag it as an Anchor (slot 1), '
                    'Noun (slot 2) or Verb (slot 3). It then shows up in the dropdowns below.',
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F1526),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF1E293B), width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('1. QUANTITY / ANCHOR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8))),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _slot1Key,
                      dropdownColor: const Color(0xFF161F36),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF161F36),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      items: _slot1Map.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _slot1Key = val;
                            _validateSlots();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('2. OBJECT / NOUN (Filtered)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8))),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _slot2Key,
                      dropdownColor: const Color(0xFF161F36),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF161F36),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      items: _slot2Map.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _slot2Key = val;
                            _validateSlots();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('3. PREDICATE / VERB (Grammar Locked)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8))),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _slot3Key,
                      dropdownColor: const Color(0xFF161F36),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF161F36),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      items: _slot3Map.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _slot3Key = val);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2219),
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
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.4),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _currentHindi,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: primaryMint),
                    ),
                    const SizedBox(height: 14),
                    const Text('शब्द सहेजिए:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                    const SizedBox(height: 6),
                    SaveableChunkRow(chunks: _currentChunks, source: 'Sentence Lab · $_currentRoman'),
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
          );
        },
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
    final wordsStore = MyWordsStore.instance;
    final settings = AppSettingsStore.instance;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vault'),
          actions: const [SearchEntryAction(), ScriptToggleAction()],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Saved Sentences'),
              Tab(text: 'Saved Words'),
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
                    message: 'Tap the bookmark on any sentence in a Situation, or build your own in Sentence Lab, '
                        'and it will live here for quick revision.',
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
                        title: Text(item.roman, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                        subtitle: Text(item.hindi),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => sentencesStore.removeSentence(item.id)),
                      ),
                    );
                  },
                );
              },
            ),
            ListenableBuilder(
              listenable: Listenable.merge([wordsStore, settings]),
              builder: (context, _) {
                final saved = wordsStore.words;
                if (saved.isEmpty) {
                  return PolishedEmptyState(
                    icon: Icons.bookmark_add_outlined,
                    title: 'No words saved yet',
                    message: 'Tap any word chunk in a Situation or Sentence Lab to save it. '
                        'Single words can later be tagged as Anchors, Nouns or Verbs.',
                    primaryLabel: 'Explore Situations',
                    onPrimary: () => HomeTabs.go(context, HomeTabs.situations),
                    secondaryLabel: 'Open Sentence Lab',
                    onSecondary: () => HomeTabs.go(context, HomeTabs.sentenceLab),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: saved.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const DismissibleHelperBanner(
                        bannerId: 'vault_tagging_tip',
                        title: 'Turn saved words into sentences',
                        message: 'Tap the ✨ icon on a single word to tag it as an Anchor, Noun or Verb. '
                            'Tagged words become options in Sentence Lab. (Multi-word phrases can\'t be tagged.)',
                      );
                    }
                    final i = index - 1;
                    final item = saved[i];
                    final label = settings.isDevanagari ? item.deva : item.roman;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text('$label = ${item.hindi}', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                        subtitle: Text(item.source, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isTaggableForSentenceLab(item.roman))
                              IconButton(
                                icon: const Icon(Icons.auto_awesome, size: 20, color: AppColors.marigold),
                                tooltip: 'Add to Sentence Lab',
                                onPressed: () => _showVaultTagDialog(context, item),
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20, color: AppColors.textFaint),
                              onPressed: () => wordsStore.removeWord(item.id),
                            ),
                          ],
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

void _showVaultTagDialog(BuildContext context, SavedWord item) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surfaceElevated,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add "${item.roman}" to Sentence Lab', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textHigh)),
            const SizedBox(height: 4),
            const Text('Choose which slot role this word should fill in the sentence builder:', style: TextStyle(fontSize: 12, color: AppColors.textMid)),
            const SizedBox(height: 12),
            for (final role in SlotRole.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  switch (role) {
                    SlotRole.anchor => Icons.anchor,
                    SlotRole.noun => Icons.category_outlined,
                    SlotRole.verb => Icons.bolt_outlined,
                  },
                  color: AppColors.marigold,
                ),
                title: Text(role.label, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                subtitle: Text(role.hindiLabel, style: const TextStyle(fontSize: 12, color: AppColors.textFaint)),
                onTap: () async {
                  final added = await SentenceLabVocabStore.instance.addCustomEntry(
                    role,
                    LabVocabEntry(roman: item.roman, deva: item.deva, hindi: item.hindi),
                  );
                  if (!ctx.mounted) return;
                  Navigator.pop(ctx);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(added
                          ? 'Added "${item.roman}" to Sentence Lab as ${role.label}! 🎉'
                          : '"${item.roman}" is already in Sentence Lab as ${role.label}.'),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    ),
  );
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
            actions: const [ScriptToggleAction()],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Row(
                  children: [
                    Text('$done / $total situations practiced', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                    const Spacer(),
                    SizedBox(
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: total == 0 ? 0 : done / total,
                          minHeight: 5,
                          backgroundColor: AppColors.outlineSoft,
                          color: AppColors.marigold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (final situation in category.situations)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      gami.isSituationCompleted(situation.id) ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: gami.isSituationCompleted(situation.id) ? AppColors.success : AppColors.textFaint,
                    ),
                    title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
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
        actions: const [ScriptToggleAction()],
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
