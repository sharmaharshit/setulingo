import 'package:flutter/material.dart';
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
    StreetEncountersPage(),
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
            icon: Icon(Icons.theater_comedy_outlined),
            selectedIcon: Icon(Icons.theater_comedy),
            label: 'Encounters',
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
// 2. Street Encounters Page (Distraction-Free Theater Mode)
// ---------------------------------------------------------------------------

class StreetEncountersPage extends StatelessWidget {
  const StreetEncountersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Street Encounters ⚡', style: TextStyle(fontWeight: FontWeight.w900)),
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
            child: Row(
              children: [
                const Text('🛡️', style: TextStyle(fontSize: 26)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Social Self-Defense', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(
                        'Step into real Bangalore scenarios. Overhear dialogue, choose your stance, and master local responses.',
                        style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (final enc in streetEncounters) ...[
            Card(
              margin: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: scheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(enc.tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: scheme.primary)),
                        ),
                        const Spacer(),
                        Text('${enc.choices.length} Stances', style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(enc.title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: -0.3, color: Colors.white)),
                    Text(enc.hindiTitle, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 14, color: scheme.primary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(enc.location, style: TextStyle(fontSize: 11, color: scheme.primary, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF162035),
                          foregroundColor: scheme.primary,
                        ),
                        onPressed: () => _open(context, TheaterModePlayerPage(encounter: enc)),
                        icon: const Icon(Icons.play_circle_outline, size: 18),
                        label: const Text('Enter Scene (Theater Mode)', style: TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class TheaterModePlayerPage extends StatefulWidget {
  final StreetEncounter encounter;

  const TheaterModePlayerPage({super.key, required this.encounter});

  @override
  State<TheaterModePlayerPage> createState() => _TheaterModePlayerPageState();
}

class _TheaterModePlayerPageState extends State<TheaterModePlayerPage> {
  EncounterChoice? _selectedChoice;
  bool _revealOverheardTranslation = false;

  @override
  Widget build(BuildContext context) {
    final enc = widget.encounter;
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettingsStore.instance;

    return Scaffold(
      backgroundColor: const Color(0xFF06080F), // True cinema dark mode
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(enc.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Act I: Atmospheric Context Card
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1526),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('🎬', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    enc.atmosphere,
                    style: const TextStyle(fontSize: 13, height: 1.4, color: Color(0xFFCBD5E1)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Act II: Spoken Moment Overheard Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF121B33), Color(0xFF0A1020)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF38BDF8).withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('👂 OVERHEARD FROM ${enc.overheardSpeaker.toUpperCase()}:',
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.0, color: Color(0xFF38BDF8))),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.volume_up, size: 20, color: Color(0xFF38BDF8)),
                      onPressed: () => TtsService.instance.speak(enc.overheardRoman),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  settings.isDevanagari ? enc.overheardDeva : enc.overheardRoman,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.3),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () => setState(() => _revealOverheardTranslation = !_revealOverheardTranslation),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_revealOverheardTranslation ? 'Hide Meaning' : 'Tap to Reveal Hindi Meaning',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: scheme.primary)),
                      Icon(_revealOverheardTranslation ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 18, color: scheme.primary),
                    ],
                  ),
                ),
                if (_revealOverheardTranslation) ...[
                  const SizedBox(height: 8),
                  Text(enc.overheardHindi, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Act III: The Dilemma
          Text('🎯 YOUR DILEMMA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: scheme.primary)),
          const SizedBox(height: 6),
          Text(enc.dilemma, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, height: 1.35, color: Colors.white)),
          const SizedBox(height: 18),

          // Act IV: Three Distinct Stances / Responses
          const Text('CHOOSE YOUR STANCE:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: Colors.white54)),
          const SizedBox(height: 10),

          for (final choice in enc.choices) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _selectedChoice = choice),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedChoice?.id == choice.id ? const Color(0xFF0B2E21) : const Color(0xFF0F1526),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedChoice?.id == choice.id ? scheme.primary : const Color(0xFF1E293B),
                        width: _selectedChoice?.id == choice.id ? 1.5 : 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(choice.stanceTitle.toUpperCase(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: scheme.primary)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(choice.stanceBadge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          settings.isDevanagari ? choice.deva : choice.roman,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(choice.hindi, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],

          // Resolution Outcome Panel
          if (_selectedChoice != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF0A2218),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('🎬 SCENE OUTCOME', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: scheme.primary)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.volume_up, size: 20),
                        onPressed: () => TtsService.instance.speak(_selectedChoice!.roman),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(_selectedChoice!.outcomeTitle, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text(_selectedChoice!.outcomeBody, style: const TextStyle(fontSize: 14, height: 1.45, color: Color(0xFFE2E8F0))),
                  const Divider(height: 24, color: Color(0xFF153F2E)),
                  Text(_selectedChoice!.culturalRule, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF38BDF8))),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () {
                        MySentencesStore.instance.addSentence(
                          SavedSentence(
                            id: 'enc_${DateTime.now().millisecondsSinceEpoch}',
                            roman: _selectedChoice!.roman,
                            deva: _selectedChoice!.deva,
                            hindi: _selectedChoice!.hindi,
                            createdAt: DateTime.now(),
                          ),
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sentence saved to Vault!')),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add, size: 18),
                      label: const Text('Save Sentence to Vault & Finish', style: TextStyle(fontWeight: FontWeight.w900)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. Sentence Lab: Constraint-Based Cascading Studio
// ---------------------------------------------------------------------------

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  // Cascading Builder state
  String _slot1 = 'Ondu';
  String _slot2 = 'dose';
  String _slot3 = 'kodi';

  final List<String> _slot1Options = ['Ondu', 'Swalpa', 'Nanage', 'Illi', 'Innondu'];

  List<String> get _slot2Options {
    switch (_slot1) {
      case 'Ondu':
      case 'Innondu':
        return ['dose', 'coffee', 'tea', 'cover', 'bill'];
      case 'Swalpa':
        return ['neeru', 'sambar', 'jaga', 'samaya'];
      case 'Nanage':
        return ['coffee', 'tea', 'sahaya', 'bill'];
      case 'Illi':
        return ['nilisi', 'banni'];
      default:
        return ['dose', 'coffee'];
    }
  }

  List<String> get _slot3Options {
    if (_slot2 == 'dose' || _slot2 == 'coffee' || _slot2 == 'tea' || _slot2 == 'cover' || _slot2 == 'bill') {
      return ['kodi', 'beku', 'beda'];
    }
    if (_slot2 == 'neeru' || _slot2 == 'sambar') {
      return ['haaki', 'kodi', 'saaku', 'beda'];
    }
    if (_slot2 == 'jaga' || _slot2 == 'samaya' || _slot2 == 'sahaya') {
      return ['kodi', 'beku'];
    }
    if (_slot2 == 'nilisi') {
      return ['boss', 'anna'];
    }
    return ['kodi', 'beku'];
  }

  @override
  void initState() {
    super.initState();
    _validateSlots();
  }

  void _validateSlots() {
    if (!_slot2Options.contains(_slot2)) {
      _slot2 = _slot2Options.first;
    }
    if (!_slot3Options.contains(_slot3)) {
      _slot3 = _slot3Options.first;
    }
  }

  String get _currentRoman {
    return '$_slot1 $_slot2 $_slot3.';
  }

  String get _currentHindi {
    if (_slot1 == 'Ondu' && _slot3 == 'kodi') return 'एक ${_slot2} दीजिए';
    if (_slot1 == 'Nanage' && _slot3 == 'beku') return 'मुझे एक ${_slot2} चाहिए';
    if (_slot1 == 'Swalpa' && _slot3 == 'haaki') return 'थोड़ा ${_slot2} डालिए';
    return '$_slot1 $_slot2 $_slot3';
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
            'Select words step-by-step. The engine automatically filters out grammar mismatches so every sentence is 100% natural.',
            style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 20),

          // Interactive 3-Slot Builder Card
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
                  value: _slot1,
                  dropdownColor: const Color(0xFF161F36),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF161F36),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: _slot1Options.map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _slot1 = val;
                        _validateSlots();
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                const Text('2. OBJECT / NOUN (Filtered)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8))),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _slot2,
                  dropdownColor: const Color(0xFF161F36),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF161F36),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: _slot2Options.map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _slot2 = val;
                        _validateSlots();
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                const Text('3. PREDICATE / VERB (Grammar Locked)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8))),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _slot3,
                  dropdownColor: const Color(0xFF161F36),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF161F36),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  ),
                  items: _slot3Options.map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontWeight: FontWeight.w800)))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _slot3 = val);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Live Generated Output Card
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
// 4. Saved Vault
// ---------------------------------------------------------------------------

class MyWordsPage extends StatelessWidget {
  const MyWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sentencesStore = MySentencesStore.instance;
    final settings = AppSettingsStore.instance;

    return DefaultTabController(
      length: 2,
      child: ListenableBuilder(
        listenable: settings,
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Vault & Practice'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Saved Sentences'),
                  Tab(text: '🎯 Flashcards'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListenableBuilder(
                  listenable: sentencesStore,
                  builder: (context, _) {
                    final saved = sentencesStore.sentences;
                    if (saved.isEmpty) return const Center(child: Text('No sentences saved yet. Use Vault buttons in Encounters or Sentence Lab.'));
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
    final scheme = Theme.of(context).colorScheme;

    if (sentences.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('Save sentences to your Vault first to practice flashcards!', textAlign: TextAlign.center),
        ),
      );
    }

    final current = sentences[_cardIndex % sentences.length];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text('Card ${_cardIndex + 1} / ${sentences.length}', style: TextStyle(fontWeight: FontWeight.w800, color: scheme.primary)),
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
                      const Text('Hindi Meaning (Recall):', style: TextStyle(fontSize: 13)),
                      const SizedBox(height: 8),
                      Text(current.hindi,
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                      const Divider(height: 36, color: Color(0xFF1E293B)),
                      if (!_revealed) ...[
                        const Icon(Icons.touch_app, size: 36, color: Colors.white38),
                        const SizedBox(height: 8),
                        const Text('Tap to Reveal Kannada', style: TextStyle(fontSize: 13, color: Colors.white54)),
                      ] else ...[
                        Text(current.roman,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: scheme.primary)),
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
                    setState(() {
                      _revealed = false;
                      _cardIndex = (_cardIndex + 1) % sentences.length;
                    });
                  },
                  child: const Text('Practice Again'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black),
                  onPressed: () {
                    setState(() {
                      _revealed = false;
                      _cardIndex = (_cardIndex + 1) % sentences.length;
                    });
                  },
                  child: const Text('Got It ✓', style: TextStyle(fontWeight: FontWeight.w900)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Category & Situation Details (Stub)
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
      appBar: AppBar(title: Text(situation.title)),
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
