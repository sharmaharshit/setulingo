import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/real_spaces_data.dart';
import '../models/reading_mode.dart';
import '../models/vault_entry.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/editorial_card.dart';
import '../widgets/reader_mode_pill.dart';
import '../widgets/tri_script_view.dart';

class _QuizQuestion {
  final VaultEntry promptEntry;
  final List<TriScriptText> options;
  final int correctIndex;

  const _QuizQuestion({
    required this.promptEntry,
    required this.options,
    required this.correctIndex,
  });
}

class VaultQuizPage extends StatefulWidget {
  const VaultQuizPage({super.key});

  @override
  State<VaultQuizPage> createState() => _VaultQuizPageState();
}

class _VaultQuizPageState extends State<VaultQuizPage> {
  List<_QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _buildQuiz();
  }

  void _buildQuiz() {
    final vaultEntries = context.read<VaultStore>().entries;
    if (vaultEntries.isEmpty) {
      setState(() {
        _questions = [];
        _currentIndex = 0;
        _score = 0;
        _selectedOption = null;
        _finished = false;
      });
      return;
    }

    final rng = Random(42);
    final pool = <TriScriptText>[
      ...vaultEntries.map((e) => e.text),
      ...RealSpacesData.allScenarios
          .expand((s) => s.phrases)
          .map((p) => p.text),
    ];

    final shuffledEntries = List<VaultEntry>.from(vaultEntries)..shuffle(rng);
    final selectedEntries = shuffledEntries.take(8).toList();

    final built = <_QuizQuestion>[];
    for (final entry in selectedEntries) {
      final distractors = pool
          .where((t) => t != entry.text)
          .toSet()
          .toList()
        ..shuffle(rng);
      final choices = <TriScriptText>[
        entry.text,
        ...distractors.take(3),
      ]..shuffle(rng);
      built.add(
        _QuizQuestion(
          promptEntry: entry,
          options: choices,
          correctIndex: choices.indexOf(entry.text),
        ),
      );
    }

    setState(() {
      _questions = built;
      _currentIndex = 0;
      _score = 0;
      _selectedOption = null;
      _finished = false;
    });
  }

  void _selectOption(int index) {
    if (_selectedOption != null) return;
    final current = _questions[_currentIndex];
    setState(() {
      _selectedOption = index;
      if (index == current.correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
      });
    } else {
      setState(() => _finished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vault Quiz'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: SafeArea(
        child: _questions.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.quiz_outlined,
                          size: 46, color: AppTheme.inkSubtle),
                      const SizedBox(height: 12),
                      Text(
                        'Save at least 1 phrase in your Vault first',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Vault Quiz builds personalized questions from the phrases and sentences you save.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppTheme.inkMuted),
                      ),
                    ],
                  ),
                ),
              )
            : _finished
                ? _buildSummary(context)
                : _buildQuestionView(context),
      ),
    );
  }

  Widget _buildQuestionView(BuildContext context) {
    final q = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;
    final answered = _selectedOption != null;
    final isCorrect = _selectedOption == q.correctIndex;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'QUESTION ${_currentIndex + 1} OF ${_questions.length}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                'Score: $_score',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.sage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppTheme.surfaceSubtle,
              valueColor: const AlwaysStoppedAnimation(AppTheme.terracotta),
            ),
          ),
          const SizedBox(height: 20),
          EditorialCard(
            backgroundColor: AppTheme.surfaceSubtle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CHOOSE THE SPOKEN KANNADA FOR:',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: AppTheme.inkSubtle,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  q.promptEntry.text.hindi,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final opt = q.options[i];
                Color? bg;
                Color? border;
                if (answered) {
                  if (i == q.correctIndex) {
                    bg = AppTheme.sageSoft;
                    border = AppTheme.sage;
                  } else if (i == _selectedOption) {
                    bg = AppTheme.dangerSoft;
                    border = AppTheme.danger;
                  }
                }
                return EditorialCard(
                  backgroundColor: bg,
                  borderColor: border,
                  onTap: () => _selectOption(i),
                  child: TriScriptView(
                    text: TriScriptText(
                      hindi: answered ? opt.hindi : 'Tap to select',
                      devanagari: opt.devanagari,
                      romanHindi: opt.romanHindi,
                    ),
                    primaryFontSize: 16,
                    secondaryFontSize: 12,
                  ),
                );
              },
            ),
          ),
          if (answered) ...[
            EditorialCard(
              backgroundColor:
                  isCorrect ? AppTheme.sageSoft : AppTheme.dangerSoft,
              borderColor: isCorrect ? AppTheme.sage : AppTheme.danger,
              child: Text(
                isCorrect
                    ? 'Correct! "${q.promptEntry.text.romanHindi}" means "${q.promptEntry.text.hindi}".'
                    : 'The right match is "${q.promptEntry.text.romanHindi}" (${q.promptEntry.text.devanagari}).',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isCorrect ? AppTheme.sage : AppTheme.danger,
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _nextQuestion,
              child: Text(
                _currentIndex == _questions.length - 1
                    ? 'View Score'
                    : 'Next Question',
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_score / ${_questions.length}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: AppTheme.terracotta,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vault Quiz Complete',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: _buildQuiz,
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Retry Quiz'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Done'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
