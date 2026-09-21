import 'package:flutter/material.dart';
import 'content.dart';
import 'store.dart';
import 'widgets.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int _index = 0;
  bool _done = false;

  // Sentence-builder state
  List<String> _placed = <String>[];
  bool? _buildResult;

  // "Use it" step state
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

  void _place(BuildStep s, String tile) {
    if (_buildResult == true ||
        _placed.contains(tile) ||
        _placed.length >= s.answer.length) {
      return;
    }
    setState(() {
      _placed = [..._placed, tile];
      if (_placed.length == s.answer.length) {
        _buildResult = _sameList(_placed, s.answer);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_done) return _buildDone();

    final total = widget.lesson.steps.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_index + 1) / total,
            minHeight: 8,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: _stepBody(),
                ),
              ),
              _bottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepBody() {
    final s = _step;
    if (s is WordStep) return _wordBody(s);
    if (s is PhraseStep) return _phraseBody(s);
    if (s is PatternStep) return _patternBody(s);
    if (s is ContrastStep) return _contrastBody(s);
    if (s is BuildStep) return _buildBody(s);
    if (s is UseStep) return _useBody(s);
    return const SizedBox.shrink();
  }

  Widget _bottomBar() {
    final s = _step;

    if (s is BuildStep) {
      final result = _buildResult;
      if (result == null) return const SizedBox.shrink();
      if (result) {
        return _feedback(
          ok: true,
          title: 'बहुत बढ़िया!',
          body: s.reveal,
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
      return _feedback(
        ok: ok,
        title: ok ? 'शानदार!' : 'एक बार फिर देखिए',
        body: ok
            ? s.reveal
            : 'सही जवाब:\n${s.options[s.answerIndex]}\n${s.reveal}',
        buttonLabel: 'आगे बढ़ें',
        onPressed: _next,
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _next,
        child: const Text('आगे बढ़ें'),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _noteBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text('💡 $text', style: const TextStyle(fontSize: 15)),
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
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ok ? const Color(0xFF1B382B) : const Color(0xFF3E2723),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ok ? Colors.greenAccent : Colors.orangeAccent,
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
              fontSize: 17,
              color: ok ? Colors.greenAccent : Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(body, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onPressed,
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _wordBody(WordStep s) {
    final word = wordsById[s.wordId];
    if (word == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('नया शब्द'),
        const SizedBox(height: 12),
        WordCard(word: word),
      ],
    );
  }

  Widget _chunkBox(Chunk c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            c.roman,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            c.hindi,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _phraseBody(PhraseStep s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('वाक्य सीखिए'),
        const SizedBox(height: 12),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.roman,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  s.deva,
                  style: TextStyle(
                    fontSize: 17,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 24),
                Text(
                  s.hindi,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'टुकड़ों में समझिए',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: s.chunks.map(_chunkBox).toList(),
        ),
        if (s.note != null) ...[
          const SizedBox(height: 18),
          _noteBox(s.note!),
        ],
      ],
    );
  }

  Widget _patternBody(PatternStep s) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('पैटर्न'),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.romanPattern,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                s.hindiPattern,
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'उदाहरण',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        for (final e in s.examples)
          Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.roman,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    e.hindi,
                    style: TextStyle(
                      fontSize: 15,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (s.note != null) ...[
          const SizedBox(height: 10),
          _noteBox(s.note!),
        ],
      ],
    );
  }

  Widget _contrastCard(Chunk c, Example e, Color color) {
    return Card(
      margin: EdgeInsets.zero,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              c.roman,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Text(
              c.hindi,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 20),
            Text(
              e.roman,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(e.hindi, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _contrastBody(ContrastStep s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('फ़र्क़ समझिए'),
        const SizedBox(height: 12),
        Text(
          s.title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _contrastCard(s.a, s.exampleA, const Color(0xFF1B382B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contrastCard(s.b, s.exampleB, const Color(0xFF3E2723)),
              ),
            ],
          ),
        ),
        if (s.note != null) ...[
          const SizedBox(height: 16),
          _noteBox(s.note!),
        ],
      ],
    );
  }

  Widget _tileChip(String text, {bool lifted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _tile(BuildStep s, String text, bool locked) {
    final chip = _tileChip(text);
    if (locked) return chip;
    return GestureDetector(
      onTap: () => _place(s, text),
      child: chip,
    );
  }

  Widget _buildBody(BuildStep s) {
    final locked = _buildResult == true;
    final remaining = s.tiles.where((t) => !_placed.contains(t)).toList();
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('वाक्य बनाइए'),
        const SizedBox(height: 12),
        Text(
          s.promptHindi,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          'नीचे दिए गए शब्दों को छूकर सही क्रम में जोड़ें:',
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 84),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainer,
            border: Border.all(color: scheme.primary.withValues(alpha: 0.5), width: 1.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: _placed.isEmpty
              ? Center(
                  child: Text(
                    'यहाँ शब्द जुड़ेंगे...',
                    style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 16),
                  ),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _placed
                      .map(
                        (t) => InputChip(
                          label: Text(t, style: const TextStyle(fontSize: 16)),
                          onDeleted: locked
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
        const SizedBox(height: 22),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: remaining.map((t) => _tile(s, t, locked)).toList(),
        ),
      ],
    );
  }

  Widget _optionButton(UseStep s, int i) {
    final answered = _picked != null;
    final isAnswer = i == s.answerIndex;
    final isPicked = _picked == i;

    Color? bg;
    if (answered && isAnswer) {
      bg = const Color(0xFF1B382B);
    } else if (answered && isPicked) {
      bg = const Color(0xFF3E2723);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: bg,
            disabledBackgroundColor: bg,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: answered ? null : () => setState(() => _picked = i),
          child: Text(
            s.options[i],
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget _useBody(UseStep s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('अब आप बोलिए'),
        const SizedBox(height: 12),
        Text(s.situation, style: const TextStyle(fontSize: 17)),
        if (s.speakerRoman != null) ...[
          const SizedBox(height: 14),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'सामने वाला कहता है',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    s.speakerRoman!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (s.speakerHindi != null)
                    Text(
                      s.speakerHindi!,
                      style: const TextStyle(fontSize: 15),
                    ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 18),
        Text(
          s.question,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < s.options.length; i++) _optionButton(s, i),
      ],
    );
  }

  Widget _buildDone() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 54)),
              const SizedBox(height: 12),
              const Text(
                'अभ्यास पूरा हुआ!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                'आपने "${widget.lesson.title}" के सभी वाक्यों का अभ्यास सफलतापूर्वक कर लिया है।',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('वापस जाएँ'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
