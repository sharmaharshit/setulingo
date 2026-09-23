import 'package:flutter/material.dart';
import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

List<KSentence> _searchSentences(String query) {
  final clean = query.toLowerCase().trim();
  if (clean.isEmpty) return [];
import 'package:flutter/material.dart';
import 'content.dart';
import 'lesson_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

List<KSentence> _searchSentences(String query) {
  final clean = query.toLowerCase().trim();
  if (clean.isEmpty) return [];

  final Map<String, List<String>> aliases = {
    'paani': ['neeru', 'पानी'],
    'pani': ['neeru', 'पानी'],
    'water': ['neeru', 'पानी'],
    'chahiye': ['beku', 'चाहिए'],
    'nahi': ['beda', 'नहीं'],
    'dosa': ['dose', 'दोसे', 'डोसा'],
    'dose': ['dose', 'दोसे', 'डोसा'],
    'coffee': ['coffee', 'कॉफ़ी'],
    'chai': ['tea', 'टी', 'चाय'],
    'tea': ['tea', 'टी', 'चाय'],
    'roko': ['nilisi', 'रोकिए'],
    'stop': ['nilisi', 'रोकिए'],
    'kitna': ['eshtu', 'कितना'],
    'bill': ['eshtu', 'bill', 'बिल'],
    'chutta': ['cilre', 'छुट्टे'],
    'change': ['cilre', 'छुट्टे'],
    'chalo': ['banni', 'hogona', 'चलते', 'चलेंगे'],
    'aao': ['banni', 'आइए'],
    'jana': ['hogbeku', 'जाना'],
    'help': ['help', 'मदद', 'swalpa'],
    'kam': ['kammi', 'कम'],
    'theli': ['cover', 'थैली'],
    'bag': ['cover', 'थैली'],
    'love': ['preethistheeni', 'प्यार'],
    'pyar': ['preethistheeni', 'प्यार'],
    'miss': ['miss', 'मिस'],
    'cute': ['muddu', 'cute', 'क्यूट'],
    'sundar': ['andhavaagiddeera', 'सुंदर'],
  };

  final all = categories.expand((c) => c.situations).expand((s) => s.sentences).toList();
  return all.where((s) {
    final r = s.roman.toLowerCase();
    final d = s.deva.toLowerCase();
    final h = s.hindi.toLowerCase();

    if (r.contains(clean) || d.contains(clean) || h.contains(clean)) return true;
    for (final entry in aliases.entries) {
      if (clean.contains(entry.key)) {
        for (final target in entry.value) {
          if (r.contains(target) || h.contains(target) || d.contains(target)) return true;
        }
      }
    }
    return false;
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
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
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
// 1. Communicate Page (Sleek Bento Grid Architecture)
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
    final daily = getDailyScenario();
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modern Mint/Deep Navy Hero Banner
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

              // 2-Column Bento Grid
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
// 2. Street Encounters Page (Structure preserved, Colors & Cards refreshed)
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
                        'Choose your path in real encounters. All choices are valid actions with unique reactions.',
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
                        Text('${enc.choices.length} Routes', style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
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
                        onPressed: () => _open(context, EncounterPlayerPage(encounter: enc)),
                        icon: const Icon(Icons.play_circle_outline, size: 18),
                        label: const Text('Start Encounter', style: TextStyle(fontWeight: FontWeight.w800)),
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

class EncounterPlayerPage extends StatefulWidget {
  final StreetEncounter encounter;

  const EncounterPlayerPage({super.key, required this.encounter});

  @override
  State<EncounterPlayerPage> createState() => _EncounterPlayerPageState();
}

class _EncounterPlayerPageState extends State<EncounterPlayerPage> {
  EncounterChoice? _selectedChoice;
  bool _revealOverheardTranslation = false;

  @override
  Widget build(BuildContext context) {
    final enc = widget.encounter;
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettingsStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(enc.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF101524),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.place, size: 14, color: scheme.primary),
                const SizedBox(width: 4),
                Expanded(child: Text(enc.location, style: TextStyle(fontSize: 11, color: scheme.primary, fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF121A2D),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF233558)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('👂 Overheard from ${enc.overheardSpeaker}:',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF38BDF8))),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined, size: 20),
                      onPressed: () => TtsService.instance.speak(enc.overheardRoman),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  settings.isDevanagari ? enc.overheardDeva : enc.overheardRoman,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setState(() => _revealOverheardTranslation = !_revealOverheardTranslation),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_revealOverheardTranslation ? 'हिंदी छिपाएँ' : 'हिंदी अर्थ समझें (Reveal Meaning)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: scheme.primary)),
                      Icon(_revealOverheardTranslation ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: scheme.primary),
                    ],
                  ),
                ),
                if (_revealOverheardTranslation) ...[
                  const SizedBox(height: 6),
                  Text(enc.overheardHindi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),

          Text('🎯 YOUR MOVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.0, color: scheme.primary)),
          const SizedBox(height: 4),
          Text(enc.dilemma, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),

          for (final choice in enc.choices) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _selectedChoice = choice),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: _selectedChoice?.id == choice.id ? const Color(0xFF0B2E21) : const Color(0xFF0F1422),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedChoice?.id == choice.id ? scheme.primary : const Color(0xFF1E293B),
                        width: _selectedChoice?.id == choice.id ? 1.5 : 0.8,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(choice.intentBadge, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          settings.isDevanagari ? choice.deva : choice.roman,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(choice.hindi, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],

          if (_selectedChoice != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A2218),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('💥 REACTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: scheme.primary)),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.volume_up_outlined, size: 18),
                        onPressed: () => TtsService.instance.speak(_selectedChoice!.roman),
                      ),
                    ],
                  ),
                  Text(_selectedChoice!.reactionTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(_selectedChoice!.reactionBody, style: const TextStyle(fontSize: 13, height: 1.4)),
                  const Divider(height: 18, color: Color(0xFF153F2E)),
                  Text(_selectedChoice!.takeawayRule, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF38BDF8))),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black),
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
                          const SnackBar(content: Text('वाक्य Vault में सहेजा गया!')),
                        );
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Save Sentence & Finish', style: TextStyle(fontWeight: FontWeight.w900)),
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
// 3. Sentence Lab: Clean Modern Studio (Structure preserved)
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
                'Type in Hinglish (हिंग्लिश स्टूडियो)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: scheme.primary),
              ),
              const SizedBox(height: 4),
              Text(
                'रोमन हिंदी में लिखें (जैसे: "paani chahiye", "yahan roko", "i love you"):',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 14),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF101524),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B), width: 1.2),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'उदा. "chalo", "paani do", "kitna hua"...',
                    hintStyle: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 14),
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
                        label: Text(pill, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
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

              const Text('Results', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
              const SizedBox(height: 10),

              if (results.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: const Color(0xFF0F1422), borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text('कोई मिलता-जुलता वाक्य नहीं मिला। ऊपर दिए गए किसी शब्द पर टैप करें।',
                        textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.3, color: Colors.white),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up_outlined),
                                tooltip: 'उच्चारण सुनें',
                                onPressed: () => TtsService.instance.speak(item.roman),
                              ),
                              IconButton(
                                icon: const Icon(Icons.bookmark_add_outlined),
                                tooltip: 'Save to Vault',
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
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to Vault!')));
                                },
                              ),
                            ],
                          ),
                          Text(settings.isDevanagari ? item.roman : item.deva, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                          const Divider(height: 18, color: Color(0xFF1E293B)),
                          Text(item.hindi, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: scheme.primary)),
                          if (item.streetCode != null) ...[
                            const SizedBox(height: 8),
                            Text(item.streetCode!, style: TextStyle(fontSize: 11, color: scheme.primary)),
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
// 4. Saved Vault & Active Recall Flashcards
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
              title: const Text('Vault & Practice'),
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
                  Tab(text: '🎯 फ़्लैशकार्ड्स'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListenableBuilder(
                  listenable: wordsStore,
                  builder: (context, _) {
                    final saved = allWords.where((w) => wordsStore.contains(w.id)).toList();
                    if (saved.isEmpty) return const Center(child: Text('अभी कोई शब्द सहेजा नहीं है।'));
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: saved.length,
                      itemBuilder: (context, i) {
                        final w = saved[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(settings.isDevanagari ? w.deva : w.roman, style: const TextStyle(fontWeight: FontWeight.w800)),
                            subtitle: Text(w.hindi),
                            trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => wordsStore.remove(w.id)),
                          ),
                        );
                      },
                    );
                  },
                ),
                ListenableBuilder(
                  listenable: sentencesStore,
                  builder: (context, _) {
                    final saved = sentencesStore.sentences;
                    if (saved.isEmpty) return const Center(child: Text('अभी कोई वाक्य सहेजा नहीं है।'));
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: saved.length,
                      itemBuilder: (context, i) {
                        final item = saved[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(settings.isDevanagari ? item.deva : item.roman, style: const TextStyle(fontWeight: FontWeight.w800)),
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
    final settings = AppSettingsStore.instance;
    final scheme = Theme.of(context).colorScheme;

    if (sentences.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('फ़्लैशकार्ड के लिए पहले Communicate या Encounters से कुछ वाक्य सहेजें!', textAlign: TextAlign.center),
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
              Text('कार्ड ${_cardIndex + 1} / ${sentences.length}',
                  style: TextStyle(fontWeight: FontWeight.w800, color: scheme.primary)),
              const Spacer(),
              if (current.mastered)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: const Color(0xFF00291B), borderRadius: BorderRadius.circular(8)),
                  child: Text('याद हो गया ✓', style: TextStyle(fontSize: 11, color: scheme.primary, fontWeight: FontWeight.w800)),
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
                      Text(current.hindi,
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.3, color: Colors.white)),
                      const Divider(height: 36, color: Color(0xFF1E293B)),
                      if (!_revealed) ...[
                        const Icon(Icons.touch_app, size: 36, color: Colors.white38),
                        const SizedBox(height: 8),
                        const Text('कन्नड़ देखने के लिए टैप करें', style: TextStyle(fontSize: 13, color: Colors.white54)),
                      ] else ...[
                        Text(displaySpoken,
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
                  style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black),
                  onPressed: () {
                    MySentencesStore.instance.markReviewed(current.id, true);
                    setState(() {
                      _revealed = false;
                      _cardIndex = (_cardIndex + 1) % sentences.length;
                    });
                  },
                  child: const Text('याद रहा ✓', style: TextStyle(fontWeight: FontWeight.w900)),
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
              const Text('⚡ Street Survival Search', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.3, color: Colors.white)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _controller,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'सर्च करें: "meter", "chutta", "stop", "coffee"...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xFF101524),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFF1E293B))),
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
                      child: Text(_query.isEmpty ? 'सर्च बॉक्स में कुछ लिखें...' : 'कोई वाक्य नहीं मिला।',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
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
                title: Text(situation.title, style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2, color: Colors.white)),
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
    final scheme = Theme.of(context).colorScheme;

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
                  color: const Color(0xFF101524),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      situation.hindiTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.2, color: Colors.white),
                    ),
                    const SizedBox(height: 3),
                    Text(situation.description, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: scheme.primary,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          final lesson = generateLessonFromSituation(situation);
                          _open(context, LessonPage(lesson: lesson));
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 20),
                        label: const Text('Guided Practice शुरू करें', style: TextStyle(fontWeight: FontWeight.w900)),
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
  final Map<String, List<String>> aliases = {
    'paani': ['neeru', 'पानी'],
    'pani': ['neeru', 'पानी'],
    'water': ['neeru', 'पानी'],
    'chahiye': ['beku', 'चाहिए'],
    'nahi': ['beda', 'नहीं'],
    'dosa': ['dose', 'दोसे', 'डोसा'],
    'dose': ['dose', 'दोसे', 'डोसा'],
    'coffee': ['coffee', 'कॉफ़ी'],
    'chai': ['tea', 'टी', 'चाय'],
    'tea': ['tea', 'टी', 'चाय'],
    'roko': ['nilisi', 'रोकिए'],
    'stop': ['nilisi', 'रोकिए'],
    'kitna': ['eshtu', 'कितना'],
    'bill': ['eshtu', 'bill', 'बिल'],
    'chutta': ['cilre', 'छुट्टे'],
    'change': ['cilre', 'छुट्टे'],
    'chalo': ['banni', 'hogona', 'चलते', 'चलेंगे'],
    'aao': ['banni', 'आइए'],
    'jana': ['hogbeku', 'जाना'],
    'help': ['help', 'मदद', 'swalpa'],
    'kam': ['kammi', 'कम'],
    'theli': ['cover', 'थैली'],
    'bag': ['cover', 'थैली'],
    'love': ['preethistheeni', 'प्यार'],
    'pyar': ['preethistheeni', 'प्यार'],
    'miss': ['miss', 'मिस'],
    'cute': ['muddu', 'cute', 'क्यूट'],
    'sundar': ['andhavaagiddeera', 'सुंदर'],
  };

  final all = categories.expand((c) => c.situations).expand((s) => s.sentences).toList();
  return all.where((s) {
    final r = s.roman.toLowerCase();
    final d = s.deva.toLowerCase();
    final h = s.hindi.toLowerCase();

    if (r.contains(clean) || d.contains(clean) || h.contains(clean)) return true;
    for (final entry in aliases.entries) {
      if (clean.contains(entry.key)) {
        for (final target in entry.value) {
          if (r.contains(target) || h.contains(target) || d.contains(target)) return true;
        }
      }
    }
    return false;
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
            icon: Icon(Icons.sports_esports_outlined),
            selectedIcon: Icon(Icons.sports_esports),
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
// 1. Communicate Page (Bento Grid Architecture)
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
    final daily = getDailyScenario();
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Editorial Daily Hero Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF26180B), Color(0xFF141521)],
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
                                Text('⚡ 2-MIN DAILY SCENARIO',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.2, color: scheme.primary)),
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
                            Text(daily.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4)),
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
                                label: const Text('Practice Scenario', style: TextStyle(fontWeight: FontWeight.w800)),
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4),
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

              // 2-Column Bento Grid
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
// 2. Street Encounters Page (The New Branching Social Confrontations)
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
              color: const Color(0xFF191B2C),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF282B40)),
            ),
            child: Row(
              children: [
                const Text('🛡️', style: TextStyle(fontSize: 26)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Social Self-Defense', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 2),
                      Text(
                        'Choose your path in real encounters. All choices are valid actions with unique reactions.',
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
                            color: scheme.primary.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(enc.tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: scheme.primary)),
                        ),
                        const Spacer(),
                        Text('${enc.choices.length} Routes', style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(enc.title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                    Text(enc.hindiTitle, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF00E599)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(enc.location, style: const TextStyle(fontSize: 11, color: Color(0xFF00E599), fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF1C1E2F),
                          foregroundColor: scheme.primary,
                        ),
                        onPressed: () => _open(context, EncounterPlayerPage(encounter: enc)),
                        icon: const Icon(Icons.play_circle_outline, size: 18),
                        label: const Text('Start Encounter', style: TextStyle(fontWeight: FontWeight.w800)),
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

class EncounterPlayerPage extends StatefulWidget {
  final StreetEncounter encounter;

  const EncounterPlayerPage({super.key, required this.encounter});

  @override
  State<EncounterPlayerPage> createState() => _EncounterPlayerPageState();
}

class _EncounterPlayerPageState extends State<EncounterPlayerPage> {
  EncounterChoice? _selectedChoice;
  bool _revealOverheardTranslation = false;

  @override
  Widget build(BuildContext context) {
    final enc = widget.encounter;
    final scheme = Theme.of(context).colorScheme;
    final settings = AppSettingsStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(enc.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Scene Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF141624),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.place, size: 14, color: Color(0xFF00E599)),
                const SizedBox(width: 4),
                Expanded(child: Text(enc.location, style: const TextStyle(fontSize: 11, color: Color(0xFF00E599), fontWeight: FontWeight.w600))),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Overheard Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1829),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFF382B54)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('👂 Overheard from ${enc.overheardSpeaker}:',
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFC084FC))),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined, size: 20),
                      onPressed: () => TtsService.instance.speak(enc.overheardRoman),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  settings.isDevanagari ? enc.overheardDeva : enc.overheardRoman,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => setState(() => _revealOverheardTranslation = !_revealOverheardTranslation),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_revealOverheardTranslation ? 'हिंदी छिपाएँ' : 'हिंदी अर्थ समझें (Reveal Meaning)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: scheme.primary)),
                      Icon(_revealOverheardTranslation ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16, color: scheme.primary),
                    ],
                  ),
                ),
                if (_revealOverheardTranslation) ...[
                  const SizedBox(height: 6),
                  Text(enc.overheardHindi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white70)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Dilemma Banner
          Text('🎯 YOUR MOVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.0, color: scheme.primary)),
          const SizedBox(height: 4),
          Text(enc.dilemma, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),

          // Choices
          for (final choice in enc.choices) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => setState(() => _selectedChoice = choice),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: _selectedChoice?.id == choice.id ? const Color(0xFF261D12) : const Color(0xFF13141F),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedChoice?.id == choice.id ? scheme.primary : const Color(0xFF26293D),
                        width: _selectedChoice?.id == choice.id ? 1.5 : 0.8,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(choice.intentBadge, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          settings.isDevanagari ? choice.deva : choice.roman,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 2),
                        Text(choice.hindi, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],

          // Consequence Panel
          if (_selectedChoice != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF12241A),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF00E599).withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('💥 REACTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Color(0xFF00E599))),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.volume_up_outlined, size: 18),
                        onPressed: () => TtsService.instance.speak(_selectedChoice!.roman),
                      ),
                    ],
                  ),
                  Text(_selectedChoice!.reactionTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(_selectedChoice!.reactionBody, style: const TextStyle(fontSize: 13, height: 1.4)),
                  const Divider(height: 18, color: Color(0xFF1E3A2B)),
                  Text(_selectedChoice!.takeawayRule, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFFFB74D))),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(backgroundColor: const Color(0xFF00E599), foregroundColor: Colors.black),
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
                          const SnackBar(content: Text('वाक्य Vault में सहेजा गया!')),
                        );
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Save Sentence & Finish', style: TextStyle(fontWeight: FontWeight.w900)),
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
// 3. Sentence Lab: Instant Hinglish Studio
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
                'Type in Hinglish (हिंग्लिश स्टूडियो)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: scheme.primary),
              ),
              const SizedBox(height: 4),
              Text(
                'रोमन हिंदी में लिखें (जैसे: "paani chahiye", "yahan roko", "i love you"):',
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: 'उदा. "chalo", "paani do", "kitna hua"...',
                    hintStyle: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.6), fontSize: 14),
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
                        label: Text(pill, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
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

              Text('Results', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: scheme.onSurface)),
              const SizedBox(height: 10),

              if (results.isEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: scheme.surfaceContainer, borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text('कोई मिलता-जुलता वाक्य नहीं मिला। ऊपर दिए गए किसी शब्द पर टैप करें।',
                        textAlign: TextAlign.center, style: TextStyle(color: scheme.onSurfaceVariant)),
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
                                tooltip: 'Save to Vault',
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
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to Vault!')));
                                },
                              ),
                            ],
                          ),
                          Text(settings.isDevanagari ? item.roman : item.deva, style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
                          const Divider(height: 18, color: Color(0xFF242738)),
                          Text(item.hindi, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: scheme.primary)),
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
// 4. Saved Vault & Active Recall Flashcards
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
              title: const Text('Vault & Practice'),
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
                  Tab(text: '🎯 फ़्लैशकार्ड्स'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListenableBuilder(
                  listenable: wordsStore,
                  builder: (context, _) {
                    final saved = allWords.where((w) => wordsStore.contains(w.id)).toList();
                    if (saved.isEmpty) return const Center(child: Text('अभी कोई शब्द सहेजा नहीं है।'));
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: saved.length,
                      itemBuilder: (context, i) {
                        final w = saved[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(settings.isDevanagari ? w.deva : w.roman, style: const TextStyle(fontWeight: FontWeight.w800)),
                            subtitle: Text(w.hindi),
                            trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => wordsStore.remove(w.id)),
                          ),
                        );
                      },
                    );
                  },
                ),
                ListenableBuilder(
                  listenable: sentencesStore,
                  builder: (context, _) {
                    final saved = sentencesStore.sentences;
                    if (saved.isEmpty) return const Center(child: Text('अभी कोई वाक्य सहेजा नहीं है।'));
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: saved.length,
                      itemBuilder: (context, i) {
                        final item = saved[i];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(settings.isDevanagari ? item.deva : item.roman, style: const TextStyle(fontWeight: FontWeight.w800)),
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
    final settings = AppSettingsStore.instance;

    if (sentences.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text('फ़्लैशकार्ड के लिए पहले Communicate या Encounters से कुछ वाक्य सहेजें!', textAlign: TextAlign.center),
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
              Text('कार्ड ${_cardIndex + 1} / ${sentences.length}',
                  style: TextStyle(fontWeight: FontWeight.w800, color: Theme.of(context).colorScheme.primary)),
              const Spacer(),
              if (current.mastered)
                const Chip(label: Text('याद हो गया ✓', style: TextStyle(fontSize: 11)), backgroundColor: Color(0xFF1B382B)),
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
                      Text(current.hindi,
                          textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                      const Divider(height: 36, color: Color(0xFF242738)),
                      if (!_revealed) ...[
                        const Icon(Icons.touch_app, size: 36, color: Colors.white38),
                        const SizedBox(height: 8),
                        const Text('कन्नड़ देखने के लिए टैप करें', style: TextStyle(fontSize: 13, color: Colors.white54)),
                      ] else ...[
                        Text(displaySpoken,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary)),
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
                      child: Text(_query.isEmpty ? 'सर्च बॉक्स में कुछ लिखें...' : 'कोई वाक्य नहीं मिला।',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
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
