import 'package:flutter_test/flutter_test.dart';
import 'package:setulingo/models/reading_mode.dart';
import 'package:setulingo/models/vault_entry.dart';
import 'package:setulingo/services/search_service.dart';

void main() {
  group('SearchService', () {
    test('Matches across Roman Hindi, Devanagari, and Hindi', () {
      final vault = [
        VaultEntry(
          id: 'v1',
          text: const TriScriptText(
            hindi: 'मेरा नाम राहुल है',
            devanagari: 'नन्न हेसरु राहुल',
            romanHindi: 'Nanna hesaru Rahul',
          ),
          sourceType: VaultSourceType.realSpace,
          sourceTitle: 'Neighbours',
          savedAt: DateTime(2026, 1, 1),
        ),
      ];

      final byRoman = SearchService.search(query: 'Nanage', vaultEntries: vault);
      expect(byRoman, isNotEmpty);

      final byDevanagari =
          SearchService.search(query: 'बेकु', vaultEntries: vault);
      expect(byDevanagari, isNotEmpty);

      final byHindi = SearchService.search(query: 'राहुल', vaultEntries: vault);
      expect(byHindi, isNotEmpty);
    });
  });
}
