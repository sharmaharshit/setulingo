import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/reading_mode.dart';
import '../services/audio_service.dart';
import '../theme/app_theme.dart';

class AudioPlayButton extends StatelessWidget {
  final String itemId;
  final TriScriptText text;
  final bool compact;

  const AudioPlayButton({
    super.key,
    required this.itemId,
    required this.text,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final audio = context.watch<AudioService>();
    final isPlayingThis = audio.isPlayingItem(itemId);
    final isUnavailable = audio.availability == AudioAvailability.unavailable;

    return Tooltip(
      message: isUnavailable
          ? (audio.statusMessage ?? 'Audio unavailable on this device')
          : (isPlayingThis ? 'Stop pronunciation' : 'Listen to pronunciation'),
      child: InkWell(
        onTap: () async {
          final started = await audio.speak(itemId: itemId, text: text);
          if (!started &&
              context.mounted &&
              audio.status == AudioPlaybackStatus.unavailableError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  audio.statusMessage ??
                      'Audio unavailable on this device.',
                ),
                backgroundColor: AppTheme.ink,
                behavior: SnackBarBehavior.floating,
              ),
            );
            audio.clearError();
          }
        },
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 10 : 12,
            vertical: compact ? 6 : 8,
          ),
          decoration: BoxDecoration(
            color: isUnavailable
                ? AppTheme.surfaceSubtle
                : isPlayingThis
                    ? AppTheme.terracotta
                    : AppTheme.terracottaSoft,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isUnavailable
                  ? AppTheme.border
                  : isPlayingThis
                      ? AppTheme.terracotta
                      : AppTheme.terracotta.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isUnavailable
                    ? Icons.volume_off_rounded
                    : isPlayingThis
                        ? Icons.stop_rounded
                        : Icons.volume_up_rounded,
                size: compact ? 16 : 18,
                color: isUnavailable
                    ? AppTheme.inkSubtle
                    : isPlayingThis
                        ? Colors.white
                        : AppTheme.terracotta,
              ),
              if (!compact) ...[
                const SizedBox(width: 6),
                Text(
                  isUnavailable
                      ? 'No Audio'
                      : isPlayingThis
                          ? 'Stop'
                          : 'Listen',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isUnavailable
                        ? AppTheme.inkSubtle
                        : isPlayingThis
                            ? Colors.white
                            : AppTheme.terracotta,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
