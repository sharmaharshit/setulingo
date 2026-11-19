// SetuLingo v3 — Core data architecture.
// Language content here is a functional first draft for app-building purposes only.
// Roman/Devanagari accuracy is expected to be reviewed by native Kannada speakers
// before this ships — see README_CONTENT_REVIEW.md.

import 'dart:math';

// ---------------------------------------------------------------------------
// Base models
// ---------------------------------------------------------------------------

class KWord {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final String? note;
  final String? streetCode;

  const KWord({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    this.note,
    this.streetCode,
  });
}

class Chunk {
  final String roman;
  final String deva;
  final String hindi;

  const Chunk(this.roman, this.deva, this.hindi);
}

class DialogueTurn {
  final String speaker;
  final bool isUser;
  final String roman;
  final String deva;
  final String hindi;
  final String? tip;

  const DialogueTurn({
    required this.speaker,
    required this.isUser,
    required this.roman,
    required this.deva,
    required this.hindi,
    this.tip,
  });
}

class RoleplayDialogue {
  final String id;
  final String title;
  final String contextDescription;
  final List<DialogueTurn> turns;

  const RoleplayDialogue({
    required this.id,
    required this.title,
    required this.contextDescription,
    required this.turns,
  });
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
  final String? streetCode;

  const PhraseStep({
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
  });
}

class SpeakPracticeStep extends LessonStep {
  final String promptHindi;
  final String targetRoman;
  final String targetDeva;
  final String tip;

  const SpeakPracticeStep({
    required this.promptHindi,
    required this.targetRoman,
    required this.targetDeva,
    required this.tip,
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
  final String? streetCode;

  const KSentence({
    required this.id,
    required this.roman,
    required this.deva,
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
  final RoleplayDialogue? dialogue;

  const KSituation({
    required this.id,
    required this.title,
    required this.hindiTitle,
    required this.description,
    required this.sentences,
    this.dialogue,
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
  final String category;

  const WordConnection({
    required this.hindi,
    required this.kannadaRoman,
    required this.kannadaDeva,
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

enum EncounterPersona { bold, diplomatic, frugal }

class EncounterOption {
  final String badge;
  final String kannadaRoman;
  final String kannadaDeva;
  final String hindiMeaning;
  final EncounterPersona persona;
  final List<Chunk> chunks;
  final int nextStep; //
  
  const EncounterOption({
    required this.badge,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.hindiMeaning,
    required this.persona,
    required this.chunks,
    this.nextStep = 1, //
  });
}

class EncounterStepNode {
  final int stepNumber;
  final String title;
  final String narrativeEn;
  final String narrativeHi;
  final List<EncounterOption> options;

  const EncounterStepNode({
    required this.stepNumber,
    required this.title,
    required this.narrativeEn,
    required this.narrativeHi,
    required this.options,
  });
}

EncounterOption _opt(String badge, String roman, String deva, String hi, EncounterPersona p, List<Chunk> chunks) =>
    EncounterOption(badge: badge, kannadaRoman: roman, kannadaDeva: deva, hindiMeaning: hi, persona: p, chunks: chunks);

final List<EncounterStepNode> epicEncounterStory = [
  EncounterStepNode(
    stepNumber: 1,
    title: 'The Morning Alarm',
    narrativeEn: '7:30 AM. Your alarm rings. You are already late for office. What do you decide?',
    narrativeHi: 'सुबह ७:३० बजे अलार्म बजा। आप ऑफ़िस के लिए पहले ही लेट हैं। आप क्या तय करते हैं?',
    options: [
      _opt('Skip Shower', 'Snana beda, bega hogona.', 'स्नान बेड़ा, बेग होगोणा।', 'नहाना नहीं, जल्दी चलते हैं।', EncounterPersona.bold,
          [Chunk('Snana beda', 'स्नान बेड़ा', 'नहाना नहीं'), Chunk('bega hogona', 'बेग होगोणा', 'जल्दी चलते हैं')]),
      _opt('Message Manager', 'Manager-ge msg madthini, swalpa late.', 'मैनेजर-गे मेसेज मड्तिनी, स्वल्प लेट।', 'मैनेजर को मैसेज करता हूँ, थोड़ा लेट।', EncounterPersona.diplomatic,
          [Chunk('msg madthini', 'मेसेज मड्तिनी', 'मैसेज करता हूँ'), Chunk('swalpa late', 'स्वल्प लेट', 'थोड़ा लेट')]),
      _opt('Take the Bus', 'Auto beda, bus hidkothini.', 'ऑटो बेड़ा, बस हिड्कोतिनी।', 'ऑटो नहीं, बस पकड़ता हूँ।', EncounterPersona.frugal,
          [Chunk('Auto beda', 'ऑटो बेड़ा', 'ऑटो नहीं'), Chunk('bus hidkothini', 'बस हिड्कोतिनी', 'बस पकड़ता हूँ')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 2,
    title: 'Breakfast Dash',
    narrativeEn: 'You rush past a crowded Darshini. Your stomach says stop. What do you order?',
    narrativeHi: 'आप एक भीड़भाड़ वाली दर्शिनी के पास से भागते हैं। पेट कहता है रुको। आप क्या ऑर्डर करते हैं?',
    options: [
      _opt('Order Fast', 'Bega kodi, time illa!', 'बेग कोडि, टाइम इल्ल!', 'जल्दी दीजिए, समय नहीं है!', EncounterPersona.bold,
          [Chunk('Bega kodi', 'बेग कोडि', 'जल्दी दीजिए'), Chunk('time illa', 'टाइम इल्ल', 'समय नहीं है')]),
      _opt('Ask Politely', 'Swalpa help madi, order madbeku.', 'स्वल्प हेल्प मडि, ऑर्डर मड्बेकु।', 'थोड़ी मदद कीजिए, ऑर्डर करना है।', EncounterPersona.diplomatic,
          [Chunk('Swalpa help madi', 'स्वल्प हेल्प मडि', 'थोड़ी मदद कीजिए'), Chunk('order madbeku', 'ऑर्डर मड्बेकु', 'ऑर्डर करना है')]),
      _opt('Keep It Cheap', 'Idli saaku, coffee beda.', 'इडली साकु, कॉफ़ी बेड़ा।', 'इडली काफ़ी है, कॉफ़ी नहीं।', EncounterPersona.frugal,
          [Chunk('Idli saaku', 'इडली साकु', 'इडली काफ़ी है'), Chunk('coffee beda', 'कॉफ़ी बेड़ा', 'कॉफ़ी नहीं')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 3,
    title: 'Catching a Ride',
    narrativeEn: 'An auto slows down near you. Time to negotiate your way to the office.',
    narrativeHi: 'एक ऑटो आपके पास धीमा होता है। ऑफ़िस तक जाने के लिए बात करनी होगी।',
    options: [
      _opt('Straight to the Point', 'Meter haaki, seedha hogona.', 'मीटर हाकि, सीधा होगोणा।', 'मीटर डालिए, सीधे चलते हैं।', EncounterPersona.bold,
          [Chunk('Meter haaki', 'मीटर हाकि', 'मीटर डालिए'), Chunk('seedha hogona', 'सीधा होगोणा', 'सीधे चलते हैं')]),
      _opt('Negotiate Kindly', 'Swalpa kammi madi rate please.', 'स्वल्प कम्मि मडि रेट प्लीज़।', 'थोड़ा किराया कम कीजिए प्लीज़।', EncounterPersona.diplomatic,
          [Chunk('kammi madi', 'कम्मि मडि', 'कम कीजिए'), Chunk('rate please', 'रेट प्लीज़', 'किराया प्लीज़')]),
      _opt('Check the Bus', 'Bus stop yeshtu door?', 'बस स्टॉप येष्टु दूर?', 'बस स्टॉप कितनी दूर है?', EncounterPersona.frugal,
          [Chunk('Bus stop', 'बस स्टॉप', 'बस स्टॉप'), Chunk('yeshtu door?', 'येष्टु दूर?', 'कितनी दूर?')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 4,
    title: 'Traffic Jam Call',
    narrativeEn: 'Your manager calls — you\'re stuck in traffic. What do you say?',
    narrativeHi: 'आपका मैनेजर कॉल करता है — आप ट्रैफ़िक में फँसे हैं। आप क्या कहते हैं?',
    options: [
      _opt('Reassure Them', 'Naanu bandu bidthini, tension beda.', 'नानु बंदु बिड्तिनी, टेंशन बेड़ा।', 'मैं आ जाऊँगा, टेंशन मत लीजिए।', EncounterPersona.bold,
          [Chunk('bandu bidthini', 'बंदु बिड्तिनी', 'आ जाऊँगा'), Chunk('tension beda', 'टेंशन बेड़ा', 'टेंशन मत लीजिए')]),
      _opt('Apologize Formally', 'Sorry sir, traffic tumba ide.', 'सॉरी सर, ट्रैफ़िक तुंबा इदे।', 'माफ़ कीजिए सर, बहुत ट्रैफ़िक है।', EncounterPersona.diplomatic,
          [Chunk('Sorry sir', 'सॉरी सर', 'माफ़ कीजिए सर'), Chunk('traffic tumba ide', 'ट्रैफ़िक तुंबा इदे', 'बहुत ट्रैफ़िक है')]),
      _opt('Take a Shortcut', 'Main road beda, shortcut hogona.', 'मेन रोड बेड़ा, शॉर्टकट होगोणा।', 'मेन रोड नहीं, शॉर्टकट लेते हैं।', EncounterPersona.frugal,
          [Chunk('Main road beda', 'मेन रोड बेड़ा', 'मेन रोड नहीं'), Chunk('shortcut hogona', 'शॉर्टकट होगोणा', 'शॉर्टकट लेते हैं')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 5,
    title: 'Office Gate',
    narrativeEn: 'You finally reach the gate, 40 minutes late. The security guard nods at you.',
    narrativeHi: 'आख़िरकार आप गेट पर पहुँचे, ४० मिनट लेट। सिक्योरिटी गार्ड आपकी तरफ़ देखता है।',
    options: [
      _opt('Own It', 'Late aaytu, adre bandhe!', 'लेट आयतु, अद्रे बंधे!', 'लेट हो गया, पर आ गया!', EncounterPersona.bold,
          [Chunk('Late aaytu', 'लेट आयतु', 'लेट हो गया'), Chunk('adre bandhe', 'अद्रे बंधे', 'पर आ गया')]),
      _opt('Apologize', 'Sorry madam, traffic jaasti itthu.', 'सॉरी मैडम, ट्रैफ़िक ज्यास्ति इत्तु।', 'माफ़ कीजिए मैडम, ट्रैफ़िक बहुत था।', EncounterPersona.diplomatic,
          [Chunk('Sorry madam', 'सॉरी मैडम', 'माफ़ कीजिए मैडम'), Chunk('traffic jaasti itthu', 'ट्रैफ़िक ज्यास्ति इत्तु', 'ट्रैफ़िक बहुत था')]),
      _opt('Mention You Walked', 'Swalpa nadedu bandhe, auto beda anta.', 'स्वल्प नडेदु बंधे, ऑटो बेड़ा अंता।', 'थोड़ा पैदल आया, ऑटो नहीं चाहिए था इसलिए।', EncounterPersona.frugal,
          [Chunk('nadedu bandhe', 'नडेदु बंधे', 'पैदल आया'), Chunk('auto beda', 'ऑटो बेड़ा', 'ऑटो नहीं')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 6,
    title: 'Desk Chaos',
    narrativeEn: 'Your laptop refuses to boot. A colleague glances over.',
    narrativeHi: 'आपका लैपटॉप चालू नहीं हो रहा। एक सहकर्मी देखता है।',
    options: [
      _opt('Call IT Now', 'IT-ge call madi, bega bartira?', 'आईटी-गे कॉल मडि, बेग बर्तिरा?', 'आईटी को कॉल कीजिए, जल्दी आएँगे?', EncounterPersona.bold,
          [Chunk('call madi', 'कॉल मडि', 'कॉल कीजिए'), Chunk('bega bartira?', 'बेग बर्तिरा?', 'जल्दी आएँगे?')]),
      _opt('Ask for Help', 'Swalpa help madtira, laptop start aagthilla.', 'स्वल्प हेल्प मड्तीरा, लैपटॉप स्टार्ट आग्तिल्ल।', 'थोड़ी मदद करेंगे, लैपटॉप शुरू नहीं हो रहा।', EncounterPersona.diplomatic,
          [Chunk('help madtira?', 'हेल्प मड्तीरा?', 'मदद करेंगे?'), Chunk('start aagthilla', 'स्टार्ट आग्तिल्ल', 'शुरू नहीं हो रहा')]),
      _opt('Just Use Your Phone', 'Nanna phone use madthini saaku.', 'नन्न फ़ोन यूज़ मड्तिनी साकु।', 'मेरा फ़ोन काफ़ी है, इस्तेमाल करता हूँ।', EncounterPersona.frugal,
          [Chunk('phone use madthini', 'फ़ोन यूज़ मड्तिनी', 'फ़ोन इस्तेमाल करता हूँ'), Chunk('saaku', 'साकु', 'काफ़ी है')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 7,
    title: 'Chai Break Invitation',
    narrativeEn: 'A colleague waves you toward the chai counter.',
    narrativeHi: 'एक सहकर्मी आपको चाय काउंटर की ओर बुलाता है।',
    options: [
      _opt('Hurry Them', 'Bega banni, chai thanda aagutte!', 'बेग बन्नि, चाय थंडा आगुत्ते!', 'जल्दी आइए, चाय ठंडी हो जाएगी!', EncounterPersona.bold,
          [Chunk('Bega banni', 'बेग बन्नि', 'जल्दी आइए'), Chunk('chai thanda aagutte', 'चाय थंडा आगुत्ते', 'चाय ठंडी हो जाएगी')]),
      _opt('Check Their Time', 'Swalpa time ideya, chai kudiyona?', 'स्वल्प टाइम इदेया, चाय कुडियोणा?', 'थोड़ा समय है क्या, चाय पीते हैं?', EncounterPersona.diplomatic,
          [Chunk('time ideya?', 'टाइम इदेया?', 'समय है क्या?'), Chunk('chai kudiyona', 'चाय कुडियोणा', 'चाय पीते हैं')]),
      _opt('Mention the Cheaper Stall', 'Illi chai kammi rate ide.', 'इल्लि चाय कम्मि रेट इदे।', 'यहाँ चाय का दाम कम है।', EncounterPersona.frugal,
          [Chunk('Illi chai', 'इल्लि चाय', 'यहाँ चाय'), Chunk('kammi rate', 'कम्मि रेट', 'कम दाम')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 8,
    title: 'Status Update',
    narrativeEn: 'Your manager asks for a quick status update on your task.',
    narrativeHi: 'मैनेजर आपके काम पर एक जल्दी अपडेट माँगता है।',
    options: [
      _opt('Done and Dusted', 'Kelsa aaytu, next task kodi.', 'केल्स आयतु, नेक्स्ट टास्क कोडि।', 'काम हो गया, अगला काम दीजिए।', EncounterPersona.bold,
          [Chunk('Kelsa aaytu', 'केल्स आयतु', 'काम हो गया'), Chunk('next task kodi', 'नेक्स्ट टास्क कोडि', 'अगला काम दीजिए')]),
      _opt('Ask for More Time', 'Swalpa time beku, naale kodthini.', 'स्वल्प टाइम बेकु, नाळे कोड्तिनी।', 'थोड़ा समय चाहिए, कल दे दूँगा।', EncounterPersona.diplomatic,
          [Chunk('time beku', 'टाइम बेकु', 'समय चाहिए'), Chunk('naale kodthini', 'नाळे कोड्तिनी', 'कल दे दूँगा')]),
      _opt('Keep It Brief', 'Simple aagi update madthini.', 'सिंपल आगि अपडेट मड्तिनी।', 'सीधा-सादा अपडेट देता हूँ।', EncounterPersona.frugal,
          [Chunk('Simple aagi', 'सिंपल आगि', 'सीधा-सादा'), Chunk('update madthini', 'अपडेट मड्तिनी', 'अपडेट देता हूँ')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 9,
    title: 'Lunch Decision',
    narrativeEn: 'Lunchtime. The team is deciding what to do.',
    narrativeHi: 'लंच का समय। टीम तय कर रही है क्या किया जाए।',
    options: [
      _opt('Take Charge', 'Naanu order madthini, bega tarisi.', 'नानु ऑर्डर मड्तिनी, बेग तरिसि।', 'मैं ऑर्डर करता हूँ, जल्दी लाइए।', EncounterPersona.bold,
          [Chunk('order madthini', 'ऑर्डर मड्तिनी', 'ऑर्डर करता हूँ'), Chunk('bega tarisi', 'बेग तरिसि', 'जल्दी लाइए')]),
      _opt('Ask the Group', 'Nimge yenu beku, together order madona?', 'निम्गे येनु बेकु, टुगेदर ऑर्डर मडोणा?', 'आपको क्या चाहिए, साथ में ऑर्डर करें?', EncounterPersona.diplomatic,
          [Chunk('Nimge yenu beku?', 'निम्गे येनु बेकु?', 'आपको क्या चाहिए?'), Chunk('together order madona', 'टुगेदर ऑर्डर मडोणा', 'साथ में ऑर्डर करें')]),
      _opt('Eat From Home', 'Mane oota tande, saaku.', 'मने ओटा तंदे, साकु।', 'घर का खाना लाया, काफ़ी है।', EncounterPersona.frugal,
          [Chunk('Mane oota', 'मने ओटा', 'घर का खाना'), Chunk('tande, saaku', 'तंदे, साकु', 'लाया, काफ़ी है')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 10,
    title: 'Colleague Asks a Favor',
    narrativeEn: 'A colleague asks if you can help with their task too.',
    narrativeHi: 'एक सहकर्मी पूछता है क्या आप उनके काम में भी मदद कर सकते हैं।',
    options: [
      _opt('Say Yes Immediately', 'Sari, naanu madthini bega.', 'सरी, नानु मड्तिनी बेग।', 'ठीक है, मैं जल्दी कर देता हूँ।', EncounterPersona.bold,
          [Chunk('Sari', 'सरी', 'ठीक है'), Chunk('madthini bega', 'मड्तिनी बेग', 'जल्दी कर देता हूँ')]),
      _opt('Set an Expectation', 'Swalpa busy iddini, aadru madthini.', 'स्वल्प बिज़ी इद्दिनी, आद्रु मड्तिनी।', 'थोड़ा व्यस्त हूँ, फिर भी कर दूँगा।', EncounterPersona.diplomatic,
          [Chunk('busy iddini', 'बिज़ी इद्दिनी', 'व्यस्त हूँ'), Chunk('aadru madthini', 'आद्रु मड्तिनी', 'फिर भी कर दूँगा')]),
      _opt('Push to Tomorrow', 'Ivathu beda, naale madthini.', 'इवत्तु बेड़ा, नाळे मड्तिनी।', 'आज नहीं, कल कर दूँगा।', EncounterPersona.frugal,
          [Chunk('Ivathu beda', 'इवत्तु बेड़ा', 'आज नहीं'), Chunk('naale madthini', 'नाळे मड्तिनी', 'कल कर दूँगा')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 11,
    title: 'Evening Plans',
    narrativeEn: 'Work is done. Friends are messaging about tonight.',
    narrativeHi: 'काम ख़त्म हुआ। दोस्त आज रात के बारे में मैसेज कर रहे हैं।',
    options: [
      _opt('Go Big', 'Sanje club hogona, full masti!', 'संजे क्लब होगोणा, फुल मस्ती!', 'शाम को क्लब चलते हैं, पूरी मस्ती!', EncounterPersona.bold,
          [Chunk('club hogona', 'क्लब होगोणा', 'क्लब चलते हैं'), Chunk('full masti', 'फुल मस्ती', 'पूरी मस्ती')]),
      _opt('Suggest Coffee', 'Sanje coffee shop nalli sigona.', 'संजे कॉफ़ी शॉप नल्लि सिगोणा।', 'शाम को कॉफ़ी शॉप में मिलते हैं।', EncounterPersona.diplomatic,
          [Chunk('coffee shop nalli', 'कॉफ़ी शॉप नल्लि', 'कॉफ़ी शॉप में'), Chunk('sigona', 'सिगोणा', 'मिलते हैं')]),
      _opt('Stay In', 'Mane hogi rest madthini.', 'मने होगि रेस्ट मड्तिनी।', 'घर जाकर आराम करता हूँ।', EncounterPersona.frugal,
          [Chunk('Mane hogi', 'मने होगि', 'घर जाकर'), Chunk('rest madthini', 'रेस्ट मड्तिनी', 'आराम करता हूँ')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 12,
    title: 'Auto Ride Home',
    narrativeEn: 'Time to bargain your way home.',
    narrativeHi: 'अब घर वापस जाने के लिए मोलभाव करना होगा।',
    options: [
      _opt('No Negotiation', 'Rate heli, discuss beda.', 'रेट हेलि, डिस्कस बेड़ा।', 'रेट बताइए, बहस नहीं चाहिए।', EncounterPersona.bold,
          [Chunk('Rate heli', 'रेट हेलि', 'रेट बताइए'), Chunk('discuss beda', 'डिस्कस बेड़ा', 'बहस नहीं')]),
      _opt('Ask Politely', 'Swalpa kammi madi please.', 'स्वल्प कम्मि मडि प्लीज़।', 'थोड़ा कम कीजिए प्लीज़।', EncounterPersona.diplomatic,
          [Chunk('kammi madi', 'कम्मि मडि', 'कम कीजिए'), Chunk('please', 'प्लीज़', 'प्लीज़')]),
      _opt('Take the Bus Instead', 'Bus hidkothini, kammi rate aagutte.', 'बस हिड्कोतिनी, कम्मि रेट आगुत्ते।', 'बस पकड़ता हूँ, दाम कम पड़ेगा।', EncounterPersona.frugal,
          [Chunk('Bus hidkothini', 'बस हिड्कोतिनी', 'बस पकड़ता हूँ'), Chunk('kammi rate', 'कम्मि रेट', 'कम दाम')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 13,
    title: 'Security Gate — Parcel Pickup',
    narrativeEn: 'You reach your apartment gate. The security guard mentions a delivery.',
    narrativeHi: 'आप अपार्टमेंट के गेट पर पहुँचे। सिक्योरिटी गार्ड डिलीवरी की बात करता है।',
    options: [
      _opt('Ask Directly', 'Parcel kodi bega anna.', 'पार्सल कोडि बेग अण्णा।', 'पार्सल जल्दी दीजिए भैया।', EncounterPersona.bold,
          [Chunk('Parcel kodi', 'पार्सल कोडि', 'पार्सल दीजिए'), Chunk('bega anna', 'बेग अण्णा', 'जल्दी भैया')]),
      _opt('Ask Respectfully', 'Parcel bandideya anna, dayavittu nodi.', 'पार्सल बंदिदेया अण्णा, दयविट्टु नोडि।', 'पार्सल आया है क्या भैया, कृपया देखिए।', EncounterPersona.diplomatic,
          [Chunk('bandideya anna?', 'बंदिदेया अण्णा?', 'आया है क्या भैया?'), Chunk('dayavittu nodi', 'दयविट्टु नोडि', 'कृपया देखिए')]),
      _opt('Collect It Tomorrow', 'Naale thogothini parcel.', 'नाळे तोगोतिनी पार्सल।', 'कल पार्सल ले लूँगा।', EncounterPersona.frugal,
          [Chunk('Naale thogothini', 'नाळे तोगोतिनी', 'कल ले लूँगा'), Chunk('parcel', 'पार्सल', 'पार्सल')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 14,
    title: 'Neighbour at the Door',
    narrativeEn: 'A neighbour stops you in the hallway for a chat.',
    narrativeHi: 'एक पड़ोसी आपको गलियारे में बातचीत के लिए रोकता है।',
    options: [
      _opt('Keep It Short', 'Time illa, naale maatadona.', 'टाइम इल्ल, नाळे मातादोणा।', 'समय नहीं है, कल बात करते हैं।', EncounterPersona.bold,
          [Chunk('Time illa', 'टाइम इल्ल', 'समय नहीं है'), Chunk('naale maatadona', 'नाळे मातादोणा', 'कल बात करते हैं')]),
      _opt('Chat a Bit', 'Hegiddira, swalpa maatadona.', 'हेगिद्दीरा, स्वल्प मातादोणा।', 'कैसे हैं, थोड़ी बात करते हैं।', EncounterPersona.diplomatic,
          [Chunk('Hegiddira', 'हेगिद्दीरा', 'कैसे हैं'), Chunk('swalpa maatadona', 'स्वल्प मातादोणा', 'थोड़ी बात करते हैं')]),
      _opt('Decline Tea', 'Chai beda, sustu aagide.', 'चाय बेड़ा, सुस्तु आगिदे।', 'चाय नहीं, थक गया हूँ।', EncounterPersona.frugal,
          [Chunk('Chai beda', 'चाय बेड़ा', 'चाय नहीं'), Chunk('sustu aagide', 'सुस्तु आगिदे', 'थक गया हूँ')]),
    ],
  ),
  EncounterStepNode(
    stepNumber: 15,
    title: 'Wrapping Up the Day',
    narrativeEn: 'You collapse onto the sofa. What a Monday. How do you sum it up?',
    narrativeHi: 'आप सोफ़े पर बैठ जाते हैं। क्या सोमवार था! आप इसे कैसे बयान करते हैं?',
    options: [
      _opt('Victory Lap', 'Bahala busy dina aaytu, adre gelthe!', 'बहळ बिज़ी दिन आयतु, अद्रे गेल्थे!', 'बहुत व्यस्त दिन था, पर मैं जीत गया!', EncounterPersona.bold,
          [Chunk('busy dina', 'बिज़ी दिन', 'व्यस्त दिन'), Chunk('gelthe', 'गेल्थे', 'जीत गया')]),
      _opt('Grateful Close', 'Dina chennagi mugithu, dhanyavaada.', 'दिन चेन्नागि मुगित्तु, धन्यवाद।', 'दिन अच्छे से ख़त्म हुआ, धन्यवाद।', EncounterPersona.diplomatic,
          [Chunk('chennagi mugithu', 'चेन्नागि मुगित्तु', 'अच्छे से ख़त्म हुआ'), Chunk('dhanyavaada', 'धन्यवाद', 'धन्यवाद')]),
      _opt('Count the Savings', 'Kammi kharchu, chennagi dina.', 'कम्मि खर्चु, चेन्नागि दिन।', 'कम ख़र्चा, अच्छा दिन।', EncounterPersona.frugal,
          [Chunk('Kammi kharchu', 'कम्मि खर्चु', 'कम ख़र्चा'), Chunk('chennagi dina', 'चेन्नागि दिन', 'अच्छा दिन')]),
    ],
  ),
];

class EncounterResult {
  final EncounterPersona persona;
  final String title;
  final String hindiTitle;
  final String blurb;
  final String emoji;

  const EncounterResult({
    required this.persona,
    required this.title,
    required this.hindiTitle,
    required this.blurb,
    required this.emoji,
  });
}

const Map<EncounterPersona, EncounterResult> encounterResults = {
  EncounterPersona.bold: EncounterResult(
    persona: EncounterPersona.bold,
    title: 'The Bold Bengalurean',
    hindiTitle: 'निडर बेंगलुरुकर',
    blurb: 'You move fast, speak directly, and don\'t overthink it. Bengaluru rewards confident speakers — keep that energy.',
    emoji: '⚡',
  ),
  EncounterPersona.diplomatic: EncounterResult(
    persona: EncounterPersona.diplomatic,
    title: 'The Diplomat',
    hindiTitle: 'कूटनीतिज्ञ',
    blurb: 'You ask nicely, acknowledge people, and keep things smooth. This builds the kind of goodwill that gets you better auto rates.',
    emoji: '🤝',
  ),
  EncounterPersona.frugal: EncounterResult(
    persona: EncounterPersona.frugal,
    title: 'The Frugal Local',
    hindiTitle: 'किफ़ायती स्थानीय',
    blurb: 'You know every rupee saved on autos and coffee adds up. Practical, budget-savvy, very Bengaluru.',
    emoji: '💰',
  ),
};

EncounterResult computeEncounterResult(List<EncounterPersona> choices) {
  final counts = <EncounterPersona, int>{
    EncounterPersona.bold: 0,
    EncounterPersona.diplomatic: 0,
    EncounterPersona.frugal: 0,
  };
  for (final c in choices) {
    counts[c] = (counts[c] ?? 0) + 1;
  }
  final winner = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  return encounterResults[winner]!;
}

// ---------------------------------------------------------------------------
// All 8 Categories — 5 situations each (40 total)
// ---------------------------------------------------------------------------

final List<Category> categories = [
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
        dialogue: RoleplayDialogue(
          id: 'rp_food1',
          title: 'टोकन काउंटर की बातचीत',
          contextDescription: 'आप दर्शिनी के टोकन काउंटर पर खड़े हैं।',
          turns: [
            DialogueTurn(speaker: 'काउंटर वाला', isUser: false, roman: 'Enu beku sir?', deva: 'एनु बेकु सर?', hindi: 'क्या चाहिए सर?'),
            DialogueTurn(speaker: 'आप', isUser: true, roman: 'Ondu masala dose, ondu filter coffee kodi.', deva: 'ओन्दु मसाला दोसे, ओन्दु फ़िल्टर कॉफ़ी कोडि।', hindi: 'एक मसाला डोसा और एक फ़िल्टर कॉफ़ी दीजिए।'),
          ],
        ),
        sentences: [
          KSentence(
            id: 'f1',
            roman: 'Nanage ondu coffee beku.',
            deva: 'ननगे ओन्दु कॉफ़ी बेकु।',
            hindi: 'मुझे एक कॉफ़ी चाहिए।',
            chunks: [Chunk('Nanage', 'ननगे', 'मुझे'), Chunk('ondu', 'ओन्दु', 'एक'), Chunk('coffee', 'कॉफ़ी', 'कॉफ़ी'), Chunk('beku', 'बेकु', 'चाहिए')],
          ),
          KSentence(
            id: 'f2',
            roman: 'Ondu masala dose kodi.',
            deva: 'ओन्दु मसाला दोसे कोडि।',
            hindi: 'एक मसाला डोसा दीजिए।',
            chunks: [Chunk('Ondu', 'ओन्दु', 'एक'), Chunk('masala dose', 'मसाला दोसे', 'मसाला डोसा'), Chunk('kodi', 'कोडि', 'दीजिए')],
            streetCode: '🏷️ Darshini Code: काउंटर पर "beku" से अधिक स्वाभाविक "kodi" लगता है',
          ),
        ],
      ),
      const KSituation(
        id: 'food_refill',
        title: 'Asking for a Refill',
        hindiTitle: 'रिफिल व एक्स्ट्रा चटनी',
        description: 'चटनी या सांभर की रिफिल माँगते समय:',
        sentences: [
          KSentence(
            id: 'f3',
            roman: 'Innondu chutney kodi.',
            deva: 'इन्नोन्दु चटनी कोडि।',
            hindi: 'एक और चटनी दीजिए।',
            chunks: [Chunk('Innondu', 'इन्नोन्दु', 'एक और'), Chunk('chutney', 'चटनी', 'चटनी'), Chunk('kodi', 'कोडि', 'दीजिए')],
            streetCode: '🏷️ Darshini Code: रिफिल अक्सर मुफ़्त होती है, माँगने में हिचकें नहीं',
          ),
        ],
      ),
      const KSituation(
        id: 'food_bill',
        title: 'Paying and Getting Change',
        hindiTitle: 'बिल देना व चेंज माँगना',
        description: 'काउंटर पर पेमेंट करते समय:',
        sentences: [
          KSentence(
            id: 'f4',
            roman: 'Bill kodi, change beku.',
            deva: 'बिल कोडि, चेंज बेकु।',
            hindi: 'बिल दीजिए, चेंज चाहिए।',
            chunks: [Chunk('Bill kodi', 'बिल कोडि', 'बिल दीजिए'), Chunk('change beku', 'चेंज बेकु', 'चेंज चाहिए')],
          ),
        ],
      ),
      const KSituation(
        id: 'food_takeaway',
        title: 'Takeaway vs Eating In',
        hindiTitle: 'पार्सल या वहीं बैठकर खाना',
        description: 'जब आपको खाना साथ ले जाना हो:',
        sentences: [
          KSentence(
            id: 'f5',
            roman: 'Parcel kodi, tinta hogthini.',
            deva: 'पार्सल कोडि, तिन्ता होग्तिनी।',
            hindi: 'पार्सल दीजिए, खाते हुए जाऊँगा।',
            chunks: [Chunk('Parcel kodi', 'पार्सल कोडि', 'पार्सल दीजिए'), Chunk('tinta hogthini', 'तिन्ता होग्तिनी', 'खाते हुए जाऊँगा')],
          ),
        ],
      ),
      const KSituation(
        id: 'food_wrong_order',
        title: 'Fixing a Wrong Order',
        hindiTitle: 'गलत ऑर्डर ठीक करवाना',
        description: 'जब आपको गलत आइटम मिल जाए:',
        sentences: [
          KSentence(
            id: 'f6',
            roman: 'Idu tappu order, badlisi.',
            deva: 'इदु तप्पु ऑर्डर, बदलिसि।',
            hindi: 'यह गलत ऑर्डर है, बदल दीजिए।',
            chunks: [Chunk('Idu tappu order', 'इदु तप्पु ऑर्डर', 'यह गलत ऑर्डर है'), Chunk('badlisi', 'बदलिसि', 'बदल दीजिए')],
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
            chunks: [Chunk('Indiranagar-ge', 'इंदिरानगर-गे', 'इंदिरानगर को'), Chunk('hogbeku', 'होगबेकु', 'जाना है')],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_haggle',
        title: 'Bargaining the Fare',
        hindiTitle: 'किराए पर मोलभाव',
        description: 'जब मीटर से ज़्यादा माँगा जाए:',
        sentences: [
          KSentence(
            id: 'a2',
            roman: 'Kammi maadi, swalpa discount kodi.',
            deva: 'कम्मि माडि, स्वल्प डिस्काउंट कोडि।',
            hindi: 'कम कीजिए, थोड़ा डिस्काउंट दीजिए।',
            chunks: [Chunk('Kammi maadi', 'कम्मि माडि', 'कम कीजिए'), Chunk('discount kodi', 'डिस्काउंट कोडि', 'डिस्काउंट दीजिए')],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_meter',
        title: 'Asking for the Meter',
        hindiTitle: 'मीटर से चलने को कहना',
        description: 'जब ड्राइवर फ़्लैट रेट माँगे:',
        sentences: [
          KSentence(
            id: 'a3',
            roman: 'Meter haaki sir.',
            deva: 'मीटर हाकि सर।',
            hindi: 'मीटर डालिए सर।',
            chunks: [Chunk('Meter haaki', 'मीटर हाकि', 'मीटर डालिए'), Chunk('sir', 'सर', 'सर')],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_stop',
        title: 'Asking the Driver to Stop',
        hindiTitle: 'ड्राइवर से रुकने को कहना',
        description: 'जब आप मंज़िल पर पहुँच जाएँ:',
        sentences: [
          KSentence(
            id: 'a4',
            roman: 'Illi nilisi, saaku.',
            deva: 'इल्लि निलिसि, साकु।',
            hindi: 'यहाँ रोकिए, बस।',
            chunks: [Chunk('Illi nilisi', 'इल्लि निलिसि', 'यहाँ रोकिए'), Chunk('saaku', 'साकु', 'बस')],
          ),
        ],
      ),
      const KSituation(
        id: 'auto_landmark',
        title: 'Giving a Landmark',
        hindiTitle: 'लैंडमार्क बताना',
        description: 'जब पते के बजाय लैंडमार्क बताना आसान हो:',
        sentences: [
          KSentence(
            id: 'a5',
            roman: 'Signal hattira ilsi.',
            deva: 'सिग्नल हत्तिर इल्सि।',
            hindi: 'सिग्नल के पास उतार दीजिए।',
            chunks: [Chunk('Signal hattira', 'सिग्नल हत्तिर', 'सिग्नल के पास'), Chunk('ilsi', 'इल्सि', 'उतार दीजिए')],
          ),
        ],
      ),
    ],
  ),
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
            chunks: [Chunk('Idhu', 'इदु', 'यह'), Chunk('eshtu?', 'एष्टु?', 'कितना?')],
          ),
        ],
      ),
      const KSituation(
        id: 'market_bargain',
        title: 'Bargaining Down',
        hindiTitle: 'दाम कम करवाना',
        description: 'जब कीमत ज़्यादा लगे:',
        sentences: [
          KSentence(
            id: 'm2',
            roman: 'Kammi madi swalpa.',
            deva: 'कम्मि मडि स्वल्प।',
            hindi: 'थोड़ा कम कीजिए।',
            chunks: [Chunk('Kammi madi', 'कम्मि मडि', 'कम कीजिए'), Chunk('swalpa', 'स्वल्प', 'थोड़ा')],
          ),
        ],
      ),
      const KSituation(
        id: 'market_weigh',
        title: 'Asking for a Quantity',
        hindiTitle: 'वज़न या मात्रा बताना',
        description: 'कितना तोलना है यह बताते समय:',
        sentences: [
          KSentence(
            id: 'm3',
            roman: 'Ondu kilo tookodi.',
            deva: 'ओन्दु किलो तूकोडि।',
            hindi: 'एक किलो तौलिए।',
            chunks: [Chunk('Ondu kilo', 'ओन्दु किलो', 'एक किलो'), Chunk('tookodi', 'तूकोडि', 'तौलिए')],
          ),
        ],
      ),
      const KSituation(
        id: 'market_bag',
        title: 'Asking for a Bag',
        hindiTitle: 'थैली माँगना',
        description: 'सामान रखने के लिए थैली माँगते समय:',
        sentences: [
          KSentence(
            id: 'm4',
            roman: 'Cover kodi swalpa.',
            deva: 'कवर कोडि स्वल्प।',
            hindi: 'एक थैली दीजिए।',
            chunks: [Chunk('Cover kodi', 'कवर कोडि', 'थैली दीजिए'), Chunk('swalpa', 'स्वल्प', 'थोड़ी')],
          ),
        ],
      ),
      const KSituation(
        id: 'market_quality',
        title: 'Asking About Freshness',
        hindiTitle: 'ताज़गी के बारे में पूछना',
        description: 'सामान ताज़ा है या नहीं यह पूछते समय:',
        sentences: [
          KSentence(
            id: 'm5',
            roman: 'Idhu fresh aa?',
            deva: 'इदु फ़्रेश आ?',
            hindi: 'यह ताज़ा है क्या?',
            chunks: [Chunk('Idhu', 'इदु', 'यह'), Chunk('fresh aa?', 'फ़्रेश आ?', 'ताज़ा है क्या?')],
          ),
        ],
      ),
    ],
  ),
  Category(
    id: 'colleagues',
    emoji: '💼',
    title: 'Colleagues & Workplace',
    hindiTitle: 'सहकर्मी और ऑफ़िस',
    blurb: 'चाय ब्रेक, मदद, स्टेटस और विदा',
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
            chunks: [Chunk('Tea', 'टी', 'चाय'), Chunk('kudiyona', 'कुडियोण', 'पीते हैं'), Chunk('banni', 'बन्नि', 'आइए')],
          ),
        ],
      ),
      const KSituation(
        id: 'work_help',
        title: 'Asking a Colleague for Help',
        hindiTitle: 'सहकर्मी से मदद माँगना',
        description: 'जब आपको किसी काम में मदद चाहिए:',
        sentences: [
          KSentence(
            id: 'c2',
            roman: 'Swalpa help madtira?',
            deva: 'स्वल्प हेल्प मड्तीरा?',
            hindi: 'थोड़ी मदद करेंगे?',
            chunks: [Chunk('Swalpa help', 'स्वल्प हेल्प', 'थोड़ी मदद'), Chunk('madtira?', 'मड्तीरा?', 'करेंगे?')],
          ),
        ],
      ),
      const KSituation(
        id: 'work_status',
        title: 'Giving a Status Update',
        hindiTitle: 'काम का स्टेटस बताना',
        description: 'मैनेजर को अपडेट देते समय:',
        sentences: [
          KSentence(
            id: 'c3',
            roman: 'Kelsa aaytu, update kodthini.',
            deva: 'केल्स आयतु, अपडेट कोड्तिनी।',
            hindi: 'काम हो गया, अपडेट देता हूँ।',
            chunks: [Chunk('Kelsa aaytu', 'केल्स आयतु', 'काम हो गया'), Chunk('update kodthini', 'अपडेट कोड्तिनी', 'अपडेट देता हूँ')],
          ),
        ],
      ),
      const KSituation(
        id: 'work_leave',
        title: 'Asking to Leave Early',
        hindiTitle: 'जल्दी निकलने की अनुमति माँगना',
        description: 'जब आपको जल्दी निकलना हो:',
        sentences: [
          KSentence(
            id: 'c4',
            roman: 'Beg hogbahuda, kelsa aaytu?',
            deva: 'बेग होगबहुदा, केल्स आयतु?',
            hindi: 'जल्दी जा सकता हूँ, काम हो गया?',
            chunks: [Chunk('Beg hogbahuda', 'बेग होगबहुदा', 'जल्दी जा सकता हूँ'), Chunk('kelsa aaytu?', 'केल्स आयतु?', 'काम हो गया?')],
          ),
        ],
      ),
      const KSituation(
        id: 'work_bye',
        title: 'Saying Bye for the Day',
        hindiTitle: 'दिन ख़त्म होने पर विदा कहना',
        description: 'ऑफ़िस से निकलते समय सहकर्मियों को बाय कहना:',
        sentences: [
          KSentence(
            id: 'c5',
            roman: 'Naale sigona, bye!',
            deva: 'नाळे सिगोणा, बाय!',
            hindi: 'कल मिलते हैं, बाय!',
            chunks: [Chunk('Naale sigona', 'नाळे सिगोणा', 'कल मिलते हैं'), Chunk('bye', 'बाय', 'बाय')],
          ),
        ],
      ),
    ],
  ),
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
            chunks: [Chunk('Macha', 'मचा', 'दोस्त / भाई'), Chunk('enu', 'एनु', 'क्या'), Chunk('samaachaara?', 'समाचारा?', 'खबर?')],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_plan',
        title: 'Making Weekend Plans',
        hindiTitle: 'वीकेंड की योजना बनाना',
        description: 'वीकेंड पर क्या करना है यह पूछते समय:',
        sentences: [
          KSentence(
            id: 'y2',
            roman: 'Weekend enu plan?',
            deva: 'वीकेंड एनु प्लान?',
            hindi: 'वीकेंड में क्या प्लान है?',
            chunks: [Chunk('Weekend', 'वीकेंड', 'वीकेंड'), Chunk('enu plan?', 'एनु प्लान?', 'क्या प्लान?')],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_tease',
        title: 'Friendly Teasing',
        hindiTitle: 'हल्की-फुल्की मज़ाक',
        description: 'दोस्तों के बीच मस्ती में छेड़ना:',
        sentences: [
          KSentence(
            id: 'y3',
            roman: 'Nee full lucky kano!',
            deva: 'नी फुल लकी कणो!',
            hindi: 'तू बहुत लकी है यार!',
            chunks: [Chunk('Nee', 'नी', 'तू'), Chunk('full lucky', 'फुल लकी', 'बहुत लकी'), Chunk('kano', 'कणो', 'है यार')],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_invite',
        title: 'Inviting to Hang Out',
        hindiTitle: 'मिलने के लिए बुलाना',
        description: 'शाम को साथ मिलने का न्योता देना:',
        sentences: [
          KSentence(
            id: 'y4',
            roman: 'Sanje sigona, coffee kudiyona.',
            deva: 'संजे सिगोणा, कॉफ़ी कुडियोणा।',
            hindi: 'शाम को मिलते हैं, कॉफ़ी पीते हैं।',
            chunks: [Chunk('Sanje sigona', 'संजे सिगोणा', 'शाम को मिलते हैं'), Chunk('coffee kudiyona', 'कॉफ़ी कुडियोणा', 'कॉफ़ी पीते हैं')],
          ),
        ],
      ),
      const KSituation(
        id: 'youth_bye',
        title: 'Casual Goodbye',
        hindiTitle: 'दोस्तों से हल्के में विदा',
        description: 'दोस्तों से अनौपचारिक रूप से विदा लेना:',
        sentences: [
          KSentence(
            id: 'y5',
            roman: 'Sari macha, hogi bartini.',
            deva: 'सरी मचा, होगि बर्तिनी।',
            hindi: 'ठीक है यार, जाकर आता हूँ।',
            chunks: [Chunk('Sari macha', 'सरी मचा', 'ठीक है यार'), Chunk('hogi bartini', 'होगि बर्तिनी', 'जाकर आता हूँ')],
          ),
        ],
      ),
    ],
  ),
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
            chunks: [Chunk('Namaskara', 'नमस्कार', 'नमस्ते'), Chunk('hegiddira?', 'हेगिद्दीरा?', 'कैसे हैं आप?')],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_help',
        title: 'Offering Help',
        hindiTitle: 'मदद की पेशकश करना',
        description: 'किसी बुज़ुर्ग को मदद देने की पेशकश करते समय:',
        sentences: [
          KSentence(
            id: 'e2',
            roman: 'Nimage sahaya beka?',
            deva: 'निमगे सहाय बेका?',
            hindi: 'आपको मदद चाहिए क्या?',
            chunks: [Chunk('Nimage', 'निमगे', 'आपको'), Chunk('sahaya beka?', 'सहाय बेका?', 'मदद चाहिए क्या?')],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_permission',
        title: 'Asking Permission Politely',
        hindiTitle: 'विनम्रता से अनुमति माँगना',
        description: 'बुज़ुर्गों से इजाज़त माँगते समय:',
        sentences: [
          KSentence(
            id: 'e3',
            roman: 'Hogabahuda sir?',
            deva: 'होगबहुदा सर?',
            hindi: 'जा सकता हूँ सर?',
            chunks: [Chunk('Hogabahuda', 'होगबहुदा', 'जा सकता हूँ'), Chunk('sir?', 'सर?', 'सर?')],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_wellbeing',
        title: 'Asking About Health',
        hindiTitle: 'तबियत के बारे में पूछना',
        description: 'बुज़ुर्गों की तबियत के हाल पूछना:',
        sentences: [
          KSentence(
            id: 'e4',
            roman: 'Ogtu ide alwa?',
            deva: 'ओग्तु इदे अल्वा?',
            hindi: 'सब ठीक है ना?',
            chunks: [Chunk('Ogtu ide', 'ओग्तु इदे', 'सब ठीक है'), Chunk('alwa?', 'अल्वा?', 'ना?')],
          ),
        ],
      ),
      const KSituation(
        id: 'elder_thanks',
        title: 'Thanking Respectfully',
        hindiTitle: 'आदरपूर्वक धन्यवाद',
        description: 'बुज़ुर्गों का आदरपूर्वक धन्यवाद करना:',
        sentences: [
          KSentence(
            id: 'e5',
            roman: 'Thumba dhanyavaadagalu.',
            deva: 'तुंबा धन्यवादगळु।',
            hindi: 'बहुत धन्यवाद।',
            chunks: [Chunk('Thumba', 'तुंबा', 'बहुत'), Chunk('dhanyavaadagalu', 'धन्यवादगळु', 'धन्यवाद')],
          ),
        ],
      ),
    ],
  ),
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
            roman: 'Parcel bandideya anna?',
            deva: 'पार्सल बंदिदेया अण्णा?',
            hindi: 'क्या कोई पार्सल आया है भैया?',
            chunks: [Chunk('Parcel', 'पार्सल', 'पार्सल'), Chunk('bandideya?', 'बंदिदेया?', 'आया है क्या?'), Chunk('anna', 'अण्णा', 'भैया')],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_maintenance',
        title: 'Reporting a Maintenance Issue',
        hindiTitle: 'मेंटेनेंस की शिकायत करना',
        description: 'घर की कोई चीज़ ख़राब हो तो शिकायत करना:',
        sentences: [
          KSentence(
            id: 'ap2',
            roman: 'Light kelsa madtilla, nodi.',
            deva: 'लाइट केल्स मड्तिल्ल, नोडि।',
            hindi: 'लाइट काम नहीं कर रही, देखिए।',
            chunks: [Chunk('Light kelsa madtilla', 'लाइट केल्स मड्तिल्ल', 'लाइट काम नहीं कर रही'), Chunk('nodi', 'नोडि', 'देखिए')],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_neighbour',
        title: 'Chatting with a Neighbour',
        hindiTitle: 'पड़ोसी से बातचीत',
        description: 'लिफ़्ट या सीढ़ी पर पड़ोसी से हालचाल पूछना:',
        sentences: [
          KSentence(
            id: 'ap3',
            roman: 'Hegiddira, tumba dina aaytu!',
            deva: 'हेगिद्दीरा, तुंबा दिन आयतु!',
            hindi: 'कैसे हैं, बहुत दिन हो गए!',
            chunks: [Chunk('Hegiddira', 'हेगिद्दीरा', 'कैसे हैं'), Chunk('tumba dina aaytu', 'तुंबा दिन आयतु', 'बहुत दिन हो गए')],
          ),
        ],
      ),
     const KSituation(
        id: 'apt_noise',
        title: 'Politely Asking About Noise',
        hindiTitle: 'विनम्रता से शोर के बारे में कहना',
        description: 'ऊपर या पड़ोस से शोर आने पर विनम्रता से बात करना:',
        sentences: [
          KSentence(
            id: 'ap4',
            roman: 'Swalpa sound kammi madi please.',
            deva: 'स्वल्प साउंड कम्मि मडि प्लीज़।',
            hindi: 'थोड़ी आवाज़ कम कीजिए प्लीज़।',
            chunks: [
              Chunk('Swalpa sound', 'स्वल्प साउंड', 'थोड़ी आवाज़'),
              Chunk('kammi madi please', 'कम्मि मडि प्लीज़', 'कम कीजिए प्लीज़'),
            ],
          ),
        ],
      ),
      const KSituation(
        id: 'apt_guest',
        title: 'Informing Guard About a Guest',
        hindiTitle: 'गार्ड को मेहमान के बारे में बताना',
        description: 'जब कोई मेहमान आने वाला हो:',
        sentences: [
          KSentence(
            id: 'ap5',
            roman: 'Nanna guest bartaare, kalisi.',
            deva: 'नन्न गेस्ट बर्ताारे, कळिसि।',
            hindi: 'मेरा मेहमान आएगा, भेज दीजिए।',
            chunks: [
              Chunk('Nanna guest', 'नन्न गेस्ट', 'मेरा मेहमान'),
              Chunk('bartaare, kalisi', 'बर्ताारे, कळिसि', 'आएगा, भेज दीजिए'),
            ],
          ),
        ],
      ),
    ],
  ),
  Category(
    id: 'romance',
    emoji: '💖',
    title: 'Love & Partner',
    hindiTitle: 'प्यार, क्रश और साथी',
    blurb: 'तारीफ़, हाल-चाल, डेट पर चलना और प्यार भरी बातें',
    situations: [
      const KSituation(
        id: 'rom_compliments',
        title: 'Sweet Compliments',
        hindiTitle: 'तारीफ़ करना (Compliments)',
        description: 'जब आपको उनकी सुंदरता या स्माइल की तारीफ़ करनी हो:',
        sentences: [
          KSentence(
            id: 'r1',
            roman: 'Neevu thumba andhavaagiddeera.',
            deva: 'नीवु तुंबा अंधवागिद्दीरा।',
            hindi: 'आप बहुत सुंदर लग रहे/रही हैं।',
            chunks: [Chunk('Neevu', 'नीवु', 'आप'), Chunk('thumba', 'तुंबा', 'बहुत'), Chunk('andhavaagiddeera', 'अंधवागिद्दीरा', 'सुंदर लग रहे हैं')],
          ),
        ],
      ),
      const KSituation(
        id: 'rom_plans',
        title: 'Making Date Plans',
        hindiTitle: 'डेट की योजना बनाना',
        description: 'शाम को डेट पर चलने का सुझाव देना:',
        sentences: [
          KSentence(
            id: 'r2',
            roman: 'Sanje date hogona.',
            deva: 'संजे डेट होगोणा।',
            hindi: 'शाम को डेट पर चलते हैं।',
            chunks: [Chunk('Sanje', 'संजे', 'शाम को'), Chunk('date hogona', 'डेट होगोणा', 'डेट पर चलते हैं')],
          ),
        ],
      ),
      const KSituation(
        id: 'rom_checkin',
        title: 'Checking In on Their Day',
        hindiTitle: 'हाल-चाल पूछना',
        description: 'दिन कैसा गया यह पूछते समय:',
        sentences: [
          KSentence(
            id: 'r3',
            roman: 'Hegideeya, dina hegittu?',
            deva: 'हेगिदीया, दिन हेगित्तु?',
            hindi: 'कैसी हो, दिन कैसा रहा?',
            chunks: [Chunk('Hegideeya', 'हेगिदीया', 'कैसी हो'), Chunk('dina hegittu?', 'दिन हेगित्तु?', 'दिन कैसा रहा?')],
          ),
        ],
      ),
      const KSituation(
        id: 'rom_miss',
        title: 'Saying You Miss Them',
        hindiTitle: 'याद आने की बात कहना',
        description: 'जब आप उनकी याद आने की बात बताना चाहें:',
        sentences: [
          KSentence(
            id: 'r4',
            roman: 'Nin nenapu aagthide.',
            deva: 'निन नेनपु आग्तिदे।',
            hindi: 'तुम्हारी याद आ रही है।',
            chunks: [Chunk('Nin nenapu', 'निन नेनपु', 'तुम्हारी याद'), Chunk('aagthide', 'आग्तिदे', 'आ रही है')],
          ),
        ],
      ),
      const KSituation(
        id: 'rom_sweet',
        title: 'Sweet Affection',
        hindiTitle: 'प्यार भरी बातें',
        description: 'प्यार जताने के लिए सीधी मीठी बात:',
        sentences: [
          KSentence(
            id: 'r5',
            roman: 'Nee nanna preethi.',
            deva: 'नी नन्न प्रीति।',
            hindi: 'तुम मेरा प्यार हो।',
            chunks: [Chunk('Nee', 'नी', 'तुम'), Chunk('nanna preethi', 'नन्न प्रीति', 'मेरा प्यार')],
          ),
        ],
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Sanskrit Cognates — 100 Tatsama words shared between Hindi and Kannada
// ---------------------------------------------------------------------------

final List<WordConnection> connections = [
  // TIME
  const WordConnection(category: 'Time', hindi: 'समय', kannadaRoman: 'samaya', kannadaDeva: 'समय', type: 'Tatsama', note: 'दोनों भाषाओं में एक ही संस्कृत शब्द जस का तस उपयोग होता है।'),
  const WordConnection(category: 'Time', hindi: 'वर्ष', kannadaRoman: 'varsha', kannadaDeva: 'वर्ष', type: 'Tatsama', note: 'साल के लिए औपचारिक शब्द, दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Time', hindi: 'दिन', kannadaRoman: 'dina', kannadaDeva: 'दिन', type: 'Tatsama', note: 'रोज़मर्रा की बातचीत में भी समान रूप से इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'रात्रि', kannadaRoman: 'raatri', kannadaDeva: 'रात्रि', type: 'Tatsama', note: 'औपचारिक रूप से रात के लिए इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'काल', kannadaRoman: 'kaala', kannadaDeva: 'काल', type: 'Tatsama', note: 'समय या युग के अर्थ में दोनों भाषाओं में सामान्य।'),
  const WordConnection(category: 'Time', hindi: 'मास', kannadaRoman: 'maasa', kannadaDeva: 'मास', type: 'Tatsama', note: 'महीने का औपचारिक/संस्कृत रूप।'),
  const WordConnection(category: 'Time', hindi: 'युग', kannadaRoman: 'yuga', kannadaDeva: 'युग', type: 'Tatsama', note: 'लंबे कालखंड के लिए इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'निमिष', kannadaRoman: 'nimisha', kannadaDeva: 'निमिष', type: 'Tatsama', note: 'एक पल के लिए काव्यात्मक शब्द।'),
  const WordConnection(category: 'Time', hindi: 'प्रहर', kannadaRoman: 'prahara', kannadaDeva: 'प्रहर', type: 'Tatsama', note: 'दिन के भाग/पहर के लिए।'),
  const WordConnection(category: 'Time', hindi: 'प्रतिदिन', kannadaRoman: 'pratidina', kannadaDeva: 'प्रतिदिन', type: 'Tatsama', note: '"हर रोज़" के लिए औपचारिक शब्द।'),

  // FAMILY
  const WordConnection(category: 'Family', hindi: 'माता', kannadaRoman: 'maata', kannadaDeva: 'माता', type: 'Tatsama', note: 'औपचारिक रूप से माँ के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पिता', kannadaRoman: 'pita', kannadaDeva: 'पिता', type: 'Tatsama', note: 'औपचारिक रूप से पिता के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पुत्र', kannadaRoman: 'putra', kannadaDeva: 'पुत्र', type: 'Tatsama', note: 'बेटे के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'पुत्री', kannadaRoman: 'putri', kannadaDeva: 'पुत्री', type: 'Tatsama', note: 'बेटी के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'सहोदर', kannadaRoman: 'sahodara', kannadaDeva: 'सहोदर', type: 'Tatsama', note: 'भाई के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'सहोदरी', kannadaRoman: 'sahodari', kannadaDeva: 'सहोदरी', type: 'Tatsama', note: 'बहन के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'पति', kannadaRoman: 'pati', kannadaDeva: 'पति', type: 'Tatsama', note: 'दोनों भाषाओं में समान रूप से पति के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पत्नी', kannadaRoman: 'patni', kannadaDeva: 'पत्नी', type: 'Tatsama', note: 'दोनों भाषाओं में समान रूप से पत्नी के लिए।'),
  const WordConnection(category: 'Family', hindi: 'विवाह', kannadaRoman: 'vivaaha', kannadaDeva: 'विवाह', type: 'Tatsama', note: 'शादी के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'कुटुंब', kannadaRoman: 'kutumba', kannadaDeva: 'कुटुंब', type: 'Tatsama', note: 'परिवार के लिए औपचारिक शब्द।'),

  // GREETINGS & SOCIAL
  const WordConnection(category: 'Greetings & Social', hindi: 'नमस्कार', kannadaRoman: 'namaskaara', kannadaDeva: 'नमस्कार', type: 'Tatsama', note: 'सबसे आम साझा अभिवादन।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'स्वागत', kannadaRoman: 'swaagata', kannadaDeva: 'स्वागत', type: 'Tatsama', note: 'स्वागत करने के लिए दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'आशीर्वाद', kannadaRoman: 'aashirvaada', kannadaDeva: 'आशीर्वाद', type: 'Tatsama', note: 'बुज़ुर्गों से आशीर्वाद माँगने के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'अभिनंदन', kannadaRoman: 'abhinandana', kannadaDeva: 'अभिनंदन', type: 'Tatsama', note: 'बधाई देने के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'धन्यवाद', kannadaRoman: 'dhanyavaadagalu', kannadaDeva: 'धन्यवादगळु', type: 'Tatsama', note: 'कन्नड़ में बहुवचन प्रत्यय (-गळु) जोड़कर अधिक सम्मान दिया जाता है।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'क्षमा', kannadaRoman: 'kshama', kannadaDeva: 'क्षमा', type: 'Tatsama', note: 'माफ़ी माँगने के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'आग्रह', kannadaRoman: 'aagraha', kannadaDeva: 'आग्रह', type: 'Tatsama', note: 'विनम्र अनुरोध के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'अनुमति', kannadaRoman: 'anumati', kannadaDeva: 'अनुमति', type: 'Tatsama', note: 'इजाज़त माँगने के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'परिचय', kannadaRoman: 'parichaya', kannadaDeva: 'परिचय', type: 'Tatsama', note: 'अपना परिचय देते समय इस्तेमाल होता है।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'सम्मान', kannadaRoman: 'sammaana', kannadaDeva: 'सम्मान', type: 'Tatsama', note: 'आदर या इज़्ज़त के लिए।'),

  // RELIGION & SPIRITUALITY
  const WordConnection(category: 'Religion & Spirituality', hindi: 'धर्म', kannadaRoman: 'dharma', kannadaDeva: 'धर्म', type: 'Tatsama', note: 'कर्तव्य और आस्था दोनों अर्थों में साझा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'कर्म', kannadaRoman: 'karma', kannadaDeva: 'कर्म', type: 'Tatsama', note: 'कर्मों के फल के अर्थ में समान रूप से समझा जाता है।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'मोक्ष', kannadaRoman: 'moksha', kannadaDeva: 'मोक्ष', type: 'Tatsama', note: 'मुक्ति के लिए साझा अवधारणा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'आत्मा', kannadaRoman: 'aatma', kannadaDeva: 'आत्मा', type: 'Tatsama', note: 'आत्मा/स्वयं के अर्थ में।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'भगवान', kannadaRoman: 'bhagavaan', kannadaDeva: 'भगवान', type: 'Tatsama', note: 'ईश्वर के लिए साझा शब्द।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'मंदिर', kannadaRoman: 'mandira', kannadaDeva: 'मंदिर', type: 'Tatsama', note: 'मंदिर के लिए दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'पूजा', kannadaRoman: 'puja', kannadaDeva: 'पूजा', type: 'Tatsama', note: 'पूजा-पाठ के लिए।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'प्रसाद', kannadaRoman: 'prasaada', kannadaDeva: 'प्रसाद', type: 'Tatsama', note: 'मंदिर से मिलने वाले भोग के लिए।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'शांति', kannadaRoman: 'shanti', kannadaDeva: 'शांति', type: 'Tatsama', note: 'शांति के अर्थ में साझा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'सत्य', kannadaRoman: 'satya', kannadaDeva: 'सत्य', type: 'Tatsama', note: 'सच्चाई के लिए साझा शब्द।'),

  // EDUCATION & KNOWLEDGE
  const WordConnection(category: 'Education & Knowledge', hindi: 'विद्या', kannadaRoman: 'vidya', kannadaDeva: 'विद्या', type: 'Tatsama', note: 'शिक्षा/विद्या के लिए साझा।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'ज्ञान', kannadaRoman: 'gnaana', kannadaDeva: 'ज्ञान', type: 'Tatsama', note: 'ज्ञान के लिए साझा शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'पुस्तक', kannadaRoman: 'pustaka', kannadaDeva: 'पुस्तक', type: 'Tatsama', note: 'किताब के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'शिक्षक', kannadaRoman: 'shikshaka', kannadaDeva: 'शिक्षक', type: 'Tatsama', note: 'अध्यापक के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'विद्यालय', kannadaRoman: 'vidyaalaya', kannadaDeva: 'विद्यालय', type: 'Tatsama', note: 'स्कूल के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'परीक्षा', kannadaRoman: 'pariksha', kannadaDeva: 'परीक्षा', type: 'Tatsama', note: 'इम्तिहान के लिए साझा शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'बुद्धि', kannadaRoman: 'buddhi', kannadaDeva: 'बुद्धि', type: 'Tatsama', note: 'समझ/अक्ल के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'विचार', kannadaRoman: 'vichaara', kannadaDeva: 'विचार', type: 'Tatsama', note: 'सोच/विचार के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'भाषा', kannadaRoman: 'bhasha', kannadaDeva: 'भाषा', type: 'Tatsama', note: 'भाषा के लिए साझा शब्द — जो इस ऐप का आधार भी है।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'अक्षर', kannadaRoman: 'akshara', kannadaDeva: 'अक्षर', type: 'Tatsama', note: 'अक्षर/लिपि के लिए।'),

  // GOVERNMENT & FORMAL
  const WordConnection(category: 'Government & Formal', hindi: 'सरकार', kannadaRoman: 'sarakaara', kannadaDeva: 'सरकार', type: 'Tatsama', note: 'सरकार के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'राज्य', kannadaRoman: 'raajya', kannadaDeva: 'राज्य', type: 'Tatsama', note: 'राज्य के लिए साझा।'),
  const WordConnection(category: 'Government & Formal', hindi: 'नियम', kannadaRoman: 'niyama', kannadaDeva: 'नियम', type: 'Tatsama', note: 'क़ानून/नियम के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'न्याय', kannadaRoman: 'nyaaya', kannadaDeva: 'न्याय', type: 'Tatsama', note: 'इंसाफ़ के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'अधिकार', kannadaRoman: 'adhikaara', kannadaDeva: 'अधिकार', type: 'Tatsama', note: 'हक़/अधिकार के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'अध्यक्ष', kannadaRoman: 'adhyaksha', kannadaDeva: 'अध्यक्ष', type: 'Tatsama', note: 'अध्यक्ष/प्रमुख के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'मंत्री', kannadaRoman: 'mantri', kannadaDeva: 'मंत्री', type: 'Tatsama', note: 'मंत्री के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'प्रशासन', kannadaRoman: 'prashaasana', kannadaDeva: 'प्रशासन', type: 'Tatsama', note: 'प्रशासन के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'सुरक्षा', kannadaRoman: 'suraksha', kannadaDeva: 'सुरक्षा', type: 'Tatsama', note: 'सुरक्षा के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'स्वतंत्र', kannadaRoman: 'swatantra', kannadaDeva: 'स्वतंत्र', type: 'Tatsama', note: 'आज़ाद/स्वतंत्र के लिए।'),

  // NUMBERS & QUANTITY
  const WordConnection(category: 'Numbers & Quantity', hindi: 'एक (औपचारिक)', kannadaRoman: 'eka', kannadaDeva: 'एक', type: 'Tatsama', note: 'रोज़मर्रा में "ondu" चलता है, पर औपचारिक रूप साझा है।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'द्वितीय', kannadaRoman: 'dvitiya', kannadaDeva: 'द्वितीय', type: 'Tatsama', note: '"दूसरा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'तृतीय', kannadaRoman: 'tritiya', kannadaDeva: 'तृतीय', type: 'Tatsama', note: '"तीसरा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'चतुर्थ', kannadaRoman: 'chaturtha', kannadaDeva: 'चतुर्थ', type: 'Tatsama', note: '"चौथा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'पंच', kannadaRoman: 'pancha', kannadaDeva: 'पंच', type: 'Tatsama', note: '"पाँच" की जड़, कई शब्दों में मिलती है।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'शत', kannadaRoman: 'shata', kannadaDeva: 'शत', type: 'Tatsama', note: '"सौ" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'सहस्र', kannadaRoman: 'sahasra', kannadaDeva: 'सहस्र', type: 'Tatsama', note: '"हज़ार" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'अर्ध', kannadaRoman: 'ardha', kannadaDeva: 'अर्ध', type: 'Tatsama', note: 'आधे के लिए साझा शब्द।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'पूर्ण', kannadaRoman: 'poorna', kannadaDeva: 'पूर्ण', type: 'Tatsama', note: 'पूरा/संपूर्ण के लिए।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'अल्प', kannadaRoman: 'alpa', kannadaDeva: 'अल्प', type: 'Tatsama', note: 'थोड़ा/कम के औपचारिक रूप में — "swalpa" इसी से आता है।'),

  // EMOTIONS & QUALITIES
  const WordConnection(category: 'Emotions & Qualities', hindi: 'प्रेम', kannadaRoman: 'prema', kannadaDeva: 'प्रेम', type: 'Tatsama', note: 'प्यार के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'क्रोध', kannadaRoman: 'krodha', kannadaDeva: 'क्रोध', type: 'Tatsama', note: 'गुस्से के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'दुःख', kannadaRoman: 'dukha', kannadaDeva: 'दुःख', type: 'Tatsama', note: 'दुःख/ग़म के लिए साझा।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'सुख', kannadaRoman: 'sukha', kannadaDeva: 'सुख', type: 'Tatsama', note: 'ख़ुशी के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'आशा', kannadaRoman: 'aashaa', kannadaDeva: 'आशा', type: 'Tatsama', note: 'उम्मीद के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'भय', kannadaRoman: 'bhaya', kannadaDeva: 'भय', type: 'Tatsama', note: 'डर के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'उत्साह', kannadaRoman: 'utsaaha', kannadaDeva: 'उत्साह', type: 'Tatsama', note: 'जोश/उत्साह के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'संतोष', kannadaRoman: 'santosha', kannadaDeva: 'संतोष', type: 'Tatsama', note: 'संतुष्टि के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'विश्वास', kannadaRoman: 'vishwaasa', kannadaDeva: 'विश्वास', type: 'Tatsama', note: 'भरोसे के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'साहस', kannadaRoman: 'saahasa', kannadaDeva: 'साहस', type: 'Tatsama', note: 'हिम्मत के लिए।'),

  // NATURE
  const WordConnection(category: 'Nature', hindi: 'सूर्य', kannadaRoman: 'surya', kannadaDeva: 'सूर्य', type: 'Tatsama', note: 'सूरज के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'चंद्र', kannadaRoman: 'chandra', kannadaDeva: 'चंद्र', type: 'Tatsama', note: 'चाँद के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'वायु', kannadaRoman: 'vaayu', kannadaDeva: 'वायु', type: 'Tatsama', note: 'हवा के औपचारिक रूप में।'),
  const WordConnection(category: 'Nature', hindi: 'जल', kannadaRoman: 'jala', kannadaDeva: 'जल', type: 'Tatsama', note: 'पानी के औपचारिक रूप में — रोज़मर्रा में "neeru" चलता है।'),
  const WordConnection(category: 'Nature', hindi: 'अग्नि', kannadaRoman: 'agni', kannadaDeva: 'अग्नि', type: 'Tatsama', note: 'आग के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'पृथ्वी', kannadaRoman: 'prithvi', kannadaDeva: 'पृथ्वी', type: 'Tatsama', note: 'धरती के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'आकाश', kannadaRoman: 'aakaasha', kannadaDeva: 'आकाश', type: 'Tatsama', note: 'आसमान के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'नदी', kannadaRoman: 'nadi', kannadaDeva: 'नदी', type: 'Tatsama', note: 'नदी के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'पर्वत', kannadaRoman: 'parvata', kannadaDeva: 'पर्वत', type: 'Tatsama', note: 'पहाड़ के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'वृक्ष', kannadaRoman: 'vriksha', kannadaDeva: 'वृक्ष', type: 'Tatsama', note: 'पेड़ के औपचारिक रूप में।'),

  // BODY & HEALTH
  const WordConnection(category: 'Body & Health', hindi: 'शरीर', kannadaRoman: 'shareera', kannadaDeva: 'शरीर', type: 'Tatsama', note: 'शरीर के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'स्वास्थ्य', kannadaRoman: 'swaasthya', kannadaDeva: 'स्वास्थ्य', type: 'Tatsama', note: 'सेहत के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'हृदय', kannadaRoman: 'hridaya', kannadaDeva: 'हृदय', type: 'Tatsama', note: 'दिल के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'नेत्र', kannadaRoman: 'netra', kannadaDeva: 'नेत्र', type: 'Tatsama', note: 'आँख के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'रोग', kannadaRoman: 'roga', kannadaDeva: 'रोग', type: 'Tatsama', note: 'बीमारी के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'औषध', kannadaRoman: 'aushadha', kannadaDeva: 'औषध', type: 'Tatsama', note: 'दवा के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'चिकित्सा', kannadaRoman: 'chikitsa', kannadaDeva: 'चिकित्सा', type: 'Tatsama', note: 'इलाज के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'शक्ति', kannadaRoman: 'shakti', kannadaDeva: 'शक्ति', type: 'Tatsama', note: 'ताक़त के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'आयु', kannadaRoman: 'aayu', kannadaDeva: 'आयु', type: 'Tatsama', note: 'उम्र के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'विश्राम', kannadaRoman: 'vishraama', kannadaDeva: 'विश्राम', type: 'Tatsama', note: 'आराम के लिए साझा शब्द।'),
];

List<String> get cognateCategories {
  final seen = <String>{};
  final ordered = <String>[];
  for (final c in connections) {
    if (seen.add(c.category)) ordered.add(c.category);
  }
  return ordered;
}

// ---------------------------------------------------------------------------
// Lesson generation
// ---------------------------------------------------------------------------

const List<Chunk> _distractorPool = [
  Chunk('illa', 'इल्ल', 'नहीं'),
  Chunk('yenu', 'येनु', 'क्या'),
  Chunk('naale', 'नाळे', 'कल'),
  Chunk('sari', 'सरी', 'ठीक है'),
  Chunk('idu', 'इदु', 'यह'),
  Chunk('bega', 'बेग', 'जल्दी'),
];

/// Picks the "2-Minute Daily Scenario" for today's device date.
///
/// The pick is deterministic for a given calendar day (so it doesn't change
/// if the user re-opens the app later the same day, or reopens after
/// killing the app), but it is seeded from the full date — not just a
/// sequential day-of-year counter — so consecutive days land on unrelated
/// situations instead of visibly stepping through the list in order.
KSituation getDailyScenario() {
  final now = DateTime.now();
  final allSituations = categories.expand((c) => c.situations).toList();
  if (allSituations.isEmpty) {
    throw StateError('No situations available to pick a daily scenario from.');
  }

  // A stable per-calendar-day seed: yyyymmdd as an integer.
  final dateSeed = now.year * 10000 + now.month * 100 + now.day;
  final rng = Random(dateSeed);

  // Shuffle a copy of the indices using the date-seeded RNG, then take the
  // first one. Because the RNG is re-seeded identically for the same date,
  // this is stable within a day but looks random from one day to the next.
  final indices = List<int>.generate(allSituations.length, (i) => i)..shuffle(rng);
  return allSituations[indices.first];
}

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];
  final rng = Random(situation.id.hashCode);

  for (final sentence in situation.sentences) {
    steps.add(
      PhraseStep(
        roman: sentence.roman,
        deva: sentence.deva,
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
        targetDeva: sentence.deva,
        tip: sentence.streetCode ?? 'ज़ोर से बोलकर अभ्यास करें ताकि झिझक मिटे।',
      ),
    );

    if (sentence.chunks.length >= 2) {
      final answerRoman = sentence.chunks.map((c) => c.roman).toList();
      final answerDeva = sentence.chunks.map((c) => c.deva).toList();

      final available = _distractorPool.where((d) => !answerRoman.contains(d.roman)).toList()..shuffle(rng);
      final distractors = available.take(2).toList();

      final tilesRoman = [...answerRoman, ...distractors.map((d) => d.roman)]..shuffle(rng);
      final tilesDeva = [...answerDeva, ...distractors.map((d) => d.deva)]..shuffle(rng);

      steps.add(
        BuildStep(
          promptHindi: sentence.hindi,
          answerRoman: answerRoman,
          answerDeva: answerDeva,
          tilesRoman: tilesRoman,
          tilesDeva: tilesDeva,
          revealRoman: sentence.roman,
          revealDeva: sentence.deva,
        ),
      );
    }
  }
  return Lesson(
    id: situation.id,
    title: situation.title,
    subtitle: situation.hindiTitle,
    steps: steps,
  );
}
