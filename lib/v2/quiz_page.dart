import 'dart:math';
import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'store.dart';

class _QuizItem {
  final String hindi;
  final String roman;
  const _QuizItem(this.hindi, this.roman);
}

class _QuizQuestion {
  final String promptHindi;
  final String correctRoman;
  final List<String> options;
  const _QuizQuestion({required this.promptHindi, required this.correctRoman, required this.options});
}

/// XP awarded per correct answer. Doesn't touch the daily streak — only
/// full lesson completions do that (see GamificationStore.recordLessonCompletion).
const int _xpPerCorrectAnswer = 5;

class VaultQuizPage extends StatefulWidget {
  const VaultQuizPage({super.key});

  @override
  State<VaultQuizPage> createState() => _VaultQuizPageState();
}

class _VaultQuizPageState extends State<VaultQuizPage> {
  late final List<_QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  int? _picked;
  bool _finished = false;
  bool _xpAwarded = false;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions();
  }

  List<_QuizQuestion> _buildQuestions() {
    final pool = <_QuizItem>[
      for (final w in MyWordsStore.instance.words)
        if (w.hindi.trim().isNotEmpty && w.roman.trim().isNotEmpty) _QuizItem(w.hindi, w.roman),
      for (final s in MySentencesStore.instance.sentences)
        if (s.hindi.trim().isNotEmpty && s.roman.trim().isNotEmpty) _QuizItem(s.hindi, s.roman),
    ];
    pool.shuffle(Random());

    final rng = Random();
    final count = min(10, pool.length);
    final questions = <_QuizQuestion>[];
    for (var i = 0; i < count; i++) {
      final correct = pool[i];
      final distractorPool = [...pool]..removeAt(i);
      distractorPool.shuffle(rng);
      final distractors = distractorPool.take(3).map((e) => e.roman).toSet().toList();
      final options = [correct.roman, ...distractors]..shuffle(rng);
      questions.add(_QuizQuestion(promptHindi: correct.hindi, correctRoman: correct.roman, options: options));
    }
    return questions;
  }

  void _answer(int i) {
    if (_picked != null) return;
    setState(() {
      _picked = i;
      if (_questions[_index].options[i] == _questions[_index].correctRoman) _score++;
    });
  }

  Future<void> _next() async {
    if (_index + 1 >= _questions.length) {
      if (!_xpAwarded && _score > 0) {
        _xpAwarded = true;
        await GamificationStore.instance.addXp(_score * _xpPerCorrectAnswer);
      }
      if (!mounted) return;
      setState(() => _finished = true);
      return;
    }
    setState(() {
      _index++;
      _picked = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    if (_questions.length < 4) {
      return Scaffold(
        appBar: AppBar(title: const Text('Vault Quiz')),
        body: const Padding(
          padding: EdgeInsets.all(28),
          child: Center(
            child: Text(
              'Save at least 4 words or sentences to your Vault to unlock the quiz.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textFaint, fontSize: 14),
            ),
          ),
        ),
      );
    }

    if (_finished) {
      return Scaffold(
        appBar: AppBar(title: const Text('Vault Quiz')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🏁', style: TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text('$_score / ${_questions.length} correct', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textHigh)),
                const SizedBox(height: 6),
                Text('+${_score * _xpPerCorrectAnswer} XP earned', style: const TextStyle(color: AppColors.textMid)),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final q = _questions[_index];
    return Scaffold(
      appBar: AppBar(title: Text('Question ${_index + 1} / ${_questions.length}')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (_index + 1) / _questions.length,
                color: scheme.primary,
                backgroundColor: AppColors.surfaceHighest,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 24),
            const Text('How do you say this in Kannada?', style: TextStyle(fontSize: 12, color: AppColors.textFaint, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(q.promptHindi, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textHigh)),
            const SizedBox(height: 24),
            for (var i = 0; i < q.options.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(14),
                      backgroundColor: _picked == null
                          ? AppColors.surfaceElevated
                          : (q.options[i] == q.correctRoman
                              ? AppColors.successSurface
                              : (_picked == i ? AppColors.dangerSurface : AppColors.surfaceElevated)),
                      side: const BorderSide(color: AppColors.outline),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () => _answer(i),
                    child: Text(q.options[i], style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  ),
                ),
              ),
            const Spacer(),
            if (_picked != null)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: _next,
                  child: Text(_index + 1 >= _questions.length ? 'See Results' : 'Next', style: const TextStyle(fontWeight: FontWeight.w900)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
