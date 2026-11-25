import 'reading_mode.dart';

enum VaultSourceType {
  realSpace,
  sentenceLab,
  lesson,
  rootBridge;

  String get label {
    switch (this) {
      case VaultSourceType.realSpace:
        return 'Real Space';
      case VaultSourceType.sentenceLab:
        return 'Sentence Lab';
      case VaultSourceType.lesson:
        return 'Lesson';
      case VaultSourceType.rootBridge:
        return 'Root Bridge';
    }
  }
}

class VaultEntry {
  final String id;
  final TriScriptText text;
  final VaultSourceType sourceType;
  final String sourceTitle;
  final String? note;
  final DateTime savedAt;

  const VaultEntry({
    required this.id,
    required this.text,
    required this.sourceType,
    required this.sourceTitle,
    this.note,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text.toJson(),
        'sourceType': sourceType.name,
        'sourceTitle': sourceTitle,
        'note': note,
        'savedAt': savedAt.toIso8601String(),
      };

  factory VaultEntry.fromJson(Map<String, dynamic> json) {
    return VaultEntry(
      id: json['id'] as String? ?? '',
      text: TriScriptText.fromJson(
        Map<String, dynamic>.from(json['text'] as Map? ?? const {}),
      ),
      sourceType: VaultSourceType.values.firstWhere(
        (e) => e.name == json['sourceType'],
        orElse: () => VaultSourceType.realSpace,
      ),
      sourceTitle: json['sourceTitle'] as String? ?? '',
      note: json['note'] as String?,
      savedAt: DateTime.tryParse(json['savedAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
