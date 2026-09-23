import 'package:flutter/material.dart';
import 'content.dart';
import 'store.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int _index = 0;
  bool _done = false;

  List<String> _placed = <String>[];
  bool? _buildResult;
  int? _picked;

  LessonStep get _step => widget.lesson.steps[_index];

  void _next() {
    if (_index + 1 >= widget.lesson.steps.length) {
      setState(() => _done = true);
      return;
    }
    setState(() {
      _index++;
      _placed = <String>[];
      _buildResult = null;
      _picked = null;
    });
  }

  bool _sameList(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _place(BuildStep s, String tile, bool isDeva) {
    final target = isDeva ? s.answerDeva : s.answerRoman;
    if (_buildResult == true || _placed.contains(tile) || _placed.length >= target.length) {
      return;
    }
    setState(() {
      _placed = [..._placed, tile];
      if (_placed.length == target.length) {
        _buildResult = _sameList(_placed, target);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _buildDone();

    final total = widget.lesson.steps.length;
    final settings = AppSettingsStore.instance;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0, end: (_index + 1) / total),
            builder: (context, value, _) => LinearProgressIndicator(value: value, minHeight: 6),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(settings.isDevanagari ? Icons.translate : Icons.language),
            tooltip: 'भाषा बदलें',
            onPressed: () => settings.toggleMode(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                    child: KeyedSubtree(key: ValueKey<int>(_index), child: _stepBody()),
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                child: _bottomBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepBody() {
    final s = _step;
    if (s is PhraseStep) return _phraseBody(s);
    if (s is SpeakPracticeStep) return _speakPracticeBody(s);
    if (s is BuildStep) return _buildBody(s);
    if (s is UseStep) return _useBody(s);
    return const SizedBox.shrink();
  }

  Widget _bottomBar() {
    final s = _step;

    if (s is SpeakPracticeStep) {
      return SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          onPressed: _next,
          icon: const Icon(Icons.check),
          label: const Text('मैंने बोल लिया · आगे बढ़ें'),
        ),
      );
    }

    if (s is BuildStep) {
      final result = _buildResult;
      if (result == null) return const SizedBox.shrink();
      final isDeva = AppSettingsStore.instance.isDevanagari;
      final reveal = isDeva ? s.revealDeva : s.revealRoman;

      if (result) {
        return _feedback(
          ok: true,
          title: 'बहुत बढ़िया!',
          body: reveal,
          buttonLabel: 'आगे बढ़ें',
          onPressed: _next,
        );
      }
      return _feedback(
        ok: false,
        title: 'क्रम थोड़ा अलग है',
        body: 'शब्दों का क्रम फिर से देखिए।',
        buttonLabel: 'फिर से कोशिश करें',
        onPressed: () {
          setState(() {
            _placed = <String>[];
            _buildResult = null;
          });
        },
      );
    }

    if (s is UseStep) {
      final picked = _picked;
      if (picked == null) return const SizedBox.shrink();
      final ok = picked == s.answerIndex;
      final isDeva = AppSettingsStore.instance.isDevanagari;
      final answerStr = isDeva ? s.optionsDeva[s.answerIndex] : s.optionsRoman[s.answerIndex];

      return _feedback(
        ok: ok,
        title: ok ? 'शानदार!' : 'एक बार फिर देखिए',
        body: ok ? s.reveal : 'सही उत्तर: $answerStr\n${s.reveal}',
        buttonLabel: 'आगे बढ़ें',
        onPressed: _next,
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton(onPressed: _next, child: const Text('आगे बढ़ें')),
    );
  }

  Widget _feedback({
    required bool ok,
    required String title,
    required String body,
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: ok ? const Color(0xFF162B1F) : const Color(0xFF331E19),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ok ? Colors.greenAccent.withValues(alpha: 0.5) : Colors.orangeAccent.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: ok ? Colors.greenAccent : Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: onPressed, child: Text(buttonLabel)),
          ),
        ],
      ),
    );
  }

  Widget _phraseBody(PhraseStep s) {
    final settings = AppSettingsStore.instance;
    final primary = settings.isDevanagari ? s.deva : s.roman;
    final secondary = settings.isDevanagari ? s.roman : s.deva;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('वाक्य सीखिए', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: Theme.of(context).colorScheme.primary)),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.volume_up_outlined),
              tooltip: 'उच्चारण सुनें',
              onPressed: () => TtsService.instance.speak(s.roman),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(primary, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.4)),
                const SizedBox(height: 2),
                Text(secondary, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                const Divider(height: 20, color: Color(0xFF242738)),
                Text(s.hindi, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
        if (s.streetCode != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E281F),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFF00E599).withValues(alpha: 0.3)),
            ),
            child: Text(s.streetCode!, style: const TextStyle(fontSize: 13, color: Color(0xFF00E599), fontWeight: FontWeight.w600)),
          ),
        ],
        const SizedBox(height: 16),
        const Text('टुकड़ों में समझिए (Breakdown)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: s.chunks.map((c) {
            final chunkText = settings.isDevanagari ? c.deva : c.roman;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chunkText, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                  Text(c.hindi, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _speakPracticeBody(SpeakPracticeStep s) {
    final settings = AppSettingsStore.instance;
    final primary = settings.isDevanagari ? s.targetDeva : s.targetRoman;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('बोलकर अभ्यास करें (Listen & Speak)',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              Text('अर्थ: "${s.promptHindi}"', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Text(primary, textAlign: TextAlign.center, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.4)),
              const SizedBox(height: 16),
              IconButton.filledTonal(
                iconSize: 34,
                icon: const Icon(Icons.volume_up),
                onPressed: () => TtsService.instance.speak(s.targetRoman),
              ),
              const SizedBox(height: 6),
              const Text('उच्चारण सुनें और 2 बार ज़ोर से बोलें', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF261D12), borderRadius: BorderRadius.circular(10)),
          child: Text('💡 ${s.tip}', style: const TextStyle(fontSize: 13, color: Color(0xFFFFB74D))),
        ),
      ],
    );
  }

  Widget _buildBody(BuildStep s) {
    final settings = AppSettingsStore.instance;
    final isDeva = settings.isDevanagari;
    final tiles = isDeva ? s.tilesDeva : s.tilesRoman;
    final remaining = tiles.where((t) => !_placed.contains(t)).toList();
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('वाक्य बनाइए', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: scheme.primary)),
        const SizedBox(height: 10),
        Text(s.promptHindi, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
        const SizedBox(height: 4),
        Text('सही क्रम में शब्दों को चुनें:', style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant)),
        const SizedBox(height: 16),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 76),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: _placed.isEmpty
              ? Center(
                  child: Text('यहाँ शब्द जुड़ेंगे...', style: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.7), fontSize: 15)),
                )
              : Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _placed
                      .map(
                        (t) => InputChip(
                          label: Text(t, style: const TextStyle(fontSize: 15)),
                          onDeleted: _buildResult == true
                              ? null
                              : () {
                                  setState(() {
                                    _placed = _placed.where((x) => x != t).toList();
                                    _buildResult = null;
                                  });
                                },
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: remaining.map((t) {
            return ActionChip(
              label: Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              onPressed: () => _place(s, t, isDeva),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _useBody(UseStep s) {
    final settings = AppSettingsStore.instance;
    final options = settings.isDevanagari ? s.optionsDeva : s.optionsRoman;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('अब आप बोलिए', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 8),
        Text(s.question, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.3)),
        const SizedBox(height: 4),
        Text(s.situation, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 16),
        for (var i = 0; i < options.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: _picked == null
                        ? null
                        : (i == s.answerIndex ? const Color(0xFF162B1F) : (_picked == i ? const Color(0xFF331E19) : null)),
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _picked != null ? null : () => setState(() => _picked = i),
                  child: Text(options[i], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDone() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 52)),
              const SizedBox(height: 12),
              const Text('अभ्यास पूरा हुआ!', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
              const SizedBox(height: 6),
              Text(
                'आपने "${widget.lesson.title}" के सभी वाक्यों का अभ्यास पूरा कर लिया है।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () => Navigator.pop(context), child: const Text('वापस जाएँ')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
