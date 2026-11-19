import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'store.dart';

/// Picks a handful of situations relevant to the user's saved daily profile
/// and friction points, for use as a "Recommended for you" rail. Falls back
/// to the first few categories if the user hasn't onboarded yet, so callers
/// never need to null-check.
List<KSituation> recommendedSituationsFor(LearningPathStore learningPath, {int limit = 6}) {
  final wantedCategoryIds = <String>{
    for (final fp in learningPath.frictionPoints) ...fp.relatedCategoryIds,
  };

  final matched = <KSituation>[];
  if (wantedCategoryIds.isNotEmpty) {
    for (final cat in categories) {
      if (wantedCategoryIds.contains(cat.id)) {
        matched.addAll(cat.situations);
      }
    }
  }
  if (matched.isEmpty) {
    // No selections yet (or nothing matched) — fall back to a safe default
    // spread across the first couple of categories.
    for (final cat in categories.take(3)) {
      matched.addAll(cat.situations.take(2));
    }
  }
  matched.shuffle(); // keeps the rail feeling "fresh" across app opens
  return matched.take(limit).toList();
}

/// Full-screen onboarding wizard: profile → friction points → done.
/// Presented modally the first time [LearningPathStore.isOnboarded] is
/// false, and reachable again from Settings ("Redo learning profile").
class OnboardingWizardPage extends StatefulWidget {
  const OnboardingWizardPage({super.key});

  @override
  State<OnboardingWizardPage> createState() => _OnboardingWizardPageState();
}

class _OnboardingWizardPageState extends State<OnboardingWizardPage> {
  int _step = 0;
  DailyProfile? _profile;
  final Set<FrictionPoint> _friction = {};

  void _finish() {
    if (_profile == null) return;
    LearningPathStore.instance.completeOnboarding(profile: _profile!, friction: _friction);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Learning Profile'),
        automaticallyImplyLeading: _step > 0,
        leading: _step > 0
            ? IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => setState(() => _step -= 1))
            : null,
        actions: [
          if (_step == 0)
            TextButton(
              onPressed: () {
                LearningPathStore.instance.completeOnboarding(profile: DailyProfile.itProfessional, friction: {});
                Navigator.of(context).pop();
              },
              child: const Text('Skip'),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (_step + 1) / 2,
                color: scheme.primary,
                backgroundColor: AppColors.surfaceHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 20),
              Expanded(child: _step == 0 ? _profileStep(scheme) : _frictionStep(scheme)),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: scheme.primary,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _step == 0
                      ? (_profile == null ? null : () => setState(() => _step = 1))
                      : _finish,
                  child: Text(
                    _step == 0 ? 'Continue' : 'Build My Learning Path',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileStep(ColorScheme scheme) {
    return ListView(
      children: [
        const Text(
          "What's your daily life like?",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
        ),
        const SizedBox(height: 6),
        const Text(
          'This helps us pick which conversations to teach you first.',
          style: TextStyle(fontSize: 13, color: AppColors.textMid),
        ),
        const SizedBox(height: 20),
        for (final p in DailyProfile.values) _choiceTile(
          selected: _profile == p,
          emoji: p.emoji,
          title: p.label,
          scheme: scheme,
          onTap: () => setState(() => _profile = p),
        ),
      ],
    );
  }

  Widget _frictionStep(ColorScheme scheme) {
    return ListView(
      children: [
        const Text(
          'Where do you get stuck most?',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
        ),
        const SizedBox(height: 6),
        const Text(
          'Pick as many as apply — we will surface these situations first.',
          style: TextStyle(fontSize: 13, color: AppColors.textMid),
        ),
        const SizedBox(height: 20),
        for (final f in FrictionPoint.values) _choiceTile(
          selected: _friction.contains(f),
          emoji: f.emoji,
          title: f.label,
          scheme: scheme,
          multiSelect: true,
          onTap: () => setState(() {
            if (_friction.contains(f)) {
              _friction.remove(f);
            } else {
              _friction.add(f);
            }
          }),
        ),
      ],
    );
  }

  Widget _choiceTile({
    required bool selected,
    required String emoji,
    required String title,
    required ColorScheme scheme,
    required VoidCallback onTap,
    bool multiSelect = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: selected ? scheme.primary.withValues(alpha: 0.12) : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: selected ? scheme.primary : AppColors.outline, width: selected ? 1.4 : 1.0),
            ),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                ),
                Icon(
                  selected
                      ? (multiSelect ? Icons.check_circle : Icons.radio_button_checked)
                      : (multiSelect ? Icons.circle_outlined : Icons.radio_button_off),
                  color: selected ? scheme.primary : AppColors.textFaint,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact "Recommended for you" rail, dropped into CommunicatePage below
/// the daily scenario card. Reuses the same card language as the rest of
/// the home screen (surfaceElevated container, marigold accents).
class RecommendedForYouSection extends StatelessWidget {
  final void Function(KSituation) onTapSituation;

  const RecommendedForYouSection({super.key, required this.onTapSituation});

  @override
  Widget build(BuildContext context) {
    final learningPath = LearningPathStore.instance;
    return ListenableBuilder(
      listenable: learningPath,
      builder: (context, _) {
        if (!learningPath.isOnboarded) return const SizedBox.shrink();
        final situations = recommendedSituationsFor(learningPath);
        if (situations.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Recommended for You',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.4, color: AppColors.textHigh),
                ),
                const Spacer(),
                if (learningPath.dailyProfile != null)
                  Text(
                    '${learningPath.dailyProfile!.emoji} ${learningPath.dailyProfile!.label}',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textFaint),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: situations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) {
                  final s = situations[i];
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => onTapSituation(s),
                      child: Container(
                        width: 190,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceElevated,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.outline),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              s.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textHigh),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s.hindiTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: AppColors.textMid),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
          ],
        );
      },
    );
  }
}
