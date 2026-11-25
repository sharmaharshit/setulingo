import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reading_mode.dart';
import '../stores/app_state_store.dart';
import '../theme/app_theme.dart';

/// Persistent global reader-mode pill accessible across the entire application.
class ReaderModePill extends StatelessWidget {
  const ReaderModePill({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStateStore>();
    final current = store.readerMode;

    return PopupMenuButton<ReaderMode>(
      tooltip: 'Switch Global Reading Mode',
      initialValue: current,
      onSelected: (mode) => store.setReaderMode(mode),
      itemBuilder: (context) => ReaderMode.values.map((mode) {
        final selected = mode == current;
        return PopupMenuItem<ReaderMode>(
          value: mode,
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 18,
                color: selected ? AppTheme.terracotta : AppTheme.inkMuted,
              ),
              const SizedBox(width: 10),
              Text(
                mode.label,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: AppTheme.ink,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.borderStrong),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.translate_rounded,
              size: 15,
              color: AppTheme.terracotta,
            ),
            const SizedBox(width: 5),
            Text(
              current.shortLabel,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.ink,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppTheme.inkMuted,
            ),
          ],
        ),
      ),
    );
  }
}
