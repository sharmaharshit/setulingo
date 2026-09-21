// All app content lives here.
// Kannada spoken patterns from Bangalore usage and Kannada Sahitya Parishat references.

class KWord {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final String? note;

  const KWord({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    this.note,
  });
}

class Chunk {
  final String roman;
  final String deva;
  final String hindi;

  const Chunk(this.roman, this.deva, this.hindi);
}

sealed class LessonStep {
  const LessonStep();
}

class PhraseStep extends LessonStep {
  final String roman;
  final String deva;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;

  const PhraseStep({
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
  });
}

class BuildStep extends LessonStep {
  final String promptHindi;
  final List<String> answerRoman;
  final List<String> answerDeva;
  final List<String> tilesRoman;
  final List<String> tilesDeva;
  final String revealRoman;
  final String revealDeva;

  const BuildStep({
    required this.promptHindi,
    required this.answerRoman,
    required this.answerDeva,
    required this.tilesRoman,
    required this.tilesDeva,
    required this.revealRoman,
    required this.revealDeva,
  });
}

class UseStep extends LessonStep {
  final String situation;
  final String question;
  final List<String> optionsRoman;
  final List<String> optionsDeva;
  final int answerIndex;
  final String reveal;

  const UseStep({
    required this.situation,
    required this.question,
    required this.optionsRoman,
    required this.optionsDeva,
    required this.answerIndex,
    required this.reveal,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final List<LessonStep> steps;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.steps,
  });
}

class KSentence {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;

  const KSentence({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
  });
}

class KSituation {
  final String id;
  final String title;
  final String hindiTitle;
  final String description;
  final List<KSentence> sentences;

  const KSituation({
    required this.id,
    required this.title,
    required this.hindiTitle,
    required this.description,
    required this.sentences,
  });
}

class Category {
  final String id;
  final String emoji;
  final String title;
  final String hindiTitle;
  final String blurb;
  final List<KSituation> situations;

  const Category({
    required this.id,
    required this.emoji,
    required this.title,
    required this.hindiTitle,
    required this.blurb,
    required this.situations,
  });
}

class WordConnection {
  final String hindi;
  final String kannadaRoman;
  final String kannadaDeva;
  final String type;
  final String note;

  const WordConnection({
    required this.hindi,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.type,
    required this.note,
  });
}

// ---------------------------------------------------------------------------
// 3-Dropdown Modular Sentence Lab Definitions
// ---------------------------------------------------------------------------

class DropdownOption {
  final String id;
  final String roman;
  final String deva;
  final String hindi;

  const DropdownOption({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
  });
}

final List<DropdownOption> startersList = [
  const DropdownOption(id: 'nanage', roman: 'Nanage', deva: 'ननगे', hindi: 'मुझे'),
  const DropdownOption(id: 'ondu', roman: 'Ondu', deva: 'ओन्दु', hindi: 'एक'),
  const DropdownOption(id: 'innondu', roman: 'Innondu', deva: 'इन्नोन्दु', hindi: 'एक और'),
  const DropdownOption(id: 'swalpa', roman: 'Swalpa', deva: 'स्वल्प', hindi: 'थोड़ा'),
  const DropdownOption(id: 'illi', roman: 'Illi', deva: 'इल्लि', hindi: 'यहाँ'),
  const DropdownOption(id: 'munde', roman: 'Munde', deva: 'मुंदे', hindi: 'आगे'),
  const DropdownOption(id: 'naavu', roman: 'Naavu', deva: 'नावु', hindi: 'हम'),
];

final List<DropdownOption> topicsList = [
  const DropdownOption(id: 'coffee', roman: 'coffee', deva: 'कॉफ़ी', hindi: 'कॉफ़ी'),
  const DropdownOption(id: 'tea', roman: 'tea', deva: 'टी', hindi: 'चाय'),
  const DropdownOption(id: 'dose', roman: 'dose', deva: 'दोसे', hindi: 'डोसा'),
  const DropdownOption(id: 'neeru', roman: 'neeru', deva: 'नीरु', hindi: 'पानी'),
  const DropdownOption(id: 'bill', roman: 'bill', deva: 'बिल', hindi: 'बिल'),
  const DropdownOption(id: 'metro', roman: 'metro station-ge', deva: 'मेट्रो स्टेशन-गे', hindi: 'मेट्रो स्टेशन'),
  const DropdownOption(id: 'office', roman: 'office-ge', deva: 'ऑफ़िस-गे', hindi: 'ऑफ़िस'),
  const DropdownOption(id: 'indiranagar', roman: 'Indiranagar-ge', deva: 'इंदिरानगर-गे', hindi: 'इंदिरानगर'),
  const DropdownOption(id: 'right', roman: 'right', deva: 'राइट', hindi: 'दाएँ'),
  const DropdownOption(id: 'left', roman: 'left', deva: 'लेफ्ट', hindi: 'बाएँ'),
  const DropdownOption(id: 'kammi', roman: 'kammi', deva: 'कम्मि', hindi: 'कम'),
  const DropdownOption(id: 'adjust', roman: 'adjust', deva: 'एडजस्ट', hindi: 'एडजस्ट'),
  const DropdownOption(id: 'help', roman: 'help', deva: 'हेल्प', hindi: 'मदद'),
  const DropdownOption(id: 'cover', roman: 'cover', deva: 'कवर', hindi: 'थैली / बैग'),
];

final List<DropdownOption> endingsList = [
  const DropdownOption(id: 'beku', roman: 'beku.', deva: 'बेकु।', hindi: 'चाहिए।'),
  const DropdownOption(id: 'beda', roman: 'beda.', deva: 'बेडा।', hindi: 'नहीं चाहिए।'),
  const DropdownOption(id: 'kodi', roman: 'kodi.', deva: 'कोडि।', hindi: 'दीजिए।'),
  const DropdownOption(id: 'hogbeku', roman: 'hogbeku.', deva: 'होगबेकु।', hindi: 'जाना है।'),
  const DropdownOption(id: 'nilisi', roman: 'nilisi.', deva: 'निलिसि।', hindi: 'रोकिए।'),
  const DropdownOption(id: 'maadi', roman: 'maadi.', deva: 'माडि।', hindi: 'कीजिए।'),
  const DropdownOption(id: 'haaki', roman: 'haaki.', deva: 'हाकि।', hindi: 'डालिए।'),
  const DropdownOption(id: 'thagoli', roman: 'thagoli.', deva: 'थगोळ्ळि।', hindi: 'लीजिए (मोड़)।'),
  const DropdownOption(id: 'idiya', roman: 'idiya?', deva: 'इदिया?', hindi: 'है क्या?'),
];

// ---------------------------------------------------------------------------
// All Words Dictionary
// ---------------------------------------------------------------------------

final List<KWord> allWords = [
  const KWord(id: 'nanage', roman: 'Nanage', deva: 'ननगे', hindi: 'मुझे', note: 'वाक्य की शुरुआत में आता है।'),
  const KWord(id: 'beku', roman: 'Beku', deva: 'बेकु', hindi: 'चाहिए', note: 'वाक्य के अंत में: Nanage + चीज़ + beku.'),
  const KWord(id: 'beda', roman: 'Beda', deva: 'बेडा', hindi: 'नहीं चाहिए', note: 'वाक्य के अंत में आता है।'),
  const KWord(id: 'saaku', roman: 'Saaku', deva: 'साकु', hindi: 'बस / काफ़ी है', note: 'रुकवाने के लिए (काफ़ी है)।'),
  const KWord(id: 'enu', roman: 'Enu', deva: 'एनु', hindi: 'क्या'),
  const KWord(id: 'ondu', roman: 'Ondu', deva: 'ओन्दु', hindi: 'एक'),
  const KWord(id: 'innondu', roman: 'Innondu', deva: 'इन्नोन्दु', hindi: 'एक और'),
  const KWord(id: 'kodi', roman: 'Kodi', deva: 'कोडि', hindi: 'दीजिए', note: 'माँगने का विनम्र तरीक़ा।'),
  const KWord(id: 'eshtu', roman: 'Eshtu', deva: 'एष्टु', hindi: 'कितना'),
  const KWord(id: 'aaytu', roman: 'Aaytu', deva: 'आयतु', hindi: 'हो गया', note: 'Eshtu aaytu? = कितना हुआ?'),
  const KWord(id: 'coffee', roman: 'Coffee', deva: 'कॉफ़ी', hindi: 'कॉफ़ी'),
  const KWord(id: 'dose', roman: 'Dose', deva: 'दोसे', hindi: 'डोसा'),
  const KWord(id: 'tea', roman: 'Tea', deva: 'टी', hindi: 'चाय'),
  const KWord(id: 'neeru', roman: 'Neeru', deva: 'नीरु', hindi: 'पानी'),
  const KWord(id: 'illi', roman: 'Illi', deva: 'इल्लि', hindi: 'यहाँ'),
  const KWord(id: 'alli', roman: 'Alli', deva: 'अल्लि', hindi: 'वहाँ'),
  const KWord(id: 'nilisi', roman: 'Nilisi', deva: 'निलिसि', hindi: 'रोकिए', note: 'ऑटो/गाड़ी रोकने के लिए।'),
  const KWord(id: 'hogbeku', roman: 'Hogbeku', deva: 'होगबेकु', hindi: 'जाना है'),
  const KWord(id: 'swalpa', roman: 'Swalpa', deva: 'स्वल्प', hindi: 'थोड़ा', note: 'Swalpa adjust maadi!'),
  const KWord(id: 'banni', roman: 'Banni', deva: 'बन्नि', hindi: 'आइए', note: 'आदर सहित बुलाने के लिए।'),
  const KWord(id: 'hegiddira', roman: 'Hegiddira', deva: 'हेगिद्दीरा', hindi: 'कैसे हैं आप', note: 'अभिवादन में।'),
  const KWord(id: 'chennagide', roman: 'Chennagide', deva: 'चेन्नागिदे', hindi: 'बढ़िया है / ठीक है'),
  const KWord(id: 'gottu', roman: 'Gottu', deva: 'गोत्तु', hindi: 'पता है / मालूम है'),
  const KWord(id: 'gottilla', roman: 'Gottilla', deva: 'गोत्तिल्ला', hindi: 'मालूम नहीं है'),
  const KWord(id: 'parvaagilla', roman: 'Parvaagilla', deva: 'पर्वागिल्ला', hindi: 'कोई बात नहीं'),
];

final Map<String, KWord> wordsById = {for (final w in allWords) w.id: w};

// ---------------------------------------------------------------------------
// Sanskrit Cognates (Tatsama)
// ---------------------------------------------------------------------------

final List<WordConnection> connections = [
  const WordConnection(
    hindi: 'समय',
    kannadaRoman: 'samaya',
    kannadaDeva: 'समय',
    type: 'Tatsama (संस्कृत समान)',
    note: 'दोनों भाषाओं में एक ही संस्कृत शब्द जस का तस उपयोग होता है।',
  ),
  const WordConnection(
    hindi: 'स्वागत',
    kannadaRoman: 'swaagata',
    kannadaDeva: 'स्वागत',
    type: 'Tatsama (संस्कृत समान)',
    note: 'स्वागत करने के लिए दोनों भाषाओं में समान रूप से बोला जाता है।',
  ),
  const WordConnection(
    hindi: 'धन्यवाद',
    kannadaRoman: 'dhanyavaadagalu',
    kannadaDeva: 'धन्यवादगळु',
    type: 'Tatsama (संस्कृत समान)',
    note: 'कन्नड़ में बहुवचन प्रत्यय (-गळु) जोड़कर और अधिक सम्मान दिया जाता है।',
  ),
  const WordConnection(
    hindi: 'कारण',
    kannadaRoman: 'kaarana',
    kannadaDeva: 'कारण',
    type: 'Tatsama (संस्कृत समान)',
    note: 'वजह या कारण बताने के लिए दोनों भाषाओं में एक ही शब्द है।',
  ),
  const WordConnection(
    hindi: 'रात',
    kannadaRoman: 'raatri',
    kannadaDeva: 'रात्रि',
    type: 'हिंदी तद्भव · कन्नड़ तत्सम',
    note: 'संस्कृत "रात्रि" हिंदी में घिसकर रात बना, पर कन्नड़ में मूल रूप में रहा।',
  ),
  const WordConnection(
    hindi: 'मुँह / चेहरा',
    kannadaRoman: 'mukha',
    kannadaDeva: 'मुख',
    type: 'संस्कृत तत्सम',
    note: 'कन्नड़ में mukha का अर्थ चेहरा (face) है, और मुँह को baayi कहते हैं।',
  ),
];

// ---------------------------------------------------------------------------
// 7 Categories x 5 Situations = 35 Situations
// ---------------------------------------------------------------------------

final List<Category> categories = [
  // 1. Food & Darshini
  Category(
    id: 'food',
    emoji: '🍛',
    title: 'Food & Darshini',
    hindiTitle: 'खाना और दर्शिनी',
    blurb: 'टोकन, ऑर्डर, रिफिल और बिलिंग',
    situations: [
      const KSituation(
        id: 'food_counter',
        title: 'Ordering at Counter',
        hindiTitle: 'काउंटर पर नाश्ता व कॉफ़ी',
        description: 'टोकन काउंटर पर ऑर्डर करते समय:',
        sentences: [
          KSentence(
            id: 'f1',
            roman: 'Nanage ondu coffee beku.',
            deva: 'ननगे ओन्दु कॉफ़ी बेकु।',
            hindi: 'मुझे एक कॉफ़ी चाहिए।',
            chunks: [
              Chunk('Nanage', 'ननगे', 'मुझे'),
              Chunk('ondu', 'ओन्दु', 'एक'),
              Chunk('coffee', 'कॉफ़ी', 'कॉफ़ी'),
              Chunk('beku', 'बेकु', 'चाहिए'),
            ],
          ),
          KSentence(
            id: 'f2',
            roman: 'Ondu masala dose kodi.',
            deva: 'ओन्दु मसाला दोसे कोडि।',
            hindi: 'एक मसाला डोसा दीजिए।',
            chunks: [
              Chunk('Ondu', 'ओन्दु', 'एक'),
              Chunk('masala dose', 'मसाला दोसे', 'मसाला डोसा'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
          KSentence(
            id: 'f3',
            roman: 'Innondu tea kodi.',
            deva: 'इन्नोन्दु टी कोडि।',
            hindi: 'एक और चाय दीजिए।',
            chunks: [
              Chunk('Innondu', 'इन्नोन्दु', 'एक और'),
              Chunk('tea', 'टी', 'चाय'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_refill',
        title: 'Refills & Serving',
        hindiTitle: 'सांभर माँगना व रुकवाना',
        description: 'खाना परोसते समय सांभर या चटनी के लिए:',
        sentences: [
          KSentence(
            id: 'f4',
            roman: 'Swalpa sambar haaki.',
            deva: 'स्वल्प सांबार हाकि।',
            hindi: 'थोड़ा सांभर डालिए।',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('sambar', 'सांबार', 'सांभर'),
              Chunk('haaki', 'हाकि', 'डालिए'),
            ],
          ),
          KSentence(
            id: 'f5',
            roman: 'Saaku, beda.',
            deva: 'साकु, बेडा।',
            hindi: 'बस, नहीं चाहिए।',
            chunks: [
              Chunk('Saaku', 'साकु', 'बस / काफ़ी है'),
              Chunk('beda', 'बेडा', 'नहीं चाहिए'),
            ],
          ),
          KSentence(
            id: 'f6',
            roman: 'Neeru kodi.',
            deva: 'नीरु कोडि।',
            hindi: 'पानी दीजिए।',
            chunks: [
              Chunk('Neeru', 'नीरु', 'पानी'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_custom',
        title: 'Custom Taste & Parcel',
        hindiTitle: 'कम चीनी व पार्सल पैक',
        description: 'स्वाद में बदलाव या पार्सल करवाना:',
        sentences: [
          KSentence(
            id: 'f7',
            roman: 'Sugar kammi maadi.',
            deva: 'शुगर कम्मि माडि।',
            hindi: 'चीनी कम कीजिए।',
            chunks: [
              Chunk('Sugar', 'शुगर', 'चीनी'),
              Chunk('kammi', 'कम्मि', 'कम'),
              Chunk('maadi', 'माडि', 'कीजिए'),
            ],
          ),
          KSentence(
            id: 'f8',
            roman: 'Parcel kodi.',
            deva: 'पार्सल कोडि।',
            hindi: 'पार्सल (पैक करके) दीजिए।',
            chunks: [
              Chunk('Parcel', 'पार्सल', 'पार्सल'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_bill',
        title: 'Billing & UPI',
        hindiTitle: 'बिल पूछना व भुगतान',
        description: 'खाते समय हिसाब और पेमेंट:',
        sentences: [
          KSentence(
            id: 'f9',
            roman: 'Eshtu aaytu?',
            deva: 'एष्टु आयतु?',
            hindi: 'कितना हुआ?',
            chunks: [
              Chunk('Eshtu', 'एष्टु', 'कितना'),
              Chunk('aaytu', 'आयतु', 'हुआ'),
            ],
          ),
          KSentence(
            id: 'f10',
            roman: 'QR code idiya?',
            deva: 'क्यूआर कोड इदिया?',
            hindi: 'क्या क्यूआर कोड है?',
            chunks: [
              Chunk('QR code', 'क्यूआर कोड', 'क्यूआर कोड'),
              Chunk('idiya?', 'इदिया?', 'है क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_ask',
        title: 'Asking what is Fresh',
        hindiTitle: 'पूछना क्या ताज़ा है',
        description: 'काउंटर पर मेन्यू के बारे में पूछना:',
        sentences: [
          KSentence(
            id: 'f11',
            roman: 'Enu special ide?',
            deva: 'एनु स्पेशल इदे?',
            hindi: 'क्या स्पेशल है?',
            chunks: [
              Chunk('Enu', 'एनु', 'क्या'),
              Chunk('special', 'स्पेशल', 'स्पेशल'),
              Chunk('ide?', 'इदे?', 'है?'),
            ],
          ),
          KSentence(
            id: 'f12',
            roman: 'Dose bisi idiya?',
            deva: 'दोसे बिसि इदिया?',
            hindi: 'क्या डोसा गरम है?',
            chunks: [
              Chunk('Dose', 'दोसे', 'डोसा'),
              Chunk('bisi', 'बिसि', 'गरम'),
              Chunk('idiya?', 'इदिया?', 'है क्या?'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 2. Autos & Travel
  Category(
    id: 'autos',
    emoji: '🛺',
    title: 'Autos & Travel',
    hindiTitle: 'ऑटो और सफ़र',
    blurb: 'दिशा, मीटर, किराया और रुकवाना',
    situations: [
      const KSituation(
        id: 'auto_dest',
        title: 'Destination & Asking',
        hindiTitle: 'कहाँ जाना है व पूछना',
        description: 'ऑटो ड्राइवर से बात शुरू करते समय:',
        sentences: [
          KSentence(
            id: 'a1',
            roman: 'Indiranagar-ge hogbeku.',
            deva: 'इंदिरानगर-गे होगबेकु।',
            hindi: 'इंदिरानगर जाना है।',
            chunks: [
              Chunk('Indiranagar-ge', 'इंदिरानगर-गे', 'इंदिरानगर को'),
              Chunk('hogbeku', 'होगबेकु', 'जाना है'),
            ],
          ),
          KSentence(
            id: 'a2',
            roman: 'Barthira?',
            deva: 'बर्तीरा?',
            hindi: 'चलेंगे क्या? (आएँगे?)',
            chunks: [
              Chunk('Barthira?', 'बर्तीरा?', 'आएँगे क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_meter',
        title: 'Meter & Fare',
        hindiTitle: 'मीटर व किराया',
        description: 'मीटर चालू करवाने के लिए:',
        sentences: [
          KSentence(
            id: 'a3',
            roman: 'Meter haaki sir.',
            deva: 'मीटर हाकि सर।',
            hindi: 'मीटर चालू कीजिए सर।',
            chunks: [
              Chunk('Meter', 'मीटर', 'मीटर'),
              Chunk('haaki', 'हाकि', 'डालिए'),
              Chunk('sir', 'सर', 'सर'),
            ],
          ),
          KSentence(
            id: 'a4',
            roman: 'Eshtu aagathe?',
            deva: 'एष्टु आगत्ते?',
            hindi: 'कितना रुपया होगा?',
            chunks: [
              Chunk('Eshtu', 'एष्टु', 'कितना'),
              Chunk('aagathe?', 'आगत्ते?', 'होगा?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_turns',
        title: 'Turns & Directions',
        hindiTitle: 'मोड़ व दिशा बताना',
        description: 'ड्राइवर को रास्ता समझाते समय:',
        sentences: [
          KSentence(
            id: 'a5',
            roman: 'Munde right thagoli.',
            deva: 'मुंदे राइट थगोळ्ळि।',
            hindi: 'आगे राइट (दाएँ) लीजिए।',
            chunks: [
              Chunk('Munde', 'मुंदे', 'आगे'),
              Chunk('right', 'राइट', 'दाएँ'),
              Chunk('thagoli', 'थगोळ्ळि', 'लीजिए'),
            ],
          ),
          KSentence(
            id: 'a6',
            roman: 'Left thagoli.',
            deva: 'लेफ्ट थगोळ्ळि।',
            hindi: 'लेफ्ट (बाएँ) लीजिए।',
            chunks: [
              Chunk('Left', 'लेफ्ट', 'बाएँ'),
              Chunk('thagoli', 'थगोळ्ळि', 'लीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_stop',
        title: 'Stopping & Change',
        hindiTitle: 'रोकना व छुट्टे पैसे',
        description: 'उतरते समय रोकना और छुट्टे पूछना:',
        sentences: [
          KSentence(
            id: 'a7',
            roman: 'Illi nilisi.',
            deva: 'इल्लि निलिसि।',
            hindi: 'यहाँ रोकिए।',
            chunks: [
              Chunk('Illi', 'इल्लि', 'यहाँ'),
              Chunk('nilisi', 'निलिसि', 'रोकिए'),
            ],
          ),
          KSentence(
            id: 'a8',
            roman: 'Cilre ideyaa?',
            deva: 'चिल्रे इदिया?',
            hindi: 'क्या छुट्टे पैसे हैं?',
            chunks: [
              Chunk('Cilre', 'चिल्रे', 'छुट्टे पैसे'),
              Chunk('ideyaa?', 'इदिया?', 'हैं क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_traffic',
        title: 'Traffic & Delay',
        hindiTitle: 'ट्रैफ़िक व समय',
        description: 'रास्ते में ट्रैफ़िक के बारे में पूछना:',
        sentences: [
          KSentence(
            id: 'a9',
            roman: 'Traffic jaasti ide.',
            deva: 'ट्रैफ़िक जास्ती इदे।',
            hindi: 'ट्रैफ़िक बहुत ज़्यादा है।',
            chunks: [
              Chunk('Traffic', 'ट्रैफ़िक', 'ट्रैफ़िक'),
              Chunk('jaasti', 'जास्ती', 'ज़्यादा'),
              Chunk('ide', 'इदे', 'है'),
            ],
          ),
          KSentence(
            id: 'a10',
            roman: 'Swalpa bega hogi.',
            deva: 'स्वल्प बेग होगि।',
            hindi: 'थोड़ा जल्दी चलिए।',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('bega', 'बेग', 'जल्दी'),
              Chunk('hogi', 'होगि', 'चलिए'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 3. Market & Shops
  Category(
    id: 'market',
    emoji: '🛒',
    title: 'Market & Shops',
    hindiTitle: 'बाज़ार और दुकानें',
    blurb: 'दाम, तोलना, मोलभाव और बैग',
    situations: [
      const KSituation(
        id: 'market_price',
        title: 'Asking Price',
        hindiTitle: 'दाम पूछना',
        description: 'फल-सब्ज़ी या सामान का भाव पूछना:',
        sentences: [
          KSentence(
            id: 'm1',
            roman: 'Idhu eshtu?',
            deva: 'इदु एष्टु?',
            hindi: 'यह कितने का है?',
            chunks: [
              Chunk('Idhu', 'इदु', 'यह'),
              Chunk('eshtu?', 'एष्टु?', 'कितना?'),
            ],
          ),
          KSentence(
            id: 'm2',
            roman: 'Kilo-ge eshtu?',
            deva: 'किलो-गे एष्टु?',
            hindi: 'प्रति किलो क्या भाव है?',
            chunks: [
              Chunk('Kilo-ge', 'किलो-गे', 'किलो का'),
              Chunk('eshtu?', 'एष्टु?', 'कितना?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'market_quantity',
        title: 'Weighing & Quantity',
        hindiTitle: 'मात्रा व तोलना',
        description: 'सब्ज़ी या फल की मात्रा बताना:',
        sentences: [
          KSentence(
            id: 'm3',
            roman: 'Ondu kilo tomato kodi.',
            deva: 'ओन्दु किलो टोमॅटो कोडि।',
            hindi: 'एक किलो टमाटर दीजिए।',
            chunks: [
              Chunk('Ondu kilo', 'ओन्दु किलो', 'एक किलो'),
              Chunk('tomato', 'टोमॅटो', 'टमाटर'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
          KSentence(
            id: 'm4',
            roman: 'Ardha kilo kodi.',
            deva: 'अर्ध किलो कोडि।',
            hindi: 'आधा किलो दीजिए।',
            chunks: [
              Chunk('Ardha kilo', 'अर्ध किलो', 'आधा किलो'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'market_bargain',
        title: 'Bargaining & Discount',
        hindiTitle: 'मोलभाव व कम कराना',
        description: 'दाम थोड़ा कम करने की बात करना:',
        sentences: [
          KSentence(
            id: 'm5',
            roman: 'Swalpa kammi maadi.',
            deva: 'स्वल्प कम्मि माडि।',
            hindi: 'थोड़ा कम कीजिए।',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('kammi', 'कम्मि', 'कम'),
              Chunk('maadi', 'माडि', 'कीजिए'),
            ],
          ),
          KSentence(
            id: 'm6',
            roman: 'Rate jaasti aaytu.',
            deva: 'रेट जास्ती आयतु।',
            hindi: 'दाम बहुत ज़्यादा है।',
            chunks: [
              Chunk('Rate', 'रेट', 'दाम'),
              Chunk('jaasti', 'जास्ती', 'ज़्यादा'),
              Chunk('aaytu', 'आयतु', 'हो गया'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'market_quality',
        title: 'Checking Freshness',
        hindiTitle: 'ताज़गी परखना',
        description: 'सब्ज़ी व फल की ताज़गी के बारे में:',
        sentences: [
          KSentence(
            id: 'm7',
            roman: 'Idhu fresh idiya?',
            deva: 'इदु फ्रेश इदिया?',
            hindi: 'क्या यह ताज़ा है?',
            chunks: [
              Chunk('Idhu', 'इदु', 'यह'),
              Chunk('fresh', 'फ्रेश', 'ताज़ा'),
              Chunk('idiya?', 'इदिया?', 'है क्या?'),
            ],
          ),
          KSentence(
            id: 'm8',
            roman: 'Olledhu kodi.',
            deva: 'ओळ्ळेदु कोडि।',
            hindi: 'अच्छा वाला छांट कर दीजिए।',
            chunks: [
              Chunk('Olledhu', 'ओळ्ळेदु', 'अच्छा वाला'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'market_bag',
        title: 'Carry Bag & Packaging',
        hindiTitle: 'थैली व कवर माँगना',
        description: 'सामान रखने के लिए बैग माँगना:',
        sentences: [
          KSentence(
            id: 'm9',
            roman: 'Cover idiya?',
            deva: 'कवर इदिया?',
            hindi: 'क्या थैली/कवर है?',
            chunks: [
              Chunk('Cover', 'कवर', 'थैली / बैग'),
              Chunk('idiya?', 'इदिया?', 'है क्या?'),
            ],
          ),
          KSentence(
            id: 'm10',
            roman: 'Cover beku.',
            deva: 'कवर बेकु।',
            hindi: 'मुझे एक थैली चाहिए।',
            chunks: [
              Chunk('Cover', 'कवर', 'थैली'),
              Chunk('beku', 'बेकु', 'चाहिए'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 4. Colleagues & Workplace
  Category(
    id: 'colleagues',
    emoji: '💼',
    title: 'Colleagues & Workplace',
    hindiTitle: 'सहकर्मी और ऑफ़िस',
    blurb: 'चाय ब्रेक, मदद, स्टेटस और मीटिंग्स',
    situations: [
      const KSituation(
        id: 'work_chai',
        title: 'Chai & Lunch Break',
        hindiTitle: 'चाय व खाने के लिए चलना',
        description: 'सहकर्मियों को ब्रेक पर साथ चलने को कहना:',
        sentences: [
          KSentence(
            id: 'c1',
            roman: 'Tea kudiyona banni.',
            deva: 'टी कुडियोण बन्नि।',
            hindi: 'आइए चाय पीने चलते हैं।',
            chunks: [
              Chunk('Tea', 'टी', 'चाय'),
              Chunk('kudiyona', 'कुडियोण', 'पीते हैं'),
              Chunk('banni', 'बन्नि', 'आइए'),
            ],
          ),
          KSentence(
            id: 'c2',
            roman: 'Oota aaytha?',
            deva: 'ऊट आयता?',
            hindi: 'खाना हो गया क्या?',
            chunks: [
              Chunk('Oota', 'ऊट', 'खाना / भोजन'),
              Chunk('aaytha?', 'आयता?', 'हो गया क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'work_help',
        title: 'Asking for Help',
        hindiTitle: 'काम में मदद माँगना',
        description: 'टास्क या काम में हाथ बँटाने के लिए:',
        sentences: [
          KSentence(
            id: 'c3',
            roman: 'Swalpa help maadthira?',
            deva: 'स्वल्प हेल्प माड्तीरा?',
            hindi: 'थोड़ी मदद करेंगे क्या?',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('help', 'हेल्प', 'मदद'),
              Chunk('maadthira?', 'माड्तीरा?', 'करेंगे क्या?'),
            ],
          ),
          KSentence(
            id: 'c4',
            roman: 'Innomme heli.',
            deva: 'इन्नोम्मे हेळि।',
            hindi: 'एक बार फिर से बोलिए।',
            chunks: [
              Chunk('Innomme', 'इन्नोम्मे', 'एक बार फिर'),
              Chunk('heli', 'हेळि', 'बोलिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'work_status',
        title: 'Work Updates & Checking',
        hindiTitle: 'काम की स्थिति बताना',
        description: 'स्टेटस अपडेट देते समय:',
        sentences: [
          KSentence(
            id: 'c5',
            roman: 'Naanu check maadi heltheeni.',
            deva: 'नानु चेक माडि हेळ्तीनि।',
            hindi: 'मैं देखकर बताता हूँ।',
            chunks: [
              Chunk('Naanu', 'नानु', 'मैं'),
              Chunk('check maadi', 'चेक माडि', 'चेक करके'),
              Chunk('heltheeni', 'हेळ्तीनि', 'बताता हूँ'),
            ],
          ),
          KSentence(
            id: 'c6',
            roman: 'Kelsa aaytu.',
            deva: 'केलसा आयतु।',
            hindi: 'काम पूरा हो गया।',
            chunks: [
              Chunk('Kelsa', 'केलसा', 'काम'),
              Chunk('aaytu', 'आयतु', 'हो गया'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'work_leave',
        title: 'Leave & Late Arrival',
        hindiTitle: 'छुट्टी व देरी की सूचना',
        description: 'छुट्टी या देरी के बारे में बताना:',
        sentences: [
          KSentence(
            id: 'c7',
            roman: 'Naale raja beku.',
            deva: 'नाळे राजा बेकु।',
            hindi: 'मुझे कल छुट्टी चाहिए।',
            chunks: [
              Chunk('Naale', 'नाळे', 'कल'),
              Chunk('raja', 'राजा', 'छुट्टी'),
              Chunk('beku', 'बेकु', 'चाहिए'),
            ],
          ),
          KSentence(
            id: 'c8',
            roman: 'Swalpa late aaguthe.',
            deva: 'स्वल्प लेट आगत्ते।',
            hindi: 'मुझे थोड़ी देर हो जाएगी।',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('late', 'लेट', 'देर'),
              Chunk('aaguthe', 'आगत्ते', 'हो जाएगी'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'work_bye',
        title: 'Leaving Office',
        hindiTitle: 'शाम को विदा लेना',
        description: 'ऑफ़िस से निकलते समय सहकर्मियों से:',
        sentences: [
          KSentence(
            id: 'c9',
            roman: 'Naale sigona.',
            deva: 'नाळे सिगोण।',
            hindi: 'कल मिलते हैं।',
            chunks: [
              Chunk('Naale', 'नाळे', 'कल'),
              Chunk('sigona', 'सिगोण', 'मिलते हैं'),
            ],
          ),
          KSentence(
            id: 'c10',
            roman: 'Naanu hogbartiini.',
            deva: 'नानु होगबर्तीनि।',
            hindi: 'अच्छा, मैं चलता हूँ।',
            chunks: [
              Chunk('Naanu', 'नानु', 'मैं'),
              Chunk('hogbartiini', 'होगबर्तीनि', 'जाकर आता हूँ'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 5. Friends & Youth
  Category(
    id: 'youth',
    emoji: '🧑‍🤝‍🧑',
    title: 'Friends & Youth',
    hindiTitle: 'दोस्त और युवा',
    blurb: 'बेंगलुरु स्लैंग, मस्ती और वीकेंड प्लान',
    situations: [
      const KSituation(
        id: 'youth_bro',
        title: 'Casual Chit-Chat',
        hindiTitle: 'यारों से गपशप (मचा)',
        description: 'दोस्त से मिलते ही हालचाल पूछना:',
        sentences: [
          KSentence(
            id: 'y1',
            roman: 'Macha, enu samaachaara?',
            deva: 'मचा, एनु समाचारा?',
            hindi: 'भाई/यार, क्या खबर है?',
            chunks: [
              Chunk('Macha', 'मचा', 'दोस्त / भाई'),
              Chunk('enu', 'एनु', 'क्या'),
              Chunk('samaachaara?', 'समाचारा?', 'खबर?'),
            ],
          ),
          KSentence(
            id: 'y2',
            roman: 'Bega baa guru.',
            deva: 'बेग बा गुरु।',
            hindi: 'जल्दी आ भाई/गुरु।',
            chunks: [
              Chunk('Bega', 'बेग', 'जल्दी'),
              Chunk('baa', 'बा', 'आ'),
              Chunk('guru', 'गुरु', 'गुरु / यार'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_awesome',
        title: 'Expressing Excitement',
        hindiTitle: 'तारीफ़ व मज़ा (सक्कथ)',
        description: 'कुछ बहुत अच्छा लगने पर कहना:',
        sentences: [
          KSentence(
            id: 'y3',
            roman: 'Sakkath aagide!',
            deva: 'सक्कथ आगिदे!',
            hindi: 'एकदम ज़बरदस्त है!',
            chunks: [
              Chunk('Sakkath', 'सक्कथ', 'शानदार / कमाल'),
              Chunk('aagide', 'आगिदे', 'है'),
            ],
          ),
          KSentence(
            id: 'y4',
            roman: 'Super guru!',
            deva: 'सुपर गुरु!',
            hindi: 'कमाल कर दिया गुरु!',
            chunks: [
              Chunk('Super', 'सुपर', 'शानदार'),
              Chunk('guru', 'गुरु', 'यार / भाई'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_hangout',
        title: 'Going Out & Cafe',
        hindiTitle: 'घूमने व कैफ़े का प्लान',
        description: 'साथ में बाहर जाने की बात:',
        sentences: [
          KSentence(
            id: 'y5',
            roman: 'Ellige hogona?',
            deva: 'एल्लिगे होगोण?',
            hindi: 'कहाँ चलें?',
            chunks: [
              Chunk('Ellige', 'एल्लिगे', 'कहाँ को'),
              Chunk('hogona?', 'होगोण?', 'चलते हैं?'),
            ],
          ),
          KSentence(
            id: 'y6',
            roman: 'Cafe-ge hogona banni.',
            deva: 'कैफ़े-गे होगोण बन्नि।',
            hindi: 'आइए कैफ़े चलते हैं।',
            chunks: [
              Chunk('Cafe-ge', 'कैफ़े-गे', 'कैफ़े को'),
              Chunk('hogona', 'होगोण', 'चलते हैं'),
              Chunk('banni', 'बन्नि', 'आइए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_fun',
        title: 'Chill & No Worries',
        hindiTitle: 'बिंदास व कोई टेंशन नहीं',
        description: 'दोस्त को रिलैक्स रहने के लिए कहना:',
        sentences: [
          KSentence(
            id: 'y7',
            roman: 'Tension thagobeda.',
            deva: 'टेंशन थगोबेडा।',
            hindi: 'टेंशन मत ले भाई।',
            chunks: [
              Chunk('Tension', 'टेंशन', 'तनाव'),
              Chunk('thagobeda', 'थगोबेडा', 'मत लो'),
            ],
          ),
          KSentence(
            id: 'y8',
            roman: 'Bidu macha, parvaagilla.',
            deva: 'बिडु मचा, पर्वागिल्ला।',
            hindi: 'छोड़ यार, कोई बात नहीं।',
            chunks: [
              Chunk('Bidu', 'बिडु', 'छोड़'),
              Chunk('macha', 'मचा', 'यार'),
              Chunk('parvaagilla', 'पर्वागिल्ला', 'कोई बात नहीं'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_later',
        title: 'Catch you Later',
        hindiTitle: 'फिर मिलेंगे',
        description: 'चलते समय दोस्तों से कहना:',
        sentences: [
          KSentence(
            id: 'y9',
            roman: 'Aamele sigona.',
            deva: 'आमेले सिगोण।',
            hindi: 'बाद में मिलते हैं।',
            chunks: [
              Chunk('Aamele', 'आमेले', 'बाद में'),
              Chunk('sigona', 'सिगोण', 'मिलते हैं'),
            ],
          ),
          KSentence(
            id: 'y10',
            roman: 'Call maadu.',
            deva: 'कॉल माडु।',
            hindi: 'फ़ोन करना।',
            chunks: [
              Chunk('Call', 'कॉल', 'कॉल'),
              Chunk('maadu', 'माडु', 'करो'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 6. Elders & Respect
  Category(
    id: 'elders',
    emoji: '👴',
    title: 'Elders & Respect',
    hindiTitle: 'बड़े-बुज़ुर्ग',
    blurb: 'सम्मान, कुशल-मंगल, आदर व विदाई',
    situations: [
      const KSituation(
        id: 'elder_greet',
        title: 'Respectful Greetings',
        hindiTitle: 'आदरपूर्वक नमस्ते',
        description: 'बुज़ुर्गों या वरिष्ठों से मिलते समय:',
        sentences: [
          KSentence(
            id: 'e1',
            roman: 'Namaskara, hegiddira?',
            deva: 'नमस्कार, हेगिद्दीरा?',
            hindi: 'नमस्ते, आप कैसे हैं?',
            chunks: [
              Chunk('Namaskara', 'नमस्कार', 'नमस्ते'),
              Chunk('hegiddira?', 'हेगिद्दीरा?', 'कैसे हैं आप?'),
            ],
          ),
          KSentence(
            id: 'e2',
            roman: 'Chennagiddira?',
            deva: 'चेन्नागिद्दीरा?',
            hindi: 'कुशल-मंगल (सब ठीक) हैं?',
            chunks: [
              Chunk('Chennagiddira?', 'चेन्नागिद्दीरा?', 'ठीक हैं क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_hospitality',
        title: 'Welcoming & Seating',
        hindiTitle: 'आदर से बिठाना व पानी',
        description: 'बुज़ुर्गों का स्वागत करते समय:',
        sentences: [
          KSentence(
            id: 'e3',
            roman: 'Banni, kuutkoļi.',
            deva: 'बन्नि, कूतकोळ्ळि।',
            hindi: 'आइए, बैठिए।',
            chunks: [
              Chunk('Banni', 'बन्नि', 'आइए'),
              Chunk('kuutkoļi', 'कूतकोळ्ळि', 'बैठिए'),
            ],
          ),
          KSentence(
            id: 'e4',
            roman: 'Neeru kudiiri.',
            deva: 'नीरु कुडीरि।',
            hindi: 'पानी पीजिए।',
            chunks: [
              Chunk('Neeru', 'नीरु', 'पानी'),
              Chunk('kudiiri', 'कुडीरि', 'पीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_family',
        title: 'Inquiring About Family',
        hindiTitle: 'परिवार का हालचाल',
        description: 'घर-परिवार के बारे में पूछना:',
        sentences: [
          KSentence(
            id: 'e5',
            roman: 'Maneeli ellaru chennaga iddaara?',
            deva: 'मनेलि एल्लारु चेन्नाग इद्दारा?',
            hindi: 'घर में सब लोग ठीक हैं?',
            chunks: [
              Chunk('Maneeli', 'मनेलि', 'घर में'),
              Chunk('ellaru', 'एल्लारु', 'सभी लोग'),
              Chunk('chennaga iddaara?', 'चेन्नाग इद्दारा?', 'कुशल हैं क्या?'),
            ],
          ),
          KSentence(
            id: 'e6',
            roman: 'Haavdu, ellaru chennagiddare.',
            deva: 'हौदु, एल्लारु चेन्नागिद्दारे।',
            hindi: 'हाँ, सब कुशल-मंगल हैं।',
            chunks: [
              Chunk('Haavdu', 'हौदु', 'हाँ'),
              Chunk('ellaru', 'एल्लारु', 'सभी'),
              Chunk('chennagiddare', 'चेन्नागिद्दारे', 'ठीक हैं'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_thanks',
        title: 'Expressing Deep Thanks',
        hindiTitle: 'बहुत-बहुत धन्यवाद',
        description: 'आभार प्रकट करते समय:',
        sentences: [
          KSentence(
            id: 'e7',
            roman: 'Thumbha dhanyavaadagalu.',
            deva: 'तुंबा धन्यवादगळु।',
            hindi: 'बहुत-बहुत धन्यवाद।',
            chunks: [
              Chunk('Thumbha', 'तुंबा', 'बहुत'),
              Chunk('dhanyavaadagalu', 'धन्यवादगळु', 'धन्यवाद'),
            ],
          ),
          KSentence(
            id: 'e8',
            roman: 'Thumbha kushi aaytu.',
            deva: 'तुंबा खुशी आयतु।',
            hindi: 'बहुत प्रसन्नता हुई।',
            chunks: [
              Chunk('Thumbha', 'तुंबा', 'बहुत'),
              Chunk('kushi', 'खुशी', 'ख़ुशी'),
              Chunk('aaytu', 'आयतु', 'हुई'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_leave',
        title: 'Polite Departure',
        hindiTitle: 'विदा लेते समय',
        description: 'बुज़ुर्गों से आज्ञा लेकर निकलते समय:',
        sentences: [
          KSentence(
            id: 'e9',
            roman: 'Hoog bartiivi.',
            deva: 'होग बर्तिवि।',
            hindi: 'अच्छा, हम चलते हैं (आते हैं)।',
            chunks: [
              Chunk('Hoog', 'होग', 'जाकर'),
              Chunk('bartiivi', 'बर्तिवि', 'आएँगे'),
            ],
          ),
          KSentence(
            id: 'e10',
            roman: 'Hogi banni.',
            deva: 'होगि बन्नि।',
            hindi: 'शुभ यात्रा, फिर आइएगा।',
            chunks: [
              Chunk('Hogi', 'होगि', 'जाकर'),
              Chunk('banni', 'बन्नि', 'आइए'),
            ],
          ),
        ],
      ),
    ],
  ),

  // 7. Apartment & Neighbours
  Category(
    id: 'apartment',
    emoji: '🏠',
    title: 'Apartment & Neighbours',
    hindiTitle: 'घर और पड़ोसी',
    blurb: 'सिक्योरिटी, मेंटेनेंस, नौकरानी व पड़ोसी',
    situations: [
      const KSituation(
        id: 'apt_security',
        title: 'Security & Parcels',
        hindiTitle: 'सिक्योरिटी व पार्सल',
        description: 'गेट पर गार्ड से पार्सल के बारे में पूछना:',
        sentences: [
          KSentence(
            id: 'ap1',
            roman: 'Parcel bandideya?',
            deva: 'पार्सल बंदिदेया?',
            hindi: 'क्या कोई पार्सल आया है?',
            chunks: [
              Chunk('Parcel', 'पार्सल', 'पार्सल'),
              Chunk('bandideya?', 'बंदिदेया?', 'आया है क्या?'),
            ],
          ),
          KSentence(
            id: 'ap2',
            roman: 'Gate open maadi.',
            deva: 'गेट ओपन माडि।',
            hindi: 'गेट खोलिए।',
            chunks: [
              Chunk('Gate', 'गेट', 'दरवाज़ा / गेट'),
              Chunk('open maadi', 'ओपन माडि', 'खोलिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_water',
        title: 'Water & Plumber',
        hindiTitle: 'पानी व प्लंबर की समस्या',
        description: 'फ्लैट में पानी न आने पर शिकायत करना:',
        sentences: [
          KSentence(
            id: 'ap3',
            roman: 'Neeru barthilla.',
            deva: 'नीरु बर्तिल्ला।',
            hindi: 'पानी नहीं आ रहा है।',
            chunks: [
              Chunk('Neeru', 'नीरु', 'पानी'),
              Chunk('barthilla', 'बर्तिल्ला', 'नहीं आ रहा'),
            ],
          ),
          KSentence(
            id: 'ap4',
            roman: 'Plumber eega barthara?',
            deva: 'प्लंबर ईग बर्त्थारा?',
            hindi: 'क्या प्लंबर अभी आएगा?',
            chunks: [
              Chunk('Plumber', 'प्लंबर', 'प्लंबर'),
              Chunk('eega', 'ईग', 'अभी'),
              Chunk('barthara?', 'बर्त्थारा?', 'आएगा क्या?'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_maid',
        title: 'Cook & Maid Instructions',
        hindiTitle: 'बाई व रसोइए से बात',
        description: 'घर पर काम के निर्देश देते समय:',
        sentences: [
          KSentence(
            id: 'ap5',
            roman: 'Naale bega banni.',
            deva: 'नाळे बेग बन्नि।',
            hindi: 'कल जल्दी आइएगा।',
            chunks: [
              Chunk('Naale', 'नाळे', 'कल'),
              Chunk('bega', 'बेग', 'जल्दी'),
              Chunk('banni', 'बन्नि', 'आइए'),
            ],
          ),
          KSentence(
            id: 'ap6',
            roman: 'Clean maadi.',
            deva: 'क्लीन माडि।',
            hindi: 'साफ़ कर दीजिए।',
            chunks: [
              Chunk('Clean', 'क्लीन', 'साफ़'),
              Chunk('maadi', 'माडि', 'कीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_noise',
        title: 'Neighbours & Noise',
        hindiTitle: 'पड़ोसियों से विनम्र बातचीत',
        description: 'शोर कम करने की विनती करते समय:',
        sentences: [
          KSentence(
            id: 'ap7',
            roman: 'Swalpa sound kammi maadi.',
            deva: 'स्वल्प साउंड कम्मि माडि।',
            hindi: 'थोड़ा आवाज़ कम कर लीजिए।',
            chunks: [
              Chunk('Swalpa', 'स्वल्प', 'थोड़ा'),
              Chunk('sound', 'साउंड', 'आवाज़'),
              Chunk('kammi maadi', 'कम्मि माडि', 'कम कीजिए'),
            ],
          ),
          KSentence(
            id: 'ap8',
            roman: 'Saddu maadbedi.',
            deva: 'सद्दु माड्बेडी।',
            hindi: 'शोर मत कीजिए।',
            chunks: [
              Chunk('Saddu', 'सद्दु', 'शोर / आवाज़'),
              Chunk('maadbedi', 'माड्बेडी', 'मत कीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_rent',
        title: 'Rent & Landlord',
        hindiTitle: 'मकान मालिक व किराया',
        description: 'किराया व पेमेंट की बात:',
        sentences: [
          KSentence(
            id: 'ap9',
            roman: 'Rent transfer maadiddiini.',
            deva: 'रेंट ट्रांसफर माडिद्दीनि।',
            hindi: 'मैंने किराया ट्रांसफर कर दिया है।',
            chunks: [
              Chunk('Rent', 'रेंट', 'किराया'),
              Chunk('transfer', 'ट्रांसफर', 'ट्रांसफर'),
              Chunk('maadiddiini', 'माडिद्दीनि', 'कर दिया है'),
            ],
          ),
          KSentence(
            id: 'ap10',
            roman: 'Receipt kodi.',
            deva: 'रसीद कोडि।',
            hindi: 'रसीद दे दीजिए।',
            chunks: [
              Chunk('Receipt', 'रसीद', 'रसीद'),
              Chunk('kodi', 'कोडि', 'दीजिए'),
            ],
          ),
        ],
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Unambiguous Lesson Generator with Clear Wrong Options
// ---------------------------------------------------------------------------

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];

  for (final sentence in situation.sentences) {
    // 1. Chunked phrase study
    steps.add(
      PhraseStep(
        roman: sentence.roman,
        deva: sentence.deva,
        hindi: sentence.hindi,
        chunks: sentence.chunks,
        note: sentence.note,
      ),
    );

    // 2. Unscramble Build Step
    final cleanWordsRoman = sentence.roman
        .replaceAll(RegExp(r'[^\w\s\-]'), '')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();

    final cleanWordsDeva = sentence.deva
        .replaceAll(RegExp(r'[^\w\s\u0900-\u097F\-]'), '')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();

    if (cleanWordsRoman.length >= 2) {
      final tilesRoman = List<String>.from(cleanWordsRoman)..shuffle();
      final tilesDeva = List<String>.from(cleanWordsDeva)..shuffle();

      steps.add(
        BuildStep(
          promptHindi: sentence.hindi,
          answerRoman: cleanWordsRoman,
          answerDeva: cleanWordsDeva,
          tilesRoman: tilesRoman,
          tilesDeva: tilesDeva,
          revealRoman: sentence.roman,
          revealDeva: sentence.deva,
        ),
      );
    }
  }

  // 3. Unambiguous "Use It" quiz for each sentence
  for (final target in situation.sentences) {
    // Clear distractors that mean completely different things
    final distractorsRoman = [
      'Nanage beda.',
      'Illi nilisi.',
      'Eshtu aaytu?',
      'Bega baa guru.',
      'Swalpa kammi maadi.',
    ]..remove(target.roman);

    final distractorsDeva = [
      'ननगे बेडा।',
      'इल्लि निलिसि।',
      'एष्टु आयतु?',
      'बेग बा गुरु।',
      'स्वल्प कम्मि माडि।',
    ]..remove(target.deva);

    final optRoman = [target.roman, distractorsRoman[0], distractorsRoman[1]]..shuffle();
    final optDeva = [target.deva, distractorsDeva[0], distractorsDeva[1]]..shuffle();
    final correctIndex = optRoman.indexOf(target.roman);

    steps.add(
      UseStep(
        situation: situation.description,
        question: 'अगर आपको कहना हो: "${target.hindi}", तो आप क्या बोलेंगे?',
        optionsRoman: optRoman,
        optionsDeva: optDeva,
        answerIndex: correctIndex,
        reveal: '${target.roman} (${target.deva})',
      ),
    );
  }

  return Lesson(
    id: situation.id,
    title: situation.title,
    subtitle: situation.hindiTitle,
    steps: steps,
  );
}
