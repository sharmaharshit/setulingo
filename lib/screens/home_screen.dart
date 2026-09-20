import 'package:flutter/material.dart';
import '../data/app_database.dart';
import 'session_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = AppDatabase.instance;
  List<Map<String, dynamic>> _days = [];
  Map<String, dynamic> _state = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final days = await db.days();
    final state = await db.state();
    if (!mounted) return;
    setState(() {
      _days = days;
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final streak = _state['current_streak'] ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SetuLingo',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '🔥 $streak Din',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _days.length,
        itemBuilder: (context, index) {
          final day = _days[index];
          final unlocked = day['is_unlocked'] == 1;
          final completed = day['is_completed'] == 1;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Card(
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: unlocked
                    ? () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SessionScreen(
                              dayNumber: day['day_number'] as int,
                            ),
                          ),
                        );
                        _load();
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: completed
                            ? Colors.green
                            : unlocked
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                        foregroundColor:
                            unlocked || completed ? Colors.white : Colors.black45,
                        child: completed
                            ? const Icon(Icons.check)
                            : Text('${day['day_number']}'),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              day['title_en'] as String,
                              style: const TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              day['title_hi'] as String,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            if (completed)
                              Text(
                                '⭐ ${(day['accuracy_score'] as num).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(
                        unlocked ? Icons.chevron_right : Icons.lock,
                        color: unlocked ? null : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
