import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/vault_entry.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/tri_script_view.dart';
import 'vault_quiz_page.dart';

class VaultPage extends StatefulWidget {
  final VoidCallback onJumpToSentenceLab;

  const VaultPage({super.key, required this.onJumpToSentenceLab});

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openEntryDetail(BuildContext context, VaultEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppTheme.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${entry.sourceType.label} · ${entry.sourceTitle}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.terracotta,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TriScriptView(text: entry.text, primaryFontSize: 22),
            if (entry.note != null && entry.note!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                entry.note!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: 18),
            Row(
              children: [
                AudioPlayButton(itemId: 'sheet_${entry.id}', text: entry.text),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onJumpToSentenceLab();
                  },
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: const Text('Practice in Lab'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vault = context.watch<VaultStore>();
    final items = vault.search(_query);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saved Vault',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${vault.entries.length} saved phrases & sentences',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: vault.entries.isEmpty
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const VaultQuizPage(),
                              ),
                            );
                          },
                    icon: const Icon(Icons.quiz_outlined, size: 18),
                    label: const Text('Vault Quiz'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search Hindi, देवनागरी, or Roman...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bookmarks_outlined,
                          size: 44,
                          color: AppTheme.inkSubtle,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _query.isEmpty
                              ? 'Your personal Vault is empty'
                              : 'No saved entries match "$_query"',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Bookmark phrases from Real Spaces or save custom sentences from Sentence Lab to review and quiz yourself here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppTheme.inkMuted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: widget.onJumpToSentenceLab,
                          child: const Text('Open Sentence Lab'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final entry = items[index];
                    return EditorialCard(
                      onTap: () => _openEntryDetail(context, entry),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${entry.sourceType.label} · ${entry.sourceTitle}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.terracotta,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TriScriptView(
                                  text: entry.text,
                                  primaryFontSize: 16,
                                  secondaryFontSize: 13,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              AudioPlayButton(
                                itemId: entry.id,
                                text: entry.text,
                                compact: true,
                              ),
                              IconButton(
                                tooltip: 'Delete from Vault',
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  size: 20,
                                  color: AppTheme.inkSubtle,
                                ),
                                onPressed: () => vault.deleteEntry(entry.id),
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
