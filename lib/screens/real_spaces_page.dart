import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../data/real_spaces_data.dart';
import '../models/real_space.dart';
import '../models/vault_entry.dart';
import '../stores/app_state_store.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/reader_mode_pill.dart';
import '../widgets/tri_script_view.dart';

class RealSpacesPage extends StatelessWidget {
  const RealSpacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateStore>();

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      itemCount: RealSpacesData.spaces.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Real Spaces',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '8 everyday contexts · 40 practical spoken scenarios',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
            ],
          );
        }

        final space = RealSpacesData.spaces[index - 1];
        final doneCount = space.scenarios
            .where((s) => appState.isScenarioCompleted(s.id))
            .length;
        final accent = _accentForStyle(space.layoutStyle);

        return EditorialCard(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => SpaceDetailPage(space: space),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_iconForStyle(space.layoutStyle), color: accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          space.badgeLabel.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: accent,
                          ),
                        ),
                        Text(
                          '$doneCount / ${space.scenarios.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.inkMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      space.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      space.hindiSubtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.inkMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      space.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Color _accentForStyle(SpaceLayoutStyle style) {
  switch (style) {
    case SpaceLayoutStyle.counterService:
      return AppTheme.terracotta;
    case SpaceLayoutStyle.transitRoute:
      return AppTheme.indigo;
    case SpaceLayoutStyle.marketStall:
      return AppTheme.ochre;
    case SpaceLayoutStyle.officeDesk:
      return AppTheme.sage;
    case SpaceLayoutStyle.neighbourhoodDoor:
      return AppTheme.terracotta;
    case SpaceLayoutStyle.clinicTriage:
      return AppTheme.danger;
    case SpaceLayoutStyle.socialCircle:
      return AppTheme.sage;
    case SpaceLayoutStyle.problemResolver:
      return AppTheme.indigo;
  }
}

IconData _iconForStyle(SpaceLayoutStyle style) {
  switch (style) {
    case SpaceLayoutStyle.counterService:
      return Icons.restaurant_menu_rounded;
    case SpaceLayoutStyle.transitRoute:
      return Icons.directions_transit_rounded;
    case SpaceLayoutStyle.marketStall:
      return Icons.storefront_rounded;
    case SpaceLayoutStyle.officeDesk:
      return Icons.work_outline_rounded;
    case SpaceLayoutStyle.neighbourhoodDoor:
      return Icons.home_outlined;
    case SpaceLayoutStyle.clinicTriage:
      return Icons.local_hospital_outlined;
    case SpaceLayoutStyle.socialCircle:
      return Icons.forum_outlined;
    case SpaceLayoutStyle.problemResolver:
      return Icons.support_agent_rounded;
  }
}

class SpaceDetailPage extends StatelessWidget {
  final RealSpace space;

  const SpaceDetailPage({super.key, required this.space});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateStore>();
    final accent = _accentForStyle(space.layoutStyle);

    return Scaffold(
      appBar: AppBar(
        title: Text(space.title),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Contextual Flow Header tailored to SpaceLayoutStyle
          EditorialCard(
            backgroundColor: accent.withValues(alpha: 0.08),
            borderColor: accent.withValues(alpha: 0.25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _flowLabelForStyle(space.layoutStyle),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  space.hindiSubtitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(space.description,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Distinct scenario presentation depending on SpaceLayoutStyle
          if (space.layoutStyle == SpaceLayoutStyle.transitRoute)
            ..._buildRouteTimeline(context, appState, accent)
          else if (space.layoutStyle == SpaceLayoutStyle.clinicTriage)
            ..._buildUrgencyCards(context, appState, accent)
          else
            ..._buildStandardEditorialCards(context, appState, accent),
        ],
      ),
    );
  }

  String _flowLabelForStyle(SpaceLayoutStyle style) {
    switch (style) {
      case SpaceLayoutStyle.counterService:
        return 'COUNTER & TABLE FLOW';
      case SpaceLayoutStyle.transitRoute:
        return 'ROUTE & STOP TIMELINE';
      case SpaceLayoutStyle.marketStall:
        return 'STALL & BARGAINING FLOW';
      case SpaceLayoutStyle.officeDesk:
        return 'WORKPLACE INTERACTION FLOW';
      case SpaceLayoutStyle.neighbourhoodDoor:
        return 'DOORSTEP & SOCIETY FLOW';
      case SpaceLayoutStyle.clinicTriage:
        return 'CARE & URGENCY TRIAGE';
      case SpaceLayoutStyle.socialCircle:
        return 'WARM CONVERSATION FLOW';
      case SpaceLayoutStyle.problemResolver:
        return 'CALM PROBLEM RESOLUTION';
    }
  }

  List<Widget> _buildRouteTimeline(
    BuildContext context,
    AppStateStore appState,
    Color accent,
  ) {
    return List.generate(space.scenarios.length, (i) {
      final scenario = space.scenarios[i];
      final done = appState.isScenarioCompleted(scenario.id);
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: done ? AppTheme.sage : accent,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (i < space.scenarios.length - 1)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppTheme.borderStrong,
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _ScenarioCard(
                  scenario: scenario,
                  isCompleted: done,
                  accent: accent,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildUrgencyCards(
    BuildContext context,
    AppStateStore appState,
    Color accent,
  ) {
    return space.scenarios.map((scenario) {
      final done = appState.isScenarioCompleted(scenario.id);
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _ScenarioCard(
          scenario: scenario,
          isCompleted: done,
          accent: accent,
          leadingTag: 'CARE SCENARIO',
        ),
      );
    }).toList();
  }

  List<Widget> _buildStandardEditorialCards(
    BuildContext context,
    AppStateStore appState,
    Color accent,
  ) {
    return List.generate(space.scenarios.length, (i) {
      final scenario = space.scenarios[i];
      final done = appState.isScenarioCompleted(scenario.id);
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _ScenarioCard(
          scenario: scenario,
          isCompleted: done,
          accent: accent,
          leadingTag: 'SCENARIO 0${i + 1}',
        ),
      );
    });
  }
}

class _ScenarioCard extends StatelessWidget {
  final Scenario scenario;
  final bool isCompleted;
  final Color accent;
  final String? leadingTag;

  const _ScenarioCard({
    required this.scenario,
    required this.isCompleted,
    required this.accent,
    this.leadingTag,
  });

  @override
  Widget build(BuildContext context) {
    return EditorialCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ScenarioDetailPage(scenario: scenario),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (leadingTag != null)
                Text(
                  leadingTag!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: accent,
                  ),
                )
              else
                const SizedBox.shrink(),
              Row(
                children: [
                  Text(
                    '${scenario.phrases.length} phrases',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.inkSubtle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isCompleted
                        ? Icons.check_circle_rounded
                        : Icons.arrow_forward_ios_rounded,
                    size: isCompleted ? 18 : 14,
                    color: isCompleted ? AppTheme.sage : AppTheme.inkMuted,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(scenario.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 2),
          Text(
            scenario.hindiTitle,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.inkMuted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            scenario.learningObjective,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class ScenarioDetailPage extends StatelessWidget {
  final Scenario scenario;
  final bool isDailyScenario;

  const ScenarioDetailPage({
    super.key,
    required this.scenario,
    this.isDailyScenario = false,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppStateStore>();
    final vault = context.watch<VaultStore>();
    final completed = appState.isScenarioCompleted(scenario.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(scenario.title),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          EditorialCard(
            backgroundColor: AppTheme.surfaceSubtle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scenario.hindiTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.terracotta,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  scenario.situationalContext,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Objective: ${scenario.learningObjective}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.sage,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text('SPOKEN PHRASES', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 10),
          ...scenario.phrases.map((phrase) {
            final isSaved = vault.isSaved(phrase.text);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: EditorialCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceSubtle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            phrase.speakerRole,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.inkMuted,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: isSaved ? 'Saved in Vault' : 'Save to Vault',
                          icon: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isSaved
                                ? AppTheme.terracotta
                                : AppTheme.inkMuted,
                          ),
                          onPressed: () async {
                            final saved = await vault.saveEntry(
                              text: phrase.text,
                              sourceType: VaultSourceType.realSpace,
                              sourceTitle: scenario.title,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    saved
                                        ? 'Saved phrase to your Vault.'
                                        : 'Already in your Vault.',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TriScriptView(text: phrase.text, primaryFontSize: 19),
                    const SizedBox(height: 12),
                    AudioPlayButton(itemId: phrase.id, text: phrase.text),
                    if (phrase.chunks.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 8),
                      ...phrase.chunks.map(
                        (chunk) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${chunk.text.romanHindi} (${chunk.text.devanagari}): ',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.ink,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  chunk.roleNote,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.inkMuted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 8),
          Text('PRACTICAL VOCABULARY',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: scenario.vocabulary.map((vocab) {
              return SizedBox(
                width: 170,
                child: EditorialCard(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vocab.partOfSpeech.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.inkSubtle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TriScriptView(
                        text: vocab.text,
                        primaryFontSize: 15,
                        secondaryFontSize: 12,
                        compact: true,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          Text('REAL-WORLD TIPS',
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          EditorialCard(
            backgroundColor: AppTheme.ochreSoft,
            borderColor: AppTheme.ochre.withValues(alpha: 0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: scenario.usageTips
                  .map(
                    (tip) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          Expanded(
                            child: Text(tip,
                                style: const TextStyle(
                                    fontSize: 13, height: 1.4)),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 22),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  completed ? AppTheme.sage : AppTheme.terracotta,
            ),
            onPressed: () async {
              if (isDailyScenario) {
                await appState.markDailyScenarioCompleted(scenario.id);
              } else {
                await appState.toggleScenarioCompleted(scenario.id);
              }
            },
            icon: Icon(
              completed
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_rounded,
            ),
            label: Text(
              completed ? 'Scenario Completed' : 'Mark Scenario Complete',
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
