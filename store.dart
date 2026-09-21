import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Model for sentences saved or created in the Sentence Lab.
class SavedSentence {
  final String id;
  final String roman;
  final String script;
  final String hindi;
  final DateTime createdAt;

  const SavedSentence({
    required this.id,
    required this.roman,
    required this.script,
    required this.hindi,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'roman': roman,
        'script': script,
        'hindi': hindi,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SavedSentence.fromMap(Map<String, dynamic> map) => SavedSentence(
        id: map['id'] as String,
        roman: map['roman'] as String,
        script: (map['script'] ?? '') as String,
        hindi: map['hindi'] as String,
        createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );
}

/// Keeps the learner's personal vocabulary ("My Words") on device.
class MyWordsStore extends ChangeNotifier {
  MyWordsStore._();
  static final MyWordsStore instance = MyWordsStore._();

  static const String _key = 'my_word_ids';
  final Set<String> _ids = <String>{};

  Set<String> get ids => Set<String>.unmodifiable(_ids);

  bool contains(String id) => _ids.contains(id);

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList(_key) ?? <String>[];
      _ids
        ..clear()
        ..addAll(saved);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, _ids.toList());
    } catch (_) {}
  }

  Future<void> add(String id) async {
    if (_ids.add(id)) {
      notifyListeners();
      await _save();
    }
  }

  Future<void> addAll(Iterable<String> ids) async {
    var changed = false;
    for (final id in ids) {
      if (_ids.add(id)) changed = true;
    }
    if (changed) {
      notifyListeners();
      await _save();
    }
  }

  Future<void> remove(String id) async {
    if (_ids.remove(id)) {
      notifyListeners();
      await _save();
    }
  }
}

/// Keeps the learner's constructed & bookmarked sentences on device.
class MySentencesStore extends ChangeNotifier {
  MySentencesStore._();
  static final MySentencesStore instance = MySentencesStore._();

  static const String _key = 'my_saved_sentences';
  final List<SavedSentence> _sentences = <SavedSentence>[];

  List<SavedSentence> get sentences => List<SavedSentence>.unmodifiable(_sentences);

  bool contains(String id) => _sentences.any((s) => s.id == id);

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_key) ?? <String>[];
      _sentences
        ..clear()
        ..addAll(
          list.map((str) => SavedSentence.fromMap(jsonDecode(str) as Map<String, dynamic>)),
        );
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = _sentences.map((s) => jsonEncode(s.toMap())).toList();
      await prefs.setStringList(_key, list);
    } catch (_) {}
  }

  Future<void> addSentence(SavedSentence sentence) async {
    _sentences.removeWhere((s) => s.id == sentence.id);
    _sentences.insert(0, sentence);
    notifyListeners();
    await _save();
  }

  Future<void> removeSentence(String id) async {
    _sentences.removeWhere((s) => s.id == id);
    notifyListeners();
    await _save();
  }
}
