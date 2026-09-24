import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
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
    SanskritCognatesPage(),
    SentenceLabPage(),
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
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'Situations',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_outlined),
            selectedIcon: Icon(Icons.account_balance),
            label: 'Sanskrit Roots',
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
// 1. Communicate Page (All 8 Categories Restored)
// ---------------------------------------------------------------------------

class CommunicatePage extends StatelessWidget {
  const CommunicatePage({super.key});

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
                      const SizedBox(height: 22),
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
// 2. Sanskrit Cognates Page (promoted out of the Vault into a primary tab)
// ---------------------------------------------------------------------------

class SanskritCognatesPage extends StatelessWidget {
  const SanskritCognatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;

    return ListenableBuilder(
      listenable: wordsStore,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sanskrit Roots 🏛️', style: TextStyle(fontWeight: FontWeight.w900)),
            actions: const [ScriptToggleAction()],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
// 3. Sentence Lab: Bilingual Dropdowns (Kannada + Hindi Meaning)
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

  final Map<String, String> _slot1Map = {
    'Ondu': 'ओन्दु (एक)',
    'Swalpa': 'स्वल्प (थोड़ा)',
    'Nanage': 'ननगे (मुझे)',
    'Illi': 'इल्लि (यहाँ)',
    'Innondu': 'इन्नोन्दु (एक और)',
  };

  Map<String, String> get _slot2Map {
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

  Map<String, String> get _slot3Map {
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

  @override
  void initState() {
    super.initState();
    _validateSlots();
  }

  void _validateSlots() {
    if (!_slot2Map.containsKey(_slot2Key)) {
      _slot2Key = _slot2Map.keys.first;
    }
    if (!_slot3Map.containsKey(_slot3Key)) {
      _slot3Key = _slot3Map.keys.first;
    }
  }

  /// Parses a slot's display value (e.g. "ओन्दु (एक)" or "dose — डोसा") into
  /// a saveable [Chunk] so each generated word — not just the full sentence —
  /// can be bookmarked to the Vault.
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
    final nounName = _slot2Map[_slot2Key]!.split('—').last.trim();
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
        actions: const [ScriptToggleAction()],
      ),
      body: ListView(
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
          const SizedBox(height: 20),

          // 3 Slot Builder
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

          // Output Card
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
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Saved Vault & Sanskrit Cognates Tab
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
          actions: const [ScriptToggleAction()],
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
                  return const Center(child: Text('No sentences saved yet. Use the bookmark button in any situation or Sentence Lab.'));
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
                  return const Center(child: Text('No words saved yet. Tap any word chunk across the app to save it here.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: saved.length,
                  itemBuilder: (context, i) {
                    final item = saved[i];
                    final label = settings.isDevanagari ? item.deva : item.roman;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text('$label = ${item.hindi}', style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                        subtitle: Text(item.source, style: const TextStyle(fontSize: 12)),
                        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => wordsStore.removeWord(item.id)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.emoji} ${category.title}'),
        actions: const [ScriptToggleAction()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final situation in category.situations)
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white)),
                subtitle: Text(situation.hindiTitle),
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
