import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/numbers_data.dart';
import '../models/kannada_number.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';
import '../widgets/editorial_card.dart';
import '../widgets/reader_mode_pill.dart';
import '../widgets/tri_script_view.dart';

class NumbersPage extends StatefulWidget {
  const NumbersPage({super.key});

  @override
  State<NumbersPage> createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> {
  NumberRange _selectedRange = NumberRange.zeroToTen;

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioService>();
    final filtered = NumbersData.numbers
        .where((n) => n.range == _selectedRange)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kannada Numbers'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: NumberRange.values.map((range) {
                  final selected = range == _selectedRange;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(range.label),
                      selected: selected,
                      selectedColor: AppTheme.terracottaSoft,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color:
                            selected ? AppTheme.terracotta : AppTheme.inkMuted,
                      ),
                      onSelected: (_) => setState(() => _selectedRange = range),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Tap any number tile to hear spoken pronunciation.',
              style: TextStyle(fontSize: 13, color: AppTheme.inkMuted),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              itemCount: filtered.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) {
                final item = filtered[index];
                final isPlaying = audio.isPlayingItem(item.id);
                return EditorialCard(
                  backgroundColor:
                      isPlaying ? AppTheme.terracottaSoft : AppTheme.surface,
                  borderColor:
                      isPlaying ? AppTheme.terracotta : AppTheme.border,
                  onTap: () async {
                    final ok = await audio.speak(
                      itemId: item.id,
                      text: item.text,
                    );
                    if (!ok &&
                        context.mounted &&
                        audio.status == AudioPlaybackStatus.unavailableError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            audio.statusMessage ??
                                'Audio unavailable on this device.',
                          ),
                        ),
                      );
                      audio.clearError();
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.displayDigit,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.terracotta,
                            ),
                          ),
                          Icon(
                            isPlaying
                                ? Icons.stop_circle_rounded
                                : Icons.volume_up_rounded,
                            size: 20,
                            color: isPlaying
                                ? AppTheme.terracotta
                                : AppTheme.inkMuted,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TriScriptView(
                        text: item.text,
                        primaryFontSize: 16,
                        secondaryFontSize: 12,
                        compact: true,
                      ),
                      const Spacer(),
                      Text(
                        item.usageHint,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.inkSubtle,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
