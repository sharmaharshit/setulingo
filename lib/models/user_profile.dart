enum AuthProviderMode {
  local;

  String get displayLabel {
    switch (this) {
      case AuthProviderMode.local:
        return 'Local Profile Mode (On-Device)';
    }
  }
}

class AudioPreferences {
  final double speechRate;
  final double pitch;
  final bool autoPlayOnLessonStep;

  const AudioPreferences({
    this.speechRate = 0.45,
    this.pitch = 1.0,
    this.autoPlayOnLessonStep = false,
  });

  AudioPreferences copyWith({
    double? speechRate,
    double? pitch,
    bool? autoPlayOnLessonStep,
  }) {
    return AudioPreferences(
      speechRate: speechRate ?? this.speechRate,
      pitch: pitch ?? this.pitch,
      autoPlayOnLessonStep: autoPlayOnLessonStep ?? this.autoPlayOnLessonStep,
    );
  }

  Map<String, dynamic> toJson() => {
        'speechRate': speechRate,
        'pitch': pitch,
        'autoPlayOnLessonStep': autoPlayOnLessonStep,
      };

  factory AudioPreferences.fromJson(Map<String, dynamic> json) {
    return AudioPreferences(
      speechRate: (json['speechRate'] as num?)?.toDouble() ?? 0.45,
      pitch: (json['pitch'] as num?)?.toDouble() ?? 1.0,
      autoPlayOnLessonStep: json['autoPlayOnLessonStep'] as bool? ?? false,
    );
  }
}

class UserProfile {
  final String userId;
  final String displayName;
  final String phoneNumber;
  final String email;
  final AuthProviderMode authMode;
  final DateTime createdAt;

  const UserProfile({
    required this.userId,
    required this.displayName,
    required this.phoneNumber,
    required this.email,
    this.authMode = AuthProviderMode.local,
    required this.createdAt,
  });

  UserProfile copyWith({
    String? userId,
    String? displayName,
    String? phoneNumber,
    String? email,
    AuthProviderMode? authMode,
    DateTime? createdAt,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      authMode: authMode ?? this.authMode,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'email': email,
        'authMode': authMode.name,
        'createdAt': createdAt.toIso8601String(),
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] as String? ?? '',
      displayName: json['displayName'] as String? ?? 'Learner',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String? ?? '',
      authMode: AuthProviderMode.values.firstWhere(
        (e) => e.name == json['authMode'],
        orElse: () => AuthProviderMode.local,
      ),
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
