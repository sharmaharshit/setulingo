// Part 3: 15-Step Epic Encounter Story
import 'models.dart';

enum EncounterPersona { bold, diplomatic, frugal }

class EncounterOption {
  final String badge;
  final String kannadaRoman;
  final String kannadaDeva;
  final String hindiMeaning;
  final EncounterPersona persona;
  final List<Chunk> chunks;
  final int nextStep;

  const EncounterOption({
    required this.badge,
    required this.kannadaRoman,
    required this.kannadaDeva,
    required this.hindiMeaning,
    required this.persona,
    required this.chunks,
    this.nextStep = 1,
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

EncounterOption _opt(String badge, String roman, String deva, String hi, EncounterPersona p, List<Chunk> chunks, [int next = 1]) =>
    EncounterOption(badge: badge, kannadaRoman: roman, kannadaDeva: deva, hindiMeaning: hi, persona: p, chunks: chunks, nextStep: next);

final List<EncounterStepNode> epicEncounterStory = [
  EncounterStepNode(
    stepNumber: 1,
    title: 'The Morning Alarm',
    narrativeEn: '7:30 AM. Your alarm rings. You are already late for office. What do you decide?',
    narrativeHi: 'सुबह ७:३० बजे अलार्म बजा। आप ऑफ़िस के लिए पहले ही लेट हैं। आप क्या तय करते हैं?',
    options: [
      _opt('Skip Shower', 'Snana beda, bega hogona.', 'स्नान बेड़ा, बेग होगोणा।', 'नहाना नहीं, जल्दी चलते हैं।', EncounterPersona.bold, [Chunk('Snana beda', 'स्नान बेड़ा', 'नहाना नहीं')], 2),
      _opt('Message Manager', 'Manager-ge msg madthini, swalpa late.', 'मैनेजर-गे मेसेज मड्तिनी, स्वल्प लेट।', 'मैनेजर को मैसेज करता हूँ, थोड़ा लेट।', EncounterPersona.diplomatic, [Chunk('msg madthini', 'मेसेज मड्तिनी', 'मैसेज करता हूँ')], 3),
      _opt('Take Bus', 'Auto beda, bus hidkothini.', 'ऑटो बेड़ा, बस हिड्कोतिनी।', 'ऑटो नहीं, बस पकड़ता हूँ।', EncounterPersona.frugal, [Chunk('bus hidkothini', 'बस हिड्कोतिनी', 'बस पकड़ता हूँ')], 3),
    ],
  ),
  EncounterStepNode(
    stepNumber: 2,
    title: 'Breakfast Dash',
    narrativeEn: 'You rush past a crowded Darshini. Your stomach says stop. What do you order?',
    narrativeHi: 'आप एक भीड़भाड़ वाली दर्शिनी के पास से भागते हैं। पेट कहता है रुको। आप क्या ऑर्डर करते हैं?',
    options: [
      _opt('Order Fast', 'Bega kodi, time illa!', 'बेग कोडि, टाइम इल्ल!', 'जल्दी दीजिए, समय नहीं है!', EncounterPersona.bold, [Chunk('Bega kodi', 'बेग कोडि', 'जल्दी दीजिए')], 4),
      _opt('Ask Politely', 'Swalpa help madi, order madbeku.', 'स्वल्प हेल्प मडि, ऑर्डर मड्बेकु।', 'थोड़ी मदद कीजिए, ऑर्डर करना है।', EncounterPersona.diplomatic, [Chunk('order madbeku', 'ऑर्डर मड्बेकु', 'ऑर्डर करना है')], 4),
      _opt('Keep It Cheap', 'Idli saaku, coffee beda.', 'इडली साकु, कॉफ़ी बेड़ा।', 'इडली काफ़ी है, कॉफ़ी नहीं।', EncounterPersona.frugal, [Chunk('Idli saaku', 'इडली साकु', 'इडली काफ़ी है')], 4),
    ],
  ),
  EncounterStepNode(
    stepNumber: 3,
    title: 'Catching a Ride',
    narrativeEn: 'An auto slows down near you. Time to negotiate your way to the office.',
    narrativeHi: 'एक ऑटो आपके पास धीमा होता है। ऑफ़िस तक जाने के लिए बात करनी होगी।',
    options: [
      _opt('Straight Point', 'Meter haaki, seedha hogona.', 'मीटर हाकि, सीधा होगोणा।', 'मीटर डालिए, सीधे चलते हैं।', EncounterPersona.bold, [Chunk('Meter haaki', 'मीटर हाकि', 'मीटर डालिए')], 5),
      _opt('Negotiate', 'Swalpa kammi madi rate please.', 'स्वल्प कम्मि मडि रेट प्लीज़।', 'थोड़ा किराया कम कीजिए प्लीज़।', EncounterPersona.diplomatic, [Chunk('kammi madi', 'कम्मि मडि', 'कम कीजिए')], 5),
      _opt('Check Bus', 'Bus stop yeshtu door?', 'बस स्टॉप येष्टु दूर?', 'बस स्टॉप कितनी दूर है?', EncounterPersona.frugal, [Chunk('Bus stop', 'बस स्टॉप', 'बस स्टॉप')], 5),
    ],
  ),
  EncounterStepNode(
    stepNumber: 4,
    title: 'Traffic Jam Call',
    narrativeEn: 'Your manager calls — you are stuck in traffic. What do you say?',
    narrativeHi: 'आपका मैनेजर कॉल करता है — आप ट्रैफ़िक में फँसे हैं। आप क्या कहते हैं?',
    options: [
      _opt('Reassure', 'Naanu bandu bidthini, tension beda.', 'नानु बंदु बिड्तिनी, टेंशन बेड़ा।', 'मैं आ जाऊँगा, टेंशन मत लीजिए।', EncounterPersona.bold, [Chunk('bandu bidthini', 'बंदु बिड्तिनी', 'आ जाऊँगा')], 6),
      _opt('Apologize', 'Sorry sir, traffic tumba ide.', 'सॉरी सर, ट्रैफ़िक तुंबा इदे।', 'माफ़ कीजिए सर, बहुत ट्रैफ़िक है।', EncounterPersona.diplomatic, [Chunk('Sorry sir', 'सॉरी सर', 'माफ़ कीजिए सर')], 6),
      _opt('Shortcut', 'Main road beda, shortcut hogona.', 'मेन रोड बेड़ा, शॉर्टकट होगोणा।', 'मेन रोड नहीं, शॉर्टकट लेते हैं।', EncounterPersona.frugal, [Chunk('shortcut hogona', 'शॉर्टकट होगोणा', 'शॉर्टकट लेते हैं')], 6),
    ],
  ),
  EncounterStepNode(
    stepNumber: 5,
    title: 'Office Gate',
    narrativeEn: 'You finally reach the gate, 40 minutes late. The security guard looks at you.',
    narrativeHi: 'आख़िरकार आप गेट पर पहुँचे, ४० मिनट लेट। सिक्योरिटी गार्ड आपकी तरफ़ देखता है।',
    options: [
      _opt('Own It', 'Late aaytu, adre bandhe!', 'लेट आयतु, अद्रे बंधे!', 'लेट हो गया, पर आ गया!', EncounterPersona.bold, [Chunk('Late aaytu', 'लेट आयतु', 'लेट हो गया')], 7),
      _opt('Apologize', 'Sorry madam, traffic jaasti itthu.', 'सॉरी मैडम, ट्रैफ़िक ज्यास्ति इत्तु।', 'माफ़ कीजिए मैडम, ट्रैफ़िक बहुत था।', EncounterPersona.diplomatic, [Chunk('Sorry madam', 'सॉरी मैडम', 'माफ़ कीजिए मैडम')], 7),
      _opt('Walked', 'Swalpa nadedu bandhe, auto beda.', 'स्वल्प नडेदु बंधे, ऑटो बेड़ा।', 'थोड़ा पैदल आया, ऑटो नहीं।', EncounterPersona.frugal, [Chunk('nadedu bandhe', 'नडेदु बंधे', 'पैदल आया')], 7),
    ],
  ),
  EncounterStepNode(
    stepNumber: 6,
    title: 'Desk Chaos',
    narrativeEn: 'Your laptop refuses to boot. A colleague glances over.',
    narrativeHi: 'आपका लैपटॉप चालू नहीं हो रहा। एक सहकर्मी देखता है।',
    options: [
      _opt('Call IT', 'IT-ge call madi, bega bartira?', 'आईटी-गे कॉल मडि, बेग बर्तिरा?', 'आईटी को कॉल कीजिए, जल्दी आएँगे?', EncounterPersona.bold, [Chunk('call madi', 'कॉल मडि', 'कॉल कीजिए')], 8),
      _opt('Ask Help', 'Swalpa help madtira, laptop start aagthilla.', 'स्वल्प हेल्प मड्तीरा, लैपटॉप स्टार्ट आग्तिल्ल।', 'थोड़ी मदद करेंगे, लैपटॉप शुरू नहीं हो रहा।', EncounterPersona.diplomatic, [Chunk('help madtira?', 'हेल्प मड्तीरा?', 'मदद करेंगे?')], 8),
      _opt('Use Phone', 'Nanna phone use madthini saaku.', 'नन्न फ़ोन यूज़ मड्तिनी साकु।', 'मेरा फ़ोन काफ़ी है, इस्तेमाल करता हूँ।', EncounterPersona.frugal, [Chunk('phone use', 'फ़ोन यूज़', 'फ़ोन इस्तेमाल')], 8),
    ],
  ),
  EncounterStepNode(
    stepNumber: 7,
    title: 'Chai Break Invitation',
    narrativeEn: 'A colleague invites you toward the chai counter.',
    narrativeHi: 'एक सहकर्मी आपको चाय काउंटर की ओर बुलाता है।',
    options: [
      _opt('Hurry', 'Bega banni, chai thanda aagutte!', 'बेग बन्नि, चाय थंडा आगुत्ते!', 'जल्दी आइए, चाय ठंडी हो जाएगी!', EncounterPersona.bold, [Chunk('Bega banni', 'बेग बन्नि', 'जल्दी आइए')], 9),
      _opt('Check Time', 'Swalpa time ideya, chai kudiyona?', 'स्वल्प टाइम इदेया, चाय कुडियोणा?', 'थोड़ा समय है क्या, चाय पीते हैं?', EncounterPersona.diplomatic, [Chunk('time ideya?', 'टाइम इदेया?', 'समय है क्या?')], 9),
      _opt('Cheap Stall', 'Illi chai kammi rate ide.', 'इल्लि चाय कम्मि रेट इदे।', 'यहाँ चाय का दाम कम है।', EncounterPersona.frugal, [Chunk('kammi rate', 'कम्मि रेट', 'कम दाम')], 9),
    ],
  ),
  EncounterStepNode(
    stepNumber: 8,
    title: 'Status Update',
    narrativeEn: 'Your manager asks for a quick status update on your task.',
    narrativeHi: 'मैनेजर आपके काम पर एक जल्दी अपडेट माँगता है।',
    options: [
      _opt('Done', 'Kelsa aaytu, next task kodi.', 'केल्स आयतु, नेक्स्ट टास्क कोडि।', 'काम हो गया, अगला काम दीजिए।', EncounterPersona.bold, [Chunk('Kelsa aaytu', 'केल्स आयतु', 'काम हो गया')], 10),
      _opt('More Time', 'Swalpa time beku, naale kodthini.', 'स्वल्प टाइम बेकु, नाळे कोड्तिनी।', 'थोड़ा समय चाहिए, कल दे दूँगा।', EncounterPersona.diplomatic, [Chunk('time beku', 'टाइम बेकु', 'समय चाहिए')], 10),
      _opt('Brief', 'Simple aagi update madthini.', 'सिंपल आगि अपडेट मड्तिनी।', 'सीधा-सादा अपडेट देता हूँ।', EncounterPersona.frugal, [Chunk('Simple aagi', 'सिंपल आगि', 'सीधा-सादा')], 10),
    ],
  ),
  EncounterStepNode(
    stepNumber: 9,
    title: 'Lunch Decision',
    narrativeEn: 'Lunchtime. The team is deciding what to do.',
    narrativeHi: 'लंच का समय। टीम तय कर रही है क्या किया जाए।',
    options: [
      _opt('Take Charge', 'Naanu order madthini, bega tarisi.', 'नानु ऑर्डर मड्तिनी, बेग तरिसि।', 'मैं ऑर्डर करता हूँ, जल्दी लाइए।', EncounterPersona.bold, [Chunk('order madthini', 'ऑर्डर मड्तिनी', 'ऑर्डर करता हूँ')], 11),
      _opt('Ask Group', 'Nimge yenu beku, together order madona?', 'निम्गे येनु बेकु, टुगेदर ऑर्डर मडोणा?', 'आपको क्या चाहिए, साथ में ऑर्डर करें?', EncounterPersona.diplomatic, [Chunk('Nimge yenu beku?', 'निम्गे येनु बेकु?', 'आपको क्या चाहिए?')], 11),
      _opt('Home Food', 'Mane oota tande, saaku.', 'मने ओटा तंदे, साकु।', 'घर का खाना लाया, काफ़ी है।', EncounterPersona.frugal, [Chunk('Mane oota', 'मने ओटा', 'घर का खाना')], 11),
    ],
  ),
  EncounterStepNode(
    stepNumber: 10,
    title: 'Colleague Favor',
    narrativeEn: 'A colleague asks if you can help with their task too.',
    narrativeHi: 'एक सहकर्मी पूछता है क्या आप उनके काम में भी मदद कर सकते हैं।',
    options: [
      _opt('Say Yes', 'Sari, naanu madthini bega.', 'सरी, नानु मड्तिनी बेग।', 'ठीक है, मैं जल्दी कर देता हूँ।', EncounterPersona.bold, [Chunk('Sari', 'सरी', 'ठीक है')], 12),
      _opt('Expectation', 'Swalpa busy iddini, aadru madthini.', 'स्वल्प बिज़ी इद्दिनी, आद्रु मड्तिनी।', 'थोड़ा व्यस्त हूँ, फिर भी कर दूँगा।', EncounterPersona.diplomatic, [Chunk('busy iddini', 'बिज़ी इद्दिनी', 'व्यस्त हूँ')], 12),
      _opt('Tomorrow', 'Ivathu beda, naale madthini.', 'इवत्तु बेड़ा, नाळे मड्तिनी।', 'आज नहीं, कल कर दूँगा।', EncounterPersona.frugal, [Chunk('Ivathu beda', 'इवत्तु बेड़ा', 'आज नहीं')], 12),
    ],
  ),
  EncounterStepNode(
    stepNumber: 11,
    title: 'Evening Plans',
    narrativeEn: 'Work is done. Friends are messaging about tonight.',
    narrativeHi: 'काम ख़त्म हुआ। दोस्त आज रात के बारे में मैसेज कर रहे हैं।',
    options: [
      _opt('Club', 'Sanje club hogona, full masti!', 'संजे क्लब होगोणा, फुल मस्ती!', 'शाम को क्लब चलते हैं, पूरी मस्ती!', EncounterPersona.bold, [Chunk('club hogona', 'क्लब होगोणा', 'क्लब चलते हैं')], 13),
      _opt('Coffee', 'Sanje coffee shop nalli sigona.', 'संजे कॉफ़ी शॉप नल्लि सिगोणा।', 'शाम को कॉफ़ी शॉप में मिलते हैं।', EncounterPersona.diplomatic, [Chunk('coffee shop nalli', 'कॉफ़ी शॉप नल्लि', 'कॉफ़ी शॉप में')], 13),
      _opt('Stay In', 'Mane hogi rest madthini.', 'मने होगि रेस्ट मड्तिनी।', 'घर जाकर आराम करता हूँ।', EncounterPersona.frugal, [Chunk('rest madthini', 'रेस्ट मड्तिनी', 'आराम करता हूँ')], 13),
    ],
  ),
  EncounterStepNode(
    stepNumber: 12,
    title: 'Auto Ride Home',
    narrativeEn: 'Time to bargain your way home.',
    narrativeHi: 'अब घर वापस जाने के लिए मोलभाव करना होगा।',
    options: [
      _opt('Direct', 'Rate heli, discuss beda.', 'रेट हेलि, डिस्कस बेड़ा।', 'रेट बताइए, बहस नहीं चाहिए।', EncounterPersona.bold, [Chunk('Rate heli', 'रेट हेलि', 'रेट बताइए')], 14),
      _opt('Polite', 'Swalpa kammi madi please.', 'स्वल्प कम्मि मडि प्लीज़।', 'थोड़ा कम कीजिए प्लीज़।', EncounterPersona.diplomatic, [Chunk('kammi madi', 'कम्मि मडि', 'कम कीजिए')], 14),
      _opt('Bus', 'Bus hidkothini, kammi rate.', 'बस हिड्कोतिनी, कम्मि रेट।', 'बस पकड़ता हूँ, दाम कम।', EncounterPersona.frugal, [Chunk('Bus hidkothini', 'बस हिड्कोतिनी', 'बस पकड़ता हूँ')], 14),
    ],
  ),
  EncounterStepNode(
    stepNumber: 13,
    title: 'Security Gate',
    narrativeEn: 'You reach your apartment gate. The security guard mentions a delivery.',
    narrativeHi: 'आप अपार्टमेंट के गेट पर पहुँचे। सिक्योरिटी गार्ड डिलीवरी की बात करता है।',
    options: [
      _opt('Direct', 'Parcel kodi bega anna.', 'पार्सल कोडि बेग अण्णा।', 'पार्सल जल्दी दीजिए भैया।', EncounterPersona.bold, [Chunk('Parcel kodi', 'पार्सल कोडि', 'पार्सल दीजिए')], 15),
      _opt('Respectful', 'Parcel bandideya anna, dayavittu nodi.', 'पार्सल बंदिदेया अण्णा, दयविट्टु नोडि।', 'पार्सल आया है क्या भैया, कृपया देखिए।', EncounterPersona.diplomatic, [Chunk('dayavittu nodi', 'दयविट्टु नोडि', 'कृपया देखिए')], 15),
      _opt('Tomorrow', 'Naale thogothini parcel.', 'नाळे तोगोतिनी पार्सल।', 'कल पार्सल ले लूँगा।', EncounterPersona.frugal, [Chunk('Naale thogothini', 'नाळे तोगोतिनी', 'कल ले लूँगा')], 15),
    ],
  ),
  EncounterStepNode(
    stepNumber: 14,
    title: 'Neighbour at Door',
    narrativeEn: 'A neighbour stops you in the hallway for a chat.',
    narrativeHi: 'एक पड़ोसी आपको गलियारे में बातचीत के लिए रोकता है।',
    options: [
      _opt('Short', 'Time illa, naale maatadona.', 'टाइम इल्ल, नाळे मातादोणा।', 'समय नहीं है, कल बात करते हैं।', EncounterPersona.bold, [Chunk('Time illa', 'टाइम इल्ल', 'समय नहीं है')], 15),
      _opt('Chat', 'Hegiddira, swalpa maatadona.', 'हेगिद्दीरा, स्वल्प मातादोणा।', 'कैसे हैं, थोड़ी बात करते हैं।', EncounterPersona.diplomatic, [Chunk('Hegiddira', 'हेगिद्दीरा', 'कैसे हैं')], 15),
      _opt('Decline', 'Chai beda, sustu aagide.', 'चाय बेड़ा, सुस्तु आगिदे।', 'चाय नहीं, थक गया हूँ।', EncounterPersona.frugal, [Chunk('sustu aagide', 'सुस्तु आगिदे', 'थक गया हूँ')], 15),
    ],
  ),
  EncounterStepNode(
    stepNumber: 15,
    title: 'Wrapping Up',
    narrativeEn: 'You collapse onto the sofa. What a Monday!',
    narrativeHi: 'आप सोफ़े पर बैठ जाते हैं। क्या सोमवार था!',
    options: [
      _opt('Victory', 'Bahala busy dina aaytu, adre gelthe!', 'बहळ बिज़ी दिन आयतु, अद्रे गेल्थे!', 'बहुत व्यस्त दिन था, पर जीत गए!', EncounterPersona.bold, [Chunk('busy dina', 'बिज़ी दिन', 'व्यस्त दिन')], 1),
      _opt('Grateful', 'Dina chennagi mugithu, dhanyavaada.', 'दिन चेन्नागि मुगित्तु, धन्यवाद।', 'दिन अच्छे से ख़त्म हुआ, धन्यवाद।', EncounterPersona.diplomatic, [Chunk('chennagi mugithu', 'चेन्नागि मुगित्तु', 'अच्छे से ख़त्म हुआ')], 1),
      _opt('Savings', 'Kammi kharchu, chennagi dina.', 'कम्मि खर्चु, चेन्नागि दिन।', 'कम ख़र्चा, अच्छा दिन।', EncounterPersona.frugal, [Chunk('Kammi kharchu', 'कम्मि खर्चु', 'कम ख़र्चा')], 1),
    ],
  ),
];

class EncounterResult {
  final EncounterPersona persona;
  final String title;
  final String hindiTitle;
  final String blurb;
  final String emoji;
  const EncounterResult({required this.persona, required this.title, required this.hindiTitle, required this.blurb, required this.emoji});
}

const Map<EncounterPersona, EncounterResult> encounterResults = {
  EncounterPersona.bold: EncounterResult(persona: EncounterPersona.bold, title: 'The Bold Bengalurean', hindiTitle: 'निडर बेंगलुरुकर', blurb: 'You move fast and speak directly.', emoji: '⚡'),
  EncounterPersona.diplomatic: EncounterResult(persona: EncounterPersona.diplomatic, title: 'The Diplomat', hindiTitle: 'कूटनीतिज्ञ', blurb: 'You keep things smooth.', emoji: '🤝'),
  EncounterPersona.frugal: EncounterResult(persona: EncounterPersona.frugal, title: 'The Frugal Local', hindiTitle: 'किफ़ायती स्थानीय', blurb: 'Practical and budget-savvy.', emoji: '💰'),
};

EncounterResult computeEncounterResult(List<EncounterPersona> choices) {
  if (choices.isEmpty) return encounterResults[EncounterPersona.bold]!;
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
