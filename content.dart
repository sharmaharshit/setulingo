// Core models, cascading sentence lab rules, and immersive theater mode encounters.

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

  const WordConnection({
    required this.hindi,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.type,
    required this.note,
  });
}

// ---------------------------------------------------------------------------
// Theater Mode Street Encounters Data
// ---------------------------------------------------------------------------

class EncounterChoice {
  final String id;
  final String stanceTitle; // e.g. "The Reasonable Local"
  final String stanceBadge;
  final String roman;
  final String deva;
  final String hindi;
  final String outcomeTitle;
  final String outcomeBody;
  final String culturalRule;

  const EncounterChoice({
    required this.id,
    required this.stanceTitle,
    required this.stanceBadge,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.outcomeTitle,
    required this.outcomeBody,
    required this.culturalRule,
  });
}

class StreetEncounter {
  final String id;
  final String tag;
  final String title;
  final String hindiTitle;
  final String location;
  final String atmosphere;
  final String overheardSpeaker;
  final String overheardRoman;
  final String overheardDeva;
  final String overheardHindi;
  final String dilemma;
  final List<EncounterChoice> choices;

  const StreetEncounter({
    required this.id,
    required this.tag,
    required this.title,
    required this.hindiTitle,
    required this.location,
    required this.atmosphere,
    required this.overheardSpeaker,
    required this.overheardRoman,
    required this.overheardDeva,
    required this.overheardHindi,
    required this.dilemma,
    required this.choices,
  });
}

final List<StreetEncounter> streetEncounters = [
  const StreetEncounter(
    id: 'enc_bmtc_mock',
    tag: '⚡ Social Self-Defense',
    title: 'The Bus Sneer',
    hindiTitle: 'बस में कपड़ों पर टिप्पणी',
    location: 'BMTC Route 500D (Silk Board to Marathahalli)',
    atmosphere: '7:45 PM. Packed evening rush hour. Two passengers behind you are chuckling and speaking in fast Kannada.',
    overheardSpeaker: 'Co-passenger',
    overheardRoman: 'Nodu guru, ivana pant nodu... circus thara ide!',
    overheardDeva: 'नोडु गुरु, इवन पँट नोडु... सर्कस तर इदे!',
    overheardHindi: 'देख भाई, इसकी पैंट देख... सर्कस जैसी लग रही है!',
    dilemma: 'They assume you are an outsider who doesn\'t understand a word. How do you respond?',
    choices: [
      EncounterChoice(
        id: 'c1',
        stanceTitle: 'The Reasonable Local',
        stanceBadge: '😏 De-escalate with Wit',
        roman: 'Kannada baratte anna, hushaar!',
        deva: 'कन्नड बरतॆ अण्णा, हुषार्!',
        hindi: 'कन्नड़ आती है भैया, ज़रा संभल के!',
        outcomeTitle: 'Immediate Silence & Respect',
        outcomeBody: 'Both passengers freeze. The guy who spoke turns red, nudges his friend, and mutters: "Ssorry bro, just joking!"',
        culturalRule: '💡 Street Rule: Speaking just 3 words of confident Kannada shatters the assumption that you are an easy target.',
      ),
      EncounterChoice(
        id: 'c2',
        stanceTitle: 'The Polite Pushback',
        stanceBadge: '🎯 Assertive Boundary',
        roman: 'Nanna dress bagge ninge en samasye boss?',
        deva: 'नन्ना ड्रेस बग्गे निंगे एन समस्यॆ बॉस?',
        hindi: 'मेरी ड्रेस से तुम्हें क्या परेशानी है बॉस?',
        outcomeTitle: 'Conductor Steps In',
        outcomeBody: 'They stammer and look away. The bus conductor yells from the front: "Enri alli galaate? Munde nodi kuutkoḷi!" (What noise is that? Face forward and sit quietly!)',
        culturalRule: '💡 Street Rule: Using "Ninge en samasye boss?" immediately puts uninvited commentators on the defensive.',
      ),
      EncounterChoice(
        id: 'c3',
        stanceTitle: 'The Disarming Witticism',
        stanceBadge: '😎 Bengaluru Slang',
        roman: 'Sakkath aagide alva macha? Bengaluru fashion idu!',
        deva: 'सक्कथ आगिदे अल्व मचा? बेंगलुरु फॅशन इदु!',
        hindi: 'ज़बरदस्त लग रही है ना भाई? बेंगलुरु फ़ैशन है यह!',
        outcomeTitle: 'Instant Camaraderie',
        outcomeBody: 'They burst out laughing and give a thumbs-up: "Super macha! You are completely local!"',
        culturalRule: '💡 Street Rule: Deploying "Macha" and "Sakkath" turns potential tension into instant local street street-cred.',
      ),
    ],
  ),
  const StreetEncounter(
    id: 'enc_auto_meter',
    tag: '🛺 Transit Standoff',
    title: 'The Double-Meter Bluff',
    hindiTitle: 'ऑटो वाले का मनमाना किराया',
    location: 'Indiranagar 100ft Road (9:00 PM in Light Drizzle)',
    atmosphere: '9:00 PM in light drizzle. You need a 3 km drop, but the auto driver flashes his yellow light and quotes a flat rate.',
    overheardSpeaker: 'Auto Driver',
    overheardRoman: 'Meter aagalla sir, 250 fix. Barovragi baa.',
    overheardDeva: 'मीटर आगल्ला सर, २५० फिक्स। बरोव्रागि बा।',
    overheardHindi: 'मीटर से नहीं चलेगा सर, २५० रुपये फ़िक्स। आना है तो आओ।',
    dilemma: 'It\'s drizzling and cabs are surge-priced. How do you negotiate your fare?',
    choices: [
      EncounterChoice(
        id: 'a1',
        stanceTitle: 'The Reasonable Local',
        stanceBadge: '🤝 Fair Negotiation',
        roman: 'Anna, meter haaki 30 extra thagoli, swalpa adjust maadi.',
        deva: 'अण्णा, मीटर हाकि ३० एक्स्ट्रा थगोळ्ळि, स्वल्प एडजस्ट माडि।',
        hindi: 'भैया, मीटर डालिए और ३० ऊपर ले लीजिए, थोड़ा एडजस्ट कीजिए।',
        outcomeTitle: 'Driver Agrees',
        outcomeBody: 'The driver smiles: "Sorry sir, rain is heavy... okay get in, I will put the meter on."',
        culturalRule: '💡 Street Rule: "Meter + 30 extra" is the golden currency of Bengaluru auto negotiations during peak hours.',
      ),
      EncounterChoice(
        id: 'a2',
        stanceTitle: 'The Polite Pushback',
        stanceBadge: '🚶 Walking Away Bluff',
        roman: 'Beda anna, naanu metro-ge hogtheeni.',
        deva: 'बेडा अण्णा, नानु मेट्रो-गे होग्तीनि।',
        hindi: 'नहीं चाहिए भैया, मैं मेट्रो से चला जाता हूँ।',
        outcomeTitle: 'Immediate Price Drop',
        outcomeBody: 'As you turn around to walk toward the main road, he honks and calls out: "Banni sir, 150 kodi, chalo!"',
        culturalRule: '💡 Street Rule: Mentioning the Metro immediately stops auto drivers from quoting tourist prices.',
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Categories & Situations Data
// ---------------------------------------------------------------------------

final List<KWord> allWords = [
  const KWord(id: 'nanage', roman: 'Nanage', deva: 'ननगे', hindi: 'मुझे', note: 'वाक्य की शुरुआत में आता है।'),
  const KWord(id: 'beku', roman: 'Beku', deva: 'बेकु', hindi: 'चाहिए'),
  const KWord(id: 'beda', roman: 'Beda', deva: 'बेडा', hindi: 'नहीं चाहिए'),
  const KWord(id: 'saaku', roman: 'Saaku', deva: 'साकु', hindi: 'बस / काफ़ी है'),
  const KWord(id: 'ondu', roman: 'Ondu', deva: 'ओन्दु', hindi: 'एक'),
  const KWord(id: 'innondu', roman: 'Innondu', deva: 'इन्नोन्दु', hindi: 'एक और'),
  const KWord(id: 'kodi', roman: 'Kodi', deva: 'कोडि', hindi: 'दीजिए'),
  const KWord(id: 'eshtu', roman: 'Eshtu', deva: 'एष्टु', hindi: 'कितना'),
  const KWord(id: 'coffee', roman: 'Coffee', deva: 'कॉफ़ी', hindi: 'कॉफ़ी'),
  const KWord(id: 'dose', roman: 'Dose', deva: 'दोसे', hindi: 'डोसा'),
  const KWord(id: 'tea', roman: 'Tea', deva: 'टी', hindi: 'चाय'),
  const KWord(id: 'neeru', roman: 'Neeru', deva: 'नीरु', hindi: 'पानी'),
  const KWord(id: 'sambar', roman: 'Sambar', deva: 'सांबार', hindi: 'सांभर'),
  const KWord(id: 'haaki', roman: 'Haaki', deva: 'हाकि', hindi: 'डालिए'),
  const KWord(id: 'swalpa', roman: 'Swalpa', deva: 'स्वल्प', hindi: 'थोड़ा', streetCode: '🏷️ Street Code: बात शुरू करने का जादुई शब्द'),
  const KWord(id: 'nilisi', roman: 'Nilisi', deva: 'निलिसि', hindi: 'रोकिए'),
  const KWord(id: 'hogbeku', roman: 'Hogbeku', deva: 'होगबेकु', hindi: 'जाना है'),
  const KWord(id: 'banni', roman: 'Banni', deva: 'बन्नि', hindi: 'आइए'),
];

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
            DialogueTurn(speaker: 'काउंटर वाला', isUser: false, roman: 'Eighty rupees aaytu. QR code table meele ide.', deva: 'एइटी रुपीस आयतु। क्यूआर कोड टेबल मेले इदे।', hindi: '८० रुपये हुए। क्यूआर कोड मेज़ पर है।'),
            DialogueTurn(speaker: 'आप', isUser: true, roman: 'Payment maadiddiini anna.', deva: 'पेमेंट माडिद्दीनि अण्णा।', hindi: 'पेमेंट कर दिया है भैया।'),
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
          KSentence(
            id: 'f3',
            roman: 'Swalpa sambar haaki.',
            deva: 'स्वल्प सांबार हाकि।',
            hindi: 'थोड़ा सांभर डालिए।',
            chunks: [Chunk('Swalpa', 'स्वल्प', 'थोड़ा'), Chunk('sambar', 'सांबार', 'सांभर'), Chunk('haaki', 'हाकि', 'डालिए')],
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
            streetCode: '🏷️ Bengaluru Suffix: जगह के नाम के साथ "-ge" जोड़ें',
          ),
          KSentence(
            id: 'a2',
            roman: 'Illi nilisi boss.',
            deva: 'इल्लि निलिसि बॉस।',
            hindi: 'यहाँ रोकिए बॉस।',
            chunks: [Chunk('Illi', 'इल्लि', 'यहाँ'), Chunk('nilisi', 'निलिसि', 'रोकिए'), Chunk('boss', 'बॉस', 'बॉस')],
            streetCode: '🏷️ Street Code: "Illi nilisi" हर दिन ऑटो या कैब में काम आता है',
          ),
        ],
      ),
    ],
  ),
];

KSituation getDailyScenario() {
  final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  final allSituations = categories.expand((c) => c.situations).toList();
  return allSituations[dayOfYear % allSituations.length];
}

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];

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

    final cleanWordsRoman = sentence.roman.replaceAll(RegExp(r'[^\w\s\-]'), '').split(' ').where((w) => w.isNotEmpty).toList();
    final cleanWordsDeva = sentence.deva.replaceAll(RegExp(r'[^\w\s\u0900-\u097F\-]'), '').split(' ').where((w) => w.isNotEmpty).toList();

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

  for (final target in situation.sentences) {
    final distractorsRoman = ['Nanage beda.', 'Illi nilisi.', 'Eshtu aaytu?']..remove(target.roman);
    final distractorsDeva = ['ननगे बेडा।', 'इल्लि निलिसि।', 'एष्टु आयतु?']..remove(target.deva);

    final optRoman = [target.roman, distractorsRoman[0], distractorsRoman.length > 1 ? distractorsRoman[1] : 'Saaku anna.']..shuffle();
    final optDeva = [target.deva, distractorsDeva[0], distractorsDeva.length > 1 ? distractorsDeva[1] : 'साकु अण्णा।']..shuffle();

    steps.add(
      UseStep(
        situation: situation.description,
        question: 'अगर आपको कहना हो: "${target.hindi}", तो आप क्या बोलेंगे?',
        optionsRoman: optRoman,
        optionsDeva: optDeva,
        answerIndex: optRoman.indexOf(target.roman),
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
