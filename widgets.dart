import 'package:flutter/material.dart';
import 'content.dart';
import 'store.dart';

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
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF161726), const Color(0xFF10111B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF26283C), width: 0.9),
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
                      color: const Color(0xFF1F2236),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    ),
                    alignment: Alignment.center,
                    child: Text(category.emoji, style: const TextStyle(fontSize: 22)),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${category.situations.length}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                category.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: -0.2),
              ),
              const SizedBox(height: 2),
              Text(
                category.hindiTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final KWord word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final store = MyWordsStore.instance;
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([store, settings]),
      builder: (context, _) {
        final saved = store.contains(word.id);
        final primary = settings.isDevanagari ? word.deva : word.roman;
        final secondary = settings.isDevanagari ? word.roman : word.deva;

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
                          Text(primary, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                          const SizedBox(height: 2),
                          Text(secondary, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined),
                      tooltip: 'उच्चारण सुनें',
                      onPressed: () => TtsService.instance.speak(word.roman),
                    ),
                  ],
                ),
                const Divider(height: 18, color: Color(0xFF222436)),
                Text(word.hindi, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                if (word.streetCode != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E281F),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF00E599).withValues(alpha: 0.3)),
                    ),
                    child: Text(word.streetCode!, style: const TextStyle(fontSize: 11, color: Color(0xFF00E599), fontWeight: FontWeight.w700)),
                  ),
                ],
                const SizedBox(height: 12),
                saved
                    ? OutlinedButton.icon(
                        onPressed: () => store.remove(word.id),
                        icon: const Icon(Icons.check, size: 15),
                        label: const Text('My Words में है'),
                      )
                    : FilledButton.icon(
                        onPressed: () => store.add(word.id),
                        icon: const Icon(Icons.add, size: 15),
                        label: const Text('Add to My Words'),
                      ),
              ],
            ),
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
            padding: const EdgeInsets.all(15),
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
                          Text(primary, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: -0.3)),
                          const SizedBox(height: 2),
                          Text(secondary, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined, size: 21),
                      tooltip: 'उच्चारण सुनें',
                      onPressed: () => TtsService.instance.speak(s.roman),
                    ),
                    IconButton(
                      icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? Theme.of(context).colorScheme.primary : null, size: 21),
                      tooltip: isSaved ? 'सहेजा गया' : 'My Sentences में सहेजें',
                      onPressed: () {
                        if (isSaved) {
                          store.removeSentence(s.id);
                        } else {
                          store.addSentence(
                            SavedSentence(
                              id: s.id,
                              roman: s.roman,
                              deva: s.deva,
                              hindi: s.hindi,
                              createdAt: DateTime.now(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(s.hindi, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.primary)),
                if (s.streetCode != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E281F),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF00E599).withValues(alpha: 0.3)),
                    ),
                    child: Text(s.streetCode!, style: const TextStyle(fontSize: 11, color: Color(0xFF00E599), fontWeight: FontWeight.w600)),
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
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 220),
                          child: Icon(Icons.keyboard_arrow_down, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
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
                          child: Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: s.chunks.map((c) {
                              final chunkText = settings.isDevanagari ? c.deva : c.roman;
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('$chunkText = ${c.hindi}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                              );
                            }).toList(),
                          ),
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

class RoleplayDialogueWidget extends StatelessWidget {
  final RoleplayDialogue dialogue;

  const RoleplayDialogueWidget({super.key, required this.dialogue});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          ),
          child: Text(
            '📍 परिस्थिति: ${dialogue.contextDescription}',
            style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 16),
        for (final turn in dialogue.turns) ...[
          Align(
            alignment: turn.isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: turn.isUser ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(turn.isUser ? 16 : 4),
                  bottomRight: Radius.circular(turn.isUser ? 4 : 16),
                ),
                border: Border.all(
                  color: turn.isUser ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.35) : Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        turn.speaker,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: turn.isUser ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => TtsService.instance.speak(turn.roman),
                        child: const Icon(Icons.volume_up_outlined, size: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(settings.isDevanagari ? turn.deva : turn.roman,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.2)),
                  const SizedBox(height: 2),
                  Text(turn.hindi, style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  if (turn.tip != null) ...[
                    const SizedBox(height: 6),
                    Text('💡 ${turn.tip!}', style: const TextStyle(fontSize: 11, color: Color(0xFFFFB74D))),
                  ],
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
