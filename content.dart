// Complete data architecture: All 8 Categories, Sanskrit Cognates, and the 15-Decision Encounter.

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
// Epic 15-Decision Encounter Story: "A Chaotic Bengaluru Monday"
// ---------------------------------------------------------------------------

class EncounterOption {
  final String badge;
  final String kannadaRoman;
  final String kannadaDeva;
  final String hindiMeaning;
  final int nextStep;

  const EncounterOption({
    required this.badge,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.hindiMeaning,
    required this.nextStep,
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

final List<EncounterStepNode> epicEncounterStory = [
  const EncounterStepNode(
    stepNumber: 1,
    title: 'The Morning Alarm',
    narrativeEn: '7:30 AM. Your alarm rings. You look at the clock and realize you are late for office. What do you decide?',
    narrativeHi: 'सुबह ७:३० बजे अलार्म बजा। आपने घड़ी देखी और पाया कि आप ऑफ़िस के लिए लेट हो रहे हैं। आप क्या तय करते हैं?',
    options: [
      EncounterOption(badge: 'Skip Shower', kannada_roman: 'Snana beda, bega hogona.', kannadaDeva: 'स्नान बेडा, बेग होगोणा।', hindiMeaning: 'स्नान नहीं, जल्दी चलते हैं।', nextStep: 2),
      EncounterOption(badge: 'Take Leave', kannada_roman: 'Inru office-ge chhutti.', kannadaDeva: 'इंद्रू ऑफ़िस-गे छुरी।', hindiMeaning: 'आज ऑफ़िस की छुट्टी।', nextStep: 3),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 2,
    title: 'Stepping Out for Breakfast',
    narrativeEn: 'You rush out without breakfast. On the street corner, you spot a crowded Darshini. Do you stop?',
    narrativeHi: 'आप बिना नाश्ते के भागे। गली के नुक्कड़ पर एक भीड़भाड़ वाली दर्शिनी दिखी। क्या आप रुकेंगे?',
    options: [
      EncounterOption(badge: 'Order Coffee', kannada_roman: 'Nanage ondu coffee beku.', kannadaDeva: 'ननगे ओन्दु कॉफ़ी बेकु।', hindiMeaning: 'मुझे एक कॉफ़ी चाहिए।', nextStep: 4),
      EncounterOption(badge: 'Skip & Walk', kannada_roman: 'Beda, naanu hogtheeni.', kannadaDeva: 'बेड़ा, नानु होग्तीनी।', hindiMeaning: 'नहीं, मैं जा रहा हूँ।', nextStep: 5),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 3,
    title: 'Calling Manager for Leave',
    narrativeEn: 'You decide to take a leave. Your manager picks up the phone sounding annoyed. What excuse do you give?',
    narrativeHi: 'आपने छुट्टी लेने का फैसला किया। मैनेजर ने नाराज़ आवाज़ में फ़ोन उठाया। आप क्या बहाना देंगे?',
    options: [
      EncounterOption(badge: 'Fever Excuse', kannada_roman: 'Nanage jwara bandide.', kannadaDeva: 'ननगे ज्वर बंदिदे।', hindiMeaning: 'मुझे बुख़ार आ गया है।', nextStep: 6),
      EncounterOption(badge: 'Family Work',_roman: 'Maneli kelasa ide.', kannadaDeva: 'मनेलि कलस इदे।', hindiMeaning: 'घर पर काम है।', nextStep: 6),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 4,
    title: 'At the Darshini Counter',
    narrativeEn: 'You ask for coffee. The counter guy asks if you want anything else to eat.',
    narrativeHi: 'आपने कॉफ़ी माँगी। काउंटर वाले ने पूछा कि क्या खाने के लिए कुछ और चाहिए?',
    options: [
      EncounterOption(badge: 'Add Dosa', kannada_roman: 'Ondu masala dose kodi.', kannadaDeva: 'ओन्दु मसाला दोसे कोडि।', hindiMeaning: 'एक मसाला डोसा दीजिए।', nextStep: 7),
      EncounterOption(badge: 'Only Coffee', kannada_roman: 'Coffee mathra saaku.', kannadaDeva: 'कॉफ़ी मात्र साकु।', hindiMeaning: 'बस कॉफ़ी काफ़ी है।', nextStep: 7),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 5,
    title: 'Hailing an Auto',
    narrativeEn: 'You walk toward the main road and wave down an auto. The driver looks at you.',
    narrativeHi: 'आप मुख्य सड़क की तरफ़ चले और ऑटो वाले को हाथ दिया। ड्राइवर आपकी तरफ़ देखता है।',
    options: [
      EncounterOption(badge: 'Ask Destination', kannada_roman: 'MG Road-ge barthira?', kannadaDeva: 'एमजी रोड-गे बर्तीरा?', hindiMeaning: 'एमजी रोड चलेंगे क्या?', nextStep: 8),
      EncounterOption(badge: 'Ask Meter', kannada_roman: 'Meter haaki anna.', kannadaDeva: 'मीटर हाकि अण्णा।', hindiMeaning: 'मीटर लगाइए भैया।', nextStep: 8),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 6,
    title: 'Manager\'s Reaction',
    narrativeEn: 'Your manager sighs on the phone and asks you to send a message on WhatsApp instead.',
    narrativeHi: 'मैनेजर ने फ़ोन पर आह भरी और WhatsApp पर मैसेज भेजने को कहा।',
    options: [
      EncounterOption(badge: 'Okay Sir', kannada_roman: 'Aythu sir, kalsutheeni.', kannadaDeva: 'आयतु सर, कल्सुतीनी।', hindiMeaning: 'ठीक है सर, भेजता हूँ।', nextStep: 10),
      EncounterOption(badge: 'Will Rest', kannada_roman: 'Naanu rest maadtheeni.', kannadaDeva: 'नानु रेस्ट माद्तीनी।', hindiMeaning: 'मैं आराम करूँगा।', nextStep: 10),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 7,
    title: 'Paying at Darshini',
    narrativeEn: 'You finish your quick breakfast and ask for the total bill amount.',
    narrativeHi: 'आपने अपना नाश्ता ख़त्म किया और कुल बिल का अमाउंट पूछा।',
    options: [
      EncounterOption(badge: 'Ask Total', kannada_roman: 'Eshtu aaytu anna?', kannadaDeva: 'एष्टु आयतु अण्णा?', hindiMeaning: 'कितना हुआ भैया?', nextStep: 9),
      EncounterOption(badge: 'UPI Payment', kannada_roman: 'Scanner illi ideyaa?', kannadaDeva: 'स्कैनर इल्लि इदिया?', hindiMeaning: 'स्कैनर यहाँ है क्या?', nextStep: 9),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 8,
    title: 'Auto Haggling',
    narrativeEn: 'The auto driver demands double the price due to traffic. How do you respond?',
    narrativeHi: 'ट्रैफिक का हवाला देकर ऑटो ड्राइवर दोगुना किराया माँग रहा है। आप क्या जवाब देंगे?',
    options: [
      EncounterOption(badge: 'Negotiate', kannada_roman: 'Swalpa kammi maadi anna.', kannadaDeva: 'स्वल्प कम्मि माडि अण्णा।', hindiMeaning: 'थोड़ा कम कीजिए भैया।', nextStep: 11),
      EncounterOption(badge: 'Walk Away', kannada_roman: 'Beda anna, namaskara.', kannadaDeva: 'बेडा अण्णा, नमस्कार।', hindiMeaning: 'नहीं चाहिए भैया, नमस्कार।', nextStep: 11),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 9,
    title: 'Exiting the Darshini',
    narrativeEn: 'You pay via UPI and step out onto the busy pavement, ready for your day.',
    narrativeHi: 'आपने UPI से भुगतान किया और अपने दिन की शुरुआत के लिए व्यस्त फ़ुटपाथ पर आ गए।',
    options: [
      EncounterOption(badge: 'Let\'s go', kannada_roman: 'Chalo, hogona banni.', kannadaDeva: 'चलो, होगोणा बन्नि।', hindiMeaning: 'चलो, चलते हैं आइए।', nextStep: 12),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 10,
    title: 'Enjoying Day Off at Home',
    narrativeEn: 'Since you took a leave, you decide to make a hot cup of tea at home.',
    narrativeHi: 'चूँकि आपने छुट्टी ले ली है, आपने घर पर ही गरम चाय बनाने का फ़ैसला किया।',
    options: [
      EncounterOption(badge: 'Boil Water', kannada_roman: 'Swalpa neeru kayisi.', kannadaDeva: 'स्वल्प नीरु कयिसि।', hindiMeaning: 'थोड़ा पानी गरम करो।', nextStep: 13),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 11,
    title: 'Reaching Office Lobby',
    narrativeEn: 'You finally reach office late. The security guard at the gate stops you for your ID card.',
    narrativeHi: 'आप आख़िरकार ऑफ़िस लेट पहुँचे। गेट पर सिक्योरिटी गार्ड ने आईडी कार्ड के लिए आपको रोक लिया।',
    options: [
      EncounterOption(badge: 'Show ID', kannada_roman: 'Id card illi ide.', kannadaDeva: 'आईडी कार्ड इल्लि इदे।', hindiMeaning: 'आईडी कार्ड यहाँ है।', nextStep: 14),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 12,
    title: 'Entering the Office Floor',
    narrativeEn: 'You walk into your floor and your teammate asks why you were running late.',
    narrativeHi: 'आप अपने फ़्लोर पर पहुँचे और आपके साथी ने पूछा कि आपको इतनी देर क्यों हुई।',
    options: [
      EncounterOption(badge: 'Traffic Jam', kannada_roman: 'Traffic thumba ide anna.', kannadaDeva: 'ट्रैफिक तुंबा इदे अण्णा।', hindiMeaning: 'ट्रैफिक बहुत है भैया।', nextStep: 15),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 13,
    title: 'Relaxing Afternoon',
    narrativeEn: 'You spend the afternoon reading a book and resting peacefully.',
    narrativeHi: 'आपने दोपहर का समय किताब पढ़ते हुए और शांति से आराम करते हुए बिताया।',
    options: [
      EncounterOption(badge: 'Very Nice', kannada_roman: 'Tumba chennagide.', kannadaDeva: 'तुंबा चेन्नागिदे।', hindiMeaning: 'बहुत बढ़िया है।', nextStep: 15),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 14,
    title: 'Desk Work Begins',
    narrativeEn: 'You sit at your desk, boot up your laptop, and start the morning emails.',
    narrativeHi: 'आप अपनी डेस्क पर बैठे, लैपटॉप ऑन किया और सुबह के ईमेल देखने शुरू किए।',
    options: [
      EncounterOption(badge: 'Start Work', kannada_roman: 'Kelsa shuru maadtheeni.', kannadaDeva: 'कलस सुरु माद्तीनी।', hindiMeaning: 'काम शुरू करता हूँ।', nextStep: 15),
    ],
  ),
  const EncounterStepNode(
    stepNumber: 15,
    title: 'End of Decision Tree',
    narrativeEn: 'You successfully navigated your chaotic Bengaluru Monday! You earned the Street Survivor Badge.',
    narrativeHi: 'आपने अपने अराजक बेंगलुरु सोमवार को सफलतापूर्वक पार कर लिया! आपने स्ट्रीट सर्वाइवर बैज जीत लिया है।',
    options: [
      EncounterOption(badge: 'Finish & Save', kannada_roman: 'Bahala khushi aaytu!', kannadaDeva: 'बहाल खुशी आयतु!', hindiMeaning: 'बहुत ख़ुशी हुई!', nextStep: 1),
    ],
  ),
];

// ---------------------------------------------------------------------------
// All 8 Categories Restored
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
    ],
  ),
];

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
  }
  return Lesson(
    id: situation.id,
    title: situation.title,
    subtitle: situation.hindiTitle,
    steps: steps,
  );
}
