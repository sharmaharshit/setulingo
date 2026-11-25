import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reading_mode.dart';
import '../stores/app_state_store.dart';
import '../theme/app_theme.dart';

/// Displays any [TriScriptText] respecting the global [ReaderMode] from [AppStateStore].
class TriScriptView extends StatelessWidget {
  final TriScriptText text;
  final double primaryFontSize;
  final double secondaryFontSize;
  final bool centerAlign;
  final bool compact;

  const TriScriptView({
    super.key,
    required this.text,
    this.primaryFontSize = 18,
    this.secondaryFontSize = 14,
    this.centerAlign = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<AppStateStore>().readerMode;
    final align = centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (mode == ReaderMode.both || mode == ReaderMode.devanagari)
          Text(
            text.devanagari,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: primaryFontSize,
              fontWeight: FontWeight.w700,
              color: AppTheme.ink,
              height: 1.3,
            ),
          ),
        if (mode == ReaderMode.both)
          SizedBox(height: compact ? 2 : 4),
        if (mode == ReaderMode.both || mode == ReaderMode.roman)
          Text(
            text.romanHindi,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: mode == ReaderMode.roman
                  ? primaryFontSize
                  : secondaryFontSize + 1,
              fontWeight: mode == ReaderMode.roman
                  ? FontWeight.w700
                  : FontWeight.w600,
              color: mode == ReaderMode.roman
                  ? AppTheme.ink
                  : AppTheme.terracotta,
              height: 1.3,
            ),
          ),
        SizedBox(height: compact ? 3 : 6),
        Text(
          text.hindi,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: secondaryFontSize,
            fontWeight: FontWeight.w500,
            color: AppTheme.inkMuted,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}
