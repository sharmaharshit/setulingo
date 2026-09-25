import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'content.dart';

enum ScriptDisplayMode { roman, deva }

class AppSettingsStore extends ChangeNotifier {
  AppSettingsStore._();
  static final AppSettingsStore instance = AppSettingsStore._();

  static const String _prefKey = 'display_script_mode';
  ScriptDisplayMode _mode = ScriptDisplayMode.roman;

  ScriptDisplayMode get mode => _mode;
  bool get isDevanagari => _mode == ScriptDisplayMode.deva;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefKey);
      _mode = (saved == 'deva') ? ScriptDisplayMode.deva : ScriptDisplayMode.roman;
    } catch (_) {}
    notifyListeners();
  }

  Future<void> toggleMode() async {
    _mode = _mode == ScriptDisplayMode.roman ? ScriptDisplayMode.deva : ScriptDisplayMode.roman;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, _mode == ScriptDisplayMode.deva ? 'deva' : 'roman');
    } catch (_) {}
  }
}

class SavedSentence {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final DateTime createdAt;
  int reviewCount;
  bool mastered;

  SavedSentence({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.createdAt,
    this.reviewCount = 0,
    this.mastered = false,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'roman': roman,
        'deva': deva,
        'hindi': hindi,
        'createdAt': createdAt.toIso8601String(),
        'reviewCount': reviewCount,
        'mastered': mastered,
      };

  factory SavedSentence.fromMap(Map<String, dynamic> map) => SavedSentence(
        id: map['id'] as String,
        roman: map['roman'] as String,
        deva: (map['deva'] ?? '') as String,
        hindi: map['hindi'] as String,
        createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
        reviewCount: (map['reviewCount'] ?? 0) as int,
        mastered: (map['mastered'] ?? false) as bool,
      );
}

/// A single saved word/chunk, with the context it was learned in (e.g. which
/// Street Encounter step, or which situation) so the Vault stays meaningful
/// instead of just being a bag of floating words.
class SavedWord {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final String source;
  final DateTime createdAt;

  SavedWord({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.source,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'roman': roman,
        'deva': deva,
        'hindi': hindi,
        'source': source,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SavedWord.fromMap(Map<String, dynamic> map) => SavedWord(
        id: map['id'] as String,
        roman: map['roman'] as String,
        deva: (map['deva'] ?? '') as String,
        hindi: map['hindi'] as String,
        source: (map['source'] ?? '') as String,
        createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
      );
}

class MyWordsStore extends ChangeNotifier {
  MyWordsStore._();
  static final MyWordsStore instance = MyWordsStore._();

  static const String _key = 'my_saved_words_v2';
  final List<SavedWord> _words = <SavedWord>[];

  List<SavedWord> get words => List<SavedWord>.unmodifiable(_words);
  bool contains(String id) => _words.any((w) => w.id == id);

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_key) ?? <String>[];
      _words
        ..clear()
        ..addAll(list.map((str) => SavedWord.fromMap(jsonDecode(str) as Map<String, dynamic>)));
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = _words.map((w) => jsonEncode(w.toMap())).toList();
      await prefs.setStringList(_key, list);
    } catch (_) {}
  }

  Future<void> addWord(SavedWord word) async {
    if (_words.any((w) => w.id == word.id)) return;
    _words.insert(0, word);
    notifyListeners();
    await _save();
  }

  Future<void> removeWord(String id) async {
    _words.removeWhere((w) => w.id == id);
    notifyListeners();
    await _save();
  }
}

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
        ..addAll(list.map((str) => SavedSentence.fromMap(jsonDecode(str) as Map<String, dynamic>)));
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

  Future<void> markReviewed(String id, bool gotIt) async {
    final idx = _sentences.indexWhere((s) => s.id == id);
    if (idx != -1) {
      _sentences[idx].reviewCount += 1;
      _sentences[idx].mastered = gotIt;
      notifyListeners();
      await _save();
    }
  }

  Future<void> removeSentence(String id) async {
    _sentences.removeWhere((s) => s.id == id);
    notifyListeners();
    await _save();
  }
}

class TtsService {
  TtsService._();
  static final TtsService instance = TtsService._();

  final FlutterTts _flutterTts = FlutterTts();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    try {
      await _flutterTts.setLanguage('kn-IN');
      await _flutterTts.setSpeechRate(0.45);
      await _flutterTts.setPitch(1.0);
      _initialized = true;
    } catch (_) {}
  }

  Future<void> speak(String text) async {
    try {
      await init();
      final clean = text.replaceAll(RegExp(r'[^\w\s\u0C80-\u0CFF]'), ' ').trim();
      await _flutterTts.stop();
      await _flutterTts.speak(clean);
    } catch (_) {}
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
    } catch (_) {}
  }

  /// Applies a new speech rate (0.2–0.8 is a sane practical range for
  /// flutter_tts) and persists it via [AppPreferencesStore] so it survives
  /// app restarts.
  Future<void> setRate(double rate) async {
    try {
      await init();
      await _flutterTts.setSpeechRate(rate);
    } catch (_) {}
  }
}

// ---------------------------------------------------------------------------
// User Profile — legal name / email / phone + upgrade state.
// Stored locally only (offline-first); nothing here talks to a server yet,
// so "Unlock Features" is a local flag ready to be wired to real billing.
// ---------------------------------------------------------------------------

class UserProfile {
  String legalName;
  String email;
  String phone;
  bool phoneVerified;
  bool premiumUnlocked;

  UserProfile({
    this.legalName = '',
    this.email = '',
    this.phone = '',
    this.phoneVerified = false,
    this.premiumUnlocked = false,
  });

  Map<String, dynamic> toMap() => {
        'legalName': legalName,
        'email': email,
        'phone': phone,
        'phoneVerified': phoneVerified,
        'premiumUnlocked': premiumUnlocked,
      };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
        legalName: (map['legalName'] ?? '') as String,
        email: (map['email'] ?? '') as String,
        phone: (map['phone'] ?? '') as String,
        phoneVerified: (map['phoneVerified'] ?? false) as bool,
        premiumUnlocked: (map['premiumUnlocked'] ?? false) as bool,
      );
}

class ProfileStore extends ChangeNotifier {
  ProfileStore._();
  static final ProfileStore instance = ProfileStore._();

  static const String _key = 'user_profile_v1';
  UserProfile profile = UserProfile();

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw != null) {
        profile = UserProfile.fromMap(jsonDecode(raw) as Map<String, dynamic>);
      }
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, jsonEncode(profile.toMap()));
    } catch (_) {}
  }

  Future<void> updateDetails({String? legalName, String? email}) async {
    if (legalName != null) profile.legalName = legalName;
    if (email != null) profile.email = email;
    notifyListeners();
    await _persist();
  }

  /// Simulated phone link/verify flow — no SMS backend wired yet, so this
  /// just records the number as "verified" locally. Swap the body for a
  /// real OTP call when a backend is available.
  Future<void> linkPhone(String phone) async {
    profile.phone = phone;
    profile.phoneVerified = phone.trim().isNotEmpty;
    notifyListeners();
    await _persist();
  }

  Future<void> unlockPremium() async {
    profile.premiumUnlocked = true;
    notifyListeners();
    await _persist();
  }
}

// ---------------------------------------------------------------------------
// App Preferences — audio rate, notification reminders, storage prefs.
// Sits alongside AppSettingsStore (script mode) rather than inside it, so
// the original settings store stays untouched.
// ---------------------------------------------------------------------------

class ReminderSlot {
  final String id;
  String label;
  String time; // "HH:mm" 24h
  bool enabled;

  ReminderSlot({required this.id, required this.label, required this.time, this.enabled = true});

  Map<String, dynamic> toMap() => {'id': id, 'label': label, 'time': time, 'enabled': enabled};

  factory ReminderSlot.fromMap(Map<String, dynamic> map) => ReminderSlot(
        id: map['id'] as String,
        label: (map['label'] ?? 'Daily practice') as String,
        time: (map['time'] ?? '19:00') as String,
        enabled: (map['enabled'] ?? true) as bool,
      );
}

class AppPreferencesStore extends ChangeNotifier {
  AppPreferencesStore._();
  static final AppPreferencesStore instance = AppPreferencesStore._();

  static const String _rateKey = 'pref_speech_rate';
  static const String _notifKey = 'pref_notifications_enabled';
  static const String _wifiKey = 'pref_wifi_only';
  static const String _remindersKey = 'pref_reminders_v1';

  double speechRate = 0.45;
  bool notificationsEnabled = true;
  bool wifiOnlyDownloads = true;
  List<ReminderSlot> reminders = [
    ReminderSlot(id: 'evening', label: 'Evening practice', time: '19:30'),
  ];

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      speechRate = prefs.getDouble(_rateKey) ?? speechRate;
      notificationsEnabled = prefs.getBool(_notifKey) ?? notificationsEnabled;
      wifiOnlyDownloads = prefs.getBool(_wifiKey) ?? wifiOnlyDownloads;
      final raw = prefs.getStringList(_remindersKey);
      if (raw != null && raw.isNotEmpty) {
        reminders = raw.map((s) => ReminderSlot.fromMap(jsonDecode(s) as Map<String, dynamic>)).toList();
      }
      await TtsService.instance.setRate(speechRate);
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _persistReminders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_remindersKey, reminders.map((r) => jsonEncode(r.toMap())).toList());
    } catch (_) {}
  }

  Future<void> setSpeechRate(double rate) async {
    speechRate = rate;
    notifyListeners();
    await TtsService.instance.setRate(rate);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_rateKey, rate);
    } catch (_) {}
  }

  Future<void> setNotificationsEnabled(bool value) async {
    notificationsEnabled = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_notifKey, value);
    } catch (_) {}
  }

  Future<void> setWifiOnlyDownloads(bool value) async {
    wifiOnlyDownloads = value;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_wifiKey, value);
    } catch (_) {}
  }

  Future<void> updateReminder(String id, {String? time, bool? enabled}) async {
    final idx = reminders.indexWhere((r) => r.id == id);
    if (idx == -1) return;
    if (time != null) reminders[idx].time = time;
    if (enabled != null) reminders[idx].enabled = enabled;
    notifyListeners();
    await _persistReminders();
  }

  Future<void> addReminder(ReminderSlot slot) async {
    reminders.add(slot);
    notifyListeners();
    await _persistReminders();
  }

  Future<void> removeReminder(String id) async {
    reminders.removeWhere((r) => r.id == id);
    notifyListeners();
    await _persistReminders();
  }
}

// ---------------------------------------------------------------------------
// Learning Path — onboarding wizard state + daily recommendation engine.
// ---------------------------------------------------------------------------

enum DailyProfile { itProfessional, businessOwner, student, homemaker }

enum FrictionPoint { autoDrivers, apartmentSecurity, maids, colleagues, groceryVendors }

extension DailyProfileX on DailyProfile {
  String get label => switch (this) {
        DailyProfile.itProfessional => 'IT Professional',
        DailyProfile.businessOwner => 'Business Owner',
        DailyProfile.student => 'Student',
        DailyProfile.homemaker => 'Homemaker',
      };

  String get emoji => switch (this) {
        DailyProfile.itProfessional => '💻',
        DailyProfile.businessOwner => '🧾',
        DailyProfile.student => '🎓',
        DailyProfile.homemaker => '🏠',
      };
}

extension FrictionPointX on FrictionPoint {
  String get label => switch (this) {
        FrictionPoint.autoDrivers => 'Auto Drivers',
        FrictionPoint.apartmentSecurity => 'Apartment Security',
        FrictionPoint.maids => 'Maids & Household Help',
        FrictionPoint.colleagues => 'Colleagues',
        FrictionPoint.groceryVendors => 'Grocery Vendors',
      };

  String get emoji => switch (this) {
        FrictionPoint.autoDrivers => '🛺',
        FrictionPoint.apartmentSecurity => '🛡️',
        FrictionPoint.maids => '🧹',
        FrictionPoint.colleagues => '🧑\u200d💼',
        FrictionPoint.groceryVendors => '🛒',
      };

  /// Maps a friction point to the category id it should boost in the daily
  /// recommendation engine. Falls back gracefully if the id doesn't exist
  /// in `categories` yet — the engine just skips unmatched ids.
  List<String> get relatedCategoryIds => switch (this) {
        FrictionPoint.autoDrivers => const ['autos'],
        FrictionPoint.apartmentSecurity => const ['apartment'],
        FrictionPoint.maids => const ['apartment', 'elders'],
        FrictionPoint.colleagues => const ['colleagues'],
        FrictionPoint.groceryVendors => const ['market', 'food'],
      };
}

class LearningPathStore extends ChangeNotifier {
  LearningPathStore._();
  static final LearningPathStore instance = LearningPathStore._();

  static const String _onboardedKey = 'learning_path_onboarded';
  static const String _profileKey = 'learning_path_profile';
  static const String _frictionKey = 'learning_path_friction';

  bool isOnboarded = false;
  DailyProfile? dailyProfile;
  Set<FrictionPoint> frictionPoints = {};

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isOnboarded = prefs.getBool(_onboardedKey) ?? false;
      final p = prefs.getString(_profileKey);
      if (p != null) {
        for (final e in DailyProfile.values) {
          if (e.name == p) dailyProfile = e;
        }
      }
      final f = prefs.getStringList(_frictionKey) ?? const [];
      final matched = <FrictionPoint>{};
      for (final name in f) {
        for (final e in FrictionPoint.values) {
          if (e.name == name) matched.add(e);
        }
      }
      frictionPoints = matched;
    } catch (_) {}
    notifyListeners();
  }

  Future<void> completeOnboarding({required DailyProfile profile, required Set<FrictionPoint> friction}) async {
    dailyProfile = profile;
    frictionPoints = friction;
    isOnboarded = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardedKey, true);
      await prefs.setString(_profileKey, profile.name);
      await prefs.setStringList(_frictionKey, friction.map((e) => e.name).toList());
    } catch (_) {}
  }

  Future<void> resetOnboarding() async {
    isOnboarded = false;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardedKey, false);
    } catch (_) {}
  }
}

// ---------------------------------------------------------------------------
// Gamification — daily streak, XP, and per-situation completion tracking.
// ---------------------------------------------------------------------------

class GamificationStore extends ChangeNotifier {
  GamificationStore._();
  static final GamificationStore instance = GamificationStore._();

  static const String _streakKey = 'gami_streak';
  static const String _xpKey = 'gami_xp';
  static const String _lastDateKey = 'gami_last_active_date';
  static const String _completedKey = 'gami_completed_situations';

  static const int xpPerLesson = 15;

  int streak = 0;
  int xp = 0;
  String? _lastActiveDate;
  Set<String> completedSituationIds = {};

  String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      streak = prefs.getInt(_streakKey) ?? 0;
      xp = prefs.getInt(_xpKey) ?? 0;
      _lastActiveDate = prefs.getString(_lastDateKey);
      completedSituationIds = (prefs.getStringList(_completedKey) ?? const <String>[]).toSet();
    } catch (_) {}
    notifyListeners();
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_streakKey, streak);
      await prefs.setInt(_xpKey, xp);
      if (_lastActiveDate != null) await prefs.setString(_lastDateKey, _lastActiveDate!);
      await prefs.setStringList(_completedKey, completedSituationIds.toList());
    } catch (_) {}
  }

  /// Call once a lesson (or the daily scenario) is fully completed.
  /// Always awards XP; bumps the daily streak only the *first* time this
  /// fires on a given calendar day, so replaying a lesson can't inflate it.
  /// Returns the XP actually awarded, so callers can show it in the UI.
  Future<int> recordLessonCompletion(String situationId, {int xpAwarded = xpPerLesson}) async {
    final today = _dateKey(DateTime.now());
    if (_lastActiveDate != today) {
      final yesterdayKey = _dateKey(DateTime.now().subtract(const Duration(days: 1)));
      streak = (_lastActiveDate == yesterdayKey) ? streak + 1 : 1;
      _lastActiveDate = today;
    }
    xp += xpAwarded;
    completedSituationIds.add(situationId);
    notifyListeners();
    await _persist();
    return xpAwarded;
  }

  /// Generic XP grant for activities that shouldn't affect the streak
  /// (e.g. the Vault quiz).
  Future<void> addXp(int amount) async {
    xp += amount;
    notifyListeners();
    await _persist();
  }

  bool isSituationCompleted(String situationId) => completedSituationIds.contains(situationId);

  int completedCountFor(Category category) =>
      category.situations.where((s) => completedSituationIds.contains(s.id)).length;
}
