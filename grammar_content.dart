import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'store.dart';
import 'widgets.dart';

// ---------------------------------------------------------------------------
// Data — Spoken Bengaluru-Kannada forms aligned with Sahitya Parishat
// ---------------------------------------------------------------------------

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

/// Multi-turn negotiation and daily survival roleplay dialogues.
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

class NumbersPage extends StatelessWidget {
  const NumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Numbers'), actions: const [ScriptToggleAction()]),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: _InfoBanner(text: '1–20, plus essential round numbers for auto fares, quantities, and market bargaining. Tap any tile to hear it spoken.'),
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
      appBar: AppBar(title: const Text('Roleplay Dialogues'), actions: const [ScriptToggleAction()]),
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
      appBar: AppBar(title: Text(widget.dialogue.title), actions: const [ScriptToggleAction()]),
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
