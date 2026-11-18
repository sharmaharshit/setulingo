import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'store.dart';
import 'widgets.dart';

class KNumberEntry {
  final int value;
  final String roman;
  final String hindi;
  const KNumberEntry(this.value, this.roman, this.hindi);
}

final List<KNumberEntry> kannadaNumbers = const [
  KNumberEntry(1, 'ondu', 'Ek'),
  KNumberEntry(2, 'eradu', 'Do'),
  KNumberEntry(3, 'muru', 'Teen'),
  KNumberEntry(4, 'nalku', 'Char'),
  KNumberEntry(5, 'aidu', 'Paanch'),
  KNumberEntry(6, 'aaru', 'Chhah'),
  KNumberEntry(7, 'elu', 'Saat'),
  KNumberEntry(8, 'entu', 'Aath'),
  KNumberEntry(9, 'ombattu', 'Nau'),
  KNumberEntry(10, 'hattu', 'Das'),
  KNumberEntry(11, 'hannondu', 'Gyaarah'),
  KNumberEntry(12, 'hanneradu', 'Baarah'),
  KNumberEntry(15, 'hadinaidu', 'Pandraah'),
  KNumberEntry(20, 'ippattu', 'Bees'),
  KNumberEntry(30, 'muvattu', 'Tees'),
  KNumberEntry(50, 'aivattu', 'Pachaas'),
  KNumberEntry(100, 'nooru', 'Sau'),
];

class NumbersPage extends StatelessWidget {
  const NumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numbers (Sankhye)')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.0),
        itemCount: kannadaNumbers.length,
        itemBuilder: (context, i) {
          final n = kannadaNumbers[i];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => TtsService.instance.speak(n.roman),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outline),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${n.value}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.marigold)),
                    const SizedBox(height: 2),
                    Text(n.roman, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                    Text(n.hindi, style: const TextStyle(fontSize: 11, color: AppColors.textFaint)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
