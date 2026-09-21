import 'package:flutter/material.dart';
import 'content.dart';
import 'store.dart';

/// A word shown with toggle to "My Words".
class WordCard extends StatelessWidget {
  final KWord word;

  const WordCard({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    final store = MyWordsStore.instance;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final saved = store.contains(word.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        word.roman,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    Text(
                      word.script,
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  word.deva,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 24),
                Text(
                  word.hindi,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (word.note != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '💡 ${word.note!}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                if (saved)
                  OutlinedButton.icon(
                    onPressed: () => store.remove(word.id),
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('My Words में है'),
                  )
                else
                  FilledButton.icon(
                    onPressed: () => store.add(word.id),
                    icon: const Icon(Icons.add, size: 18),
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

/// A sentence displayed with script, roman, deva, hindi, chunk breakdowns, and bookmark action.
class SentenceCard extends StatelessWidget {
  final KSentence sentence;

  const SentenceCard({super.key, required this.sentence});

  @override
  Widget build(BuildContext context) {
    final sentencesStore = MySentencesStore.instance;

    return ListenableBuilder(
      listenable: sentencesStore,
      builder: (context, _) {
        final isSaved = sentencesStore.contains(sentence.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(18),
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
                            sentence.roman,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            sentence.script,
                            style: TextStyle(
                              fontSize: 19,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: isSaved ? Theme.of(context).colorScheme.primary : null,
                      ),
                      tooltip: isSaved ? 'सहेजा गया' : 'My Sentences में सहेजें',
                      onPressed: () {
                        if (isSaved) {
                          sentencesStore.removeSentence(sentence.id);
                        } else {
                          sentencesStore.addSentence(
                            SavedSentence(
                              id: sentence.id,
                              roman: sentence.roman,
                              script: sentence.script,
                              hindi: sentence.hindi,
                              createdAt: DateTime.now(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  sentence.deva,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Divider(height: 22),
                Text(
                  sentence.hindi,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: sentence.chunks.map((c) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${c.roman} = ${c.hindi}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                ),
                if (sentence.note != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    '💡 ${sentence.note!}',
                    style: TextStyle(
                      fontSize: 13,
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
