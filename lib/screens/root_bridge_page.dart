import 'package:flutter/material.dart';

import '../data/root_bridge_data.dart';
import '../models/root_bridge.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/tri_script_view.dart';

class RootBridgePage extends StatefulWidget {
  const RootBridgePage({super.key});

  @override
  State<RootBridgePage> createState() => _RootBridgePageState();
}

class _RootBridgePageState extends State<RootBridgePage> {
  ConnectionType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final items = _selectedFilter == null
        ? RootBridgeData.connections
        : RootBridgeData.connections
            .where((c) => c.connectionType == _selectedFilter)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Root Bridge',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${RootBridgeData.connections.length} Sanskrit & Tatsama bridges you already know from Hindi.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text('All (${RootBridgeData.connections.length})'),
                  selected: _selectedFilter == null,
                  selectedColor: AppTheme.ochreSoft,
                  onSelected: (_) => setState(() => _selectedFilter = null),
                ),
              ),
              ...ConnectionType.values.map((type) {
                final count = RootBridgeData.connections
                    .where((c) => c.connectionType == type)
                    .length;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text('${type.label} ($count)'),
                    selected: _selectedFilter == type,
                    selectedColor: AppTheme.ochreSoft,
                    onSelected: (_) => setState(() => _selectedFilter = type),
                  ),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return EditorialCard(
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
                            color: AppTheme.ochreSoft,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.connectionType.label,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.ochre,
                            ),
                          ),
                        ),
                        Text(
                          item.hindiCognateOrMeaning,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.inkMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.rootOrWord,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceSubtle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TriScriptView(
                              text: item.kannadaForm,
                              primaryFontSize: 17,
                            ),
                          ),
                          AudioPlayButton(
                            itemId: '${item.id}_form',
                            text: item.kannadaForm,
                            compact: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.linguisticExplanation,
                      style: const TextStyle(fontSize: 13, height: 1.45),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 10),
                    const Text(
                      'IN CONVERSATION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: AppTheme.inkSubtle,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TriScriptView(
                            text: item.exampleUsage,
                            primaryFontSize: 15,
                            secondaryFontSize: 12,
                          ),
                        ),
                        AudioPlayButton(
                          itemId: '${item.id}_ex',
                          text: item.exampleUsage,
                          compact: true,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
