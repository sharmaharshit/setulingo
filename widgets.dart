import 'package:flutter/material.dart';
import 'content.dart';
import '../main_v2.dart';
import 'store.dart';

/// Universal Devanagari ⇄ Roman script toggle, meant to be dropped into the
/// `actions` list of any primary screen's AppBar so it always sits top-right.
/// Purely functional — reuses the existing icon-button look already used on
/// LessonPage, so no new visual language is introduced.
class ScriptToggleAction extends StatelessWidget {
  const ScriptToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        return IconButton(
          icon: Icon(settings.isDevanagari ? Icons.translate : Icons.language),
          tooltip: settings.isDevanagari ? 'Roman script पर जाएँ' : 'देवनागरी में देखें',
          onPressed: () => settings.toggleMode(),
        );
      },
    );
  }
}

class BentoCategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const BentoCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final gami = GamificationStore.instance;
    return ListenableBuilder(
      listenable: gami,
      builder: (context, _) {
        final total = category.situations.length;
        final done = gami.completedCountFor(category);
        final complete = total > 0 && done == total;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.surfaceHighest, AppColors.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: complete ? AppColors.success.withValues(alpha: 0.5) : AppColors.outline,
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.marigold.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.marigold.withValues(alpha: 0.25)),
                        ),
                        alignment: Alignment.center,
                        child: Text(category.emoji, style: const TextStyle(fontSize: 22)),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: complete ? AppColors.success.withValues(alpha: 0.18) : AppColors.jacaranda.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (complete) const Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.check_circle, size: 11, color: AppColors.success)),
                            Text(
                              '$done/$total',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: complete ? AppColors.success : AppColors.jacaranda,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    category.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: -0.2, color: AppColors.textHigh),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    category.hindiTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textMid),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: total == 0 ? 0 : done / total,
                      minHeight: 4,
                      backgroundColor: AppColors.outlineSoft,
                      color: complete ? AppColors.success : AppColors.marigold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A row of tappable word chunks. Tapping a chunk saves it to the Vault —
/// used in sentence breakdowns, Street Encounter dialogue, and anywhere a
/// user should be able to pull an individual word out of a phrase.
class SaveableChunkRow extends StatelessWidget {
  final List<Chunk> chunks;
  final String source;

  const SaveableChunkRow({super.key, required this.chunks, required this.source});

  @override
  Widget build(BuildContext context) {
    final wordsStore = MyWordsStore.instance;
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([wordsStore, settings]),
      builder: (context, _) {
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: chunks.map((c) {
            final id = '${c.roman}_${source.hashCode}';
            final saved = wordsStore.contains(id);
            final label = settings.isDevanagari ? c.deva : c.roman;
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                if (saved) return;
                wordsStore.addWord(SavedWord(
                  id: id,
                  roman: c.roman,
                  deva: c.deva,
                  hindi: c.hindi,
                  source: source,
                  createdAt: DateTime.now(),
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"${c.roman}" Vault में सहेजा गया')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: saved ? AppColors.marigold.withValues(alpha: 0.14) : AppColors.surfaceHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: saved ? AppColors.marigold.withValues(alpha: 0.5) : AppColors.outline),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$label = ${c.hindi}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textHigh)),
                    const SizedBox(width: 4),
                    Icon(saved ? Icons.bookmark : Icons.bookmark_add_outlined, size: 14, color: saved ? AppColors.marigold : AppColors.textFaint),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

/// The self-confirm "practice speaking" card: shows a phrase, lets the user
/// hear it via TTS, and asks them to confirm they said it out loud before
/// continuing — no speech recognition required.
class PracticeConfirmCard extends StatelessWidget {
  final String roman;
  final String deva;
  final String hindi;
  final VoidCallback onConfirmed;
  final List<Chunk>? chunks;
  final String? chunkSource;

  const PracticeConfirmCard({
    super.key,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.onConfirmed,
    this.chunks,
    this.chunkSource,
  });

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final primary = settings.isDevanagari ? deva : roman;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.jacaranda.withValues(alpha: 0.14), AppColors.surface],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.jacaranda.withValues(alpha: 0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('🎙 बोलकर अभ्यास करें', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 0.4, color: AppColors.jacaranda)),
              const SizedBox(height: 10),
              Text(hindi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textMid)),
              const SizedBox(height: 6),
              Text(primary, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textHigh, letterSpacing: -0.3)),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton.filledTonal(
                    icon: const Icon(Icons.volume_up),
                    onPressed: () => TtsService.instance.speak(roman),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('सुनिए और ज़ोर से बोलिए', style: TextStyle(fontSize: 12, color: AppColors.textFaint)),
                  ),
                ],
              ),
              if (chunks != null && chunks!.isNotEmpty) ...[
                const SizedBox(height: 14),
                Text('शब्द सहेजिए:', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textFaint)),
                const SizedBox(height: 6),
                SaveableChunkRow(chunks: chunks!, source: chunkSource ?? primary),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: AppColors.marigold, foregroundColor: const Color(0xFF2B1B02)),
                  onPressed: onConfirmed,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('✅ मैंने बोल लिया — आगे बढ़ें', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SentenceCard extends StatefulWidget {
  final KSentence sentence;

  const SentenceCard({super.key, required this.sentence});

  @override
  State<SentenceCard> createState() => _SentenceCardState();
}

class _SentenceCardState extends State<SentenceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final store = MySentencesStore.instance;
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([store, settings]),
      builder: (context, _) {
        final s = widget.sentence;
        final isSaved = store.contains(s.id);
        final primary = settings.isDevanagari ? s.deva : s.roman;
        final secondary = settings.isDevanagari ? s.roman : s.deva;

        return Card(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            primary,
                            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.3, color: AppColors.textHigh),
                          ),
                          const SizedBox(height: 2),
                          Text(secondary, style: const TextStyle(fontSize: 13, color: AppColors.textMid)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined, size: 21),
                      tooltip: 'उच्चारण सुनें',
                      onPressed: () => TtsService.instance.speak(s.roman),
                    ),
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? AppColors.marigold : null,
                        size: 21,
                      ),
                      tooltip: isSaved ? 'सहेजा गया' : 'Vault में सहेजें',
                      onPressed: () {
                        if (isSaved) {
                          store.removeSentence(s.id);
                        } else {
                          store.addSentence(
                            SavedSentence(id: s.id, roman: s.roman, deva: s.deva, hindi: s.hindi, createdAt: DateTime.now()),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(s.hindi, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.marigold)),
                if (s.streetCode != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.marigoldDeep,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.marigold.withValues(alpha: 0.35)),
                    ),
                    child: Text(s.streetCode!, style: const TextStyle(fontSize: 11, color: AppColors.marigold, fontWeight: FontWeight.w600)),
                  ),
                ],
                const SizedBox(height: 8),
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => setState(() => _expanded = !_expanded),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _expanded ? 'टुकड़े छिपाएँ' : 'टुकड़े देखें (Breakdown)',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMid),
                        ),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          child: const Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textMid),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeInOutCubic,
                  child: _expanded
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SaveableChunkRow(chunks: s.chunks, source: s.id),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
