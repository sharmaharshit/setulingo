import 'reading_mode.dart';

enum NumberRange {
  zeroToTen,
  elevenToTwenty,
  tensAndHundreds,
  everydayMoneyAndTime;

  String get label {
    switch (this) {
      case NumberRange.zeroToTen:
        return '0 – 10';
      case NumberRange.elevenToTwenty:
        return '11 – 20';
      case NumberRange.tensAndHundreds:
        return '30 – 1000';
      case NumberRange.everydayMoneyAndTime:
        return 'Auto & Market';
    }
  }
}

class KannadaNumber {
  final String id;
  final int value;
  final String displayDigit;
  final NumberRange range;
  final TriScriptText text;
  final String usageHint;

  const KannadaNumber({
    required this.id,
    required this.value,
    required this.displayDigit,
    required this.range,
    required this.text,
    required this.usageHint,
  });
}
