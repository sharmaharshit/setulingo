import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../data/lessons_data.dart';
import '../data/real_spaces_data.dart';
import '../models/lesson.dart';
import '../stores/app_state_store.dart';
import '../stores/user_auth_store.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/editorial_card.dart';
import 'lesson_page.dart';
import 'numbers_page.dart';
import 'real_spaces_page.dart';
import 'vault_quiz_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onOpenSentenceLab;
  final VoidCallback onOpenRealSpacesTab;

  const HomePage({
    super.key,
    required this.onOpenSentenceLab,
    required this.onOpenRealSpacesTab,
  });

  Lesson _nextLesson(AppStateStore appState) {
    for (final lesson in LessonsData.lessons) {
      if (!appState.isLessonCompleted(lesson.id)) {
        return lesson;
      }
    }
    return LessonsData.lessons.first;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<UserAuthStore>();
    final appState = context.watch<AppStateStore>();
    final vault = context.watch<VaultStore>();
    final textTheme = Theme.of(context).textTheme;

    final dailyScenario = RealSpacesData.todaysTwoMinuteScenario();
    final nextLesson = _nextLesson(appState);
    final totalScenarios = RealSpacesData.allScenarios.length;
    final completedScenarios = appState.completedScenarioCount;
    final progressRatio =
        totalScenarios == 0 ? 0.0 : completedScenarios / totalScenarios;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        // Editorial Greeting
        Text(
          'Namaskaara, ${auth.currentUser?.displayName.split(' ').first ?? 'Learner'}',
          style: textTheme.headlineMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'कन्नड़ बोलने की रोज़ाना की शुरुआत — बिना लिपि सीखे।',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 18),

        // DO NEXT — Primary Guided Action
        EditorialCard(
          backgroundColor: AppTheme.terracottaSoft,
          borderColor: AppTheme.terracotta.withValues(alpha: 0.35),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => LessonPage(lesson: nextLesson),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'DO NEXT · STEP-BY-STEP LESSON',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.7,
                      color: AppTheme.terracotta,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '~${nextLesson.estimatedMinutes} min',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.ink,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                nextLesson.title,
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                nextLesson.hindiSubtitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.terracotta,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                nextLesson.focusSummary,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.terracotta,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      appState.getLessonStepIndex(nextLesson.id) > 0
                          ? 'Continue Lesson'
                          : 'Start Lesson',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // TODAY'S 2-MINUTE SCENARIO
        EditorialCard(
          backgroundColor: AppTheme.sageSoft,
          borderColor: AppTheme.sage.withValues(alpha: 0.3),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ScenarioDetailPage(
                  scenario: dailyScenario,
                  isDailyScenario: true,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "TODAY'S 2-MINUTE SCENARIO",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                            color: AppTheme.sage,
                          ),
                        ),
                        if (appState.isDailyScenarioCompleted) ...[
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 15,
                            color: AppTheme.sage,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dailyScenario.title,
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      dailyScenario.hindiTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.sage,
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // PROGRESS OVERVIEW
        EditorialCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Progress Overview', style: textTheme.titleMedium),
                  Text(
                    '$completedScenarios / $totalScenarios scenarios',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.terracotta,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progressRatio,
                  minHeight: 7,
                  backgroundColor: AppTheme.surfaceSubtle,
                  valueColor: const AlwaysStoppedAnimation(AppTheme.terracotta),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lessons: ${appState.completedLessonCount}/${LessonsData.lessons.length}',
                    style: textTheme.bodyMedium,
                  ),
                  Text(
                    'Vault Phrases: ${vault.entries.length}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // CONTINUE LEARNING — Guided Lesson Strip
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Continue Learning', style: textTheme.titleLarge),
            Text(
              '${LessonsData.lessons.length} Lessons',
              style: const TextStyle(fontSize: 12, color: AppTheme.inkMuted),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 126,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: LessonsData.lessons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final lesson = LessonsData.lessons[index];
              final done = appState.isLessonCompleted(lesson.id);
              return SizedBox(
                width: 230,
                child: EditorialCard(
                  padding: const EdgeInsets.all(14),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => LessonPage(lesson: lesson),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'LESSON ${lesson.order}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.inkSubtle,
                            ),
                          ),
                          Icon(
                            done
                                ? Icons.check_circle_rounded
                                : Icons.arrow_forward_rounded,
                            size: 16,
                            color: done ? AppTheme.sage : AppTheme.terracotta,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        lesson.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        lesson.hindiSubtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.inkMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 22),

        // QUICK TOOLS: Sentence Lab, Kannada Numbers, Vault Quiz
        Text('Practice Tools', style: textTheme.titleLarge),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _QuickToolTile(
                title: 'Sentence Lab',
                subtitle: '81-word builder',
                icon: Icons.tune_rounded,
                accent: AppTheme.terracotta,
                onTap: onOpenSentenceLab,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickToolTile(
                title: 'Numbers',
                subtitle: '0–1000 & Auto',
                icon: Icons.pin_outlined,
                accent: AppTheme.indigo,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NumbersPage()),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickToolTile(
                title: 'Vault Quiz',
                subtitle: 'Test saved items',
                icon: Icons.quiz_outlined,
                accent: AppTheme.sage,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const VaultQuizPage()),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        // EIGHT REAL SPACES PREVIEW
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Eight Real Spaces', style: textTheme.titleLarge),
            TextButton(
              onPressed: onOpenRealSpacesTab,
              child: const Text('Explore All 8'),
            ),
          ],
        ),
        const SizedBox(height: 6),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: RealSpacesData.spaces.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.55,
          ),
          itemBuilder: (context, index) {
            final space = RealSpacesData.spaces[index];
            final doneCount = space.scenarios
                .where((s) => appState.isScenarioCompleted(s.id))
                .length;
            return EditorialCard(
              padding: const EdgeInsets.all(12),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SpaceDetailPage(space: space),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.badgeLabel.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: AppTheme.terracotta,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    space.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '$doneCount/${space.scenarios.length} completed',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.inkMuted,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _QuickToolTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  const _QuickToolTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return EditorialCard(
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: accent),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: AppTheme.inkMuted),
          ),
        ],
      ),
    );
  }
}
