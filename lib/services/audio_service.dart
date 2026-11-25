import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/reading_mode.dart';
import '../models/user_profile.dart';

enum AudioAvailability {
  checking,
  kannadaReady,
  fallbackHindiOrEnglish,
  unavailable,
}

enum AudioPlaybackStatus {
  idle,
  playing,
  unavailableError,
}

class AudioService extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();

  AudioAvailability _availability = AudioAvailability.checking;
  AudioPlaybackStatus _status = AudioPlaybackStatus.idle;
  String? _activeItemId;
  String? _statusMessage;
  String? _configuredLanguage;
  List<String> _availableLocales = const [];
  bool _isInitialized = false;
  double _speechRate = 0.45;
  double _pitch = 1.0;

  AudioAvailability get availability => _availability;
  AudioPlaybackStatus get status => _status;
  String? get activeItemId => _activeItemId;
  String? get statusMessage => _statusMessage;
  String? get configuredLanguage => _configuredLanguage;
  List<String> get availableLocales => _availableLocales;
  bool get isPlaying => _status == AudioPlaybackStatus.playing;

  bool isPlayingItem(String itemId) =>
      _status == AudioPlaybackStatus.playing && _activeItemId == itemId;

  Future<void> initialize({AudioPreferences? prefs}) async {
    if (prefs != null) {
      _speechRate = prefs.speechRate;
      _pitch = prefs.pitch;
    }
    if (_isInitialized) return;
    _isInitialized = true;

    try {
      await _tts.awaitSpeakCompletion(true);
      _tts.setStartHandler(() {
        _status = AudioPlaybackStatus.playing;
        notifyListeners();
      });
      _tts.setCompletionHandler(() {
        _status = AudioPlaybackStatus.idle;
        _activeItemId = null;
        notifyListeners();
      });
      _tts.setCancelHandler(() {
        _status = AudioPlaybackStatus.idle;
        _activeItemId = null;
        notifyListeners();
      });
      _tts.setErrorHandler((msg) {
        _status = AudioPlaybackStatus.unavailableError;
        _activeItemId = null;
        _statusMessage = 'Audio playback failed on this device: $msg';
        notifyListeners();
      });

      await _probeEngineAndVoices();
    } catch (e) {
      _availability = AudioAvailability.unavailable;
      _statusMessage =
          'Text-to-Speech engine is unavailable on this device.';
      notifyListeners();
    }
  }

  Future<void> _probeEngineAndVoices() async {
    try {
      await _tts.setSpeechRate(_speechRate);
      await _tts.setPitch(_pitch);

      final dynamic rawLangs = await _tts.getLanguages;
      if (rawLangs is List) {
        _availableLocales = rawLangs.map((e) => e.toString()).toList();
      }

      // Also check available voices where supported
      try {
        await _tts.getVoices;
      } catch (_) {
        // Some platforms do not support getVoices; safe to ignore
      }

      // Attempt Kannada configuration first (kn-IN, then kn)
      final dynamic knInAvailable = await _tts.isLanguageAvailable('kn-IN');
      if (knInAvailable == true || knInAvailable == 1) {
        final result = await _tts.setLanguage('kn-IN');
        if (result == 1 || result == true) {
          _availability = AudioAvailability.kannadaReady;
          _configuredLanguage = 'kn-IN';
          _statusMessage = 'Kannada (kn-IN) voice ready.';
          notifyListeners();
          return;
        }
      }

      final dynamic knAvailable = await _tts.isLanguageAvailable('kn');
      if (knAvailable == true || knAvailable == 1) {
        final result = await _tts.setLanguage('kn');
        if (result == 1 || result == true) {
          _availability = AudioAvailability.kannadaReady;
          _configuredLanguage = 'kn';
          _statusMessage = 'Kannada (kn) voice ready.';
          notifyListeners();
          return;
        }
      }

      // Graceful fallback: Hindi (hi-IN) or Indian English (en-IN)
      final dynamic hiAvailable = await _tts.isLanguageAvailable('hi-IN');
      if (hiAvailable == true || hiAvailable == 1) {
        await _tts.setLanguage('hi-IN');
        _availability = AudioAvailability.fallbackHindiOrEnglish;
        _configuredLanguage = 'hi-IN';
        _statusMessage =
            'Kannada TTS voice is not installed on this device. Using Hindi (hi-IN) phonetic fallback.';
        notifyListeners();
        return;
      }

      final dynamic enInAvailable = await _tts.isLanguageAvailable('en-IN');
      if (enInAvailable == true || enInAvailable == 1) {
        await _tts.setLanguage('en-IN');
        _availability = AudioAvailability.fallbackHindiOrEnglish;
        _configuredLanguage = 'en-IN';
        _statusMessage =
            'Kannada TTS voice is not installed on this device. Using Indian English (en-IN) phonetic fallback.';
        notifyListeners();
        return;
      }

      _availability = AudioAvailability.unavailable;
      _configuredLanguage = null;
      _statusMessage =
          'No compatible TTS voice (Kannada, Hindi, or English) was found on this device.';
      notifyListeners();
    } catch (_) {
      _availability = AudioAvailability.unavailable;
      _configuredLanguage = null;
      _statusMessage = 'Unable to initialize device Text-to-Speech engine.';
      notifyListeners();
    }
  }

  Future<void> updatePreferences(AudioPreferences prefs) async {
    _speechRate = prefs.speechRate;
    _pitch = prefs.pitch;
    try {
      await _tts.setSpeechRate(_speechRate);
      await _tts.setPitch(_pitch);
    } catch (_) {
      // Ignore if TTS engine is unavailable
    }
    notifyListeners();
  }

  /// Speaks the given [TriScriptText]. Prevents overlapping playback by stopping
  /// any active utterance first. Returns `true` only if playback actually started.
  Future<bool> speak({
    required String itemId,
    required TriScriptText text,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    // Toggle off if already playing this exact item
    if (isPlayingItem(itemId)) {
      await stop();
      return false;
    }

    // Prevent overlapping playback
    await stop();

    if (_availability == AudioAvailability.unavailable) {
      _status = AudioPlaybackStatus.unavailableError;
      _activeItemId = null;
      _statusMessage =
          'Audio unavailable: no Text-to-Speech voice is available on this device.';
      notifyListeners();
      return false;
    }

    final utterance = _configuredLanguage == 'hi-IN'
        ? text.devanagari
        : text.romanHindi;

    if (utterance.trim().isEmpty) {
      _status = AudioPlaybackStatus.unavailableError;
      _statusMessage = 'No speakable text available for this item.';
      notifyListeners();
      return false;
    }

    try {
      _activeItemId = itemId;
      _status = AudioPlaybackStatus.playing;
      notifyListeners();

      final dynamic result = await _tts.speak(utterance);
      if (result == 0 || result == false) {
        _status = AudioPlaybackStatus.unavailableError;
        _activeItemId = null;
        _statusMessage =
            'Device TTS engine could not play this phrase.';
        notifyListeners();
        return false;
      }
      return true;
    } catch (e) {
      _status = AudioPlaybackStatus.unavailableError;
      _activeItemId = null;
      _statusMessage = 'Audio playback error: unable to start speech.';
      notifyListeners();
      return false;
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {
      // Safe no-op if engine unavailable
    }
    _status = AudioPlaybackStatus.idle;
    _activeItemId = null;
    notifyListeners();
  }

  void clearError() {
    if (_status == AudioPlaybackStatus.unavailableError) {
      _status = AudioPlaybackStatus.idle;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
