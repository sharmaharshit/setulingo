import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/reading_mode.dart';
import '../models/user_profile.dart';
import '../models/vault_entry.dart';

class PersistenceService {
  static const String _keyUserProfile = 'setulingo_user_profile_v1';
  static const String _keyIsAuthenticated = 'setulingo_is_authenticated_v1';
  static const String _keyReaderMode = 'setulingo_reader_mode_v1';
  static const String _keyAudioPrefs = 'setulingo_audio_prefs_v1';
  static const String _keyCompletedScenarios = 'setulingo_completed_scenarios_v1';
  static const String _keyCompletedLessons = 'setulingo_completed_lessons_v1';
  static const String _keyLessonStepIndex = 'setulingo_lesson_step_index_v1';
  static const String _keyDailyScenarioDate = 'setulingo_daily_scenario_date_v1';
  static const String _keyDailyScenarioDone = 'setulingo_daily_scenario_done_v1';
  static const String _keyVaultEntries = 'setulingo_vault_entries_v1';

  final SharedPreferences _prefs;

  PersistenceService(this._prefs);

  static Future<PersistenceService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PersistenceService(prefs);
  }

  // Authentication & User Profile
  Future<void> saveAuthState({
    required bool isAuthenticated,
    UserProfile? profile,
  }) async {
    await _prefs.setBool(_keyIsAuthenticated, isAuthenticated);
    if (profile != null) {
      await _prefs.setString(_keyUserProfile, jsonEncode(profile.toJson()));
    } else if (!isAuthenticated) {
      await _prefs.remove(_keyUserProfile);
    }
  }

  bool loadIsAuthenticated() {
    return _prefs.getBool(_keyIsAuthenticated) ?? false;
  }

  UserProfile? loadUserProfile() {
    final raw = _prefs.getString(_keyUserProfile);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return UserProfile.fromJson(decoded);
    } catch (_) {
      return null;
    }
  }

  // Global Reader Mode
  Future<void> saveReaderMode(ReaderMode mode) async {
    await _prefs.setString(_keyReaderMode, mode.name);
  }

  ReaderMode loadReaderMode() {
    return ReaderMode.fromString(_prefs.getString(_keyReaderMode));
  }

  // Audio Preferences
  Future<void> saveAudioPreferences(AudioPreferences prefs) async {
    await _prefs.setString(_keyAudioPrefs, jsonEncode(prefs.toJson()));
  }

  AudioPreferences loadAudioPreferences() {
    final raw = _prefs.getString(_keyAudioPrefs);
    if (raw == null || raw.isEmpty) return const AudioPreferences();
    try {
      return AudioPreferences.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return const AudioPreferences();
    }
  }

  // Scenario Progress
  Future<void> saveCompletedScenarios(Set<String> ids) async {
    await _prefs.setStringList(_keyCompletedScenarios, ids.toList());
  }

  Set<String> loadCompletedScenarios() {
    return (_prefs.getStringList(_keyCompletedScenarios) ?? const []).toSet();
  }

  // Lesson Progress
  Future<void> saveCompletedLessons(Set<String> ids) async {
    await _prefs.setStringList(_keyCompletedLessons, ids.toList());
  }

  Set<String> loadCompletedLessons() {
    return (_prefs.getStringList(_keyCompletedLessons) ?? const []).toSet();
  }

  Future<void> saveLessonStepProgress(Map<String, int> stepMap) async {
    await _prefs.setString(_keyLessonStepIndex, jsonEncode(stepMap));
  }

  Map<String, int> loadLessonStepProgress() {
    final raw = _prefs.getString(_keyLessonStepIndex);
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.map(
        (key, value) => MapEntry(key, (value as num?)?.toInt() ?? 0),
      );
    } catch (_) {
      return {};
    }
  }

  // Daily 2-Minute Scenario Completion
  Future<void> saveDailyScenarioStatus({
    required String dateKey,
    required bool completed,
  }) async {
    await _prefs.setString(_keyDailyScenarioDate, dateKey);
    await _prefs.setBool(_keyDailyScenarioDone, completed);
  }

  bool isDailyScenarioCompletedFor(String dateKey) {
    final savedDate = _prefs.getString(_keyDailyScenarioDate);
    if (savedDate != dateKey) return false;
    return _prefs.getBool(_keyDailyScenarioDone) ?? false;
  }

  // Saved Vault
  Future<void> saveVaultEntries(List<VaultEntry> entries) async {
    final encoded = jsonEncode(entries.map((e) => e.toJson()).toList());
    await _prefs.setString(_keyVaultEntries, encoded);
  }

  List<VaultEntry> loadVaultEntries() {
    final raw = _prefs.getString(_keyVaultEntries);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((item) => VaultEntry.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
