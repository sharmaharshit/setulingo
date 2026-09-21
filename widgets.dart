import 'package:flutter/material.dart';

import 'content.dart';
import 'store.dart';

/// A word shown in full, with an "Add to My Words" button.
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

        return SizedBox(
          width: double.infinity,
          child: Card(
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
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Text(
                        word.script,
                        style: const TextStyle(fontSize: 26),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    word.deva,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const Divider(height: 24),
                  Text(
                    word.hindi,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (word.note != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      word.note!,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  if (saved)
                    OutlinedButton.icon(
                      onPressed: () => store.remove(word.id),
                      icon: const Icon(Icons.check),
                      label: const Text('My Words में है'),
                    )
                  else
                    FilledButton.icon(
                      onPressed: () => store.add(word.id),
                      icon: const Icon(Icons.add),
                      label: const Text('Add to My Words'),
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
