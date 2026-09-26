import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The three grammatical roles a Sentence Lab slot can hold.
/// Slot 1 = Anchor, Slot 2 = Noun, Slot 3 = Predicate Verb.
enum SlotRole { anchor, noun, verb }

extension SlotRoleX on SlotRole {
  String get label => switch (this) {
        SlotRole.anchor => 'Anchor',
        SlotRole.noun => 'Noun',
        SlotRole.verb => 'Verb',
      };

  String get hindiLabel => switch (this) {
        SlotRole.anchor => 'ऐंकर (Slot 1)',
        SlotRole.noun => 'संज्ञा (Slot 2)',
        SlotRole.verb => 'क्रिया (Slot 3)',
      };
}

/// A Sentence Lab slot only makes grammatical sense with a single lexical
/// token (e.g. "Ondu", "dose", "kodi") — never a multi-word phrase. This is
/// the "valid tag rule" the Vault-tagging UI checks before it offers the
/// Anchor/Noun/Verb tagging option on a saved word.
bool isTaggableForSentenceLab(String roman) {
  final trimmed = roman.trim();
  if (trimmed.isEmpty) return false;
  return !trimmed.contains(RegExp(r'\s'));
}

class LabVocabEntry {
  final String roman;
  final String deva;
  final String hindi;

  const LabVocabEntry({required this.roman, required this.deva, required this.hindi});

  Map<String, dynamic> toMap() => {'roman': roman, 'deva': deva, 'hindi': hindi};

  factory LabVocabEntry.fromMap(Map<String, dynamic> map) => LabVocabEntry(
        roman: map['roman'] as String,
        deva: (map['deva'] ?? '') as String,
        hindi: (map['hindi'] ?? '') as String,
      );
}

/// Holds user-tagged custom vocabulary so the Sentence Lab's slots can grow
/// beyond the curated built-in set as people tag saved Vault words as
/// Anchor / Noun / Verb elsewhere in the app.
class SentenceLabVocabStore extends ChangeNotifier {
  SentenceLabVocabStore._();
  static final SentenceLabVocabStore instance = SentenceLabVocabStore._();

  static const String _anchorsKey = 'lab_vocab_anchors';
  static const String _nounsKey = 'lab_vocab_nouns';
  static const String _verbsKey = 'lab_vocab_verbs';

  List<LabVocabEntry> customAnchors = [];
  List<LabVocabEntry> customNouns = [];
  List<LabVocabEntry> customVerbs = [];

  String _keyFor(SlotRole role) => switch (role) {
        SlotRole.anchor => _anchorsKey,
        SlotRole.noun => _nounsKey,
        SlotRole.verb => _verbsKey,
      };

  List<LabVocabEntry> forRole(SlotRole role) => switch (role) {
        SlotRole.anchor => customAnchors,
        SlotRole.noun => customNouns,
        SlotRole.verb => customVerbs,
      };

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final role in SlotRole.values) {
        final raw = prefs.getStringList(_keyFor(role)) ?? const <String>[];
        final list = raw.map((s) => LabVocabEntry.fromMap(jsonDecode(s) as Map<String, dynamic>)).toList();
        if (role == SlotRole.anchor) {
          customAnchors = list;
        } else if (role == SlotRole.noun) {
          customNouns = list;
        } else {
          customVerbs = list;
        }
      }
    } catch (_) {}
    notifyListeners();
  }

  Future<void> addCustomEntry(SlotRole role, LabVocabEntry entry) async {
    final list = forRole(role);
    if (list.any((e) => e.roman.toLowerCase() == entry.roman.toLowerCase())) return;
    list.add(entry);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_keyFor(role), list.map((e) => jsonEncode(e.toMap())).toList());
    } catch (_) {}
  }
}
