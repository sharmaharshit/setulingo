import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sentence_lab.dart';
import '../models/vault_entry.dart';
import '../services/sentence_engine.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_play_button.dart';
import '../widgets/editorial_card.dart';
import '../widgets/tri_script_view.dart';

class SentenceLabPage extends StatefulWidget {
  const SentenceLabPage({super.key});

  @override
  State<SentenceLabPage> createState() => _SentenceLabPageState();
}

class _SentenceLabPageState extends State<SentenceLabPage> {
  AnchorWord? _selectedAnchor;
  NounWord? _selectedNoun;
  VerbWord? _selectedVerb;

  void _selectAnchor(AnchorWord anchor) {
    setState(() {
      _selectedAnchor = anchor;
      final compatibleNouns = SentenceEngine.compatibleNounsFor(anchor);
      if (_selectedNoun != null && !compatibleNouns.contains(_selectedNoun)) {
        _selectedNoun = null;
      }
      final compatibleVerbs = SentenceEngine.compatibleVerbsFor(
        anchor: anchor,
        noun: _selectedNoun,
      );
      if (_selectedVerb != null && !compatibleVerbs.contains(_selectedVerb)) {
        _selectedVerb = null;
      }
    });
  }

  void _selectNoun(NounWord noun) {
    setState(() {
      _selectedNoun = noun;
      final compatibleVerbs = SentenceEngine.compatibleVerbsFor(
        anchor: _selectedAnchor,
        noun: noun,
      );
      if (_selectedVerb != null && !compatibleVerbs.contains(_selectedVerb)) {
        _selectedVerb = null;
      }
    });
  }

  void _selectVerb(VerbWord verb) {
    setState(() {
      _selectedVerb = verb;
    });
  }

  void _reset() {
    setState(() {
      _selectedAnchor = null;
      _selectedNoun = null;
      _selectedVerb = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final vault = context.watch<VaultStore>();
    final compatibleNouns = SentenceEngine.compatibleNounsFor(_selectedAnchor);
    final compatibleVerbs = SentenceEngine.compatibleVerbsFor(
      anchor: _selectedAnchor,
      noun: _selectedNoun,
    );

    final assembled = (_selectedAnchor != null &&
            _selectedNoun != null &&
            _selectedVerb != null)
        ? SentenceEngine.assemble(
            _selectedAnchor!,
            _selectedNoun!,
            _selectedVerb!,
          )
        : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sentence Lab',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '81-word tagged engine · 22 Anchors · 32 Nouns · 27 Verbs',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (_selectedAnchor != null ||
                _selectedNoun != null ||
                _selectedVerb != null)
              TextButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: const Text('Reset'),
              ),
          ],
        ),
        const SizedBox(height: 14),

        // Live Assembled Sentence Stage
        EditorialCard(
          backgroundColor: assembled != null
              ? AppTheme.sageSoft
              : AppTheme.surfaceSubtle,
          borderColor: assembled != null
              ? AppTheme.sage.withValues(alpha: 0.4)
              : AppTheme.border,
          child: assembled != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ASSEMBLED SPOKEN KANNADA',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                        color: AppTheme.sage,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TriScriptView(
                      text: assembled.assembledText,
                      primaryFontSize: 21,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      assembled.grammarNote,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.inkMuted,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        AudioPlayButton(
                          itemId:
                              'lab_${assembled.anchor.id}_${assembled.noun.id}_${assembled.verb.id}',
                          text: assembled.assembledText,
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: () async {
                            final saved = await vault.saveEntry(
                              text: assembled.assembledText,
                              sourceType: VaultSourceType.sentenceLab,
                              sourceTitle: 'Sentence Lab Builder',
                              note: assembled.grammarNote,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    saved
                                        ? 'Saved sentence to Vault.'
                                        : 'Already saved in Vault.',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: Icon(
                            vault.isSaved(assembled.assembledText)
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_add_outlined,
                            size: 18,
                          ),
                          label: Text(
                            vault.isSaved(assembled.assembledText)
                                ? 'Saved'
                                : 'Save to Vault',
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'THREE-SLOT COMBINATORIAL BUILDER',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                        color: AppTheme.inkSubtle,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _SlotPreviewChip(
                          label: '1. Anchor',
                          value: _selectedAnchor?.text.romanHindi,
                          accent: AppTheme.terracotta,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('+',
                              style: TextStyle(color: AppTheme.inkSubtle)),
                        ),
                        _SlotPreviewChip(
                          label: '2. Noun',
                          value: _selectedNoun?.text.romanHindi,
                          accent: AppTheme.indigo,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('+',
                              style: TextStyle(color: AppTheme.inkSubtle)),
                        ),
                        _SlotPreviewChip(
                          label: '3. Verb',
                          value: _selectedVerb?.text.romanHindi,
                          accent: AppTheme.sage,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Pick one Anchor, one compatible Noun, and one compatible Verb below.',
                      style: TextStyle(fontSize: 12, color: AppTheme.inkMuted),
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 20),

        // SLOT 1: 22 ANCHORS
        _SlotHeader(
          step: 'SLOT 1',
          title: 'Choose Anchor (${SentenceEngine.allAnchors.length})',
          accent: AppTheme.terracotta,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: SentenceEngine.allAnchors.map((anchor) {
            final selected = _selectedAnchor?.id == anchor.id;
            return _WordTile(
              selected: selected,
              accent: AppTheme.terracotta,
              onTap: () => _selectAnchor(anchor),
              child: TriScriptView(
                text: anchor.text,
                primaryFontSize: 14,
                secondaryFontSize: 11,
                compact: true,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 22),

        // SLOT 2: COMPATIBLE NOUNS
        _SlotHeader(
          step: 'SLOT 2',
          title: _selectedAnchor == null
              ? 'Choose Noun (${compatibleNouns.length})'
              : 'Compatible Nouns (${compatibleNouns.length} of ${SentenceEngine.allNouns.length})',
          accent: AppTheme.indigo,
        ),
        const SizedBox(height: 8),
        if (compatibleNouns.isEmpty)
          const EditorialCard(
            child: Text(
              'No compatible nouns for this anchor.',
              style: TextStyle(color: AppTheme.inkMuted),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: compatibleNouns.map((noun) {
              final selected = _selectedNoun?.id == noun.id;
              return _WordTile(
                selected: selected,
                accent: AppTheme.indigo,
                onTap: () => _selectNoun(noun),
                child: TriScriptView(
                  text: noun.text,
                  primaryFontSize: 14,
                  secondaryFontSize: 11,
                  compact: true,
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 22),

        // SLOT 3: COMPATIBLE VERBS / PREDICATES
        _SlotHeader(
          step: 'SLOT 3',
          title: (_selectedAnchor == null && _selectedNoun == null)
              ? 'Choose Verb / Predicate (${compatibleVerbs.length})'
              : 'Compatible Verbs (${compatibleVerbs.length} of ${SentenceEngine.allVerbs.length})',
          accent: AppTheme.sage,
        ),
        const SizedBox(height: 8),
        if (compatibleVerbs.isEmpty)
          const EditorialCard(
            child: Text(
              'No compatible verbs match this Anchor + Noun pair. Try another noun or reset.',
              style: TextStyle(color: AppTheme.inkMuted),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: compatibleVerbs.map((verb) {
              final selected = _selectedVerb?.id == verb.id;
              return _WordTile(
                selected: selected,
                accent: AppTheme.sage,
                onTap: () => _selectVerb(verb),
                child: TriScriptView(
                  text: verb.text,
                  primaryFontSize: 14,
                  secondaryFontSize: 11,
                  compact: true,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

class _SlotPreviewChip extends StatelessWidget {
  final String label;
  final String? value;
  final Color accent;

  const _SlotPreviewChip({
    required this.label,
    required this.value,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final filled = value != null;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: filled ? accent.withValues(alpha: 0.12) : AppTheme.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: filled ? accent : AppTheme.border,
          ),
        ),
        child: Text(
          value ?? label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: filled ? FontWeight.w700 : FontWeight.w500,
            color: filled ? accent : AppTheme.inkSubtle,
          ),
        ),
      ),
    );
  }
}

class _SlotHeader extends StatelessWidget {
  final String step;
  final String title;
  final Color accent;

  const _SlotHeader({
    required this.step,
    required this.title,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            step,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _WordTile extends StatelessWidget {
  final bool selected;
  final Color accent;
  final VoidCallback onTap;
  final Widget child;

  const _WordTile({
    required this.selected,
    required this.accent,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.12) : AppTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? accent : AppTheme.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: child,
      ),
    );
  }
}
