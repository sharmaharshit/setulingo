import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/lesson.dart';
import '../models/reading_mode.dart';
import '../services/audio_service.dart';
import '../stores/app_state_store.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/reader_mode_pill.dart';
import '../widgets/tri_script_view.dart';

class LessonPage extends StatefulWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  late int _stepIndex;
  bool _isCompletedView = false;

  // SpeakPracticeStep state
  bool _spokenConfirmed = false;

  // BuildStep state
  final List<int> _selectedTileIndices = [];
  bool _buildChecked = false;
  bool _buildCorrect = false;

  // UseStep state
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppStateStore>();
    final savedIndex = appState.getLessonStepIndex(widget.lesson.id);
    _stepIndex = savedIndex.clamp(0, widget.lesson.steps.length - 1);
    _maybeAutoPlay();
  }

  void _maybeAutoPlay() {
    final appState = context.read<AppStateStore>();
    if (!appState.audioPreferences.autoPlayOnLessonStep) return;
    final step = widget.lesson.steps[_stepIndex];
    TriScriptText? text;
    if (step is PhraseStep) text = step.phrase;
    if (step is SpeakPracticeStep) text = step.phrase;
    if (text != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<AudioService>().speak(itemId: step.id, text: text!);
        }
      });
    }
  }

  void _resetStepLocalState() {
    _spokenConfirmed = false;
    _selectedTileIndices.clear();
    _buildChecked = false;
    _buildCorrect = false;
    _selectedOptionIndex = null;
  }

  Future<void> _goNext() async {
    final appState = context.read<AppStateStore>();
    if (_stepIndex < widget.lesson.steps.length - 1) {
      setState(() {
        _stepIndex++;
        _resetStepLocalState();
      });
      await appState.saveLessonStep(widget.lesson.id, _stepIndex);
      _maybeAutoPlay();
    } else {
      await appState.markLessonCompleted(widget.lesson.id);
      await appState.saveLessonStep(widget.lesson.id, 0);
      if (mounted) {
        setState(() {
          _isCompletedView = true;
        });
      }
    }
  }

  Future<void> _restartLesson() async {
    await context.read<AppStateStore>().resetLessonProgress(widget.lesson.id);
    if (mounted) {
      setState(() {
        _stepIndex = 0;
        _isCompletedView = false;
        _resetStepLocalState();
      });
      _maybeAutoPlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.lesson.steps;
    final currentStep = steps[_stepIndex];
    final progress = (_stepIndex + 1) / steps.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.title),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: SafeArea(
        child: _isCompletedView
            ? _buildCompletionView(context)
            : Column(
                children: [
                  // Step progress indicator
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'STEP ${_stepIndex + 1} OF ${steps.length}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              _stepTypeLabel(currentStep),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.terracotta,
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
                            valueColor: const AlwaysStoppedAnimation(
                              AppTheme.terracotta,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: SingleChildScrollView(
                        key: ValueKey(currentStep.id),
                        padding: const EdgeInsets.all(20),
                        child: _buildStepBody(context, currentStep),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Row(
                      children: [
                        if (_stepIndex > 0) ...[
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _stepIndex--;
                                _resetStepLocalState();
                              });
                            },
                            child: const Text('Back'),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _canProceed(currentStep) ? _goNext : null,
                            child: Text(
                              _stepIndex == steps.length - 1
                                  ? 'Complete Lesson'
                                  : 'Continue',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _stepTypeLabel(LessonStep step) {
    return switch (step) {
      PhraseStep() => 'PHRASE INTRO',
      SpeakPracticeStep() => 'SPEAK PRACTICE',
      BuildStep() => 'BUILD SENTENCE',
      UseStep() => 'REAL-LIFE USE',
    };
  }

  bool _canProceed(LessonStep step) {
    return switch (step) {
      PhraseStep() => true,
      SpeakPracticeStep() => _spokenConfirmed,
      BuildStep() => _buildChecked && _buildCorrect,
      UseStep() =>
        _selectedOptionIndex != null &&
            step.options[_selectedOptionIndex!].isCorrect,
    };
  }

  Widget _buildStepBody(BuildContext context, LessonStep step) {
    return switch (step) {
      PhraseStep() => _buildPhraseStep(context, step),
      SpeakPracticeStep() => _buildSpeakStep(context, step),
      BuildStep() => _buildBuildStep(context, step),
      UseStep() => _buildUseStep(context, step),
    };
  }

  Widget _buildPhraseStep(BuildContext context, PhraseStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.promptTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        EditorialCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TriScriptView(text: step.phrase, primaryFontSize: 22),
              const SizedBox(height: 14),
              AudioPlayButton(itemId: step.id, text: step.phrase),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'WORD-BY-WORD BREAKDOWN',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 8),
        ...step.chunks.map(
          (chunk) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: EditorialCard(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TriScriptView(
                      text: chunk.text,
                      primaryFontSize: 15,
                      secondaryFontSize: 12,
                      compact: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Text(
                      chunk.roleNote,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        EditorialCard(
          backgroundColor: AppTheme.ochreSoft,
          borderColor: AppTheme.ochre.withValues(alpha: 0.3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.lightbulb_outline_rounded,
                  size: 18, color: AppTheme.ochre),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  step.culturalNote,
                  style: const TextStyle(fontSize: 13, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakStep(BuildContext context, SpeakPracticeStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.promptTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        EditorialCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TriScriptView(text: step.phrase, primaryFontSize: 22),
              const SizedBox(height: 14),
              Row(
                children: [
                  AudioPlayButton(itemId: step.id, text: step.phrase),
                  const SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: () {
                      context
                          .read<AudioService>()
                          .speak(itemId: step.id, text: step.phrase);
                    },
                    icon: const Icon(Icons.replay_rounded, size: 16),
                    label: const Text('Repeat'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        EditorialCard(
          backgroundColor: AppTheme.surfaceSubtle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.focusSound,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.terracotta,
                ),
              ),
              const SizedBox(height: 6),
              Text(step.speakingGuidance,
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const SizedBox(height: 18),
        CheckboxListTile(
          value: _spokenConfirmed,
          activeColor: AppTheme.sage,
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'I have practiced saying this phrase aloud',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          onChanged: (val) {
            setState(() => _spokenConfirmed = val ?? false);
          },
        ),
      ],
    );
  }

  Widget _buildBuildStep(BuildContext context, BuildStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.promptTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          'Target meaning: "${step.targetHindiMeaning}"',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppTheme.terracotta,
          ),
        ),
        const SizedBox(height: 16),

        // Assembly Area
        EditorialCard(
          backgroundColor: AppTheme.surfaceSubtle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR SENTENCE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.inkSubtle,
                ),
              ),
              const SizedBox(height: 10),
              if (_selectedTileIndices.isEmpty)
                const Text(
                  'Tap word tiles below in the right Kannada order.',
                  style: TextStyle(color: AppTheme.inkMuted),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedTileIndices.map((idx) {
                    final tile = step.availableTiles[idx];
                    return InputChip(
                      label: Text('${tile.devanagari} (${tile.romanHindi})'),
                      onDeleted: _buildCorrect
                          ? null
                          : () {
                              setState(() {
                                _selectedTileIndices.remove(idx);
                                _buildChecked = false;
                              });
                            },
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Available Tiles
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(step.availableTiles.length, (i) {
            final used = _selectedTileIndices.contains(i);
            final tile = step.availableTiles[i];
            return ActionChip(
              backgroundColor:
                  used ? AppTheme.surfaceSubtle : AppTheme.surface,
              side: BorderSide(
                color: used ? AppTheme.border : AppTheme.borderStrong,
              ),
              label: TriScriptView(
                text: tile,
                primaryFontSize: 14,
                secondaryFontSize: 11,
                compact: true,
              ),
              onPressed: used || _buildCorrect
                  ? null
                  : () {
                      setState(() {
                        _selectedTileIndices.add(i);
                        _buildChecked = false;
                      });
                    },
            );
          }),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            ElevatedButton(
              onPressed: _selectedTileIndices.isEmpty
                  ? null
                  : () {
                      final isMatch = _selectedTileIndices.length ==
                              step.correctOrderIndices.length &&
                          List.generate(
                            _selectedTileIndices.length,
                            (i) =>
                                _selectedTileIndices[i] ==
                                step.correctOrderIndices[i],
                          ).every((e) => e);
                      setState(() {
                        _buildChecked = true;
                        _buildCorrect = isMatch;
                      });
                    },
              child: const Text('Check Answer'),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedTileIndices.clear();
                  _buildChecked = false;
                  _buildCorrect = false;
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
        if (_buildChecked) ...[
          const SizedBox(height: 14),
          EditorialCard(
            backgroundColor:
                _buildCorrect ? AppTheme.sageSoft : AppTheme.dangerSoft,
            borderColor: _buildCorrect ? AppTheme.sage : AppTheme.danger,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _buildCorrect
                      ? 'Correct Construction!'
                      : 'Not quite — try reordering or check the pattern:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: _buildCorrect ? AppTheme.sage : AppTheme.danger,
                  ),
                ),
                const SizedBox(height: 6),
                if (_buildCorrect) ...[
                  TriScriptView(text: step.expectedSentence, primaryFontSize: 16),
                  const SizedBox(height: 6),
                ],
                Text(step.explanation,
                    style: const TextStyle(fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUseStep(BuildContext context, UseStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(step.promptTitle, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 10),
        EditorialCard(
          backgroundColor: AppTheme.surfaceSubtle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step.situationDescription,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Text(
                step.question,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...List.generate(step.options.length, (i) {
          final opt = step.options[i];
          final selected = _selectedOptionIndex == i;
          Color? bg;
          Color? border;
          if (selected) {
            bg = opt.isCorrect ? AppTheme.sageSoft : AppTheme.dangerSoft;
            border = opt.isCorrect ? AppTheme.sage : AppTheme.danger;
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: EditorialCard(
              backgroundColor: bg,
              borderColor: border,
              onTap: () {
                setState(() => _selectedOptionIndex = i);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TriScriptView(text: opt.text, primaryFontSize: 16),
                  if (selected) ...[
                    const SizedBox(height: 8),
                    Text(
                      opt.feedback,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: opt.isCorrect ? AppTheme.sage : AppTheme.danger,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCompletionView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: AppTheme.sageSoft,
              child: Icon(Icons.check_rounded, size: 38, color: AppTheme.sage),
            ),
            const SizedBox(height: 18),
            Text(
              'Lesson Completed!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.lesson.title} (${widget.lesson.hindiSubtitle})',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: _restartLesson,
                  icon: const Icon(Icons.replay_rounded, size: 18),
                  label: const Text('Retry Lesson'),
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
