import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';
import '../services/persistence_service.dart';

/// Abstraction so a real remote authentication provider (e.g. Firebase Auth
/// or custom OTP/OAuth backend) can be integrated later without changing UI code.
abstract class AuthProviderInterface {
  AuthProviderMode get mode;

  Future<UserProfile> signUp({
    required String displayName,
    required String phoneNumber,
    required String email,
  });

  Future<UserProfile> signIn({
    required String identifier,
  });
}

class LocalAuthProvider implements AuthProviderInterface {
  @override
  AuthProviderMode get mode => AuthProviderMode.local;

  @override
  Future<UserProfile> signUp({
    required String displayName,
    required String phoneNumber,
    required String email,
  }) async {
    final normalizedPhone = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    final normalizedEmail = email.trim().toLowerCase();
    final idSeed = normalizedEmail.isNotEmpty
        ? normalizedEmail
        : normalizedPhone;
    final userId = 'local_${idSeed.hashCode.abs()}';

    return UserProfile(
      userId: userId,
      displayName: displayName.trim(),
      phoneNumber: normalizedPhone,
      email: normalizedEmail,
      authMode: AuthProviderMode.local,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<UserProfile> signIn({required String identifier}) async {
    final trimmed = identifier.trim();
    final isEmail = trimmed.contains('@');
    final userId = 'local_${trimmed.toLowerCase().hashCode.abs()}';
    return UserProfile(
      userId: userId,
      displayName: isEmail ? trimmed.split('@').first : 'Learner',
      phoneNumber: isEmail ? '' : trimmed,
      email: isEmail ? trimmed.toLowerCase() : '',
      authMode: AuthProviderMode.local,
      createdAt: DateTime.now(),
    );
  }
}

class UserAuthStore extends ChangeNotifier {
  final PersistenceService _persistence;
  final AuthProviderInterface _provider;

  bool _isAuthenticated = false;
  UserProfile? _currentUser;
  String? _lastError;

  UserAuthStore(
    this._persistence, {
    AuthProviderInterface? provider,
  }) : _provider = provider ?? LocalAuthProvider() {
    _isAuthenticated = _persistence.loadIsAuthenticated();
    _currentUser = _persistence.loadUserProfile();
    if (_isAuthenticated && _currentUser == null) {
      _isAuthenticated = false;
    }
  }

  bool get isAuthenticated => _isAuthenticated;
  UserProfile? get currentUser => _currentUser;
  String? get lastError => _lastError;
  AuthProviderMode get authMode => _provider.mode;

  static String? validatePhone(String? value) {
    final raw = (value ?? '').trim().replaceAll(RegExp(r'[\s\-]'), '');
    if (raw.isEmpty) return 'Please enter your phone number.';
    final digits = raw.startsWith('+') ? raw.substring(1) : raw;
    if (!RegExp(r'^\d{10,15}$').hasMatch(digits)) {
      return 'Enter a valid 10–15 digit phone number.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final raw = (value ?? '').trim();
    if (raw.isEmpty) return 'Please enter your Gmail or email address.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(raw)) {
      return 'Enter a valid email address (e.g., name@gmail.com).';
    }
    return null;
  }

  Future<bool> signUp({
    required String displayName,
    required String phoneNumber,
    required String email,
  }) async {
    _lastError = null;
    if (displayName.trim().length < 2) {
      _lastError = 'Please enter your name (at least 2 characters).';
      notifyListeners();
      return false;
    }
    final phoneErr = validatePhone(phoneNumber);
    if (phoneErr != null) {
      _lastError = phoneErr;
      notifyListeners();
      return false;
    }
    final emailErr = validateEmail(email);
    if (emailErr != null) {
      _lastError = emailErr;
      notifyListeners();
      return false;
    }

    final profile = await _provider.signUp(
      displayName: displayName,
      phoneNumber: phoneNumber,
      email: email,
    );
    _currentUser = profile;
    _isAuthenticated = true;
    await _persistence.saveAuthState(isAuthenticated: true, profile: profile);
    notifyListeners();
    return true;
  }

  Future<bool> signIn({required String identifier}) async {
    _lastError = null;
    final trimmed = identifier.trim();
    if (trimmed.isEmpty) {
      _lastError = 'Enter your registered phone number or Gmail/email.';
      notifyListeners();
      return false;
    }
    if (trimmed.contains('@')) {
      final err = validateEmail(trimmed);
      if (err != null) {
        _lastError = err;
        notifyListeners();
        return false;
      }
    } else {
      final err = validatePhone(trimmed);
      if (err != null) {
        _lastError = err;
        notifyListeners();
        return false;
      }
    }

    final existing = _persistence.loadUserProfile();
    if (existing != null &&
        (existing.email.toLowerCase() == trimmed.toLowerCase() ||
            existing.phoneNumber == trimmed.replaceAll(RegExp(r'[\s\-]'), ''))) {
      _currentUser = existing;
    } else {
      _currentUser = await _provider.signIn(identifier: trimmed);
    }

    _isAuthenticated = true;
    await _persistence.saveAuthState(
      isAuthenticated: true,
      profile: _currentUser,
    );
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    _isAuthenticated = false;
    _lastError = null;
    await _persistence.saveAuthState(isAuthenticated: false);
    notifyListeners();
  }
}
