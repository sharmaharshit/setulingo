import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/lessons_data.dart';
import '../data/real_spaces_data.dart';
import '../models/reading_mode.dart';
import '../services/audio_service.dart';
import '../stores/app_state_store.dart';
import '../stores/user_auth_store.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/editorial_card.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<UserAuthStore>();
    final appState = context.watch<AppStateStore>();
    final vault = context.watch<VaultStore>();
    final audio = context.watch<AudioService>();
    final user = auth.currentUser;
    final audioPrefs = appState.audioPreferences;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Preferences'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // User Info Card
          EditorialCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppTheme.terracottaSoft,
                      child: Text(
                        (user?.displayName.isNotEmpty ?? false)
                            ? user!.displayName[0].toUpperCase()
                            : 'S',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.terracotta,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? 'Learner',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            auth.authMode.displayLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.indigo,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Divider(),
                const SizedBox(height: 12),
                if (user?.email.isNotEmpty ?? false)
                  _InfoRow(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    value: user!.email,
                  ),
                if (user?.phoneNumber.isNotEmpty ?? false) ...[
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: user!.phoneNumber,
                  ),
                ],
                const SizedBox(height: 8),
                _InfoRow(
                  icon: Icons.badge_outlined,
                  label: 'Profile ID',
                  value: user?.userId ?? '-',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Progress Summary
          Text(
            'LEARNING PROGRESS',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          EditorialCard(
            child: Row(
              children: [
                Expanded(
                  child: _StatItem(
                    label: 'Scenarios',
                    value:
                        '${appState.completedScenarioCount}/${RealSpacesData.allScenarios.length}',
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Lessons',
                    value:
                        '${appState.completedLessonCount}/${LessonsData.lessons.length}',
                  ),
                ),
                Expanded(
                  child: _StatItem(
                    label: 'Vault Saved',
                    value: '${vault.entries.length}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Global Reading Mode
          Text(
            'GLOBAL READING MODE',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          EditorialCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Updates Devanagari and Roman Hindi pronunciation across every screen.',
                  style: TextStyle(fontSize: 13, color: AppTheme.inkMuted),
                ),
                const SizedBox(height: 12),
                ...ReaderMode.values.map((mode) {
                  return RadioListTile<ReaderMode>(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    activeColor: AppTheme.terracotta,
                    value: mode,
                    groupValue: appState.readerMode,
                    title: Text(
                      mode.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    onChanged: (val) {
                      if (val != null) appState.setReaderMode(val);
                    },
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Audio Preferences
          Text(
            'AUDIO & PRONUNCIATION',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          EditorialCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: audio.availability == AudioAvailability.kannadaReady
                        ? AppTheme.sageSoft
                        : audio.availability ==
                                AudioAvailability.fallbackHindiOrEnglish
                            ? AppTheme.ochreSoft
                            : AppTheme.dangerSoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        audio.availability == AudioAvailability.unavailable
                            ? Icons.volume_off_rounded
                            : Icons.graphic_eq_rounded,
                        size: 18,
                        color: AppTheme.ink,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          audio.statusMessage ??
                              'Checking device TTS voice availability...',
                          style: const TextStyle(fontSize: 12, height: 1.35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Speech Speed',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${audioPrefs.speechRate.toStringAsFixed(2)}x',
                      style: const TextStyle(color: AppTheme.inkMuted),
                    ),
                  ],
                ),
                Slider(
                  value: audioPrefs.speechRate.clamp(0.25, 0.8),
                  min: 0.25,
                  max: 0.8,
                  divisions: 11,
                  activeColor: AppTheme.terracotta,
                  onChanged: (v) {
                    final updated = audioPrefs.copyWith(speechRate: v);
                    appState.updateAudioPreferences(updated);
                    audio.updatePreferences(updated);
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppTheme.terracotta,
                  title: const Text(
                    'Auto-play phrase on lesson steps',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  value: audioPrefs.autoPlayOnLessonStep,
                  onChanged: (v) {
                    final updated =
                        audioPrefs.copyWith(autoPlayOnLessonStep: v);
                    appState.updateAudioPreferences(updated);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          OutlinedButton.icon(
            onPressed: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            icon: const Icon(Icons.logout_rounded, color: AppTheme.danger),
            label: const Text(
              'Sign Out',
              style: TextStyle(color: AppTheme.danger),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.inkMuted),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.inkMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.terracotta,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppTheme.inkMuted),
        ),
      ],
    );
  }
}
