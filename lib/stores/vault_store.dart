import 'package:flutter/foundation.dart';

import '../models/reading_mode.dart';
import '../models/vault_entry.dart';
import '../services/persistence_service.dart';

class VaultStore extends ChangeNotifier {
  final PersistenceService _persistence;
  List<VaultEntry> _entries;

  VaultStore(this._persistence) : _entries = _persistence.loadVaultEntries();

  List<VaultEntry> get entries => List.unmodifiable(_entries);

  bool isSaved(TriScriptText text) {
    return _entries.any((e) => e.text == text);
  }

  Future<bool> saveEntry({
    required TriScriptText text,
    required VaultSourceType sourceType,
    required String sourceTitle,
    String? note,
  }) async {
    if (isSaved(text)) {
      return false;
    }
    final entry = VaultEntry(
      id: 'vault_${DateTime.now().microsecondsSinceEpoch}',
      text: text,
      sourceType: sourceType,
      sourceTitle: sourceTitle,
      note: note,
      savedAt: DateTime.now(),
    );
    _entries = [entry, ..._entries];
    await _persistence.saveVaultEntries(_entries);
    notifyListeners();
    return true;
  }

  Future<void> deleteEntry(String id) async {
    _entries = _entries.where((e) => e.id != id).toList();
    await _persistence.saveVaultEntries(_entries);
    notifyListeners();
  }

  List<VaultEntry> search(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return entries;
    return _entries
        .where(
          (e) =>
              e.text.matchesQuery(q) ||
              e.sourceTitle.toLowerCase().contains(q) ||
              (e.note?.toLowerCase().contains(q) ?? false),
        )
        .toList();
  }
}
