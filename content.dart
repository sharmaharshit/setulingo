// All app content lives here so it can be reviewed and edited in one place.
// IMPORTANT: every Kannada sentence should be checked by a native
// Bengaluru speaker before release.

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

class Category {
  final String id;
  final String emoji;
  final String title;
  final String hindiTitle;
  final String blurb;
  final Lesson? lesson;

  const Category({
    required this.id,
    required this.emoji,
    required this.title,
    required this.hindiTitle,
    required this.blurb,
    this.lesson,
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
// Words
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
    note: 'विनम्र तरीक़ा। काउंटर पर यही सबसे ज़्यादा सुनाई देता है।',
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
];

final Map<String, KWord> wordsById = {
  for (final w in allWords) w.id: w,
};

// ---------------------------------------------------------------------------
// Words a Hindi speaker already has a connection to
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
    note:
        'संस्कृत रात्रि। हिंदी में घिसकर "रात" बना, कन्नड़ में मूल रूप के क़रीब रहा।',
  ),
  const WordConnection(
    hindi: 'मुँह',
    hindiRoman: 'munh',
    kannada: 'ಮುಖ',
    kannadaRoman: 'mukha',
    type: 'Hindi: Tadbhava · Kannada: Tatsama',
    note:
        'संस्कृत मुख। ध्यान दीजिए: कन्नड़ में mukha का मतलब "चेहरा" है, मुँह को "baayi" कहते हैं।',
  ),
  const WordConnection(
    hindi: 'खेत',
    hindiRoman: 'khet',
    kannada: 'ಕ್ಷೇತ್ರ',
    kannadaRoman: 'kshetra',
    type: 'Related',
    note:
        'दोनों संस्कृत क्षेत्र से हैं, पर मतलब अलग हो गया: हिंदी में खेत, कन्नड़ में आम तौर पर इलाका या कार्यक्षेत्र।',
  ),
];

// ---------------------------------------------------------------------------
// Lesson: Food & Darshini
// ---------------------------------------------------------------------------

final Lesson darshiniLesson = Lesson(
  id: 'darshini',
  title: 'Food & Darshini',
  subtitle: 'ऑर्डर करना, और माँगना, "बस" कहना, बिल पूछना',
  wordIds: allWords.map((w) => w.id).toList(),
  steps: [
    const WordStep('nanage'),
    const WordStep('beku'),
    const PhraseStep(
      roman: 'Nanage coffee beku.',
      deva: 'ननगे कॉफ़ी बेकु।',
      hindi: 'मुझे कॉफ़ी चाहिए।',
      chunks: [
        Chunk('Nanage', 'मुझे'),
        Chunk('coffee', 'कॉफ़ी'),
        Chunk('beku', 'चाहिए'),
      ],
      note: 'यह वही बात है जो आप हिंदी में कहते, बस क्रिया (चाहिए) आख़िर में आती है।',
    ),
    const PatternStep(
      romanPattern: 'Nanage + ___ + beku',
      hindiPattern: 'मुझे + ___ + चाहिए',
      examples: [
        Example('Nanage dose beku.', 'मुझे डोसा चाहिए।'),
        Example('Nanage tea beku.', 'मुझे चाय चाहिए।'),
        Example('Nanage neeru beku.', 'मुझे पानी चाहिए।'),
        Example('Nanage idli beku.', 'मुझे इडली चाहिए।'),
      ],
      note: 'बीच का शब्द बदलिए, बाक़ी वाक्य वही रहता है।',
    ),
    const PhraseStep(
      roman: 'Enu beku?',
      deva: 'एनु बेकु?',
      hindi: 'क्या चाहिए?',
      chunks: [
        Chunk('Enu', 'क्या'),
        Chunk('beku', 'चाहिए'),
      ],
      note: 'काउंटर पर सर्वर आपसे यही पूछेगा।',
    ),
    const BuildStep(
      promptHindi: 'मुझे कॉफ़ी चाहिए।',
      answer: ['Nanage', 'coffee', 'beku'],
      tiles: ['beku', 'coffee', 'Nanage'],
      reveal: 'Nanage + चीज़ + beku। यही ढाँचा आगे भी काम आएगा।',
    ),
    const BuildStep(
      promptHindi: 'मुझे डोसा चाहिए।',
      answer: ['Nanage', 'dose', 'beku'],
      tiles: ['dose', 'Nanage', 'beku', 'coffee'],
      reveal: 'सिर्फ़ बीच का शब्द बदला, ढाँचा वही रहा।',
    ),
    const UseStep(
      situation: 'आप दर्शिनी के काउंटर पर खड़े हैं।',
      speakerRoman: 'Enu beku?',
      speakerHindi: 'क्या चाहिए?',
      question: 'आपको एक कॉफ़ी चाहिए। आप क्या बोलेंगे?',
      options: [
        'Nanage coffee beku.',
        'Nanage coffee beda.',
        'Eshtu aaytu?',
      ],
      answerIndex: 0,
      reveal: 'Nanage coffee beku. आपने अभी यही ढाँचा बनाया था।',
    ),
    const WordStep('beda'),
    const ContrastStep(
      title: 'Beku बनाम Beda',
      a: Chunk('Beku', 'चाहिए'),
      b: Chunk('Beda', 'नहीं चाहिए'),
      exampleA: Example('Nanage coffee beku.', 'मुझे कॉफ़ी चाहिए।'),
      exampleB: Example('Nanage coffee beda.', 'मुझे कॉफ़ी नहीं चाहिए।'),
      note: 'दोनों वाक्य के अंत में आते हैं, बाक़ी वाक्य वही रहता है।',
    ),
    const BuildStep(
      promptHindi: 'मुझे चाय नहीं चाहिए।',
      answer: ['Nanage', 'tea', 'beda'],
      tiles: ['beda', 'beku', 'tea', 'Nanage'],
      reveal: 'Beku की जगह beda रखने से मतलब उलट गया।',
    ),
    const WordStep('saaku'),
    const UseStep(
      situation: 'सर्वर बार-बार सांभर डाल रहा है और आपका पेट भर गया है।',
      question: 'आप रुकवाने के लिए क्या बोलेंगे?',
      options: [
        'Saaku.',
        'Beku.',
        'Eshtu aaytu?',
      ],
      answerIndex: 0,
      reveal: 'Saaku = बस, काफ़ी है।',
    ),
    const PhraseStep(
      roman: 'Ondu coffee kodi.',
      deva: 'ओन्दु कॉफ़ी कोडि।',
      hindi: 'एक कॉफ़ी दीजिए।',
      chunks: [
        Chunk('Ondu', 'एक'),
        Chunk('coffee', 'कॉफ़ी'),
        Chunk('kodi', 'दीजिए'),
      ],
      note:
          'Beku बताता है कि आपको क्या चाहिए; kodi माँगने का विनम्र तरीक़ा है, जो काउंटर पर अक्सर सुनाई देता है।',
    ),
    const PhraseStep(
      roman: 'Innondu dose kodi.',
      deva: 'इन्नोन्दु दोसे कोडि।',
      hindi: 'एक और डोसा दीजिए।',
      chunks: [
        Chunk('Innondu', 'एक और'),
        Chunk('dose', 'डोसा'),
        Chunk('kodi', 'दीजिए'),
      ],
      note: 'और माँगना हो तो Ondu की जगह Innondu लगाइए।',
    ),
    const BuildStep(
      promptHindi: 'एक और कॉफ़ी दीजिए।',
      answer: ['Innondu', 'coffee', 'kodi'],
      tiles: ['kodi', 'coffee', 'Innondu', 'Nanage'],
      reveal: 'Innondu + चीज़ + kodi।',
    ),
    const PhraseStep(
      roman: 'Eshtu aaytu?',
      deva: 'एष्टु आयतु?',
      hindi: 'कितना हुआ? (बिल)',
      chunks: [
        Chunk('Eshtu', 'कितना'),
        Chunk('aaytu', 'हुआ'),
      ],
      note: 'खाने के बाद काउंटर पर बिल पूछने का सबसे आम तरीक़ा।',
    ),
    const UseStep(
      situation: 'खाना खत्म हो गया और आपको बिल पूछना है।',
      question: 'आप क्या बोलेंगे?',
      options: [
        'Eshtu aaytu?',
        'Nanage beda.',
        'Innondu dose kodi.',
      ],
      answerIndex: 0,
      reveal: 'Eshtu aaytu? = कितना हुआ?',
    ),
  ],
);

// ---------------------------------------------------------------------------
// Communication categories
// ---------------------------------------------------------------------------

final List<Category> categories = [
  Category(
    id: 'food',
    emoji: '🍛',
    title: 'Food & Darshini',
    hindiTitle: 'खाना और दर्शिनी',
    blurb: 'ऑर्डर करना, और माँगना, "बस" कहना, बिल पूछना',
    lesson: darshiniLesson,
  ),
  const Category(
    id: 'autos',
    emoji: '🛺',
    title: 'Autos & Travel',
    hindiTitle: 'ऑटो और सफ़र',
    blurb: 'कहाँ जाना है, किराया, यहाँ रोकिए',
  ),
  const Category(
    id: 'market',
    emoji: '🛒',
    title: 'Market & Shops',
    hindiTitle: 'बाज़ार और दुकानें',
    blurb: 'दाम पूछना, मोलभाव, मात्रा बताना',
  ),
  const Category(
    id: 'colleagues',
    emoji: '💼',
    title: 'Colleagues & Workplace',
    hindiTitle: 'सहकर्मी और ऑफ़िस',
    blurb: 'मदद माँगना, "मैं देखता हूँ", दोबारा पूछना',
  ),
  const Category(
    id: 'youth',
    emoji: '🧑‍🤝‍🧑',
    title: 'Friends & Youth',
    hindiTitle: 'दोस्त और युवा',
    blurb: 'दोस्तों से बेतकल्लुफ़ बातचीत',
  ),
  const Category(
    id: 'elders',
    emoji: '👴',
    title: 'Elders & Respect',
    hindiTitle: 'बड़े-बुज़ुर्ग',
    blurb: 'सम्मान के साथ बात करने के तरीक़े',
  ),
  const Category(
    id: 'apartment',
    emoji: '🏠',
    title: 'Apartment & Neighbours',
    hindiTitle: 'घर और पड़ोसी',
    blurb: 'सिक्योरिटी, पड़ोसी, मकान मालिक',
  ),
];
