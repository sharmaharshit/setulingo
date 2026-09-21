import 'package:flutter/material.dart';
import 'content.dart';
import 'store.dart';
import 'tts_service.dart';

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
        final primarySpoken = settings.isDevanagari ? word.deva : word.roman;
        final secondarySpoken = settings.isDevanagari ? word.roman : word.deva;

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
                            primarySpoken,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            secondarySpoken,
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
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
                const Divider(height: 18),
                Text(
                  word.hindi,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (word.note != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    '💡 ${word.note!}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                if (saved)
                  OutlinedButton.icon(
                    onPressed: () => store.remove(word.id),
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('My Words में है'),
                  )
                else
                  FilledButton.icon(
                    onPressed: () => store.add(word.id),
                    icon: const Icon(Icons.add, size: 16),
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
    final sentencesStore = MySentencesStore.instance;
    final settings = AppSettingsStore.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([sentencesStore, settings]),
      builder: (context, _) {
        final s = widget.sentence;
        final isSaved = sentencesStore.contains(s.id);
        final primarySpoken = settings.isDevanagari ? s.deva : s.roman;
        final secondarySpoken = settings.isDevanagari ? s.roman : s.deva;

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(14),
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
                            primarySpoken,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            secondarySpoken,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up_outlined, size: 22),
                      tooltip: 'उच्चारण सुनें',
                      onPressed: () => TtsService.instance.speak(s.roman),
                    ),
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? Theme.of(context).colorScheme.primary : null,
                        size: 22,
                      ),
                      tooltip: isSaved ? 'सहेजा गया' : 'My Sentences में सहेजें',
                      onPressed: () {
                        if (isSaved) {
                          sentencesStore.removeSentence(s.id);
                        } else {
                          sentencesStore.addSentence(
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
                Text(
                  s.hindi,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                // Compact expandable chunks
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
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Icon(
                          _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_expanded) ...[
                  const SizedBox(height: 8),
                  Wrap(
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
                        child: Text(
                          '$chunkText = ${c.hindi}',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      );
                    }).toList(),
                  ),
                ],
                if (s.note != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    '💡 ${s.note!}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
