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
        roman: (map['roman'] ?? '').toString().trim(),
        deva: (map['deva'] ?? '').toString().trim(),
        hindi: (map['hindi'] ?? '').toString().trim(),
      );

  /// Safe parse of one stored JSON string. Returns null for anything
  /// malformed, empty, or not a single lexical token, so one bad entry can
  /// never take down the whole list.
  static LabVocabEntry? tryParse(Object? raw) {
    try {
      if (raw is! String) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final entry = LabVocabEntry.fromMap(Map<String, dynamic>.from(decoded));
      return isTaggableForSentenceLab(entry.roman) ? entry : null;
    } catch (_) {
      return null;
    }
  }
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

  /// Loads every role independently. A corrupt value for one role (or one
  /// corrupt entry inside a role) is skipped instead of wiping the others.
  Future<void> load() async {
    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (_) {}

    for (final role in SlotRole.values) {
      final list = <LabVocabEntry>[];
      try {
        final raw = prefs?.getStringList(_keyFor(role)) ?? const <String>[];
        final seen = <String>{};
        for (final item in raw) {
          final entry = LabVocabEntry.tryParse(item);
          if (entry == null) continue;
          if (!seen.add(entry.roman.toLowerCase())) continue; // drop duplicates
          list.add(entry);
        }
      } catch (_) {
        // e.g. the key holds a non-list type from an older build: start clean.
      }
      switch (role) {
        case SlotRole.anchor:
          customAnchors = list;
        case SlotRole.noun:
          customNouns = list;
        case SlotRole.verb:
          customVerbs = list;
      }
    }
    notifyListeners();
  }

  /// Returns true if the entry was added, false if it was rejected (not a
  /// single token) or already present for that role.
  Future<bool> addCustomEntry(SlotRole role, LabVocabEntry entry) async {
    final clean = LabVocabEntry(
      roman: entry.roman.trim(),
      deva: entry.deva.trim(),
      hindi: entry.hindi.trim(),
    );
    if (!isTaggableForSentenceLab(clean.roman)) return false;
    final list = forRole(role);
    if (list.any((e) => e.roman.toLowerCase() == clean.roman.toLowerCase())) return false;
    list.add(clean);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_keyFor(role), list.map((e) => jsonEncode(e.toMap())).toList());
    } catch (_) {
      // Persisting failed: the entry still works for this session.
    }
    return true;
  }
}

/// Remembers which one-time helper banners the user has dismissed.
class HelperBannerStore extends ChangeNotifier {
  HelperBannerStore._();
  static final HelperBannerStore instance = HelperBannerStore._();

  static const String _prefKey = 'dismissed_helper_banners';
  final Set<String> _dismissed = {};

  bool isDismissed(String id) => _dismissed.contains(id);

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _dismissed
        ..clear()
        ..addAll(prefs.getStringList(_prefKey) ?? const <String>[]);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> dismiss(String id) async {
    if (!_dismissed.add(id)) return;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_prefKey, _dismissed.toList());
    } catch (_) {}
  }
}
