import '../models/lesson.dart';
import '../models/reading_mode.dart';
import '../models/real_space.dart';

class LessonsData {
  LessonsData._();

  static const List<Lesson> lessons = [
    Lesson(
      id: 'lesson_01',
      order: 1,
      title: 'Polite Requests & Needs (Beku / Kodi)',
      hindiSubtitle: 'विनम्र निवेदन और ज़रूरत बताना',
      focusSummary: 'Master "Nanage ... beku" and "... kodi" for ordering and asking.',
      estimatedMinutes: 4,
      steps: [
        PhraseStep(
          id: 'l1_s1',
          promptTitle: 'Core Phrase: Asking for what you need',
          phrase: TriScriptText(
            hindi: 'मुझे एक कॉफी चाहिए।',
            devanagari: 'ननगे ओंदु कॉफी बेकु।',
            romanHindi: 'Nanage ondu coffee beku.',
          ),
          chunks: [
            PhraseChunk(
              text: TriScriptText(hindi: 'मुझे', devanagari: 'ननगे', romanHindi: 'Nanage'),
              roleNote: 'Dative pronoun (literally "to me").',
            ),
            PhraseChunk(
              text: TriScriptText(hindi: 'एक', devanagari: 'ओंदु', romanHindi: 'Ondu'),
              roleNote: 'Number 1.',
            ),
            PhraseChunk(
              text: TriScriptText(hindi: 'चाहिए', devanagari: 'बेकु', romanHindi: 'Beku'),
              roleNote: 'Essential verb meaning "want / need".',
            ),
          ],
          culturalNote:
              'In Kannada, you do not say "I want"; you say "To me (Nanage) ... is needed (beku)". This works for food, water, bills, and help.',
        ),
        SpeakPracticeStep(
          id: 'l1_s2',
          promptTitle: 'Speak Out Loud: Polite Counter Request',
          phrase: TriScriptText(
            hindi: 'कृपया थोड़ा पानी दीजिए।',
            devanagari: 'दयविट्टु स्वल्प नीरु कोडी।',
            romanHindi: 'Dayavittu swalpa neeru kodi.',
          ),
          speakingGuidance:
              'Keep the "d" in "kodi" soft-retroflex (कोडी) and pause briefly after "Dayavittu".',
          focusSound: 'Kodi (कोडी) = दीजिए (respectful)',
        ),
        BuildStep(
          id: 'l1_s3',
          promptTitle: 'Assemble the Kannada Sentence',
          targetHindiMeaning: 'मुझे बिल चाहिए।',
          availableTiles: [
            TriScriptText(hindi: 'चाहिए', devanagari: 'बेकु', romanHindi: 'beku'),
            TriScriptText(hindi: 'मुझे', devanagari: 'ननगे', romanHindi: 'Nanage'),
            TriScriptText(hindi: 'बिल', devanagari: 'बिल', romanHindi: 'bill'),
            TriScriptText(hindi: 'नहीं चाहिए', devanagari: 'बेडा', romanHindi: 'beda'),
          ],
          correctOrderIndices: [1, 2, 0],
          expectedSentence: TriScriptText(
            hindi: 'मुझे बिल चाहिए।',
            devanagari: 'ननगे बिल बेकु।',
            romanHindi: 'Nanage bill beku.',
          ),
          explanation:
              'Spoken Kannada follows Anchor (Nanage) → Object (bill) → Predicate (beku). "Beda" means "do not want".',
        ),
        UseStep(
          id: 'l1_s4',
          promptTitle: 'Real-Life Check',
          situationDescription:
              'A waiter offers extra rice, but you are already full.',
          question: 'How do you politely say "No, I don\'t need it"?',
          options: [
            UseStepOption(
              text: TriScriptText(
                hindi: 'नहीं चाहिए, धन्यवाद।',
                devanagari: 'बेडा, धन्यवादगळु।',
                romanHindi: 'Beda, dhanyavaadagalu.',
              ),
              isCorrect: true,
              feedback:
                  'Spot on! "Beda" politely declines an offer, and adding "dhanyavaadagalu" or a smile keeps it warm.',
            ),
            UseStepOption(
              text: TriScriptText(
                hindi: 'मुझे चाहिए।',
                devanagari: 'ननगे बेकु।',
                romanHindi: 'Nanage beku.',
              ),
              isCorrect: false,
              feedback:
                  '"Nanage beku" means you DO want it. Use "Beda" to decline.',
            ),
            UseStepOption(
              text: TriScriptText(
                hindi: 'मालूम नहीं।',
                devanagari: 'गोत्तिल्ला।',
                romanHindi: 'Gottilla.',
              ),
              isCorrect: false,
              feedback:
                  '"Gottilla" means "I don\'t know", not "I don\'t want".',
            ),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'lesson_02',
      order: 2,
      title: 'Greetings & "Do You Know?" (Gottu / Gottilla)',
      hindiSubtitle: 'अभिवादन और जानकारी पूछना',
      focusSummary: 'Greet naturally and express what you know or understand.',
      estimatedMinutes: 4,
      steps: [
        PhraseStep(
          id: 'l2_s1',
          promptTitle: 'Core Phrase: Warm Greeting',
          phrase: TriScriptText(
            hindi: 'नमस्ते, आप कैसे हैं?',
            devanagari: 'नमस्कार, नीवु हेगिद्दीरा?',
            romanHindi: 'Namaskaara, neevu hegiddeera?',
          ),
          chunks: [
            PhraseChunk(
              text: TriScriptText(hindi: 'आप', devanagari: 'नीवु', romanHindi: 'Neevu'),
              roleNote: 'Respectful "you".',
            ),
            PhraseChunk(
              text: TriScriptText(hindi: 'कैसे हैं?', devanagari: 'हेगिद्दीरा?', romanHindi: 'Hegiddeera?'),
              roleNote: 'Standard polite inquiry about well-being.',
            ),
          ],
          culturalNote:
              'When someone asks "Hegiddeera?", the natural reply is "Channagiddeeni" (मैं ठीक हूँ / बढ़िया हूँ).',
        ),
        SpeakPracticeStep(
          id: 'l2_s2',
          promptTitle: 'Speak Out Loud: Explaining Your Kannada Level',
          phrase: TriScriptText(
            hindi: 'मुझे थोड़ी-थोड़ी कन्नड़ आती है।',
            devanagari: 'ननगे स्वल्प-स्वल्प कन्नड गोत्तु।',
            romanHindi: 'Nanage swalpa-swalpa Kannada gottu.',
          ),
          speakingGuidance:
              'Say "swalpa-swalpa" briskly—locals love hearing newcomers try Kannada!',
          focusSound: 'Gottu (गोत्तु) = मालूम है / आता है',
        ),
        BuildStep(
          id: 'l2_s3',
          promptTitle: 'Assemble the Sentence',
          targetHindiMeaning: 'मुझे रास्ता नहीं पता।',
          availableTiles: [
            TriScriptText(hindi: 'रास्ता', devanagari: 'दारी', romanHindi: 'daari'),
            TriScriptText(hindi: 'नहीं पता', devanagari: 'गोत्तिल्ला', romanHindi: 'gottilla'),
            TriScriptText(hindi: 'मुझे', devanagari: 'ननगे', romanHindi: 'Nanage'),
            TriScriptText(hindi: 'पता है', devanagari: 'गोत्तु', romanHindi: 'gottu'),
          ],
          correctOrderIndices: [2, 0, 1],
          expectedSentence: TriScriptText(
            hindi: 'मुझे रास्ता नहीं पता।',
            devanagari: 'ननगे दारी गोत्तिल्ला।',
            romanHindi: 'Nanage daari gottilla.',
          ),
          explanation:
              'Attach "-illa" to "gottu" to form "gottilla" (don\'t know).',
        ),
        UseStep(
          id: 'l2_s4',
          promptTitle: 'Real-Life Check',
          situationDescription:
              'Someone speaks fast Kannada to you and you want them to slow down.',
          question: 'Which phrase works best?',
          options: [
            UseStepOption(
              text: TriScriptText(
                hindi: 'कृपया थोड़ा धीरे बोलिए।',
                devanagari: 'दयविट्टु स्वल्प निधानवागि हेळी।',
                romanHindi: 'Dayavittu swalpa nidhaanavaagi heli.',
              ),
              isCorrect: true,
              feedback:
                  'Perfect! "Swalpa nidhaanavaagi heli" politely asks them to speak a little slower.',
            ),
            UseStepOption(
              text: TriScriptText(
                hindi: 'यहाँ आइए।',
                devanagari: 'इल्लि बन्नी।',
                romanHindi: 'Illi banni.',
              ),
              isCorrect: false,
              feedback:
                  '"Illi banni" means "Come here", not "Speak slowly".',
            ),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'lesson_03',
      order: 3,
      title: 'Auto & Directions (Elli / Eshtu / Hogona)',
      hindiSubtitle: 'ऑटो, किराया और रास्ता पूछना',
      focusSummary: 'Ask destinations, check fares, and direct your driver.',
      estimatedMinutes: 5,
      steps: [
        PhraseStep(
          id: 'l3_s1',
          promptTitle: 'Core Phrase: Asking the Auto Driver',
          phrase: TriScriptText(
            hindi: 'इंदिरानगर चलेंगे क्या?',
            devanagari: 'इंदिरानगर बर्तीरा?',
            romanHindi: 'Indiranagar barteera?',
          ),
          chunks: [
            PhraseChunk(
              text: TriScriptText(hindi: 'आएंगे क्या / चलेंगे क्या?', devanagari: 'बर्तीरा?', romanHindi: 'Barteera?'),
              roleNote: 'In Bengaluru, you ask drivers "Will you come?" (Barteera?) rather than "Will you go?".',
            ),
          ],
          culturalNote:
              'Saying "[Place] barteera?" is the authentic local way to hail an auto in Karnataka.',
        ),
        SpeakPracticeStep(
          id: 'l3_s2',
          promptTitle: 'Speak Out Loud: Asking the Fare',
          phrase: TriScriptText(
            hindi: 'कितना हुआ? मीटर लगाइए।',
            devanagari: 'एष्टु आइटु? मीटर हाकी।',
            romanHindi: 'Eshtu aaytu? Meter haaki.',
          ),
          speakingGuidance:
              '"Eshtu" (एष्टु) is your go-to word for "How much?".',
          focusSound: 'Eshtu aaytu? (एष्टु आइटु?) = कितना हुआ?',
        ),
        BuildStep(
          id: 'l3_s3',
          promptTitle: 'Assemble the Direction',
          targetHindiMeaning: 'यहाँ बाईं तरफ़ रोकिए।',
          availableTiles: [
            TriScriptText(hindi: 'रोकिए', devanagari: 'निल्लिसी', romanHindi: 'nillisi'),
            TriScriptText(hindi: 'यहाँ', devanagari: 'इल्लि', romanHindi: 'Illi'),
            TriScriptText(hindi: 'बाईं तरफ़', devanagari: 'एडगडे', romanHindi: 'edagade'),
          ],
          correctOrderIndices: [1, 2, 0],
          expectedSentence: TriScriptText(
            hindi: 'यहाँ बाईं तरफ़ रोकिए।',
            devanagari: 'इल्लि एडगडे निल्लिसी।',
            romanHindi: 'Illi edagade nillisi.',
          ),
          explanation:
              'Place (Illi) + Side (edagade = left, balagade = right) + Action (nillisi = stop).',
        ),
        UseStep(
          id: 'l3_s4',
          promptTitle: 'Real-Life Check',
          situationDescription:
              'You want to ask where the nearest Metro station is.',
          question: 'Choose the natural Kannada question:',
          options: [
            UseStepOption(
              text: TriScriptText(
                hindi: 'मेट्रो स्टेशन कहाँ है?',
                devanagari: 'मेट्रो स्टेशन एल्लि इदे?',
                romanHindi: 'Metro station elli ide?',
              ),
              isCorrect: true,
              feedback:
                  'Correct! "Elli ide?" means "Where is it?".',
            ),
            UseStepOption(
              text: TriScriptText(
                hindi: 'मेट्रो स्टेशन कितना है?',
                devanagari: 'मेट्रो स्टेशन एष्टु इदे?',
                romanHindi: 'Metro station eshtu ide?',
              ),
              isCorrect: false,
              feedback:
                  '"Eshtu" asks "how much/how many", whereas "Elli" asks "where".',
            ),
          ],
        ),
      ],
    ),
    Lesson(
      id: 'lesson_04',
      order: 4,
      title: 'Market & Price Negotiation (Eshtu / Kadime)',
      hindiSubtitle: 'दुकान, दाम और मोलभाव',
      focusSummary: 'Ask prices, check availability (Idiya / Illa), and bargain politely.',
      estimatedMinutes: 4,
      steps: [
        PhraseStep(
          id: 'l4_s1',
          promptTitle: 'Core Phrase: Checking Availability',
          phrase: TriScriptText(
            hindi: 'क्या आपके पास ताज़ा सब्ज़ियाँ हैं?',
            devanagari: 'निम्म हत्तिरा फ्रेश तरकारी इदिया?',
            romanHindi: 'Nimma hattira fresh tarkaari idiya?',
          ),
          chunks: [
            PhraseChunk(
              text: TriScriptText(hindi: 'आपके पास', devanagari: 'निम्म हत्तिरा', romanHindi: 'Nimma hattira'),
              roleNote: 'Literally "near you" — used for "do you have?".',
            ),
            PhraseChunk(
              text: TriScriptText(hindi: 'क्या है?', devanagari: 'इदिया?', romanHindi: 'Idiya?'),
              roleNote: 'Question form of "ide" (is there?).',
            ),
          ],
          culturalNote:
              'Adding "-a" to "ide" turns a statement ("Ide" = it is there) into a yes/no question ("Idiya?" = is it there?).',
        ),
        SpeakPracticeStep(
          id: 'l4_s2',
          promptTitle: 'Speak Out Loud: Asking for a Lower Price',
          phrase: TriScriptText(
            hindi: 'थोड़ा कम कीजिए ना।',
            devanagari: 'स्वल्प कडिमे माडी।',
            romanHindi: 'Swalpa kadime maadi.',
          ),
          speakingGuidance:
              'Keep the tone friendly and smiling—"kadime maadi" is universally understood in markets.',
          focusSound: 'Kadime (कडिमे) = कम (less)',
        ),
        BuildStep(
          id: 'l4_s3',
          promptTitle: 'Assemble the Question',
          targetHindiMeaning: 'यह कितना है?',
          availableTiles: [
            TriScriptText(hindi: 'कितना', devanagari: 'एष्टु', romanHindi: 'eshtu'),
            TriScriptText(hindi: 'यह', devanagari: 'इदु', romanHindi: 'Idu'),
            TriScriptText(hindi: 'है', devanagari: 'इदे', romanHindi: 'ide?'),
          ],
          correctOrderIndices: [1, 0, 2],
          expectedSentence: TriScriptText(
            hindi: 'यह कितना है?',
            devanagari: 'इदु एष्टु इदे?',
            romanHindi: 'Idu eshtu ide?',
          ),
          explanation:
              'Simple and effective: "Idu eshtu?" or "Idu eshtu ide?" asks the price of any item you point to.',
        ),
        UseStep(
          id: 'l4_s4',
          promptTitle: 'Real-Life Check',
          situationDescription:
              'The shopkeeper says "Change illa" (छुट्टे नहीं हैं). You want to pay via UPI.',
          question: 'How do you ask if UPI / PhonePe works?',
          options: [
            UseStepOption(
              text: TriScriptText(
                hindi: 'यूपीआई चलेगा क्या?',
                devanagari: 'यूपीआई आगुत्ता?',
                romanHindi: 'UPI aagutta?',
              ),
              isCorrect: true,
              feedback:
                  'Great! "Aagutta?" means "Will it work / Is it possible?".',
            ),
            UseStepOption(
              text: TriScriptText(
                hindi: 'यूपीआई अच्छा है।',
                devanagari: 'यूपीआई चनागिदे।',
                romanHindi: 'UPI channagide.',
              ),
              isCorrect: false,
              feedback:
                  '"Channagide" means "it is good", not "will it work here?".',
            ),
          ],
        ),
      ],
    ),
  ];
}
