// SetuLingo v4 — Spoken Kannada Core Architecture & Tagged Sentence Lab Engine

import 'dart:math';

// ---------------------------------------------------------------------------
// Base Models
// ---------------------------------------------------------------------------

class KWord {
  final String id;
  final String roman;
  final String hindi;
  final String? note;

  const KWord({
    required this.id,
    required this.roman,
    required this.hindi,
    this.note,
  });
}

class Chunk {
  final String roman;
  final String hindi;
  String get deva => roman;

  const Chunk(this.roman, this.hindi);
}

sealed class LessonStep {
  const LessonStep();
}

class PhraseStep extends LessonStep {
  final String roman;
  final String hindi;
  final List<Chunk> chunks;
  final String? note;
  final String? streetCode;
  String get deva => roman;

  const PhraseStep({
    required this.roman,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
  });
}

class SpeakPracticeStep extends LessonStep {
  final String promptHindi;
  final String targetRoman;
  final String tip;
  String get targetDeva => targetRoman;

  const SpeakPracticeStep({
    required this.promptHindi,
    required this.targetRoman,
    required this.tip,
  });
}

class BuildStep extends LessonStep {
  final String promptHindi;
  final List<String> answerRoman;
  final List<String> tilesRoman;
  final String revealRoman;

  List<String> get answerDeva => answerRoman;
  List<String> get tilesDeva => tilesRoman;
  String get revealDeva => revealRoman;

  const BuildStep({
    required this.promptHindi,
    required this.answerRoman,
    required this.tilesRoman,
    required this.revealRoman,
  });
}

class UseStep extends LessonStep {
  final String question;
  final String situation;
  final List<String> optionsRoman;
  final List<String> optionsDeva;
  final int answerIndex;
  final String reveal;

  const UseStep({
    required this.question,
    required this.situation,
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
  final String hindi;
  final List<Chunk> chunks;
  final String? note;
  final String? streetCode;
  String get deva => roman;

  const KSentence({
    required this.id,
    required this.roman,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
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
  final String type;
  final String note;
  final String category;

  const WordConnection({
    required this.hindi,
    required this.kannadaRoman,
    required this.type,
    required this.note,
    this.category = 'General',
  });
}

// ---------------------------------------------------------------------------
// Sentence Lab v3 — 81-Word Curated Matrix
// ---------------------------------------------------------------------------

class LabAnchor {
  final String roman;
  final String hindi;
  final String anchorType;
  final List<String> allowedNounTags;

  const LabAnchor({
    required this.roman,
    required this.hindi,
    required this.anchorType,
    required this.allowedNounTags,
  });
}

class LabNoun {
  final String category;
  final String roman;
  final String hindi;
  final String countability;
  final List<String> semanticTags;

  const LabNoun({
    required this.category,
    required this.roman,
    required this.hindi,
    required this.countability,
    required this.semanticTags,
  });
}

class LabVerb {
  final String roman;
  final String hindi;
  final List<String> allowedAnchorTypes;
  final List<String> requiredNounTags;

  const LabVerb({
    required this.roman,
    required this.hindi,
    required this.allowedAnchorTypes,
    required this.requiredNounTags,
  });
}

// 1. Anchors (22 words)
final List<LabAnchor> labAnchors = const [
  LabAnchor(roman: 'Nange', hindi: 'Mujhe', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Nimage', hindi: 'Aapko', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Namge', hindi: 'Humein', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Avange', hindi: 'Us ladke ko', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Avalge', hindi: 'Us ladki ko', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Ellargu', hindi: 'Sabko', anchorType: 'dative', allowedNounTags: ['food', 'drink', 'abstract']),
  LabAnchor(roman: 'Nanna', hindi: 'Mera / Meri', anchorType: 'possessive', allowedNounTags: ['object', 'place', 'info', 'health']),
  LabAnchor(roman: 'Nimma', hindi: 'Aapka / Aapki', anchorType: 'possessive', allowedNounTags: ['object', 'place', 'info', 'health']),
  LabAnchor(roman: 'Namma', hindi: 'Hamara / Hamari', anchorType: 'possessive', allowedNounTags: ['object', 'place', 'info', 'work']),
  LabAnchor(roman: 'Ee', hindi: 'Yeh', anchorType: 'modifier', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Aa', hindi: 'Woh', anchorType: 'modifier', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport', 'work', 'info', 'health', 'abstract', 'language', 'payable', 'readable', 'place_info', 'needable']),
  LabAnchor(roman: 'Bere', hindi: 'Doosra / Alag', anchorType: 'modifier', allowedNounTags: ['food', 'drink', 'object', 'place']),
  LabAnchor(roman: 'Hosa', hindi: 'Naya / Nayi', anchorType: 'modifier', allowedNounTags: ['object', 'place', 'work']),
  LabAnchor(roman: 'Olle', hindi: 'Achha / Achhi', anchorType: 'modifier', allowedNounTags: ['food', 'drink', 'object', 'place', 'work']),
  LabAnchor(roman: 'Swalpa', hindi: 'Thoda', anchorType: 'quant_mass', allowedNounTags: ['drink', 'food', 'abstract']),
  LabAnchor(roman: 'Tumba', hindi: 'Bahut', anchorType: 'quant_all', allowedNounTags: ['drink', 'food', 'abstract', 'work']),
  LabAnchor(roman: 'Ondu', hindi: 'Ek', anchorType: 'quant_count', allowedNounTags: ['object', 'food', 'place', 'transport']),
  LabAnchor(roman: 'Ella', hindi: 'Saara / Sab', anchorType: 'quant_all', allowedNounTags: ['drink', 'food', 'object']),
  LabAnchor(roman: 'Naanu', hindi: 'Main', anchorType: 'nom_1sg', allowedNounTags: ['food', 'drink', 'readable', 'work', 'payable', 'language']),
  LabAnchor(roman: 'Illi', hindi: 'Yahan', anchorType: 'locative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport']),
  LabAnchor(roman: 'Alli', hindi: 'Wahan', anchorType: 'locative', allowedNounTags: ['food', 'drink', 'object', 'place', 'transport']),
  LabAnchor(roman: 'Eega', hindi: 'Abhi', anchorType: 'temporal', allowedNounTags: ['food', 'drink', 'work', 'abstract']),
];

// 2. Nouns (32 words)
final List<LabNoun> labNouns = const [
  LabNoun(category: 'Drinks', roman: 'Neeru', hindi: 'Paani', countability: 'mass', semanticTags: ['drink', 'needable']),
  LabNoun(category: 'Drinks', roman: 'Coffee', hindi: 'Coffee', countability: 'mass', semanticTags: ['drink', 'needable']),
  LabNoun(category: 'Drinks', roman: 'Chaha', hindi: 'Chai', countability: 'mass', semanticTags: ['drink', 'needable']),
  LabNoun(category: 'Drinks', roman: 'Haalu', hindi: 'Doodh', countability: 'mass', semanticTags: ['drink', 'needable']),
  LabNoun(category: 'Food', roman: 'Oota', hindi: 'Khaana', countability: 'mass', semanticTags: ['food', 'needable']),
  LabNoun(category: 'Food', roman: 'Tindi', hindi: 'Naashta', countability: 'mass', semanticTags: ['food', 'needable']),
  LabNoun(category: 'Food', roman: 'Sebu', hindi: 'Seb (Apple)', countability: 'count', semanticTags: ['food', 'needable']),
  LabNoun(category: 'Food', roman: 'Dose', hindi: 'Dosa', countability: 'count', semanticTags: ['food', 'needable']),
  LabNoun(category: 'Objects', roman: 'Pustaka', hindi: 'Kitaab', countability: 'count', semanticTags: ['readable', 'object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Batte', hindi: 'Kapde', countability: 'mass', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Hana', hindi: 'Paise', countability: 'mass', semanticTags: ['payable', 'needable']),
  LabNoun(category: 'Objects', roman: 'Phone', hindi: 'Phone', countability: 'count', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Beega', hindi: 'Chaabi / Taala', countability: 'count', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Ticket', hindi: 'Ticket', countability: 'count', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Bill', hindi: 'Bill', countability: 'count', semanticTags: ['payable', 'object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Cheela', hindi: 'Thaila / Bag', countability: 'count', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Objects', roman: 'Kurchi', hindi: 'Kursi', countability: 'count', semanticTags: ['object', 'needable']),
  LabNoun(category: 'Places & Travel', roman: 'Mane', hindi: 'Ghar', countability: 'count', semanticTags: ['place']),
  LabNoun(category: 'Places & Travel', roman: 'Angadi', hindi: 'Dukaan', countability: 'count', semanticTags: ['place']),
  LabNoun(category: 'Places & Travel', roman: 'Aspatre', hindi: 'Hospital', countability: 'count', semanticTags: ['place']),
  LabNoun(category: 'Places & Travel', roman: 'Daari', hindi: 'Raasta', countability: 'count', semanticTags: ['place_info', 'info']),
  LabNoun(category: 'Places & Travel', roman: 'Auto', hindi: 'Auto', countability: 'count', semanticTags: ['transport', 'needable']),
  LabNoun(category: 'Places & Travel', roman: 'Bus', hindi: 'Bus', countability: 'count', semanticTags: ['transport', 'needable']),
  LabNoun(category: 'Places & Travel', roman: 'Room', hindi: 'Kamra', countability: 'count', semanticTags: ['place', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Kelasa', hindi: 'Kaam', countability: 'mass', semanticTags: ['work', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Samaya', hindi: 'Samay / Time', countability: 'mass', semanticTags: ['abstract', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Sahaya', hindi: 'Madad', countability: 'mass', semanticTags: ['work', 'abstract', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Vishaya', hindi: 'Baat / Vishay', countability: 'count', semanticTags: ['info']),
  LabNoun(category: 'Work & Info', roman: 'Hesaru', hindi: 'Naam', countability: 'count', semanticTags: ['info']),
  LabNoun(category: 'Work & Info', roman: 'Number', hindi: 'Number', countability: 'count', semanticTags: ['info', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Vilasa', hindi: 'Pata (Address)', countability: 'count', semanticTags: ['info', 'needable']),
  LabNoun(category: 'Work & Info', roman: 'Kannada', hindi: 'Kannada', countability: 'abstract', semanticTags: ['language']),
];

// 3. Verbs & Predicates (27 words)
final List<LabVerb> labVerbs = const [
  LabVerb(roman: 'Beku', hindi: 'Chahiye', allowedAnchorTypes: ['dative', 'modifier', 'quant_mass', 'quant_all', 'quant_count'], requiredNounTags: ['needable']),
  LabVerb(roman: 'Beda', hindi: 'Nahi chahiye', allowedAnchorTypes: ['dative', 'modifier', 'quant_mass', 'quant_all', 'quant_count'], requiredNounTags: ['needable']),
  LabVerb(roman: 'Ishta', hindi: 'Pasand hai', allowedAnchorTypes: ['dative'], requiredNounTags: ['food', 'drink', 'object', 'language', 'place']),
  LabVerb(roman: 'Gottu', hindi: 'Pata hai / Aata hai', allowedAnchorTypes: ['dative'], requiredNounTags: ['info', 'place_info', 'language', 'work']),
  LabVerb(roman: 'Gottilla', hindi: 'Nahi pata / Nahi aata', allowedAnchorTypes: ['dative'], requiredNounTags: ['info', 'place_info', 'language', 'work']),
  LabVerb(roman: 'Ide', hindi: 'Hai', allowedAnchorTypes: ['possessive', 'modifier', 'quant_mass', 'quant_all', 'quant_count', 'locative', 'temporal'], requiredNounTags: []),
  LabVerb(roman: 'Illa', hindi: 'Nahi hai', allowedAnchorTypes: ['dative', 'possessive', 'modifier', 'quant_mass', 'quant_all', 'quant_count', 'locative', 'temporal'], requiredNounTags: []),
  LabVerb(roman: 'Sikkutte', hindi: 'Milta hai / Milega', allowedAnchorTypes: ['dative', 'locative'], requiredNounTags: ['food', 'drink', 'object', 'transport', 'work', 'needable']),
  LabVerb(roman: 'Sikkutta', hindi: 'Milta hai kya?', allowedAnchorTypes: ['locative'], requiredNounTags: ['food', 'drink', 'object', 'transport', 'needable']),
  LabVerb(roman: 'Channagide', hindi: 'Achha hai', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['food', 'drink', 'object', 'place']),
  LabVerb(roman: 'Sariyagide', hindi: 'Sahi / Theek hai', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['object', 'work', 'info']),
  LabVerb(roman: 'Sari illa', hindi: 'Theek nahi hai', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['food', 'drink', 'object', 'work']),
  LabVerb(roman: 'Kodi', hindi: 'Dijiye', allowedAnchorTypes: ['dative', 'modifier', 'quant_mass', 'quant_all', 'quant_count'], requiredNounTags: ['needable', 'info']),
  LabVerb(roman: 'Tanni', hindi: 'Laaiye', allowedAnchorTypes: ['dative', 'modifier', 'quant_mass', 'quant_all', 'quant_count'], requiredNounTags: ['food', 'drink', 'object']),
  LabVerb(roman: 'Torisi', hindi: 'Dikhaiye', allowedAnchorTypes: ['dative', 'modifier'], requiredNounTags: ['object', 'place_info', 'info']),
  LabVerb(roman: 'Tagolli', hindi: 'Lijiye', allowedAnchorTypes: ['modifier', 'quant_mass', 'quant_all', 'quant_count'], requiredNounTags: ['food', 'drink', 'object', 'payable']),
  LabVerb(roman: 'Maadi', hindi: 'Kijiye / Banaiye', allowedAnchorTypes: ['modifier', 'temporal', 'quant_mass'], requiredNounTags: ['food', 'drink', 'work']),
  LabVerb(roman: 'Heli', hindi: 'Bataiye', allowedAnchorTypes: ['dative', 'possessive', 'modifier'], requiredNounTags: ['info', 'place_info']),
  LabVerb(roman: 'Enu', hindi: 'Kya hai?', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['info', 'work']),
  LabVerb(roman: 'Elli', hindi: 'Kahan hai?', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['object', 'place', 'transport']),
  LabVerb(roman: 'Eshtu', hindi: 'Kitna hai?', allowedAnchorTypes: ['possessive', 'modifier'], requiredNounTags: ['payable', 'abstract']),
  LabVerb(roman: 'Tintini', hindi: 'Khaata/Khaati hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['food']),
  LabVerb(roman: 'Kuditini', hindi: 'Peeta/Peeti hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['drink']),
  LabVerb(roman: 'Odtini', hindi: 'Padhta/Padhti hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['readable', 'language']),
  LabVerb(roman: 'Maadtini', hindi: 'Karta/Karti hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['work', 'food', 'drink']),
  LabVerb(roman: 'Kodtini', hindi: 'Deta/Deti hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['payable', 'object', 'info']),
  LabVerb(roman: 'Kaltini', hindi: 'Seekhta/Seekhti hoon', allowedAnchorTypes: ['nom_1sg'], requiredNounTags: ['language', 'work']),
];

List<LabNoun> getValidNounsForAnchor(LabAnchor anchor) {
  return labNouns.where((noun) {
    return noun.semanticTags.any((tag) => anchor.allowedNounTags.contains(tag));
  }).toList();
}

List<LabVerb> getValidVerbsForPair(LabAnchor anchor, LabNoun noun) {
  return labVerbs.where((verb) {
    if (!verb.allowedAnchorTypes.contains(anchor.anchorType)) return false;
    if (verb.requiredNounTags.isNotEmpty) {
      return noun.semanticTags.any((tag) => verb.requiredNounTags.contains(tag));
    }
    return true;
  }).toList();
}

// ---------------------------------------------------------------------------
// Categories & Situations
// ---------------------------------------------------------------------------

final List<Category> categories = [
  Category(
    id: 'food',
    emoji: '🍛',
    title: 'Food & Darshini',
    hindiTitle: 'खाना और दर्शिनी',
    blurb: 'ऑर्डर, कॉफी और नाश्ता',
    situations: [
      const KSituation(
        id: 'food_counter',
        title: 'Ordering at Counter',
        hindiTitle: 'काउंटर पर ऑर्डर करना',
        description: 'दर्शिनी काउंटर पर बात करते समय:',
        sentences: [
          KSentence(
            id: 'f1',
            roman: 'Nanage ondu coffee beku.',
            hindi: 'मुझे एक कॉफ़ी चाहिए।',
            chunks: [Chunk('Nanage', 'मुझे'), Chunk('ondu', 'एक'), Chunk('coffee', 'कॉफ़ी'), Chunk('beku', 'चाहिए')],
          ),
          KSentence(
            id: 'f2',
            roman: 'Ondu dose kodi.',
            hindi: 'एक डोसा दीजिए।',
            chunks: [Chunk('Ondu', 'एक'), Chunk('dose', 'डोसा'), Chunk('kodi', 'दीजिए')],
            streetCode: '🏷️ Darshini Tip: काउंटर पर सीधा "kodi" बोलें',
          ),
        ],
      ),
    ],
  ),
  Category(
    id: 'autos',
    emoji: '🛺',
    title: 'Autos & Travel',
    hindiTitle: 'ऑटो और सफ़र',
    blurb: 'ऑटो, मीटर और रास्ता',
    situations: [
      const KSituation(
        id: 'auto_dest',
        title: 'Going Somewhere',
        hindiTitle: 'कहाँ जाना है बताना',
        description: 'ऑटो ड्राइवर से बात करते समय:',
        sentences: [
          KSentence(
            id: 'a1',
            roman: 'Illi auto sikkutta?',
            hindi: 'यहाँ ऑटो मिलता है क्या?',
            chunks: [Chunk('Illi', 'यहाँ'), Chunk('auto', 'ऑटो'), Chunk('sikkutta?', 'मिलता है क्या?')],
          ),
        ],
      ),
    ],
  ),
];

final List<WordConnection> connections = [
  const WordConnection(hindi: 'समय', kannadaRoman: 'samaya', type: 'Tatsama', note: 'दोनों भाषाओं में समान।'),
  const WordConnection(hindi: 'पुस्तक', kannadaRoman: 'pustaka', type: 'Tatsama', note: 'किताब के लिए साझा शब्द।'),
  const WordConnection(hindi: 'मार्ग', kannadaRoman: 'maarga', type: 'Tatsama', note: 'रास्ते के लिए।'),
];

List<String> get cognateCategories => ['Time', 'General'];

KSituation getDailyScenario() {
  return categories.first.situations.first;
}

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];
  for (final sentence in situation.sentences) {
    steps.add(
      PhraseStep(
        roman: sentence.roman,
        hindi: sentence.hindi,
        chunks: sentence.chunks,
        note: sentence.note,
        streetCode: sentence.streetCode,
      ),
    );
    steps.add(
      SpeakPracticeStep(
        promptHindi: sentence.hindi,
        targetRoman: sentence.roman,
        tip: sentence.streetCode ?? 'ज़ोर से बोलकर अभ्यास करें।',
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
