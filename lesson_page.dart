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
    if (a.length != b.length) {
      return false;
    }
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
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

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_done) {
      return _buildDone();
    }

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

    if (s is WordStep) {
      return _wordBody(s);
    }
    if (s is PhraseStep) {
      return _phraseBody(s);
    }
    if (s is PatternStep) {
      return _patternBody(s);
    }
    if (s is ContrastStep) {
      return _contrastBody(s);
    }
    if (s is BuildStep) {
      return _buildBody(s);
    }
    if (s is UseStep) {
      return _useBody(s);
    }
    return const SizedBox.shrink();
  }

  Widget _bottomBar() {
    final s = _step;

    if (s is BuildStep) {
      final result = _buildResult;
      if (result == null) {
        return const SizedBox.shrink();
      }
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
        title: 'लगभग!',
        body: 'क्रम थोड़ा अलग है। एक बार फिर देखिए।',
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
      if (picked == null) {
        return const SizedBox.shrink();
      }
      final ok = picked == s.answerIndex;
      return _feedback(
        ok: ok,
        title: ok ? 'बहुत बढ़िया!' : 'एक बार फिर देखिए',
        body: ok
            ? s.reveal
            : 'सही जवाब: ${s.options[s.answerIndex]}\n${s.reveal}',
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

  // -------------------------------------------------------------------------
  // Shared bits
  // -------------------------------------------------------------------------

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
        color: Colors.amber.shade50,
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
        color: ok ? Colors.green.shade50 : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: ok ? Colors.green.shade800 : Colors.orange.shade900,
            ),
          ),
          const SizedBox(height: 6),
          Text(body),
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

  // -------------------------------------------------------------------------
  // Teaching steps
  // -------------------------------------------------------------------------

  Widget _wordBody(WordStep s) {
    final word = wordsById[s.wordId];
    if (word == null) {
      return const SizedBox.shrink();
    }
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
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            c.roman,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(c.hindi, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _phraseBody(PhraseStep s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('वाक्य'),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: Card(
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
                  const SizedBox(height: 6),
                  Text(
                    s.deva,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const Divider(height: 26),
                  Text(
                    s.hindi,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
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
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.romanPattern,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                s.hindiPattern,
                style: const TextStyle(fontSize: 18),
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
          SizedBox(
            width: double.infinity,
            child: Card(
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
                    Text(e.hindi, style: const TextStyle(fontSize: 15)),
                  ],
                ),
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            Text(
              c.hindi,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 22),
            Text(
              e.roman,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(e.hindi, style: const TextStyle(fontSize: 14)),
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _contrastCard(s.a, s.exampleA, Colors.green.shade50),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contrastCard(s.b, s.exampleB, Colors.red.shade50),
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

  // -------------------------------------------------------------------------
  // Sentence builder (drag or tap)
  // -------------------------------------------------------------------------

  Widget _tileChip(String text, {bool lifted = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
        boxShadow: lifted
            ? const [BoxShadow(blurRadius: 8, color: Colors.black26)]
            : null,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _tile(BuildStep s, String text, bool locked) {
    final chip = _tileChip(text);
    if (locked) {
      return chip;
    }
    return Draggable<String>(
      data: text,
      feedback: Material(
        color: Colors.transparent,
        child: _tileChip(text, lifted: true),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: chip),
      child: GestureDetector(
        onTap: () => _place(s, text),
        child: chip,
      ),
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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        const Text(
          'नीचे से शब्द खींचकर डिब्बे में रखिए (या शब्द को दबाइए)।',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 18),
        DragTarget<String>(
          onWillAcceptWithDetails: (details) =>
              !locked &&
              !_placed.contains(details.data) &&
              _placed.length < s.answer.length,
          onAcceptWithDetails: (details) => _place(s, details.data),
          builder: (context, candidate, rejected) {
            final hovering = candidate.isNotEmpty;
            return Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 84),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hovering ? scheme.primaryContainer : null,
                border: Border.all(
                  color: hovering ? scheme.primary : Colors.black26,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _placed.isEmpty
                  ? const Text(
                      'यहाँ रखिए',
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _placed
                          .map(
                            (t) => InputChip(
                              label: Text(
                                t,
                                style: const TextStyle(fontSize: 18),
                              ),
                              onDeleted: locked
                                  ? null
                                  : () {
                                      setState(() {
                                        _placed = _placed
                                            .where((x) => x != t)
                                            .toList();
                                        _buildResult = null;
                                      });
                                    },
                            ),
                          )
                          .toList(),
                    ),
            );
          },
        ),
        const SizedBox(height: 26),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: remaining.map((t) => _tile(s, t, locked)).toList(),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Use it
  // -------------------------------------------------------------------------

  Widget _optionButton(UseStep s, int i) {
    final answered = _picked != null;
    final isAnswer = i == s.answerIndex;
    final isPicked = _picked == i;

    Color? bg;
    if (answered && isAnswer) {
      bg = Colors.green.shade50;
    } else if (answered && isPicked) {
      bg = Colors.red.shade50;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: bg,
            disabledBackgroundColor: bg,
            disabledForegroundColor: Colors.black87,
            padding: const EdgeInsets.all(14),
            alignment: Alignment.centerLeft,
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
        Text(s.situation, style: const TextStyle(fontSize: 18)),
        if (s.speakerRoman != null) ...[
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'सामने वाला कहता है',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      s.speakerRoman!,
                      style: const TextStyle(
                        fontSize: 22,
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
          ),
        ],
        const SizedBox(height: 18),
        Text(
          s.question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < s.options.length; i++) _optionButton(s, i),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Finished
  // -------------------------------------------------------------------------

  Widget _buildDone() {
    final store = MyWordsStore.instance;
    final words = widget.lesson.wordIds
        .map((id) => wordsById[id])
        .whereType<KWord>()
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: store,
          builder: (context, _) {
            final allSaved = words.every((w) => store.contains(w.id));

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'बहुत बढ़िया! 🎉',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'आपने "${widget.lesson.title}" पूरा किया। ये शब्द आपने देखे:',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: words
                      .map((w) => Chip(label: Text('${w.roman} · ${w.hindi}')))
                      .toList(),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: allSaved
                      ? null
                      : () => store.addAll(words.map((w) => w.id)),
                  icon: const Icon(Icons.add),
                  label: Text(
                    allSaved
                        ? 'सभी शब्द My Words में हैं'
                        : 'सभी शब्द My Words में जोड़ें',
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('वापस जाएँ'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
