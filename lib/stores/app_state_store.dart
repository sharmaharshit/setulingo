import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/reading_mode.dart';
import '../models/user_profile.dart';
import '../services/persistence_service.dart';

class AppStateStore extends ChangeNotifier {
  final PersistenceService _persistence;

  ReaderMode _readerMode;
  AudioPreferences _audioPreferences;
  final Set<String> _completedScenarios;
  final Set<String> _completedLessons;
  final Map<String, int> _lessonStepProgress;
  bool _isDailyScenarioCompleted;

  AppStateStore(this._persistence)
      : _readerMode = _persistence.loadReaderMode(),
        _audioPreferences = _persistence.loadAudioPreferences(),
        _completedScenarios = _persistence.loadCompletedScenarios(),
        _completedLessons = _persistence.loadCompletedLessons(),
        _lessonStepProgress = _persistence.loadLessonStepProgress(),
        _isDailyScenarioCompleted =
            _persistence.isDailyScenarioCompletedFor(_todayKey());

  static String _todayKey() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  ReaderMode get readerMode => _readerMode;
  AudioPreferences get audioPreferences => _audioPreferences;
  Set<String> get completedScenarios => Set.unmodifiable(_completedScenarios);
  Set<String> get completedLessons => Set.unmodifiable(_completedLessons);
  bool get isDailyScenarioCompleted => _isDailyScenarioCompleted;

  int get completedScenarioCount => _completedScenarios.length;
  int get completedLessonCount => _completedLessons.length;

  Future<void> setReaderMode(ReaderMode mode) async {
    if (_readerMode == mode) return;
    _readerMode = mode;
    await _persistence.saveReaderMode(mode);
    notifyListeners();
  }

  Future<void> updateAudioPreferences(AudioPreferences prefs) async {
    _audioPreferences = prefs;
    await _persistence.saveAudioPreferences(prefs);
    notifyListeners();
  }

  bool isScenarioCompleted(String scenarioId) =>
      _completedScenarios.contains(scenarioId);

  Future<void> toggleScenarioCompleted(String scenarioId) async {
    if (_completedScenarios.contains(scenarioId)) {
      _completedScenarios.remove(scenarioId);
    } else {
      _completedScenarios.add(scenarioId);
    }
    await _persistence.saveCompletedScenarios(_completedScenarios);
    notifyListeners();
  }

  Future<void> markScenarioCompleted(String scenarioId) async {
    if (_completedScenarios.add(scenarioId)) {
      await _persistence.saveCompletedScenarios(_completedScenarios);
      notifyListeners();
    }
  }

  Future<void> markDailyScenarioCompleted(String scenarioId) async {
    _isDailyScenarioCompleted = true;
    await _persistence.saveDailyScenarioStatus(
      dateKey: _todayKey(),
      completed: true,
    );
    await markScenarioCompleted(scenarioId);
  }

  int getLessonStepIndex(String lessonId) =>
      _lessonStepProgress[lessonId] ?? 0;

  bool isLessonCompleted(String lessonId) =>
      _completedLessons.contains(lessonId);

  Future<void> saveLessonStep(String lessonId, int stepIndex) async {
    _lessonStepProgress[lessonId] = stepIndex;
    await _persistence.saveLessonStepProgress(_lessonStepProgress);
    notifyListeners();
  }

  Future<void> markLessonCompleted(String lessonId) async {
    _completedLessons.add(lessonId);
    await _persistence.saveCompletedLessons(_completedLessons);
    notifyListeners();
  }

  Future<void> resetLessonProgress(String lessonId) async {
    _lessonStepProgress[lessonId] = 0;
    _completedLessons.remove(lessonId);
    await _persistence.saveLessonStepProgress(_lessonStepProgress);
    await _persistence.saveCompletedLessons(_completedLessons);
    notifyListeners();
  }
}
