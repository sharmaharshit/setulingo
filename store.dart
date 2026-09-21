import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keeps the learner's personal vocabulary ("My Words") on the device.
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
    } catch (_) {
      // Storage unavailable: start with an empty list.
    }
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, _ids.toList());
    } catch (_) {
      // Ignore write failures; the list still works for this session.
    }
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
      if (_ids.add(id)) {
        changed = true;
      }
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
