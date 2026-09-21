import 'dart:convert';

import 'package:flutter/material.dart';

import '../data/app_database.dart';
import 'summary_screen.dart';

class SessionScreen extends StatefulWidget {
  final int dayNumber;

  const SessionScreen({
    super.key,
    required this.dayNumber,
  });

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  final db = AppDatabase.instance;

  List<Map<String, dynamic>> ex = [];
  int idx = 0;
  int correct = 0;
  bool answered = false;
  bool? lastCorrect;
  List<String> selected = [];

  Map<String, dynamic> get cur => ex[idx];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final x = await db.exercises(widget.dayNumber);

    if (mounted) {
      setState(() {
        ex = x;
      });
    }
  }

  void evaluate(bool ok) {
    if (answered) {
      return;
    }

    setState(() {
      answered = true;
      lastCorrect = ok;

      if (ok) {
        correct++;
      }
    });
  }

  void next() {
    if (idx + 1 >= ex.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SummaryScreen(
            dayNumber: widget.dayNumber,
            correct: correct,
            total: ex.length,
          ),
        ),
      );
    } else {
      setState(() {
        idx++;
        answered = false;
        lastCorrect = null;
        selected = <String>[];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ex.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final data =
        jsonDecode(cur['target_data_json']) as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 7,
          child: LinearProgressIndicator(
            value: (idx + 1) / ex.length,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step ${idx + 1} of ${ex.length}',
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              cur['prompt_hindi'],
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _widget(data),
            ),
            if (answered)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: lastCorrect == true
                      ? Colors.green.shade50
                      : Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastCorrect == true
                          ? 'बहुत बढ़िया!'
                          : 'एक बार फिर देखिए',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: lastCorrect == true
                            ? Colors.green.shade800
                            : Colors.orange.shade900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(cur['reveal_tip']),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: next,
                        child: Text(
                          idx + 1 == ex.length
                              ? 'समाप्त करें'
                              : 'आगे बढ़ें',
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

  Widget _widget(Map<String, dynamic> data) {
    switch (cur['exercise_type']) {
      case 'listen_select':
        return _options(
          (data['options'] as List).cast<String>(),
          data['correct_answer'],
        );

      case 'cloze_selection':
        return Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  data['sentence_display'],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _options(
              (data['options'] as List).cast<String>(),
              data['correct_answer'],
            ),
          ],
        );

      case 'dialogue_branch':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  data['prompt_speaker'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _options(
              (data['options'] as List).cast<String>(),
              data['correct_answer'],
            ),
          ],
        );

      case 'sov_tile_arrange':
        final tiles = (data['tiles'] as List).cast<String>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selected
                    .map(
                      (s) => InputChip(
                        label: Text(s),
                        onDeleted: answered
                            ? null
                            : () {
                                setState(() {
                                  selected.remove(s);
                                });
                              },
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: tiles
                  .map(
                    (s) => ActionChip(
                      label: Text(s),
                      onPressed: answered || selected.contains(s)
                          ? null
                          : () {
                              final nextSelection = [
                                ...selected,
                                s,
                              ];

                              setState(() {
                                selected = nextSelection;
                              });

                              if (nextSelection.length ==
                                  (data['correct_sequence'] as List)
                                      .length) {
                                evaluate(
                                  _listEq(
                                    nextSelection,
                                    (data['correct_sequence'] as List)
                                        .cast<String>(),
                                  ),
                                );
                              }
                            },
                    ),
                  )
                  .toList(),
            ),
          ],
        );

      default:
        return const SizedBox();
    }
  }

  bool _listEq(
    List<String> a,
    List<String> b,
  ) {
    return a.length == b.length &&
        List.generate(
          a.length,
          (i) => a[i] == b[i],
        ).every((x) => x);
  }

  Widget _options(
    List<String> opts,
    String answer,
  ) {
    return Column(
      children: opts
          .map(
            (o) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: answered
                      ? null
                      : () => evaluate(o == answer),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      o,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
