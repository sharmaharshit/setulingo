import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main_v2.dart';
import 'learning_path.dart';
import 'store.dart';

Future<void> _openUrl(BuildContext context, String url) async {
  try {
    final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  }
}

/// Small round icon-button used in a couple of primary AppBars to reach the
/// profile hub without adding a 5th bottom-nav tab (keeps the locked nav
/// bar untouched).
class ProfileEntryAction extends StatelessWidget {
  const ProfileEntryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_outline),
      tooltip: 'Profile & Settings',
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
    );
  }
}

// ---------------------------------------------------------------------------
// Profile Screen
// ---------------------------------------------------------------------------

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileStore = ProfileStore.instance;
    final scheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: profileStore,
      builder: (context, _) {
        final p = profileStore.profile;
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: scheme.primary.withValues(alpha: 0.16),
                      child: Text(
                        (p.legalName.isNotEmpty ? p.legalName[0] : '?').toUpperCase(),
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: scheme.primary),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      p.legalName.isNotEmpty ? p.legalName : 'Add your name',
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: AppColors.textHigh),
                    ),
                    if (p.premiumUnlocked) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(10)),
                        child: const Text('PREMIUM', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.black)),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionCard(
                title: 'Account Details',
                children: [
                  _fieldTile(
                    icon: Icons.badge_outlined,
                    label: 'Legal Name',
                    value: p.legalName.isEmpty ? 'Not set' : p.legalName,
                    onTap: () => _editTextDialog(
                      context,
                      title: 'Legal Name',
                      initial: p.legalName,
                      onSave: (v) => profileStore.updateDetails(legalName: v),
                    ),
                  ),
                  _fieldTile(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: p.email.isEmpty ? 'Not set' : p.email,
                    onTap: () => _editTextDialog(
                      context,
                      title: 'Email',
                      initial: p.email,
                      keyboardType: TextInputType.emailAddress,
                      onSave: (v) => profileStore.updateDetails(email: v),
                    ),
                  ),
                  _fieldTile(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: p.phone.isEmpty ? 'Link a phone number' : '${p.phone} ${p.phoneVerified ? '✓ Verified' : ''}',
                    onTap: () => _editTextDialog(
                      context,
                      title: 'Phone Number',
                      initial: p.phone,
                      keyboardType: TextInputType.phone,
                      onSave: (v) => profileStore.linkPhone(v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (!p.premiumUnlocked)
                _sectionCard(
                  title: null,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.workspace_premium, color: scheme.primary),
                      title: const Text('Unlock Features', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                      subtitle: const Text('All 30 days, offline audio pack, no limits', style: TextStyle(color: AppColors.textMid)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColors.surfaceElevated,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                        builder: (_) => const UnlockFeaturesModal(),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              _sectionCard(
                title: 'Manage',
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.tune, color: AppColors.textMid),
                    title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.route_outlined, color: AppColors.textMid),
                    title: const Text('My Learning Profile', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                    subtitle: const Text('Update your daily profile & focus areas', style: TextStyle(color: AppColors.textMid)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingWizardPage())),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.help_outline, color: AppColors.textMid),
                    title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen())),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionCard({required String? title, required List<Widget> children}) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if (i != children.length - 1) rows.add(const Divider(height: 1));
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 4),
              child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.6, color: AppColors.textFaint)),
            ),
          ...rows,
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _fieldTile({required IconData icon, required String label, required String value, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textMid),
      title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textFaint)),
      subtitle: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textHigh)),
      trailing: const Icon(Icons.edit_outlined, size: 18),
      onTap: onTap,
    );
  }

  void _editTextDialog(
    BuildContext context, {
    required String title,
    required String initial,
    required ValueChanged<String> onSave,
    TextInputType? keyboardType,
  }) {
    final controller = TextEditingController(text: initial);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: Text(title),
        content: TextField(controller: controller, keyboardType: keyboardType, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              onSave(controller.text.trim());
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

/// Simple local "upgrade" flow — no payment SDK wired in yet, so this just
/// flips the local premium flag. Swap [ProfileStore.unlockPremium] for a
/// real purchase call once billing is integrated.
class UnlockFeaturesModal extends StatelessWidget {
  const UnlockFeaturesModal({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.workspace_premium, color: scheme.primary, size: 36),
          const SizedBox(height: 12),
          const Text('Unlock All Features', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textHigh)),
          const SizedBox(height: 8),
          const _BenefitRow(text: 'All 30 days of lessons, unlocked at once'),
          const _BenefitRow(text: 'Downloadable offline audio pack'),
          const _BenefitRow(text: 'Unlimited Vault & Sentence Lab saves'),
          const _BenefitRow(text: 'Priority new-content updates'),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: () {
                ProfileStore.instance.unlockPremium();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Premium unlocked 🎉')));
              },
              child: const Text('Unlock Now', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Maybe later')),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;
  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 16, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: AppColors.textMid))),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Settings Screen
// ---------------------------------------------------------------------------

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    final prefs = AppPreferencesStore.instance;

    return ListenableBuilder(
      listenable: Listenable.merge([settings, prefs]),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _settingsSection('Display', [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Devanagari Script', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  subtitle: const Text('Show Kannada in देवनागरी instead of Roman', style: TextStyle(color: AppColors.textMid)),
                  value: settings.isDevanagari,
                  onChanged: (_) => settings.toggleMode(),
                ),
              ]),
              const SizedBox(height: 16),
              _settingsSection('Audio', [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Speech Rate', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  subtitle: Text('${prefs.speechRate.toStringAsFixed(2)}x — how fast TTS speaks Kannada', style: const TextStyle(color: AppColors.textMid)),
                ),
                Slider(
                  value: prefs.speechRate,
                  min: 0.2,
                  max: 0.8,
                  divisions: 12,
                  label: prefs.speechRate.toStringAsFixed(2),
                  onChanged: (v) => prefs.setSpeechRate(v),
                  onChangeEnd: (v) => TtsService.instance.speak('Namaskara'),
                ),
              ]),
              const SizedBox(height: 16),
              _settingsSection('Notifications', [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Daily Reminders', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  subtitle: const Text('Nudge me to practice every day', style: TextStyle(color: AppColors.textMid)),
                  value: prefs.notificationsEnabled,
                  onChanged: (v) => prefs.setNotificationsEnabled(v),
                ),
                if (prefs.notificationsEnabled)
                  for (final r in prefs.reminders)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.alarm, color: AppColors.textMid),
                      title: Text(r.label, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textHigh)),
                      subtitle: Text(r.time, style: const TextStyle(color: AppColors.textMid)),
                      trailing: Switch(value: r.enabled, onChanged: (v) => prefs.updateReminder(r.id, enabled: v)),
                      onTap: () => _pickTime(context, prefs, r),
                    ),
              ]),
              const SizedBox(height: 16),
              _settingsSection('Storage', [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Wi-Fi Only Downloads', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  subtitle: const Text('Only fetch audio packs over Wi-Fi', style: TextStyle(color: AppColors.textMid)),
                  value: prefs.wifiOnlyDownloads,
                  onChanged: (v) => prefs.setWifiOnlyDownloads(v),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.storage_outlined, color: AppColors.textMid),
                  title: const Text('App data', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  subtitle: const Text('Vault, saved sentences, and settings are stored on this device only', style: TextStyle(color: AppColors.textMid)),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickTime(BuildContext context, AppPreferencesStore prefs, ReminderSlot r) async {
    final parts = r.time.split(':');
    final initial = TimeOfDay(hour: int.tryParse(parts[0]) ?? 19, minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) {
      final hh = picked.hour.toString().padLeft(2, '0');
      final mm = picked.minute.toString().padLeft(2, '0');
      await prefs.updateReminder(r.id, time: '$hh:$mm');
    }
  }

  Widget _settingsSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 2),
            child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.6, color: AppColors.textFaint)),
          ),
          ...children,
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Help & Support Hub
// ---------------------------------------------------------------------------

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const _faqs = <(String, String)>[
    ('Does the app work offline?', 'Yes — once a day\'s lesson is opened, its text content works fully offline. Audio playback uses on-device TTS.'),
    ('How do I change script (Hindi/Roman)?', 'Tap the translate icon in any top bar, or go to Settings → Display.'),
    ('Where are my saved words and sentences?', 'Open the Vault tab from the bottom navigation.'),
    ('How do I reset my learning profile?', 'Go to Profile → My Learning Profile to redo the wizard.'),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(backgroundColor: scheme.primary, foregroundColor: Colors.black),
                  onPressed: () => _openUrl(context, 'https://play.google.com/store/apps/details?id=com.setulingo'),
                  icon: const Icon(Icons.star_rounded),
                  label: const Text('Rate App', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Join the community', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textFaint, letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _socialChip(context, Icons.chat, 'WhatsApp', const Color(0xFF25D366), 'https://wa.me/910000000000'),
              _socialChip(context, Icons.camera_alt_outlined, 'Instagram', const Color(0xFFE1306C), 'https://instagram.com/setulingo'),
              _socialChip(context, Icons.business_center_outlined, 'LinkedIn', const Color(0xFF0A66C2), 'https://linkedin.com/company/setulingo'),
              _socialChip(context, Icons.play_circle_outline, 'YouTube', const Color(0xFFFF0000), 'https://youtube.com/@setulingo'),
            ],
          ),
          const SizedBox(height: 24),
          _linkTile(context, Icons.privacy_tip_outlined, 'Privacy Policy', 'https://setulingo.example.com/privacy'),
          const Divider(height: 24, color: AppColors.outlineSoft),
          const Text('FAQ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: AppColors.textFaint, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          for (final (q, a) in _faqs)
            ExpansionTile(
              collapsedIconColor: AppColors.textMid,
              iconColor: scheme.primary,
              title: Text(q, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh, fontSize: 14)),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Text(a, style: const TextStyle(color: AppColors.textMid, fontSize: 13)),
                ),
              ],
            ),
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: () => _openUrl(context, 'mailto:support@setulingo.example.com'),
              icon: const Icon(Icons.mail_outline, size: 18),
              label: const Text('Email Support'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialChip(BuildContext context, IconData icon, String label, Color color, String url) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _openUrl(context, url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _linkTile(BuildContext context, IconData icon, String label, String url) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textMid),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh)),
      trailing: const Icon(Icons.open_in_new, size: 16),
      onTap: () => _openUrl(context, url),
    );
  }
}
