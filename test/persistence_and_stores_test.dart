import 'package:flutter_test/flutter_test.dart';
import 'package:setulingo/models/reading_mode.dart';
import 'package:setulingo/models/vault_entry.dart';
import 'package:setulingo/services/persistence_service.dart';
import 'package:setulingo/stores/app_state_store.dart';
import 'package:setulingo/stores/user_auth_store.dart';
import 'package:setulingo/stores/vault_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('Stores & Persistence', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('UserAuthStore signs up, persists, and signs out', () async {
      final persistence = await PersistenceService.create();
      final auth = UserAuthStore(persistence);
      expect(auth.isAuthenticated, isFalse);

      final ok = await auth.signUp(
        displayName: 'Aarav',
        phoneNumber: '+919876543210',
        email: 'aarav@gmail.com',
      );
      expect(ok, isTrue);
      expect(auth.isAuthenticated, isTrue);
      expect(auth.currentUser?.email, 'aarav@gmail.com');

      final reloadedAuth = UserAuthStore(persistence);
      expect(reloadedAuth.isAuthenticated, isTrue);
      expect(reloadedAuth.currentUser?.displayName, 'Aarav');

      await reloadedAuth.signOut();
      expect(reloadedAuth.isAuthenticated, isFalse);
    });

    test('AppStateStore persists global ReaderMode and scenario completion',
        () async {
      final persistence = await PersistenceService.create();
      final store = AppStateStore(persistence);
      await store.setReaderMode(ReaderMode.roman);
      await store.markScenarioCompleted('food_01');

      final reloaded = AppStateStore(persistence);
      expect(reloaded.readerMode, ReaderMode.roman);
      expect(reloaded.isScenarioCompleted('food_01'), isTrue);
    });

    test('VaultStore saves, searches, and deletes entries', () async {
      final persistence = await PersistenceService.create();
      final vault = VaultStore(persistence);

      const sample = TriScriptText(
        hindi: 'मुझे पानी चाहिए।',
        devanagari: 'ननगे नीरु बेकु।',
        romanHindi: 'Nanage neeru beku.',
      );

      final saved = await vault.saveEntry(
        text: sample,
        sourceType: VaultSourceType.sentenceLab,
        sourceTitle: 'Sentence Lab',
      );
      expect(saved, isTrue);
      expect(vault.entries.length, 1);
      expect(vault.search('neeru').length, 1);

      await vault.deleteEntry(vault.entries.first.id);
      expect(vault.entries, isEmpty);
    });
  });
}
