// Core models, vocabulary, situations, categories, and branching Street Encounters.

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
  final List<String> hinglishKeywords;

  const KSentence({
    required this.id,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.chunks,
    this.note,
    this.streetCode,
    this.hinglishKeywords = const [],
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
// Street Encounters (Branching Social Confrontation Engine)
// ---------------------------------------------------------------------------

class EncounterChoice {
  final String id;
  final String intentBadge; // e.g. "😏 Witty De-escalation"
  final String roman;
  final String deva;
  final String hindi;
  final String reactionTitle;
  final String reactionBody;
  final String takeawayRule;

  const EncounterChoice({
    required this.id,
    required this.intentBadge,
    required this.roman,
    required this.deva,
    required this.hindi,
    required this.reactionTitle,
    required this.reactionBody,
    required this.takeawayRule,
  });
}

class StreetEncounter {
  final String id;
  final String tag;
  final String title;
  final String hindiTitle;
  final String location;
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
    location: 'BMTC Route 500D (Silk Board $\\rightarrow$ Marathahalli)',
    overheardSpeaker: 'पीछे बैठा यात्री (Co-passenger)',
    overheardRoman: 'Nodu guru, ivana pant nodu... circus thara ide!',
    overheardDeva: 'नोडु गुरु, इवन पँट नोडु... सर्कस तर इदे!',
    overheardHindi: 'देख भाई, इसकी पैंट देख... सर्कस जैसी लग रही है!',
    dilemma: 'वे सोच रहे हैं कि आप बाहर से हैं और कन्नड़ का एक शब्द भी नहीं समझते। आप क्या बोलेंगे?',
    choices: [
      EncounterChoice(
        id: 'c1',
        intentBadge: '😏 शांत व करारा जवाब (Wit)',
        roman: 'Kannada baratte anna, hushaar!',
        deva: 'कन्नड बरतॆ अण्णा, हुषार्!',
        hindi: 'कन्नड़ आती है भैया, ज़रा संभल के!',
        reactionTitle: 'सन्नाटा और झेंप',
        reactionBody: 'दोनों का चेहरा लाल पड़ जाता है। उसका दोस्त हँसते हुए कहता है: "सॉरी ब्रो, ऐसे ही मज़ाक कर रहे थे!"',
        takeawayRule: '💡 Street Rule: 3 शब्द पूरे आत्मविश्वास से बोलने पर बाहरी समझकर मज़ाक उड़ाने वाले तुरंत शांत हो जाते हैं।',
      ),
      EncounterChoice(
        id: 'c2',
        intentBadge: '🎯 सीधा सवाल (Assertive)',
        roman: 'Nanna dress bagge ninge en samasye boss?',
        deva: 'नन्ना ड्रेस बग्गे निंगे एन समस्यॆ बॉस?',
        hindi: 'मेरी ड्रेस से तुम्हें क्या परेशानी है बॉस?',
        reactionTitle: 'कंडक्टर का दखल',
        reactionBody: 'वे हकलाने लगते हैं। आगे से कंडक्टर बोलता है: "एन्री अल्लि गलटे? मुंदे नोडि कूतकोळ्ळि!" (क्या शोर है? सीधे बैठो!)',
        takeawayRule: '💡 Street Rule: "Ninge en samasye boss?" अनुचित दखल देने वालों को तुरंत अपनी सीमा में रखता है।',
      ),
      EncounterChoice(
        id: 'c3',
        intentBadge: '😎 बेंगलुरु कूल अंदाज़ (Slang & Humor)',
        roman: 'Sakkath aagide alva macha? Bengaluru fashion idu!',
        deva: 'सक्कथ आगिदे अल्व मचा? बेंगलुरु फॅशन इदु!',
        hindi: 'ज़बरदस्त लग रही है ना भाई? बेंगलुरु फ़ैशन है यह!',
        reactionTitle: 'माहौल दोस्ताना हो गया',
        reactionBody: 'दोनों हँस पड़ते हैं और दाद देते हैं: "सुपर मचा! तुम तो एकदम लोकल निकले!"',
        takeawayRule: '💡 Street Rule: "Macha" और "Sakkath" तनाव को तुरंत दोस्ताना बातचीत में बदल देते हैं।',
      ),
    ],
  ),
  const StreetEncounter(
    id: 'enc_auto_meter',
    tag: '🛺 The Standoff',
    title: 'The Double-Meter Bluff',
    hindiTitle: 'ऑटो वाले का मनमाना किराया',
    location: 'Indiranagar 100ft Road (हल्की बारिश में 9:00 PM)',
    overheardSpeaker: 'ऑटो ड्राइवर (Auto Anna)',
    overheardRoman: 'Meter aagalla sir, 250 fix. Barovragi baa.',
    overheardDeva: 'मीटर आगल्ला सर, २५० फिक्स। बरोव्रागि बा।',
    overheardHindi: 'मीटर से नहीं चलेगा सर, २५० रुपये फ़िक्स। आना है तो आओ।',
    dilemma: 'बारिश हो रही है लेकिन दूरी सिर्फ़ ३ किमी है। आप किराया कैसे तय करेंगे?',
    choices: [
      EncounterChoice(
        id: 'a1',
        intentBadge: '🤝 व्यावहारिक नेगोशिएशन (Street Negotiator)',
        roman: 'Anna, meter haaki 30 extra thagoli, swalpa adjust maadi.',
        deva: 'अण्णा, मीटर हाकि ३० एक्स्ट्रा थगोळ्ळि, स्वल्प एडजस्ट माडि।',
        hindi: 'भैया, मीटर डालिए और ३० ऊपर ले लीजिए, थोड़ा एडजस्ट कीजिए।',
        reactionTitle: 'ड्राइवर मान गया',
        reactionBody: 'ड्राइवर मुस्कुराता है: "सॉरी सर बारिश है... चलिए बैठिए, मीटर चालू करता हूँ।"',
        takeawayRule: '💡 Street Rule: "Meter + 30 extra" बेंगलुरु में पीक आवर की सबसे व्यावहारिक और स्वीकृत डील है।',
      ),
      EncounterChoice(
        id: 'a2',
        intentBadge: '🚶 वाकअवे ब्लफ़ (Walking Away)',
        roman: 'Beda anna, naanu metro-ge hogtheeni.',
        deva: 'बेडा अण्णा, नानु मेट्रो-गे होग्तीनि।',
        hindi: 'नहीं चाहिए भैया, मैं मेट्रो से चला जाता हूँ।',
        reactionTitle: 'तुरंत पीछे से आवाज़',
        reactionBody: 'जैसे ही आप मुड़ते हैं, वह हॉर्न बजाकर कहता है: "बन्नी सर, १५० दीजिए, चलिए!"',
        takeawayRule: '💡 Street Rule: मेट्रो का ज़िक्र करते ही मनमाना दाम माँगने वाले ड्राइवर तुरंत नीचे आ जाते हैं।',
      ),
    ],
  ),
  const StreetEncounter(
    id: 'enc_swiggy_call',
    tag: '📦 Phone Navigation',
    title: 'The Lost Swiggy Rider',
    hindiTitle: 'रास्ता भटके डिलीवरी पार्टनर का फ़ोन',
    location: 'HSR Layout Sector 2 (गली के मोड़ पर)',
    overheardSpeaker: 'डिलीवरी पार्टनर (फ़ोन पर)',
    overheardRoman: 'Sir, location sigthilla... yavdu cross?',
    overheardDeva: 'सर, लोकेशन सिग्तिल्ला... याव्दु क्रॉस?',
    overheardHindi: 'सर, लोकेशन नहीं मिल रही... कौन सा क्रॉस रोड है?',
    dilemma: 'फ़ोन पर कन्नड़ में तेज़ी से पूछ रहा है। आप उसे गेट तक कैसे गाइड करेंगे?',
    choices: [
      EncounterChoice(
        id: 's1',
        intentBadge: '📍 लैंडमार्क से गाइड करना (Landmark Guide)',
        roman: 'Main road bakery pakkadalli cross ide anna, alli banni.',
        deva: 'मेन रोड बेकरी पक्कदल्लि क्रॉस इदे अण्णा, अल्लि बन्नि।',
        hindi: 'मेन रोड बेकरी के बग़ल में क्रॉस है भैया, वहाँ आइए।',
        reactionTitle: 'राइडर समझ गया',
        reactionBody: '"आह बेकरी गोत्तायतु सर, २ मिनट में पहुँचता हूँ!"',
        takeawayRule: '💡 Street Rule: "Pakkadalli" (बग़ल में) और "Hattra" (पास) दिशा समझाने के सबसे काम के शब्द हैं।',
      ),
      EncounterChoice(
        id: 's2',
        intentBadge: '🚪 गेट पर रुकवाना (Gate Pickup)',
        roman: 'Apartment gate hattra nilisi, naanu kelage barthini.',
        deva: 'अपार्टमेंट गेट हत्त्र निलिसि, नानु केळगे बर्तिनि।',
        hindi: 'अपार्टमेंट गेट के पास रोकिए, मैं नीचे आता हूँ।',
        reactionTitle: 'बिना किसी उलझन के डिलीवरी',
        reactionBody: '"सरी सर, गेट आगे गार्ड हत्त्र निल्तिनि!" (ठीक है सर, गेट पर गार्ड के पास रुकता हूँ!)',
        takeawayRule: '💡 Street Rule: जब पता जटिल हो, "Kelage barthini" (मैं नीचे आ रहा हूँ) कहना सबसे सुरक्षित रास्ता है।',
      ),
    ],
  ),
];

// ---------------------------------------------------------------------------
// 8 Categories with Complete Practical Situations
// ---------------------------------------------------------------------------

final List<KWord> allWords = [
  const KWord(id: 'nanage', roman: 'Nanage', deva: 'ननगे', hindi: 'मुझे', note: 'वाक्य की शुरुआत में आता है।'),
  const KWord(id: 'beku', roman: 'Beku', deva: 'बेकु', hindi: 'चाहिए', note: 'वाक्य के अंत में: Nanage + चीज़ + beku.'),
  const KWord(id: 'beda', roman: 'Beda', deva: 'बेडा', hindi: 'नहीं चाहिए', note: 'वाक्य के अंत में आता है।'),
  const KWord(id: 'saaku', roman: 'Saaku', deva: 'साकु', hindi: 'बस / काफ़ी है', note: 'रुकवाने के लिए उपयोग करें।'),
  const KWord(id: 'enu', roman: 'Enu', deva: 'एनु', hindi: 'क्या'),
  const KWord(id: 'ondu', roman: 'Ondu', deva: 'ओन्दु', hindi: 'एक'),
  const KWord(id: 'innondu', roman: 'Innondu', deva: 'इन्नोन्दु', hindi: 'एक और'),
  const KWord(id: 'kodi', roman: 'Kodi', deva: 'कोडि', hindi: 'दीजिए', note: 'माँगने का सबसे विनम्र तरीक़ा।'),
  const KWord(id: 'eshtu', roman: 'Eshtu', deva: 'एष्टु', hindi: 'कितना'),
  const KWord(id: 'aaytu', roman: 'Aaytu', deva: 'आयतु', hindi: 'हो गया', note: 'Eshtu aaytu? = कितना हुआ?'),
  const KWord(id: 'coffee', roman: 'Coffee', deva: 'कॉफ़ी', hindi: 'कॉफ़ी'),
  const KWord(id: 'dose', roman: 'Dose', deva: 'दोसे', hindi: 'डोसा'),
  const KWord(id: 'tea', roman: 'Tea', deva: 'टी', hindi: 'चाय'),
  const KWord(id: 'neeru', roman: 'Neeru', deva: 'नीरु', hindi: 'पानी'),
  const KWord(id: 'illi', roman: 'Illi', deva: 'इल्लि', hindi: 'यहाँ'),
  const KWord(id: 'alli', roman: 'Alli', deva: 'अल्लि', hindi: 'वहाँ'),
  const KWord(id: 'nilisi', roman: 'Nilisi', deva: 'निलिसि', hindi: 'रोकिए', note: 'गाड़ी रुकवाने के लिए।'),
  const KWord(id: 'hogbeku', roman: 'Hogbeku', deva: 'होगबेकु', hindi: 'जाना है'),
  const KWord(id: 'swalpa', roman: 'Swalpa', deva: 'स्वल्प', hindi: 'थोड़ा', streetCode: '🏷️ Street Code: बात शुरू करने का जादुई शब्द'),
  const KWord(id: 'banni', roman: 'Banni', deva: 'बन्नि', hindi: 'आइए', note: 'आदर सहित बुलाने के लिए।'),
  const KWord(id: 'hegiddira', roman: 'Hegiddira', deva: 'हेगिद्दीरा', hindi: 'कैसे हैं आप'),
  const KWord(id: 'chennagide', roman: 'Chennagide', deva: 'चेन्नागिदे', hindi: 'बढ़िया है / ठीक है'),
  const KWord(id: 'gottu', roman: 'Gottu', deva: 'गोत्तु', hindi: 'पता है / मालूम है'),
  const KWord(id: 'gottilla', roman: 'Gottilla', deva: 'गोत्तिल्ला', hindi: 'मालूम नहीं है'),
  const KWord(id: 'parvaagilla', roman: 'Parvaagilla', deva: 'पर्वागिल्ला', hindi: 'कोई बात नहीं'),
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
    type: 'तद्भव / तत्सम',
    note: 'संस्कृत "रात्रि" हिंदी में घिसकर रात बना, पर कन्नड़ में मूल रूप में रहा।',
  ),
];

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
            hinglishKeywords: ['mujhe coffee chahiye', 'coffee chahiye', 'ek coffee', 'coffee'],
          ),
          KSentence(
            id: 'f2',
            roman: 'Ondu masala dose kodi.',
            deva: 'ओन्दु मसाला दोसे कोडि।',
            hindi: 'एक मसाला डोसा दीजिए।',
            chunks: [Chunk('Ondu', 'ओन्दु', 'एक'), Chunk('masala dose', 'मसाला दोसे', 'मसाला डोसा'), Chunk('kodi', 'कोडि', 'दीजिए')],
            streetCode: '🏷️ Darshini Code: काउंटर पर "beku" से अधिक स्वाभाविक "kodi" लगता है',
            hinglishKeywords: ['ek dosa do', 'masala dosa kodi', 'dosa do', 'dosa kodi', 'dosa chahiye'],
          ),
          KSentence(
            id: 'f3',
            roman: 'Innondu tea kodi.',
            deva: 'इन्नोन्दु टी कोडि।',
            hindi: 'एक और चाय दीजिए।',
            chunks: [Chunk('Innondu', 'इन्नोन्दु', 'एक और'), Chunk('tea', 'टी', 'चाय'), Chunk('kodi', 'कोडि', 'दीजिए')],
            hinglishKeywords: ['ek aur chai do', 'aur ek chai', 'chai do', 'innondu tea'],
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
            chunks: [Chunk('Swalpa', 'स्वल्प', 'थोड़ा'), Chunk('sambar', 'सांबार', 'सांभर'), Chunk('haaki', 'हाकि', 'डालिए')],
            hinglishKeywords: ['thoda sambar dalo', 'sambar dalo', 'sambar do'],
          ),
          KSentence(
            id: 'f5',
            roman: 'Saaku, beda anna.',
            deva: 'साकु, बेडा अण्णा।',
            hindi: 'बस, नहीं चाहिए भैया।',
            chunks: [Chunk('Saaku', 'साकु', 'बस / काफ़ी है'), Chunk('beda', 'बेडा', 'नहीं चाहिए'), Chunk('anna', 'अण्णा', 'भैया')],
            streetCode: '🏷️ Street Code: रुकवाने के लिए हाथ दिखाकर "Saaku anna" कहें',
            hinglishKeywords: ['bas nahi chahiye', 'bas karo', 'nahi chahiye'],
          ),
          KSentence(
            id: 'f6',
            roman: 'Neeru kodi.',
            deva: 'नीरु कोडि।',
            hindi: 'पानी दीजिए।',
            chunks: [Chunk('Neeru', 'नीरु', 'पानी'), Chunk('kodi', 'कोडि', 'दीजिए')],
            hinglishKeywords: ['paani do', 'paani chahiye', 'water kodi'],
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
            chunks: [Chunk('Indiranagar-ge', 'इंदिरानगर-गे', 'इंदिरानगर को'), Chunk('hogbeku', 'होगबेकु', 'जाना है')],
            streetCode: '🏷️ Bengaluru Suffix: जगह के नाम के साथ "-ge" जोड़ें (जैसे: Metro-ge)',
            hinglishKeywords: ['indiranagar jana hai', 'jana hai', 'metro jana hai'],
          ),
          KSentence(
            id: 'a2',
            roman: 'Barthira anna?',
            deva: 'बर्तीरा अण्णा?',
            hindi: 'चलेंगे क्या भैया? (आएँगे?)',
            chunks: [Chunk('Barthira?', 'बर्तीरा?', 'आएँगे क्या?'), Chunk('anna', 'अण्णा', 'भैया')],
            hinglishKeywords: ['chaloge kya', 'aaoge kya', 'auto chaloge'],
          ),
          KSentence(
            id: 'a7',
            roman: 'Illi nilisi boss.',
            deva: 'इल्लि निलिसि बॉस।',
            hindi: 'यहाँ रोकिए बॉस।',
            chunks: [Chunk('Illi', 'इल्लि', 'यहाँ'), Chunk('nilisi', 'निलिसि', 'रोकिए'), Chunk('boss', 'बॉस', 'बॉस / भाई')],
            streetCode: '🏷️ Street Code: "Illi nilisi" हर दिन ऑटो या कैब में काम आता है',
            hinglishKeywords: ['yahan roko', 'rokiye', 'yahan utarna hai'],
          ),
          KSentence(
            id: 'a8',
            roman: 'Cilre ideyaa?',
            deva: 'चिल्रे इदिया?',
            hindi: 'क्या छुट्टे पैसे हैं?',
            chunks: [Chunk('Cilre', 'चिल्रे', 'छुट्टे पैसे'), Chunk('ideyaa?', 'इदिया?', 'हैं क्या?')],
            hinglishKeywords: ['chutta hai kya', 'change hai kya', 'khulle paise'],
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
            chunks: [Chunk('Idhu', 'इदु', 'यह'), Chunk('eshtu?', 'एष्टु?', 'कितना?')],
            hinglishKeywords: ['ye kitne ka hai', 'kitna daam hai', 'price kya hai'],
          ),
          KSentence(
            id: 'm5',
            roman: 'Swalpa kammi maadi anna.',
            deva: 'स्वल्प कम्मि माडि अण्णा।',
            hindi: 'थोड़ा कम कीजिए भैया।',
            chunks: [Chunk('Swalpa', 'स्वल्प', 'थोड़ा'), Chunk('kammi', 'कम्मि', 'कम'), Chunk('maadi', 'माडि', 'कीजिए'), Chunk('anna', 'अण्णा', 'भैया')],
            streetCode: '🏷️ Street Code: मोलभाव में "anna" जोड़ने से दुकानदार जल्दी मान जाता है',
            hinglishKeywords: ['thoda kam karo', 'kam kijiye', 'discount do'],
          ),
          KSentence(
            id: 'm9',
            roman: 'Cover idiya?',
            deva: 'कवर इदिया?',
            hindi: 'क्या थैली/कवर है?',
            chunks: [Chunk('Cover', 'कवर', 'थैली / बैग'), Chunk('idiya?', 'इदिया?', 'है क्या?')],
            streetCode: '🏷️ Street Code: प्लास्टिक थैली को हमेशा "Cover" कहते हैं',
            hinglishKeywords: ['theli hai kya', 'bag hai kya', 'cover hai kya'],
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
            hinglishKeywords: ['chai peene chalo', 'tea break', 'chai peete hain'],
          ),
          KSentence(
            id: 'c2',
            roman: 'Oota aaytha?',
            deva: 'ऊट आयता?',
            hindi: 'खाना हो गया क्या?',
            chunks: [Chunk('Oota', 'ऊट', 'खाना / भोजन'), Chunk('aaytha?', 'आयता?', 'हो गया क्या?')],
            streetCode: '🏷️ Cultural Code: "Oota aaytha?" कर्नाटक का सबसे गर्मजोशी भरा अभिवादन है',
            hinglishKeywords: ['khana ho gaya kya', 'lunch kar liya kya'],
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
            chunks: [Chunk('Macha', 'मचा', 'दोस्त / भाई'), Chunk('enu', 'एनु', 'क्या'), Chunk('samaachaara?', 'समाचारा?', 'खबर?')],
            streetCode: '🏷️ Slang Code: "Macha" करीबी दोस्तों के लिए बेंगलुरु का पसंदीदा संबोधन है',
            hinglishKeywords: ['kya khabar hai bhai', 'kya scene hai macha', 'kya hal hai'],
          ),
          KSentence(
            id: 'y3',
            roman: 'Sakkath aagide!',
            deva: 'सक्कथ आगिदे!',
            hindi: 'एकदम ज़बरदस्त है!',
            chunks: [Chunk('Sakkath', 'सक्कथ', 'शानदार / कमाल'), Chunk('aagide', 'आगिदे', 'है')],
            streetCode: '🏷️ Slang Code: "Sakkath" = Awesome / Superb!',
            hinglishKeywords: ['zabardast hai', 'bahut badhiya', 'superb'],
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
            chunks: [Chunk('Namaskara', 'नमस्कार', 'नमस्ते'), Chunk('hegiddira?', 'हेगिद्दीरा?', 'कैसे हैं आप?')],
            streetCode: '🏷️ Respect Code: बड़ों को "Hegiddira" बोलें, "Hegiddeeya" नहीं',
            hinglishKeywords: ['namaste kaise hain aap', 'namaskara hegiddira', 'pranam'],
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
            roman: 'Parcel bandideya anna?',
            deva: 'पार्सल बंदिदेया अण्णा?',
            hindi: 'क्या कोई पार्सल आया है भैया?',
            chunks: [Chunk('Parcel', 'पार्सल', 'पार्सल'), Chunk('bandideya?', 'बंदिदेया?', 'आया है क्या?'), Chunk('anna', 'अण्णा', 'भैया')],
            hinglishKeywords: ['parcel aaya kya', 'delivery aayi kya', 'courier aaya'],
          ),
        ],
      ),
    ],
  ),

  // 8. Love, Crush & Partner
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
            streetCode: '🏷️ Sweet Code: किसी की तारीफ़ करने के लिए सबसे सभ्य और प्यारा वाक्य',
            hinglishKeywords: ['bahut sundar ho', 'tum sundar lag rahi ho', 'looking beautiful', 'pretty'],
          ),
          KSentence(
            id: 'r2',
            roman: 'Ninna smile thumba muddu.',
            deva: 'निन्ना स्माइल तुंबा मुद्दु।',
            hindi: 'आपकी स्माइल बहुत प्यारी है।',
            chunks: [Chunk('Ninna', 'निन्ना', 'आपकी'), Chunk('smile', 'स्माइल', 'मुस्कान'), Chunk('thumba muddu', 'तुंबा मुद्दु', 'बहुत प्यारी / क्यूट')],
            hinglishKeywords: ['tumhari smile achhi hai', 'smile pyari hai', 'cute'],
          ),
          KSentence(
            id: 'r4',
            roman: 'Nam jothe coffee-ge barthira?',
            deva: 'नम् जोथे कॉफ़ी-गे बर्त्तीरा?',
            hindi: 'क्या आप मेरे साथ कॉफ़ी पर चलेंगे?',
            chunks: [Chunk('Nam jothe', 'नम् जोथे', 'मेरे साथ'), Chunk('coffee-ge', 'कॉफ़ी-गे', 'कॉफ़ी पर'), Chunk('barthira?', 'बर्त्तीरा?', 'चलेंगे क्या?')],
            hinglishKeywords: ['mere saath coffee chaloge', 'date par chaloge', 'coffee peene chalein'],
          ),
          KSentence(
            id: 'r10',
            roman: 'Naanu ninnannu preethistheeni.',
            deva: 'नानु निन्नन्नु प्रीतीस्तीनि।',
            hindi: 'मैं तुमसे प्यार करता/करती हूँ।',
            chunks: [Chunk('Naanu', 'नानु', 'मैं'), Chunk('ninnannu', 'निन्नन्नु', 'तुमसे'), Chunk('preethistheeni', 'प्रीतीस्तीनि', 'प्यार करता हूँ')],
            hinglishKeywords: ['i love you', 'main tumse pyar karta hoon', 'preethistheeni'],
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
