/// Global reader mode controlling how Kannada pronunciation and Hindi meaning
/// are displayed across the entire application.
enum ReaderMode {
  both,
  devanagari,
  roman;

  String get label {
    switch (this) {
      case ReaderMode.both:
        return 'देवनागरी + Roman';
      case ReaderMode.devanagari:
        return 'देवनागरी';
      case ReaderMode.roman:
        return 'Roman Hindi';
    }
  }

  String get shortLabel {
    switch (this) {
      case ReaderMode.both:
        return 'दोनों / Both';
      case ReaderMode.devanagari:
        return 'देवनागरी';
      case ReaderMode.roman:
        return 'Roman';
    }
  }

  static ReaderMode fromString(String? value) {
    return ReaderMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ReaderMode.both,
    );
  }
}

/// Core three-way reading representation required on every learning item:
/// 1. [hindi]: Hindi meaning and translation
/// 2. [devanagari]: Devanagari-script pronunciation of spoken Kannada
/// 3. [romanHindi]: Romanized pronunciation readable by Hindi speakers
class TriScriptText {
  final String hindi;
  final String devanagari;
  final String romanHindi;

  const TriScriptText({
    required this.hindi,
    required this.devanagari,
    required this.romanHindi,
  });

  /// Text passed to the TTS engine (Romanized phonetic approximation or
  /// Devanagari when Kannada voice is unavailable).
  String get speakableText => romanHindi;

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return false;
    return hindi.toLowerCase().contains(q) ||
        devanagari.toLowerCase().contains(q) ||
        romanHindi.toLowerCase().contains(q);
  }

  Map<String, dynamic> toJson() => {
        'hindi': hindi,
        'devanagari': devanagari,
        'romanHindi': romanHindi,
      };

  factory TriScriptText.fromJson(Map<String, dynamic> json) {
    return TriScriptText(
      hindi: json['hindi'] as String? ?? '',
      devanagari: json['devanagari'] as String? ?? '',
      romanHindi: json['romanHindi'] as String? ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriScriptText &&
          runtimeType == other.runtimeType &&
          hindi == other.hindi &&
          devanagari == other.devanagari &&
          romanHindi == other.romanHindi;

  @override
  int get hashCode => Object.hash(hindi, devanagari, romanHindi);
}
