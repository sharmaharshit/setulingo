import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'store.dart';
import 'widgets.dart';

// ---------------------------------------------------------------------------
// Data — colloquial Bengaluru-Kannada forms, first-draft quality (same
// caveat as content.dart: roman/deva accuracy should be reviewed by a
// native speaker before shipping).
// ---------------------------------------------------------------------------

class TenseForm {
  final String roman;
  final String deva;
  final String hindi;
  const TenseForm(this.roman, this.deva, this.hindi);
}

class VerbConjugation {
  final String verbRoman;
  final String verbDeva;
  final String hindiMeaning;
  final TenseForm past;
  final TenseForm present;
  final TenseForm future;

  const VerbConjugation({
    required this.verbRoman,
    required this.verbDeva,
    required this.hindiMeaning,
    required this.past,
    required this.present,
    required this.future,
  });
}

final List<VerbConjugation> verbConjugations = const [
  VerbConjugation(
    verbRoman: 'Hogu', verbDeva: 'ಹೋಗು', hindiMeaning: 'जाना (to go)',
    past: TenseForm('Hogide', 'ಹೋಗಿದೆ', 'मैं गया'),
    present: TenseForm('Hogthini', 'ಹೋಗ್ತೀನಿ', 'मैं जाता हूँ'),
    future: TenseForm('Hogthini (mele)', 'ಹೋಗ್ತೀನಿ (ಮೇಲೆ)', 'मैं जाऊँगा'),
  ),
  VerbConjugation(
    verbRoman: 'Baru', verbDeva: 'ಬರು', hindiMeaning: 'आना (to come)',
    past: TenseForm('Bandhe', 'ಬಂದೆ', 'मैं आया'),
    present: TenseForm('Barthini', 'ಬರ್ತೀನಿ', 'मैं आता हूँ'),
    future: TenseForm('Bartini, swalpa time aagthe', 'ಬರ್ತೀನಿ, ಸ್ವಲ್ಪ ಟೈಮ್ ಆಗ್ತೆ', 'मैं आऊँगा, थोड़ा समय लगेगा'),
  ),
  VerbConjugation(
    verbRoman: 'Madu', verbDeva: 'ಮಾಡು', hindiMeaning: 'करना (to do)',
    past: TenseForm('Madide', 'ಮಾಡಿದೆ', 'मैंने किया'),
    present: TenseForm('Madthini', 'ಮಾಡ್ತೀನಿ', 'मैं करता हूँ'),
    future: TenseForm('Madthini, naale', 'ಮಾಡ್ತೀನಿ, ನಾಳೆ', 'मैं करूँगा, कल'),
  ),
  VerbConjugation(
    verbRoman: 'Tinnu', verbDeva: 'ತಿನ್ನು', hindiMeaning: 'खाना (to eat)',
    past: TenseForm('Tinde', 'ತಿಂದೆ', 'मैंने खाया'),
    present: TenseForm('Tinthini', 'ತಿನ್ತೀನಿ', 'मैं खाता हूँ'),
    future: TenseForm('Tinthini, aamele', 'ತಿನ್ತೀನಿ, ಆಮೇಲೆ', 'मैं बाद में खाऊँगा'),
  ),
  VerbConjugation(
    verbRoman: 'Kudi', verbDeva: 'ಕುಡಿ', hindiMeaning: 'पीना (to drink)',
    past: TenseForm('Kudide', 'ಕುಡಿದೆ', 'मैंने पिया'),
    present: TenseForm('Kudithini', 'ಕುಡಿತೀನಿ', 'मैं पीता हूँ'),
    future: TenseForm('Kudithini, aamele', 'ಕುಡಿತೀನಿ, ಆಮೇಲೆ', 'मैं बाद में पियूँगा'),
  ),
  VerbConjugation(
    verbRoman: 'Nodu', verbDeva: 'ನೋಡು', hindiMeaning: 'देखना (to see)',
    past: TenseForm('Nodide', 'ನೋಡಿದೆ', 'मैंने देखा'),
    present: TenseForm('Nodthini', 'ನೋಡ್ತೀನಿ', 'मैं देखता हूँ'),
    future: TenseForm('Nodthini, naale', 'ನೋಡ್ತೀನಿ, ನಾಳೆ', 'मैं कल देखूँगा'),
  ),
  VerbConjugation(
    verbRoman: 'Heli', verbDeva: 'ಹೇಳಿ', hindiMeaning: 'कहना (to say)',
    past: TenseForm('Heltidde', 'ಹೇಳ್ತಿದ್ದೆ', 'मैंने कहा'),
    present: TenseForm('Helthini', 'ಹೇಳ್ತೀನಿ', 'मैं कहता हूँ'),
    future: TenseForm('Helthini, aamele', 'ಹೇಳ್ತೀನಿ, ಆಮೇಲೆ', 'मैं बाद में कहूँगा'),
  ),
  VerbConjugation(
    verbRoman: 'Kodu', verbDeva: 'ಕೊಡು', hindiMeaning: 'देना (to give)',
    past: TenseForm('Kotte', 'ಕೊಟ್ಟೆ', 'मैंने दिया'),
    present: TenseForm('Kodthini', 'ಕೊಡ್ತೀನಿ', 'मैं देता हूँ'),
    future: TenseForm('Kodthini, swalpa time', 'ಕೊಡ್ತೀನಿ, ಸ್ವಲ್ಪ ಟೈಮ್', 'मैं थोड़ी देर में दूँगा'),
  ),
];

class AntonymPair {
  final String hindi;
  final String romanA;
  final String devaA;
  final String romanB;
  final String devaB;

  const AntonymPair({required this.hindi, required this.romanA, required this.devaA, required this.romanB, required this.devaB});
}

final List<AntonymPair> antonymPairs = const [
  AntonymPair(hindi: 'पास / दूर', romanA: 'Hattira', devaA: 'ಹತ್ತಿರ', romanB: 'Dura', devaB: 'ದೂರ'),
  AntonymPair(hindi: 'ऊपर / नीचे', romanA: 'Mele', devaA: 'ಮೇಲೆ', romanB: 'Kelage', devaB: 'ಕೆಳಗೆ'),
  AntonymPair(hindi: 'तेज़ / धीमा', romanA: 'Bega', devaA: 'ಬೇಗ', romanB: 'Nidana', devaB: 'ನಿಧಾನ'),
  AntonymPair(hindi: 'बड़ा / छोटा', romanA: 'Dodda', devaA: 'ದೊಡ್ಡ', romanB: 'Chikka', devaB: 'ಚಿಕ್ಕ'),
  AntonymPair(hindi: 'गर्म / ठंडा', romanA: 'Bisi', devaA: 'ಬಿಸಿ', romanB: 'Tanni', devaB: 'ತಣ್ಣಿ'),
  AntonymPair(hindi: 'अच्छा / बुरा', romanA: 'Chennagide', devaA: 'ಚೆನ್ನಾಗಿದೆ', romanB: 'Chennagilla', devaB: 'ಚೆನ್ನಾಗಿಲ್ಲ'),
  AntonymPair(hindi: 'खुला / बंद', romanA: 'Open ide', devaA: 'ಓಪನ್ ಇದೆ', romanB: 'Close ide', devaB: 'ಕ್ಲೋಸ್ ಇದೆ'),
  AntonymPair(hindi: 'सस्ता / महँगा', romanA: 'Kammi', devaA: 'ಕಮ್ಮಿ', romanB: 'Jaasti', devaB: 'ಜಾಸ್ತಿ'),
  AntonymPair(hindi: 'ज़्यादा / कम', romanA: 'Jaasti', devaA: 'ಜಾಸ್ತಿ', romanB: 'Kammi', devaB: 'ಕಮ್ಮಿ'),
  AntonymPair(hindi: 'आज / कल', romanA: 'Ivathu', devaA: 'ಇವತ್ತು', romanB: 'Naale', devaB: 'ನಾಳೆ'),
  AntonymPair(hindi: 'हाँ / नहीं', romanA: 'Howdu', devaA: 'ಹೌದು', romanB: 'Illa', devaB: 'ಇಲ್ಲ'),
  AntonymPair(hindi: 'जल्दी / देर से', romanA: 'Bega', devaA: 'ಬೇಗ', romanB: 'Late aagi', devaB: 'ಲೇಟ್ ಆಗಿ'),
  AntonymPair(hindi: 'बायाँ / दायाँ', romanA: 'Edakke', devaA: 'ಎಡಕ್ಕೆ', romanB: 'Balakke', devaB: 'ಬಲಕ್ಕೆ'),
  AntonymPair(hindi: 'अंदर / बाहर', romanA: 'Olage', devaA: 'ಒಳಗೆ', romanB: 'Horage', devaB: 'ಹೊರಗೆ'),
  AntonymPair(hindi: 'नया / पुराना', romanA: 'Hosa', devaA: 'ಹೊಸ', romanB: 'Hazhe', devaB: 'ಹಳೆ'),
];

class AksharaEntry {
  final String deva; // shown as-is (Kannada script placeholder / romanized note)
  final String roman;
  final String hindiHint;

  const AksharaEntry(this.deva, this.roman, this.hindiHint);
}

final List<AksharaEntry> kannadaVowels = const [
  AksharaEntry('ಅ', 'a', 'अ जैसा'),
  AksharaEntry('ಆ', 'aa', 'आ जैसा'),
  AksharaEntry('ಇ', 'i', 'इ जैसा'),
  AksharaEntry('ಈ', 'ee', 'ई जैसा'),
  AksharaEntry('ಉ', 'u', 'उ जैसा'),
  AksharaEntry('ಊ', 'oo', 'ऊ जैसा'),
  AksharaEntry('ಎ', 'e', 'ऎ जैसा (ह्रस्व)'),
  AksharaEntry('ಏ', 'ae', 'ए जैसा (दीर्घ)'),
  AksharaEntry('ಐ', 'ai', 'ऐ जैसा'),
  AksharaEntry('ಒ', 'o', 'ऒ जैसा (ह्रस्व)'),
  AksharaEntry('ಓ', 'oa', 'ओ जैसा (दीर्घ)'),
  AksharaEntry('ಔ', 'au', 'औ जैसा'),
  AksharaEntry('ಅಂ', 'am', 'अं जैसा (अनुस्वार)'),
];

final List<AksharaEntry> kannadaConsonants = const [
  AksharaEntry('ಕ', 'ka', 'क'),
  AksharaEntry('ಖ', 'kha', 'ख'),
  AksharaEntry('ಗ', 'ga', 'ग'),
  AksharaEntry('ಘ', 'gha', 'घ'),
  AksharaEntry('ಙ', 'nga', 'ङ'),
  AksharaEntry('ಚ', 'cha', 'च'),
  AksharaEntry('ಛ', 'chha', 'छ'),
  AksharaEntry('ಜ', 'ja', 'ज'),
  AksharaEntry('ಝ', 'jha', 'झ'),
  AksharaEntry('ಟ', 'Ta', 'ट (मूर्धन्य)'),
  AksharaEntry('ಠ', 'Tha', 'ठ (मूर्धन्य)'),
  AksharaEntry('ಡ', 'Da', 'ड (मूर्धन्य)'),
  AksharaEntry('ಢ', 'Dha', 'ढ (मूर्धन्य)'),
  AksharaEntry('ಣ', 'Na', 'ण (मूर्धन्य)'),
  AksharaEntry('ತ', 'ta', 'त (दंत्य)'),
  AksharaEntry('ಥ', 'tha', 'थ (दंत्य)'),
  AksharaEntry('ದ', 'da', 'द (दंत्य)'),
  AksharaEntry('ಧ', 'dha', 'ध (दंत्य)'),
  AksharaEntry('ನ', 'na', 'न'),
  AksharaEntry('ಪ', 'pa', 'प'),
  AksharaEntry('ಫ', 'pha', 'फ'),
  AksharaEntry('ಬ', 'ba', 'ब'),
  AksharaEntry('ಭ', 'bha', 'भ'),
  AksharaEntry('ಮ', 'ma', 'म'),
  AksharaEntry('ಯ', 'ya', 'य'),
  AksharaEntry('ರ', 'ra', 'र'),
  AksharaEntry('ಲ', 'la', 'ल'),
  AksharaEntry('ವ', 'va', 'व'),
  AksharaEntry('ಶ', 'sha', 'श'),
  AksharaEntry('ಷ', 'Sha', 'ष (मूर्धन्य)'),
  AksharaEntry('ಸ', 'sa', 'स'),
  AksharaEntry('ಹ', 'ha', 'ह'),
  AksharaEntry('ಳ', 'La', 'ळ (कन्नड़-विशेष)'),
];

class KNumberEntry {
  final int value;
  final String roman;
  final String deva;
  const KNumberEntry(this.value, this.roman, this.deva);
}

final List<KNumberEntry> kannadaNumbers = const [
  KNumberEntry(1, 'ondu', 'ಒಂದು'),
  KNumberEntry(2, 'eradu', 'ಎರಡು'),
  KNumberEntry(3, 'muru', 'ಮೂರು'),
  KNumberEntry(4, 'nalku', 'ನಾಲ್ಕು'),
  KNumberEntry(5, 'aidu', 'ಐದು'),
  KNumberEntry(6, 'aaru', 'ಆರು'),
  KNumberEntry(7, 'elu', 'ಏಳು'),
  KNumberEntry(8, 'entu', 'ಎಂಟು'),
  KNumberEntry(9, 'ombattu', 'ಒಂಬತ್ತು'),
  KNumberEntry(10, 'hattu', 'ಹತ್ತು'),
  KNumberEntry(11, 'hannondu', 'ಹನ್ನೊಂದು'),
  KNumberEntry(12, 'hanneradu', 'ಹನ್ನೆರಡು'),
  KNumberEntry(13, 'hadimuru', 'ಹದಿಮೂರು'),
  KNumberEntry(14, 'hadinalku', 'ಹದಿನಾಲ್ಕು'),
  KNumberEntry(15, 'hadinaidu', 'ಹದಿನೈದು'),
  KNumberEntry(16, 'hadinaaru', 'ಹದಿನಾರು'),
  KNumberEntry(17, 'hadinelu', 'ಹದಿನೇಳು'),
  KNumberEntry(18, 'hadinentu', 'ಹದಿನೆಂಟು'),
  KNumberEntry(19, 'hattombattu', 'ಹತ್ತೊಂಬತ್ತು'),
  KNumberEntry(20, 'ippattu', 'ಇಪ್ಪತ್ತು'),
  KNumberEntry(30, 'muvattu', 'ಮೂವತ್ತು'),
  KNumberEntry(40, 'nalvattu', 'ನಲ್ವತ್ತು'),
  KNumberEntry(50, 'aivattu', 'ಐವತ್ತು'),
  KNumberEntry(100, 'nooru', 'ನೂರು'),
];

/// New multi-turn negotiation-style roleplays, beyond the single dialogue
/// already attached to a couple of KSituations in content.dart. Reuses the
/// existing RoleplayDialogue/DialogueTurn model so nothing new has to be
/// taught to LessonPage or SentenceCard.
final List<RoleplayDialogue> extendedRoleplays = [
  const RoleplayDialogue(
    id: 'rp_auto_negotiate',
    title: 'Negotiating with an Auto Driver',
    contextDescription: 'आप सड़क किनारे ऑटो रोकते हैं और किराया तय करते हैं।',
    turns: [
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Auto! Indiranagar bartira?', deva: 'ಆಟೋ! ಇಂದಿರಾನಗರ ಬರ್ತೀರಾ?', hindi: 'ऑटो! इंदिरानगर चलेंगे?'),
      DialogueTurn(speaker: 'ड्राइवर', isUser: false, roman: 'Meter alli hogalla, 150 kodi.', deva: 'ಮೀಟರ್ ಅಲ್ಲಿ ಹೋಗಲ್ಲ, ೧೫೦ ಕೊಡಿ।', hindi: 'मीटर पर नहीं जाऊँगा, 150 दीजिए।'),
      DialogueTurn(
        speaker: 'आप', isUser: true,
        roman: 'Swalpa jaasti aaythu, 100 madi sir.', deva: 'ಸ್ವಲ್ಪ ಜಾಸ್ತಿ ಆಯ್ತು, ೧೦೦ ಮಾಡಿ ಸರ್।', hindi: 'ज़रा ज़्यादा है, 100 कर दीजिए सर।',
        tip: 'मीटर से इनकार आम है — विनम्रता से मोलभाव करना सामान्य है।',
      ),
      DialogueTurn(speaker: 'ड्राइवर', isUser: false, roman: 'Sari, 120 kodi, banni.', deva: 'ಸರಿ, ೧೨೦ ಕೊಡಿ, ಬನ್ನಿ।', hindi: 'ठीक है, 120 दीजिए, आइए।'),
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Sari, banni hogona.', deva: 'ಸರಿ, ಬನ್ನಿ ಹೋಗೋಣ।', hindi: 'ठीक है, चलिए चलते हैं।'),
    ],
  ),
  const RoleplayDialogue(
    id: 'rp_maid_terms',
    title: 'Discussing Terms with Household Help',
    contextDescription: 'आप घर के काम के लिए एक नई सहायिका से बात कर रहे हैं।',
    turns: [
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Naaley inda kelasakke banni saaku.', deva: 'ನಾಳೆಯಿಂದ ಕೆಲಸಕ್ಕೆ ಬನ್ನಿ ಸಾಕು।', hindi: 'कल से काम पर आइए, ठीक है।'),
      DialogueTurn(speaker: 'सहायिका', isUser: false, roman: 'Sari madam, salary yeshtu kodthira?', deva: 'ಸರಿ ಮೇಡಂ, ಸ್ಯಾಲರಿ ಎಷ್ಟು ಕೊಡ್ತೀರಾ?', hindi: 'ठीक है मैडम, तनख़्वाह कितनी देंगी?'),
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Month ge 3000 kodthini, sari na?', deva: 'ಮಂತ್ ಗೆ ೩೦೦೦ ಕೊಡ್ತೀನಿ, ಸರಿನಾ?', hindi: 'महीने के 3000 दूँगी, ठीक है ना?'),
      DialogueTurn(speaker: 'सहायिका', isUser: false, roman: 'Sari. Naanu vaara-dinnadu ondu day off beku.', deva: 'ಸರಿ. ನಾನು ವಾರದಲ್ಲಿ ಒಂದು ಡೇ ಆಫ್ ಬೇಕು।', hindi: 'ठीक है। मुझे हफ़्ते में एक दिन छुट्टी चाहिए।'),
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Sari, Sunday off kodthini.', deva: 'ಸರಿ, ಸಂಡೇ ಆಫ್ ಕೊಡ್ತೀನಿ।', hindi: 'ठीक है, रविवार छुट्टी दूँगी।'),
    ],
  ),
  const RoleplayDialogue(
    id: 'rp_security_checkin',
    title: 'Checking In with Apartment Security',
    contextDescription: 'आपका कोई मेहमान आया है और आप सिक्योरिटी को बता रहे हैं।',
    turns: [
      DialogueTurn(speaker: 'गार्ड', isUser: false, roman: 'Yaru bandidru sir/madam?', deva: 'ಯಾರು ಬಂದಿದ್ರು ಸರ್/ಮೇಡಂ?', hindi: 'कौन आया था सर/मैडम?'),
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Nanna friend bartare, dayavittu olage kalisi.', deva: 'ನನ್ನ ಫ್ರೆಂಡ್ ಬರ್ತಾರೆ, ದಯವಿಟ್ಟು ಒಳಗೆ ಕಳಿಸಿ।', hindi: 'मेरा दोस्त आ रहा है, कृपया अंदर भेज दीजिए।'),
      DialogueTurn(speaker: 'गार्ड', isUser: false, roman: 'Sari, avara hesaru heli.', deva: 'ಸರಿ, ಅವರ ಹೆಸರು ಹೇಳಿ।', hindi: 'ठीक है, उनका नाम बताइए।'),
      DialogueTurn(speaker: 'आप', isUser: true, roman: 'Avara hesaru Rahul, flat 402ge banthare.', deva: 'ಅವರ ಹೆಸರು ರಾಹುಲ್, ಫ್ಲ್ಯಾಟ್ ೪೦೨ಗೆ ಬರ್ತಾರೆ।', hindi: 'उनका नाम राहुल है, फ़्लैट 402 पर आएँगे।'),
      DialogueTurn(speaker: 'गार्ड', isUser: false, roman: 'Sari madam, kalisthini.', deva: 'ಸರಿ ಮೇಡಂ, ಕಳಿಸ್ತೀನಿ।', hindi: 'ठीक है मैडम, भेज देता हूँ।'),
    ],
  ),
];

// ---------------------------------------------------------------------------
// Pages
// ---------------------------------------------------------------------------

class _InfoBanner extends StatelessWidget {
  final String text;
  const _InfoBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
    );
  }
}

class VerbsTensesPage extends StatelessWidget {
  const VerbsTensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Verbs & Tenses'), actions: const [ScriptToggleAction()]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _InfoBanner(text: 'Colloquial spoken forms used in everyday Bengaluru Kannada — not textbook-formal grammar. Tap any row to hear it.'),
          for (final v in verbConjugations)
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${v.verbRoman} (${v.verbDeva})', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.textHigh)),
                        const Spacer(),
                        Text(v.hindiMeaning, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                      ],
                    ),
                    const Divider(height: 20, color: AppColors.outlineSoft),
                    _tenseRow(context, 'PAST', v.past, scheme),
                    _tenseRow(context, 'PRESENT', v.present, scheme),
                    _tenseRow(context, 'FUTURE', v.future, scheme),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _tenseRow(BuildContext context, String label, TenseForm form, ColorScheme scheme) {
    return InkWell(
      onTap: () => TtsService.instance.speak(form.roman),
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 68,
              child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: scheme.primary, letterSpacing: 0.5)),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(form.roman, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textHigh)),
                  Text(form.hindi, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                ],
              ),
            ),
            const Icon(Icons.volume_up_outlined, size: 18, color: AppColors.textFaint),
          ],
        ),
      ),
    );
  }
}

class AntonymsPage extends StatelessWidget {
  const AntonymsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsStore.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Opposites'), actions: const [ScriptToggleAction()]),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _InfoBanner(text: 'High-frequency opposite pairs. Tap either word to hear it spoken.'),
            for (final pair in antonymPairs)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pair.hindi, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textFaint)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _wordChip(context, settings.isDevanagari ? pair.devaA : pair.romanA, pair.romanA)),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.compare_arrows, size: 16, color: AppColors.textFaint)),
                        Expanded(child: _wordChip(context, settings.isDevanagari ? pair.devaB : pair.romanB, pair.romanB)),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _wordChip(BuildContext context, String label, String speakRoman) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => TtsService.instance.speak(speakRoman),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: AppColors.surfaceHighest, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
      ),
    );
  }
}

class AlphabetPage extends StatelessWidget {
  const AlphabetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alphabet & Syllables'),
          bottom: const TabBar(tabs: [Tab(text: 'Vowels'), Tab(text: 'Consonants')]),
        ),
        body: const TabBarView(
          children: [
            _AksharaGrid(entries: kannadaVowels),
            _AksharaGrid(entries: kannadaConsonants),
          ],
        ),
      ),
    );
  }
}

class _AksharaGrid extends StatelessWidget {
  final List<AksharaEntry> entries;
  const _AksharaGrid({required this.entries});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.95),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        final e = entries[i];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => TtsService.instance.speak(e.roman),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.outline),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(e.deva, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                  const SizedBox(height: 4),
                  Text(e.roman, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.marigold)),
                  Text(e.hindiHint, style: const TextStyle(fontSize: 10, color: AppColors.textFaint), textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// "Numbers (1–20+)" reference — 1 through 20 plus a few round tens and a
/// hundred, alongside the Alphabet Guide in Grammar & Extras.
class NumbersPage extends StatelessWidget {
  const NumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numbers')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: _InfoBanner(text: '1–20, plus a few round numbers (30, 40, 50, 100). Tap any tile to hear it spoken.'),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 0.95),
              itemCount: kannadaNumbers.length,
              itemBuilder: (context, i) {
                final n = kannadaNumbers[i];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => TtsService.instance.speak(n.roman),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceElevated,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.outline),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${n.value}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.marigold)),
                          const SizedBox(height: 2),
                          Text(n.deva, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                          Text(n.roman, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textFaint)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RoleplayListPage extends StatelessWidget {
  const RoleplayListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roleplay Dialogues')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _InfoBanner(text: 'Multi-turn conversations. Step through both sides of the dialogue, and confirm each of your own lines out loud.'),
          for (final rp in extendedRoleplays)
            Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(rp.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textHigh)),
                subtitle: Text(rp.contextDescription, style: const TextStyle(color: AppColors.textMid)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RoleplayPlayerPage(dialogue: rp))),
              ),
            ),
        ],
      ),
    );
  }
}

class RoleplayPlayerPage extends StatefulWidget {
  final RoleplayDialogue dialogue;
  const RoleplayPlayerPage({super.key, required this.dialogue});

  @override
  State<RoleplayPlayerPage> createState() => _RoleplayPlayerPageState();
}

class _RoleplayPlayerPageState extends State<RoleplayPlayerPage> {
  int _revealed = 1;

  @override
  Widget build(BuildContext context) {
    final turns = widget.dialogue.turns;
    final done = _revealed >= turns.length;

    return Scaffold(
      appBar: AppBar(title: Text(widget.dialogue.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: _InfoBanner(text: widget.dialogue.contextDescription),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _revealed,
              itemBuilder: (context, i) {
                final t = turns[i];
                return Align(
                  alignment: t.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: t.isUser ? AppColors.marigoldDeep : AppColors.surfaceElevated,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: t.isUser ? AppColors.marigold.withValues(alpha: 0.4) : AppColors.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.speaker, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: t.isUser ? AppColors.marigold : AppColors.textFaint)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(child: Text(t.roman, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textHigh))),
                            IconButton(
                              icon: const Icon(Icons.volume_up, size: 16),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () => TtsService.instance.speak(t.roman),
                            ),
                          ],
                        ),
                        Text(t.hindi, style: const TextStyle(fontSize: 12, color: AppColors.textMid)),
                        if (t.tip != null) ...[
                          const SizedBox(height: 4),
                          Text('💡 ${t.tip}', style: const TextStyle(fontSize: 11, color: AppColors.jacaranda)),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: AppColors.marigold, foregroundColor: const Color(0xFF2B1B02)),
                onPressed: done ? () => Navigator.pop(context) : () => setState(() => _revealed += 1),
                icon: Icon(done ? Icons.check_circle_outline : Icons.arrow_forward),
                label: Text(done ? 'Finish Roleplay' : 'Next Line', style: const TextStyle(fontWeight: FontWeight.w900)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
