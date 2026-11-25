import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/real_spaces_data.dart';
import '../models/search_result.dart';
import '../screens/real_spaces_page.dart';
import '../services/search_service.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/reader_mode_pill.dart';
import '../widgets/tri_script_view.dart';

class GlobalSearchPage extends StatefulWidget {
  final ValueChanged<int> onNavigateTab;

  const GlobalSearchPage({super.key, required this.onNavigateTab});

  @override
  State<GlobalSearchPage> createState() => _GlobalSearchPageState();
}

class _GlobalSearchPageState extends State<GlobalSearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(SearchResultItem item) {
    switch (item.category) {
      case SearchCategory.realSpace:
        final space = RealSpacesData.findSpaceById(item.targetId);
        if (space != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => SpaceDetailPage(space: space)),
          );
        }
        break;
      case SearchCategory.scenario:
      case SearchCategory.phrase:
        final scenario = RealSpacesData.findScenarioById(item.targetId);
        if (scenario != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ScenarioDetailPage(scenario: scenario),
            ),
          );
        }
        break;
      case SearchCategory.anchor:
      case SearchCategory.noun:
      case SearchCategory.verb:
        Navigator.of(context).pop();
        widget.onNavigateTab(2); // Sentence Lab
        break;
      case SearchCategory.rootBridge:
        Navigator.of(context).pop();
        widget.onNavigateTab(3); // Root Bridge
        break;
      case SearchCategory.vault:
        Navigator.of(context).pop();
        widget.onNavigateTab(4); // Vault
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vaultEntries = context.watch<VaultStore>().entries;
    final results = SearchService.search(
      query: _query,
      vaultEntries: vaultEntries,
    );

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (v) => setState(() => _query = v),
          decoration: InputDecoration(
            hintText: 'Search Hindi, देवनागरी, or Roman...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            suffixIcon: _query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _query = '');
                    },
                  )
                : null,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: ReaderModePill(),
          ),
        ],
      ),
      body: _query.trim().isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Search across all 40 Real Space scenarios, 81 Sentence Lab words, 40 Root Bridges, Numbers, and your Saved Vault.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.inkMuted),
                ),
              ),
            )
          : results.isEmpty
              ? Center(
                  child: Text(
                    'No results found for "$_query".',
                    style: const TextStyle(color: AppTheme.inkMuted),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = results[index];
                    return EditorialCard(
                      onTap: () => _handleTap(item),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.category.label.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    color: AppTheme.terracotta,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (item.triScript != null)
                                  TriScriptView(
                                    text: item.triScript!,
                                    primaryFontSize: 16,
                                    secondaryFontSize: 12,
                                    compact: true,
                                  )
                                else ...[
                                  Text(
                                    item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (item.triScript != null)
                            AudioPlayButton(
                              itemId: item.id,
                              text: item.triScript!,
                              compact: true,
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
