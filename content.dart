// All app content lives here so it can be reviewed and edited in one place.

class KWord {
  final String id;
  final String roman;
  final String script;
  final String deva;
  final String hindi;
  final String? note;

  const KWord({
    required this.id,
    required this.roman,
    required this.script,
    required this.deva,
    required this.hindi,
    this.note,
  });
}

class Chunk {
  final String roman;
  final String hindi;

  const Chunk(this.roman, this.hindi);
}

class Example {
  final String roman;
  final String hindi;

  const Example(this.roman, this.hindi);
}

sealed class LessonStep {
  const LessonStep();
}

class WordStep extends LessonStep {
  final String wordId;
  const WordStep(this.wordId);
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

class PatternStep extends LessonStep {
  final String romanPattern;
  final String hindiPattern;
  final List<Example> examples;
  final String? note;

  const PatternStep({
    required this.romanPattern,
    required this.hindiPattern,
    required this.examples,
    this.note,
  });
}

class ContrastStep extends LessonStep {
  final String title;
  final Chunk a;
  final Chunk b;
  final Example exampleA;
  final Example exampleB;
  final String? note;

  const ContrastStep({
    required this.title,
    required this.a,
    required this.b,
    required this.exampleA,
    required this.exampleB,
    this.note,
  });
}

class BuildStep extends LessonStep {
  final String promptHindi;
  final List<String> answer;
  final List<String> tiles;
  final String reveal;

  const BuildStep({
    required this.promptHindi,
    required this.answer,
    required this.tiles,
    required this.reveal,
  });
}

class UseStep extends LessonStep {
  final String situation;
  final String? speakerRoman;
  final String? speakerHindi;
  final String question;
  final List<String> options;
  final int answerIndex;
  final String reveal;

  const UseStep({
    required this.situation,
    this.speakerRoman,
    this.speakerHindi,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.reveal,
  });
}

class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final List<String> wordIds;
  final List<LessonStep> steps;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.wordIds,
    required this.steps,
  });
}

class KSentence {
  final String id;
  final String roman;
  final String script;
  final String deva;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;

  const KSentence({
    required this.id,
    required this.roman,
    required this.script,
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
  final Lesson? customLesson;

  const Category({
    required this.id,
    required this.emoji,
    required this.title,
    required this.hindiTitle,
    required this.blurb,
    required this.situations,
    this.customLesson,
  });
}

class WordConnection {
  final String hindi;
  final String hindiRoman;
  final String kannada;
  final String kannadaRoman;
  final String type;
  final String note;

  const WordConnection({
    required this.hindi,
    required this.hindiRoman,
    required this.kannada,
    required this.kannadaRoman,
    required this.type,
    required this.note,
  });
}

// ---------------------------------------------------------------------------
// Sentence Lab Pattern Definitions
// ---------------------------------------------------------------------------

class LabSlotOption {
  final String id;
  final String kannada;
  final String hindi;

  const LabSlotOption({
    required this.id,
    required this.kannada,
    required this.hindi,
  });
}

class LabPattern {
  final String id;
  final String title;
  final String templateRoman;
  final String templateHindi;
  final List<LabSlotOption> slotOptions;
  final String slotPlaceholder;

  const LabPattern({
    required this.id,
    required this.title,
    required this.templateRoman,
    required this.templateHindi,
    required this.slotOptions,
    required this.slotPlaceholder,
  });
}

final List<LabPattern> labPatterns = [
  const LabPattern(
    id: 'need_item',
    title: 'मुझे [सामान] चाहिए',
    templateRoman: 'Nanage {slot} beku.',
    templateHindi: 'मुझे {slot} चाहिए।',
    slotPlaceholder: 'सामान',
    slotOptions: [
      LabSlotOption(id: 'coffee', kannada: 'coffee', hindi: 'कॉफ़ी'),
      LabSlotOption(id: 'tea', kannada: 'tea', hindi: 'चाय'),
      LabSlotOption(id: 'dose', kannada: 'dose', hindi: 'डोसा'),
      LabSlotOption(id: 'neeru', kannada: 'neeru', hindi: 'पानी'),
      LabSlotOption(id: 'bill', kannada: 'bill', hindi: 'बिल'),
      LabSlotOption(id: 'auto', kannada: 'auto', hindi: 'ऑटो'),
    ],
  ),
  const LabPattern(
    id: 'dont_need',
    title: 'मुझे [सामान] नहीं चाहिए',
    templateRoman: 'Nanage {slot} beda.',
    templateHindi: 'मुझे {slot} नहीं चाहिए।',
    slotPlaceholder: 'सामान',
    slotOptions: [
      LabSlotOption(id: 'coffee', kannada: 'coffee', hindi: 'कॉफ़ी'),
      LabSlotOption(id: 'sakkare', kannada: 'sakkare', hindi: 'चीनी'),
      LabSlotOption(id: 'cover', kannada: 'cover', hindi: 'थैली / बैग'),
      LabSlotOption(id: 'khara', kannada: 'khara', hindi: 'तीखा'),
    ],
  ),
  const LabPattern(
    id: 'give_one',
    title: 'एक [सामान] दीजिए',
    templateRoman: 'Ondu {slot} kodi.',
    templateHindi: 'एक {slot} दीजिए।',
    slotPlaceholder: 'सामान',
    slotOptions: [
      LabSlotOption(id: 'coffee', kannada: 'coffee', hindi: 'कॉफ़ी'),
      LabSlotOption(id: 'dose', kannada: 'dose', hindi: 'डोसा'),
      LabSlotOption(id: 'water_bottle', kannada: 'water bottle', hindi: 'पानी की बोतल'),
      LabSlotOption(id: 'spoon', kannada: 'spoon', hindi: 'चम्मच'),
      LabSlotOption(id: 'plate', kannada: 'plate', hindi: 'प्लेट'),
    ],
  ),
  const LabPattern(
    id: 'give_another',
    title: 'एक और [सामान] दीजिए',
    templateRoman: 'Innondu {slot} kodi.',
    templateHindi: 'एक और {slot} दीजिए।',
    slotPlaceholder: 'सामान',
    slotOptions: [
      LabSlotOption(id: 'coffee', kannada: 'coffee', hindi: 'कॉफ़ी'),
      LabSlotOption(id: 'dose', kannada: 'dose', hindi: 'डोसा'),
      LabSlotOption(id: 'idli', kannada: 'idli', hindi: 'इडली'),
      LabSlotOption(id: 'tea', kannada: 'tea', hindi: 'चाय'),
    ],
  ),
  const LabPattern(
    id: 'go_to_place',
    title: '[जगह] जाना है',
    templateRoman: '{slot}-ge hogbeku.',
    templateHindi: '{slot} जाना है।',
    slotPlaceholder: 'स्थान',
    slotOptions: [
      LabSlotOption(id: 'metro', kannada: 'Metro station', hindi: 'मेट्रो स्टेशन'),
      LabSlotOption(id: 'office', kannada: 'Office', hindi: 'ऑफ़िस'),
      LabSlotOption(id: 'market', kannada: 'Market', hindi: 'मार्केट'),
      LabSlotOption(id: 'indiranagar', kannada: 'Indiranagar', hindi: 'इंदिरानगर'),
      LabSlotOption(id: 'koramangala', kannada: 'Koramangala', hindi: 'कोरमंगला'),
      LabSlotOption(id: 'mane', kannada: 'Mane', hindi: 'घर'),
    ],
  ),
  const LabPattern(
    id: 'do_a_little',
    title: 'थोड़ा [क्रिया] कीजिए',
    templateRoman: 'Swalpa {slot} maadi.',
    templateHindi: 'थोड़ा {slot} कीजिए।',
    slotPlaceholder: 'क्रिया / बात',
    slotOptions: [
      LabSlotOption(id: 'adjust', kannada: 'adjust', hindi: 'एडजस्ट'),
      LabSlotOption(id: 'help', kannada: 'help', hindi: 'मदद'),
      LabSlotOption(id: 'kammi', kannada: 'kammi (कम)', hindi: 'कम'),
      LabSlotOption(id: 'check', kannada: 'check', hindi: 'चेक'),
    ],
  ),
];

// ---------------------------------------------------------------------------
// All Words Dictionary (Expanded with Spoken Kannada textbook vocabulary)
// ---------------------------------------------------------------------------

final List<KWord> allWords = [
  const KWord(
    id: 'nanage',
    roman: 'Nanage',
    script: 'ನನಗೆ',
    deva: 'ननगे',
    hindi: 'मुझे',
    note: 'वाक्य की शुरुआत में आता है।',
  ),
  const KWord(
    id: 'beku',
    roman: 'Beku',
    script: 'ಬೇಕು',
    deva: 'बेकु',
    hindi: 'चाहिए',
    note: 'वाक्य के अंत में आता है: Nanage + चीज़ + beku.',
  ),
  const KWord(
    id: 'beda',
    roman: 'Beda',
    script: 'ಬೇಡ',
    deva: 'बेडा',
    hindi: 'नहीं चाहिए',
    note: 'Beku की जगह आता है, वाक्य के अंत में।',
  ),
  const KWord(
    id: 'saaku',
    roman: 'Saaku',
    script: 'ಸಾಕು',
    deva: 'साकु',
    hindi: 'बस / काफ़ी है',
    note: 'जब कोई परोस रहा हो और आपको रुकवाना हो।',
  ),
  const KWord(
    id: 'enu',
    roman: 'Enu',
    script: 'ಏನು',
    deva: 'एनु',
    hindi: 'क्या',
  ),
  const KWord(
    id: 'ondu',
    roman: 'Ondu',
    script: 'ಒಂದು',
    deva: 'ओन्दु',
    hindi: 'एक',
  ),
  const KWord(
    id: 'innondu',
    roman: 'Innondu',
    script: 'ಇನ್ನೊಂದು',
    deva: 'इन्नोन्दु',
    hindi: 'एक और',
  ),
  const KWord(
    id: 'kodi',
    roman: 'Kodi',
    script: 'ಕೊಡಿ',
    deva: 'कोडि',
    hindi: 'दीजिए',
    note: 'विनम्र तरीक़ा। काउंटर और दुकानों पर सबसे ज़्यादा काम आता है।',
  ),
  const KWord(
    id: 'eshtu',
    roman: 'Eshtu',
    script: 'ಎಷ್ಟು',
    deva: 'एष्टु',
    hindi: 'कितना',
  ),
  const KWord(
    id: 'aaytu',
    roman: 'Aaytu',
    script: 'ಆಯ್ತು',
    deva: 'आयतु',
    hindi: 'हुआ / हो गया',
    note: 'Eshtu aaytu? = कितना हुआ? (बिल पूछने के लिए)',
  ),
  const KWord(
    id: 'coffee',
    roman: 'Coffee',
    script: 'ಕಾಫಿ',
    deva: 'कॉफ़ी',
    hindi: 'कॉफ़ी',
    note: 'अंग्रेज़ी शब्द, वैसे का वैसा इस्तेमाल होता है।',
  ),
  const KWord(
    id: 'dose',
    roman: 'Dose',
    script: 'ದೋಸೆ',
    deva: 'दोसे',
    hindi: 'डोसा',
    note: 'मेन्यू में "Dosa" लिखा होता है, बोलचाल में "dose"।',
  ),
  const KWord(
    id: 'tea',
    roman: 'Tea',
    script: 'ಟೀ',
    deva: 'टी',
    hindi: 'चाय',
    note: 'अंग्रेज़ी शब्द, वैसे का वैसा इस्तेमाल होता है।',
  ),
  const KWord(
    id: 'neeru',
    roman: 'Neeru',
    script: 'ನೀರು',
    deva: 'नीरु',
    hindi: 'पानी',
  ),
  const KWord(
    id: 'idli',
    roman: 'Idli',
    script: 'ಇಡ್ಲಿ',
    deva: 'इड्ली',
    hindi: 'इडली',
  ),
  const KWord(
    id: 'illi',
    roman: 'Illi',
    script: 'ಇಲ್ಲಿ',
    deva: 'इल्लि',
    hindi: 'यहाँ',
  ),
  const KWord(
    id: 'alli',
    roman: 'Alli',
    script: 'ಅಲ್ಲಿ',
    deva: 'अल्लि',
    hindi: 'वहाँ',
  ),
  const KWord(
    id: 'nilisi',
    roman: 'Nilisi',
    script: 'ನಿಲ್ಲಿಸಿ',
    deva: 'निलिसि',
    hindi: 'रोकिए',
    note: 'ऑटो या कैब रुकवाने के लिए: Illi nilisi (यहाँ रोकिए)।',
  ),
  const KWord(
    id: 'hogbeku',
    roman: 'Hogbeku',
    script: 'ಹೋಗಬೇಕು',
    deva: 'होगबेकु',
    hindi: 'जाना है',
    note: 'जगह + ge + hogbeku (जैसे Indiranagar-ge hogbeku)।',
  ),
  const KWord(
    id: 'swalpa',
    roman: 'Swalpa',
    script: 'ಸ್ವಲ್ಪ',
    deva: 'स्वल्प',
    hindi: 'थोड़ा',
    note: 'बेंगलुरु का सबसे जादुई शब्द: Swalpa adjust maadi!',
  ),
  const KWord(
    id: 'banni',
    roman: 'Banni',
    script: 'ಬನ್ನಿ',
    deva: 'बन्नि',
    hindi: 'आइए',
    note: 'आदर के साथ बुलाने के लिए (Come)।',
  ),
  const KWord(
    id: 'hegiddira',
    roman: 'Hegiddira',
    script: 'ಹೇಗಿದ್ದೀರಾ',
    deva: 'हेगिद्दीरा',
    hindi: 'कैसे हैं आप',
    note: 'अभिवादन: Namaskara, hegiddira?',
  ),
  const KWord(
    id: 'chennagide',
    roman: 'Chennagide',
    script: 'ಚೆನ್ನಾಗಿದೆ',
    deva: 'चेन्नागिदे',
    hindi: 'अच्छा / बढ़िया है',
  ),
  const KWord(
    id: 'gottu',
    roman: 'Gottu',
    script: 'ಗೊತ್ತು',
    deva: 'गोत्तु',
    hindi: 'पता है / मालूम है',
  ),
  const KWord(
    id: 'gottilla',
    roman: 'Gottilla',
    script: 'ಗೊತ್ತಿಲ್ಲ',
    deva: 'गोत्तिल्ला',
    hindi: 'पता नहीं है / मालूम नहीं',
  ),
  const KWord(
    id: 'parvaagilla',
    roman: 'Parvaagilla',
    script: 'ಪರ್ವಾಗಿಲ್ಲ',
    deva: 'पर्वागिल्ला',
    hindi: 'कोई बात नहीं / ठीक है',
  ),
];

final Map<String, KWord> wordsById = {
  for (final w in allWords) w.id: w,
};

// ---------------------------------------------------------------------------
// Hindi - Kannada Shared Linguistic Connections
// ---------------------------------------------------------------------------

final List<WordConnection> connections = [
  const WordConnection(
    hindi: 'समय',
    hindiRoman: 'samay',
    kannada: 'ಸಮಯ',
    kannadaRoman: 'samaya',
    type: 'Tatsama',
    note: 'एक ही संस्कृत शब्द, दोनों भाषाओं में लगभग जस का तस।',
  ),
  const WordConnection(
    hindi: 'स्वागत',
    hindiRoman: 'swagat',
    kannada: 'ಸ್ವಾಗತ',
    kannadaRoman: 'swaagata',
    type: 'Tatsama',
    note: 'दोनों भाषाओं में "welcome" के लिए।',
  ),
  const WordConnection(
    hindi: 'धन्यवाद',
    hindiRoman: 'dhanyavaad',
    kannada: 'ಧನ್ಯವಾದ',
    kannadaRoman: 'dhanyavaada',
    type: 'Tatsama',
    note: 'कन्नड़ में अक्सर "dhanyavaadagalu" भी सुनने को मिलता है।',
  ),
  const WordConnection(
    hindi: 'कारण',
    hindiRoman: 'kaaran',
    kannada: 'ಕಾರಣ',
    kannadaRoman: 'kaarana',
    type: 'Tatsama',
    note: 'एक ही संस्कृत शब्द, वही मतलब: वजह।',
  ),
  const WordConnection(
    hindi: 'रात',
    hindiRoman: 'raat',
    kannada: 'ರಾತ್ರಿ',
    kannadaRoman: 'raatri',
    type: 'Hindi: Tadbhava · Kannada: Tatsama',
    note: 'संस्कृत रात्रि। हिंदी में घिसकर "रात" बना, कन्नड़ में मूल रूप के क़रीब रहा।',
  ),
  const WordConnection(
    hindi: 'मुँह',
    hindiRoman: 'munh',
    kannada: 'ಮುಖ',
    kannadaRoman: 'mukha',
    type: 'Hindi: Tadbhava · Kannada: Tatsama',
    note: 'संस्कृत मुख। ध्यान दीजिए: कन्नड़ में mukha का मतलब "चेहरा" है, मुँह को "baayi" कहते हैं।',
  ),
  const WordConnection(
    hindi: 'खेत',
    hindiRoman: 'khet',
    kannada: 'ಕ್ಷೇತ್ರ',
    kannadaRoman: 'kshetra',
    type: 'Related',
    note: 'दोनों संस्कृत क्षेत्र से हैं। हिंदी में खेत, कन्नड़ में इलाका या कार्यक्षेत्र।',
  ),
];

// ---------------------------------------------------------------------------
// All Categories & Situations (Unlocked with Bengaluru Spoken Kannada)
// ---------------------------------------------------------------------------

final List<Category> categories = [
  // 1. Food & Darshini
  Category(
    id: 'food',
    emoji: '🍛',
    title: 'Food & Darshini',
    hindiTitle: 'खाना और दर्शिनी',
    blurb: 'ऑर्डर करना, और माँगना, "बस" कहना, बिल पूछना',
    situations: [
      const KSituation(
        id: 'food_ordering',
        title: 'Ordering at Counter',
        hindiTitle: 'काउंटर पर ऑर्डर करना',
        description: 'नाश्ता या कॉफ़ी टोकन लेते समय बोले जाने वाले वाक्य।',
        sentences: [
          KSentence(
            id: 'f1',
            roman: 'Nanage ondu coffee beku.',
            script: 'ನನಗೆ ಒಂದು ಕಾಫಿ ಬೇಕು.',
            deva: 'ननगे ओन्दु कॉफ़ी बेकु।',
            hindi: 'मुझे एक कॉफ़ी चाहिए।',
            chunks: [
              Chunk('Nanage', 'मुझे'),
              Chunk('ondu', 'एक'),
              Chunk('coffee', 'कॉफ़ी'),
              Chunk('beku', 'चाहिए'),
            ],
            note: 'Nanage + चीज़ + beku सबसे मूल ढाँचा है।',
          ),
          KSentence(
            id: 'f2',
            roman: 'Ondu masala dose kodi.',
            script: 'ಒಂದು ಮಸಾಲ ದೋಸೆ ಕೊಡಿ.',
            deva: 'ओन्दु मसाला दोसे कोडि।',
            hindi: 'एक मसाला डोसा दीजिए।',
            chunks: [
              Chunk('Ondu', 'एक'),
              Chunk('masala dose', 'मसाला डोसा'),
              Chunk('kodi', 'दीजिए'),
            ],
            note: 'Kodi विनम्र तरीक़ा है कुछ भी माँगने का।',
          ),
          KSentence(
            id: 'f3',
            roman: 'Innondu tea kodi.',
            script: 'ಇನ್ನೊಂದು ಟೀ ಕೊಡಿ.',
            deva: 'इन्नोन्दु टी कोडि।',
            hindi: 'एक और चाय दीजिए।',
            chunks: [
              Chunk('Innondu', 'एक और'),
              Chunk('tea', 'चाय'),
              Chunk('kodi', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_refill',
        title: 'Refills & Asking to Stop',
        hindiTitle: 'सांभर माँगना या रुकवाना',
        description: 'खाना परोसते समय और माँगना या मना करना।',
        sentences: [
          KSentence(
            id: 'f4',
            roman: 'Swalpa sambar haaki.',
            script: 'ಸ್ವಲ್ಪ ಸಾಂಬಾರ್ ಹಾಕಿ.',
            deva: 'स्वल्प सांबार हाकि।',
            hindi: 'थोड़ा सांभर डालिए।',
            chunks: [
              Chunk('Swalpa', 'थोड़ा'),
              Chunk('sambar', 'सांभर'),
              Chunk('haaki', 'डालिए'),
            ],
          ),
          KSentence(
            id: 'f5',
            roman: 'Saaku, beda.',
            script: 'ಸಾಕು, ಬೇಡ.',
            deva: 'साकु, बेडा।',
            hindi: 'बस, नहीं चाहिए।',
            chunks: [
              Chunk('Saaku', 'बस / काफ़ी है'),
              Chunk('beda', 'नहीं चाहिए'),
            ],
            note: 'जब सर्वर और सांभर/चटनी दे रहा हो और आपको नहीं चाहिए।',
          ),
          KSentence(
            id: 'f6',
            roman: 'Neeru kodi.',
            script: 'ನೀರು ಕೊಡಿ.',
            deva: 'नीरु कोडि।',
            hindi: 'पानी दीजिए।',
            chunks: [
              Chunk('Neeru', 'पानी'),
              Chunk('kodi', 'दीजिए'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'food_bill',
        title: 'Billing & Payment',
        hindiTitle: 'बिल पूछना और भुगतान',
        description: 'खाने के बाद हिसाब करना।',
        sentences: [
          KSentence(
            id: 'f7',
            roman: 'Eshtu aaytu?',
            script: 'ಎಷ್ಟು ಆಯ್ತು?',
            deva: 'एष्टु आयतु?',
            hindi: 'कितना हुआ?',
            chunks: [
              Chunk('Eshtu', 'कितना'),
              Chunk('aaytu', 'हुआ'),
            ],
          ),
          KSentence(
            id: 'f8',
            roman: 'QR code idiya?',
            script: 'ಕ್ಯೂಆರ್ ಕೋಡ್ ಇದಿಯಾ?',
            deva: 'क्यूआर कोड इदिया?',
            hindi: 'क्या क्यूआर कोड है?',
            chunks: [
              Chunk('QR code', 'क्यूआर कोड'),
              Chunk('idiya?', 'है क्या?'),
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
    blurb: 'कहाँ जाना है, किराया, यहाँ रोकिए',
    situations: [
      const KSituation(
        id: 'auto_destination',
        title: 'Destination & Meter',
        hindiTitle: 'कहाँ जाना है और मीटर',
        description: 'ऑटो वाले से बात शुरू करना।',
        sentences: [
          KSentence(
            id: 'a1',
            roman: 'Indiranagar-ge hogbeku.',
            script: 'ಇಂದಿರಾನಗರಕ್ಕೆ ಹೋಗಬೇಕು.',
            deva: 'इंदिरानगरक्के होगबेकु।',
            hindi: 'इंदिरानगर जाना है।',
            chunks: [
              Chunk('Indiranagar-ge', 'इंदिरानगर को'),
              Chunk('hogbeku', 'जाना है'),
            ],
            note: 'किसी भी जगह के नाम के साथ -ge लगाएँ।',
          ),
          KSentence(
            id: 'a2',
            roman: 'Barthira?',
            script: 'ಬರ್ತೀರಾ?',
            deva: 'बर्तीरा?',
            hindi: 'चलेंगे क्या? (आएँगे?)',
            chunks: [
              Chunk('Barthira?', 'आएँगे क्या?'),
            ],
            note: 'ड्राइवर से पूछने का सबसे लोकप्रिय तरीक़ा।',
          ),
          KSentence(
            id: 'a3',
            roman: 'Meter haaki sir.',
            script: 'ಮೀಟರ್ ಹಾಕಿ ಸರ್.',
            deva: 'मीटर हाकि सर।',
            hindi: 'मीटर चालू कीजिए सर।',
            chunks: [
              Chunk('Meter', 'मीटर'),
              Chunk('haaki', 'डालिए'),
              Chunk('sir', 'सर'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_navigation',
        title: 'Directions & Stopping',
        hindiTitle: 'रास्ता और रोकना',
        description: 'ड्राइवर को मोड़ और स्टॉप बताना।',
        sentences: [
          KSentence(
            id: 'a4',
            roman: 'Munde right thagoli.',
            script: 'ಮುಂದೆ ರೈಟ್ ತಗೊಳ್ಳಿ.',
            deva: 'मुंदे राइट थगोळ्ळि।',
            hindi: 'आगे राइट (दाएँ) लीजिए।',
            chunks: [
              Chunk('Munde', 'आगे'),
              Chunk('right', 'दाएँ'),
              Chunk('thagoli', 'लीजिए'),
            ],
          ),
          KSentence(
            id: 'a5',
            roman: 'Illi nilisi.',
            script: 'ಇಲ್ಲಿ ನಿಲ್ಲಿಸಿ.',
            deva: 'इल्लि निलिसि।',
            hindi: 'यहाँ रोकिए।',
            chunks: [
              Chunk('Illi', 'यहाँ'),
              Chunk('nilisi', 'रोकिए'),
            ],
          ),
          KSentence(
            id: 'a6',
            roman: 'Cilre ideyaa?',
            script: 'ಚಿಿಲ್ಲರೆ ಇದೆಯಾ?',
            deva: 'चिल्रे इदिया?',
            hindi: 'क्या छुट्टे (चेंज) हैं?',
            chunks: [
              Chunk('Cilre', 'छुट्टे पैसे'),
              Chunk('ideyaa?', 'हैं क्या?'),
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
    blurb: 'दाम पूछना, मोलभाव, मात्रा बताना',
    situations: [
      const KSituation(
        id: 'market_price',
        title: 'Asking Price & Weight',
        hindiTitle: 'दाम और तोलना',
        description: 'सब्ज़ी और सामान की खरीदारी।',
        sentences: [
          KSentence(
            id: 'm1',
            roman: 'Idhu eshtu?',
            script: 'ಇದು ಎಷ್ಟು?',
            deva: 'इदु एष्टु?',
            hindi: 'यह कितने का है?',
            chunks: [
              Chunk('Idhu', 'यह'),
              Chunk('eshtu?', 'कितना?'),
            ],
          ),
          KSentence(
            id: 'm2',
            roman: 'Ondu kilo tomato kodi.',
            script: 'ಒಂದು ಕಿಲೋ ಟೊಮ್ಯಾಟೊ ಕೊಡಿ.',
            deva: 'ओन्दु किलो टोमॅटो कोडि।',
            hindi: 'एक किलो टमाटर दीजिए।',
            chunks: [
              Chunk('Ondu kilo', 'एक किलो'),
              Chunk('tomato', 'टमाटर'),
              Chunk('kodi', 'दीजिए'),
            ],
          ),
          KSentence(
            id: 'm3',
            roman: 'Swalpa kammi maadi.',
            script: 'ಸ್ವಲ್ಪ ಕಮ್ಮಿ ಮಾಡಿ.',
            deva: 'स्वल्प कम्मि माडि।',
            hindi: 'थोड़ा कम कीजिए।',
            chunks: [
              Chunk('Swalpa', 'थोड़ा'),
              Chunk('kammi', 'कम'),
              Chunk('maadi', 'कीजिए'),
            ],
          ),
          KSentence(
            id: 'm4',
            roman: 'Cover idiya?',
            script: 'ಕವರ್ ಇದಿಯಾ?',
            deva: 'कवर इदिया?',
            hindi: 'क्या थैली/कवर है?',
            chunks: [
              Chunk('Cover', 'थैली / बैग'),
              Chunk('idiya?', 'है क्या?'),
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
    blurb: 'मदद माँगना, "मैं देखता हूँ", दोबारा पूछना',
    situations: [
      const KSituation(
        id: 'work_collab',
        title: 'Help & Coordination',
        hindiTitle: 'मदद और बातचीत',
        description: 'ऑफ़िस में साथियों के साथ बातचीत।',
        sentences: [
          KSentence(
            id: 'c1',
            roman: 'Tea kudiyona banni.',
            script: 'ಟೀ ಕುಡಿಯೋಣ ಬನ್ನಿ.',
            deva: 'टी कुडियोण बन्नि।',
            hindi: 'आइए चाय पीते हैं।',
            chunks: [
              Chunk('Tea', 'चाय'),
              Chunk('kudiyona', 'पीते हैं'),
              Chunk('banni', 'आइए'),
            ],
          ),
          KSentence(
            id: 'c2',
            roman: 'Oota aaytha?',
            script: 'ಊಟ ಆಯ್ತಾ?',
            deva: 'ऊट आयता?',
            hindi: 'खाना हो गया क्या?',
            chunks: [
              Chunk('Oota', 'भोजन'),
              Chunk('aaytha?', 'हो गया क्या?'),
            ],
            note: 'कर्नाटक में यह शिष्टाचार अभिवादन की तरह भी इस्तेमाल होता है।',
          ),
          KSentence(
            id: 'c3',
            roman: 'Swalpa help maadthira?',
            script: 'ಸ್ವಲ್ಪ ಹೆಲ್ಪ್ ಮಾಡ್ತೀರಾ?',
            deva: 'स्वल्प हेल्प माड्तीरा?',
            hindi: 'थोड़ी मदद करेंगे क्या?',
            chunks: [
              Chunk('Swalpa', 'थोड़ा'),
              Chunk('help', 'मदद'),
              Chunk('maadthira?', 'करेंगे क्या?'),
            ],
          ),
          KSentence(
            id: 'c4',
            roman: 'Naanu check maadi heltheeni.',
            script: 'ನಾನು ಚೆಕ್ ಮಾಡಿ ಹೇಳ್ತೀನಿ.',
            deva: 'नानु चेक माडि हेळ्तीनि।',
            hindi: 'मैं देखकर बताता हूँ।',
            chunks: [
              Chunk('Naanu', 'मैं'),
              Chunk('check maadi', 'चेक करके'),
              Chunk('heltheeni', 'बताता हूँ'),
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
    blurb: 'दोस्तों से बेतकल्लुफ़ बातचीत',
    situations: [
      const KSituation(
        id: 'youth_talk',
        title: 'Bengaluru Slang & Casual',
        hindiTitle: 'दोस्तों के साथ कैज़ुअल बात',
        description: 'बेंगलुरु के युवाओं की आम बातचीत।',
        sentences: [
          KSentence(
            id: 'y1',
            roman: 'Macha, enu samaachaara?',
            script: 'ಮಚಾ, ಏನು ಸಮಾಚಾರ?',
            deva: 'मचा, एनु समाचारा?',
            hindi: 'भाई/यार, क्या खबर है?',
            chunks: [
              Chunk('Macha', 'दोस्त / भाई'),
              Chunk('enu', 'क्या'),
              Chunk('samaachaara?', 'समाचार / खबर?'),
            ],
          ),
          KSentence(
            id: 'y2',
            roman: 'Sakkath aagide!',
            script: 'ಸಕ್ಕತ್ ಆಗಿದೆ!',
            deva: 'सक्कथ आगिदे!',
            hindi: 'एकदम ज़बरदस्त है!',
            chunks: [
              Chunk('Sakkath', 'शानदार / कमाल'),
              Chunk('aagide', 'है / हो गया'),
            ],
          ),
          KSentence(
            id: 'y3',
            roman: 'Bega baa guru.',
            script: 'ಬೇಗ ಬಾ ಗುರು.',
            deva: 'बेग बा गुरु।',
            hindi: 'जल्दी आ भाई/गुरु।',
            chunks: [
              Chunk('Bega', 'जल्दी'),
              Chunk('baa', 'आ'),
              Chunk('guru', 'गुरु / यार'),
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
    blurb: 'सम्मान के साथ बात करने के तरीक़े',
    situations: [
      const KSituation(
        id: 'elder_respect',
        title: 'Respectful Greetings',
        hindiTitle: 'आदरपूर्ण बातचीत',
        description: 'बुज़ुर्गों और अतिथियों से शिष्टाचार।',
        sentences: [
          KSentence(
            id: 'e1',
            roman: 'Namaskara, hegiddira?',
            script: 'ನಮಸ್ಕಾರ, ಹೇಗಿದ್ದೀರಾ?',
            deva: 'नमस्कार, हेगिद्दीरा?',
            hindi: 'नमस्ते, आप कैसे हैं?',
            chunks: [
              Chunk('Namaskara', 'नमस्ते'),
              Chunk('hegiddira?', 'कैसे हैं आप?'),
            ],
          ),
          KSentence(
            id: 'e2',
            roman: 'Banni, kuutkoļi.',
            script: 'ಬನ್ನಿ, ಕೂತ್ಕೊಳ್ಳಿ.',
            deva: 'बन्नि, कूतकोळ्ळि।',
            hindi: 'आइए, बैठिए।',
            chunks: [
              Chunk('Banni', 'आइए'),
              Chunk('kuutkoļi', 'बैठिए'),
            ],
          ),
          KSentence(
            id: 'e3',
            roman: 'Thumbha dhanyavaadagalu.',
            script: 'ತುಂಬಾ ಧನ್ಯವಾದಗಳು.',
            deva: 'तुंबा धन्यवादगळु।',
            hindi: 'बहुत-बहुत धन्यवाद।',
            chunks: [
              Chunk('Thumbha', 'बहुत'),
              Chunk('dhanyavaadagalu', 'धन्यवाद'),
            ],
          ),
          KSentence(
            id: 'e4',
            roman: 'Hoog bartiivi.',
            script: 'ಹೋಗ್ ಬರ್ತೀವಿ.',
            deva: 'होग बर्तिवि।',
            hindi: 'अच्छा, हम चलते हैं (विदा लेते समय)।',
            chunks: [
              Chunk('Hoog', 'जाकर'),
              Chunk('bartiivi', 'आएँगे'),
            ],
            note: 'कन्नड़ संस्कृति में "जा रहा हूँ" नहीं, बल्कि "जाकर आता हूँ" कहते हैं।',
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
    blurb: 'सिक्योरिटी, पड़ोसी, मकान मालिक',
    situations: [
      const KSituation(
        id: 'apt_help',
        title: 'Security & Utilities',
        hindiTitle: 'सिक्योरिटी और मेंटेनेंस',
        description: 'फ्लैट और गेट पर बातचीत।',
        sentences: [
          KSentence(
            id: 'ap1',
            roman: 'Parcel bandideya?',
            script: 'ಪಾರ್ಸಲ್ ಬಂದಿದೆಯಾ?',
            deva: 'पार्सल बंदिदेया?',
            hindi: 'क्या पार्सल आया है?',
            chunks: [
              Chunk('Parcel', 'पार्सल'),
              Chunk('bandideya?', 'आया है क्या?'),
            ],
          ),
          KSentence(
            id: 'ap2',
            roman: 'Neeru barthilla.',
            script: 'ನೀರು ಬರ್ತಿಲ್ಲ.',
            deva: 'नीरु बर्तिल्ला।',
            hindi: 'पानी नहीं आ रहा है।',
            chunks: [
              Chunk('Neeru', 'पानी'),
              Chunk('barthilla', 'नहीं आ रहा'),
            ],
          ),
          KSentence(
            id: 'ap3',
            roman: 'Plumber eega barthara?',
            script: 'ಪ್ಲಂಬರ್ ಈಗ ಬರ್ತಾರಾ?',
            deva: 'प्लंबर ईग बर्त्थारा?',
            hindi: 'क्या प्लंबर अभी आएगा?',
            chunks: [
              Chunk('Plumber', 'प्लंबर'),
              Chunk('eega', 'अभी'),
              Chunk('barthara?', 'आएगा क्या?'),
            ],
          ),
        ],
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Dynamic Guided Practice Generator
// Generates a complete interactive lesson from any situation's sentences.
// ---------------------------------------------------------------------------

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];

  for (final sentence in situation.sentences) {
    // 1. Chunked Phrase Study Step
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
    final cleanWords = sentence.roman
        .replaceAll(RegExp(r'[^\w\s\-]'), '')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .toList();

    if (cleanWords.length >= 2) {
      final tiles = List<String>.from(cleanWords)..shuffle();
      if (!tiles.contains('beku')) tiles.add('beku');

      steps.add(
        BuildStep(
          promptHindi: sentence.hindi,
          answer: cleanWords,
          tiles: tiles,
          reveal: '${sentence.roman} — बहुत बढ़िया!',
        ),
      );
    }
  }

  // 3. Situational Use Challenge Step
  if (situation.sentences.isNotEmpty) {
    final correct = situation.sentences.first;
    final others = situation.sentences.length > 1
        ? situation.sentences.skip(1).take(2).map((s) => s.roman).toList()
        : ['Beku beda.', 'Nanage gothilla.'];

    final options = [correct.roman, ...others]..shuffle();
    final correctIndex = options.indexOf(correct.roman);

    steps.add(
      UseStep(
        situation: situation.description,
        question: 'इस स्थिति में आप क्या कहेंगे?',
        options: options,
        answerIndex: correctIndex,
        reveal: '${correct.roman}\n(${correct.hindi})',
      ),
    );
  }

  return Lesson(
    id: situation.id,
    title: situation.title,
    subtitle: situation.hindiTitle,
    wordIds: const [],
    steps: steps,
  );
}
