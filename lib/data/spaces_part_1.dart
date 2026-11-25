import '../models/reading_mode.dart';
import '../models/real_space.dart';

/// Spaces 1 to 4 (20 complete scenarios).
const List<RealSpace> realSpacesPart1 = [
  // 1. Ordering Food & Restaurants
  RealSpace(
    id: 'space_food',
    order: 1,
    title: 'Ordering Food & Restaurants',
    hindiSubtitle: 'होटल, दर्शनी और रेस्टोरेंट',
    description:
        'Order breakfast at a Darshini, customize spice levels, ask for water, and settle the bill naturally.',
    badgeLabel: 'Counter & Table',
    layoutStyle: SpaceLayoutStyle.counterService,
    scenarios: [
      Scenario(
        id: 'food_01',
        spaceId: 'space_food',
        title: 'Morning Darshini Breakfast',
        hindiTitle: 'सुबह का नाश्ता (दर्शनी होटल)',
        situationalContext:
            'You are at a busy Bengaluru Darshini counter ordering idli, dosa, and filter coffee.',
        learningObjective: 'Order specific counts and ask what is ready.',
        phrases: [
          PhraseItem(
            id: 'food_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'अभी गरम क्या तैयार है?',
              devanagari: 'ईग बिसी-बिसी एनु रेडी इदे?',
              romanHindi: 'Eega bisi-bisi enu ready ide?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'गरम-गरम', devanagari: 'बिसी-बिसी', romanHindi: 'Bisi-bisi'),
                roleNote: 'Reduplicated adjective meaning piping hot.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'क्या तैयार है?', devanagari: 'एनु रेडी इदे?', romanHindi: 'Enu ready ide?'),
                roleNote: 'Natural spoken mix with English "ready".',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'दो इडली और एक मसाला दोसा दीजिए।',
              devanagari: 'एरडु इड्ली मत्तु ओंदु मसाले दोसे कोडी।',
              romanHindi: 'Eradu idli mattu ondu masaale dose kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'और', devanagari: 'मत्तु', romanHindi: 'Mattu'),
                roleNote: 'Conjunction "and".',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'दीजिए', devanagari: 'कोडी', romanHindi: 'Kodi'),
                roleNote: 'Polite imperative "give".',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_01_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'पार्सल नहीं, यहीं खाना है।',
              devanagari: 'पार्सल बेडा, इल्ले तिनबेकु।',
              romanHindi: 'Parcel beda, ille tinbeku.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'यहीं', devanagari: 'इल्ले', romanHindi: 'Ille'),
                roleNote: 'Emphatic "right here".',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'खाना है', devanagari: 'तिनबेकु', romanHindi: 'Tinbeku'),
                roleNote: 'Tinnu (eat) + beku (need/want).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'food_01_v1',
            text: TriScriptText(hindi: 'गरम', devanagari: 'बिसी', romanHindi: 'Bisi'),
            partOfSpeech: 'Adjective',
          ),
          VocabItem(
            id: 'food_01_v2',
            text: TriScriptText(hindi: 'नाश्ता', devanagari: 'तिंडी', romanHindi: 'Tindi'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_01_v3',
            text: TriScriptText(hindi: 'दोपहर/रात का खाना', devanagari: 'ऊटा', romanHindi: 'Oota'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'At Darshini counters, you usually pay first and hand the token to the serving counter.',
          'Saying "bisi-bisi" signals you want fresh, hot items.',
        ],
      ),
      Scenario(
        id: 'food_02',
        spaceId: 'space_food',
        title: 'Customizing Spice & Sugar',
        hindiTitle: 'तीखा और मीठा कम-ज़्यादा करना',
        situationalContext:
            'You want less chilli in your dish and less sugar in your filter coffee.',
        learningObjective: 'Use "swalpa kadime" (a little less) and "khaara" (spicy).',
        phrases: [
          PhraseItem(
            id: 'food_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मिर्च थोड़ा कम डालिए।',
              devanagari: 'खार स्वल्प कडिमे हाकी।',
              romanHindi: 'Khaara swalpa kadime haaki.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'तीखा / मिर्च', devanagari: 'खार', romanHindi: 'Khaara'),
                roleNote: 'Spice / chilli heat.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'कम डालिए', devanagari: 'कडिमे हाकी', romanHindi: 'Kadime haaki'),
                roleNote: 'Haaki = put/add.',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कॉफी में चीनी कम दीजिए।',
              devanagari: 'कॉफीअल्लि सक्करे कडिमे कोडी।',
              romanHindi: 'Coffee-alli sakkare kadime kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'चीनी', devanagari: 'सक्करे', romanHindi: 'Sakkare'),
                roleNote: 'Derived from Sanskrit sharkara (like Hindi shakkar).',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_02_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'बिना चीनी के एक चाय दीजिए।',
              devanagari: 'सक्करे इल्लदे ओंदु चा कोडी।',
              romanHindi: 'Sakkare illade ondu chaa kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'के बिना', devanagari: 'इल्लदे', romanHindi: 'Illade'),
                roleNote: '"Without".',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'food_02_v1',
            text: TriScriptText(hindi: 'नमक', devanagari: 'उप्पु', romanHindi: 'Uppu'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_02_v2',
            text: TriScriptText(hindi: 'मीठा', devanagari: 'सिही', romanHindi: 'Sihi'),
            partOfSpeech: 'Adjective',
          ),
          VocabItem(
            id: 'food_02_v3',
            text: TriScriptText(hindi: 'तीखा', devanagari: 'खार', romanHindi: 'Khaara'),
            partOfSpeech: 'Adjective',
          ),
        ],
        usageTips: [
          '"Illade" (के बिना) works with any ingredient: "Eerulli illade" (without onion).',
        ],
      ),
      Scenario(
        id: 'food_03',
        spaceId: 'space_food',
        title: 'Asking for Water & Extra Chutney',
        hindiTitle: 'पानी और एक्स्ट्रा चटनी मांगना',
        situationalContext: 'You are seated at a table and need drinking water and more sambar.',
        learningObjective: 'Ask politely for refills and water.',
        phrases: [
          PhraseItem(
            id: 'food_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'पीने का पानी दीजिए।',
              devanagari: 'कुडियुव नीरु कोडी।',
              romanHindi: 'Kudiyuva neeru kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'पीने का', devanagari: 'कुडियुव', romanHindi: 'Kudiyuva'),
                roleNote: 'From kudiyodu (to drink).',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'थोड़ा और सांभर डालिए।',
              devanagari: 'इन्नु स्वल्प सांबार हाकी।',
              romanHindi: 'Innu swalpa saambaar haaki.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'और थोड़ा', devanagari: 'इन्नु स्वल्प', romanHindi: 'Innu swalpa'),
                roleNote: 'Innu = more/still.',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_03_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'खाना बहुत अच्छा था।',
              devanagari: 'ऊटा तुंबा चनागित्तु।',
              romanHindi: 'Oota tumba channagittu.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'बहुत अच्छा था', devanagari: 'तुंबा चनागित्तु', romanHindi: 'Tumba channagittu'),
                roleNote: 'Past tense of channagide.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'food_03_v1',
            text: TriScriptText(hindi: 'पानी', devanagari: 'नीरु', romanHindi: 'Neeru'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_03_v2',
            text: TriScriptText(hindi: 'चम्मच', devanagari: 'चमच', romanHindi: 'Chamacha'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_03_v3',
            text: TriScriptText(hindi: 'प्लेट', devanagari: 'तट्टे', romanHindi: 'Tatte'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Complimenting the food with "Oota tumba channagittu" always brings a warm smile.',
        ],
      ),
      Scenario(
        id: 'food_04',
        spaceId: 'space_food',
        title: 'Vegetarian & Dietary Checks',
        hindiTitle: 'शाकाहारी और सामग्री की जानकारी',
        situationalContext: 'You want to confirm whether a dish is pure veg or contains egg/nuts.',
        learningObjective: 'Ask "Idaralli ... idiya?" (Is ... in this?).',
        phrases: [
          PhraseItem(
            id: 'food_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'क्या यह शुद्ध शाकाहारी है?',
              devanagari: 'इदु प्योर वेज आ?',
              romanHindi: 'Idu pure veg aa?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'क्या?', devanagari: 'आ?', romanHindi: 'Aa?'),
                roleNote: 'Spoken "-aa" suffix turns any phrase into a yes/no question.',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इसमें अंडा है क्या?',
              devanagari: 'इदरल्लि मोट्टे इदिया?',
              romanHindi: 'Idaralli motte idiya?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'इसमें', devanagari: 'इदरल्लि', romanHindi: 'Idaralli'),
                roleNote: 'Idu (this) + alli (in).',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'अंडा', devanagari: 'मोट्टे', romanHindi: 'Motte'),
                roleNote: 'Egg.',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_04_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'बिना प्याज़ का मिलेगा क्या?',
              devanagari: 'ईरुळ्ळी इल्लदे सिगुत्ता?',
              romanHindi: 'Eerulli illade sigutta?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'प्याज़', devanagari: 'ईरुळ्ळी', romanHindi: 'Eerulli'),
                roleNote: 'Onion.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'मिलेगा क्या?', devanagari: 'सिगुत्ता?', romanHindi: 'Sigutta?'),
                roleNote: 'Question form of sigutte (available).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'food_04_v1',
            text: TriScriptText(hindi: 'लहसुन', devanagari: 'बेळ्ळुळ्ळी', romanHindi: 'Bellulli'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_04_v2',
            text: TriScriptText(hindi: 'दही', devanagari: 'मोसरु', romanHindi: 'Mosaru'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'food_04_v3',
            text: TriScriptText(hindi: 'घी', devanagari: 'तुप्पा', romanHindi: 'Tuppa'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Idaralli ... idiya?" is a universal pattern for checking allergies or ingredients.',
        ],
      ),
      Scenario(
        id: 'food_05',
        spaceId: 'space_food',
        title: 'Paying the Bill & Packing Leftovers',
        hindiTitle: 'बिल मांगना और पैक करवाना',
        situationalContext: 'You have finished your meal and want to pack leftovers and pay via UPI.',
        learningObjective: 'Ask for the bill, parcel, and digital payment.',
        phrases: [
          PhraseItem(
            id: 'food_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'भैया, बिल दीजिए।',
              devanagari: 'अण्णा, बिल कोडी।',
              romanHindi: 'Anna, bill kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'भैया (बड़े भाई)', devanagari: 'अण्णा', romanHindi: 'Anna'),
                roleNote: 'Warm, respectful address for male staff.',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इसे पार्सल कर दीजिए।',
              devanagari: 'इदन्नु पार्सल माडी कोडी।',
              romanHindi: 'Idannu parcel maadi kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'इसे', devanagari: 'इदन्नु', romanHindi: 'Idannu'),
                roleNote: 'Object form of idu (this).',
              ),
            ],
          ),
          PhraseItem(
            id: 'food_05_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यूपीआई स्कैन कहाँ है?',
              devanagari: 'यूपीआई स्कैन एल्लि इदे?',
              romanHindi: 'UPI scan elli ide?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कहाँ है?', devanagari: 'एल्लि इदे?', romanHindi: 'Elli ide?'),
                roleNote: 'Standard location question.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'food_05_v1',
            text: TriScriptText(hindi: 'कुल मिलाकर', devanagari: 'ओट्टु', romanHindi: 'Ottu'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'food_05_v2',
            text: TriScriptText(hindi: 'छुट्टे पैसे', devanagari: 'चिल्लरे', romanHindi: 'Chillare'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Use "Anna" (अण्णा) for men and "Akka" (अक्का) for women—it immediately builds rapport.',
        ],
      ),
    ],
  ),

  // 2. Auto, Metro & Transportation
  RealSpace(
    id: 'space_transit',
    order: 2,
    title: 'Auto, Metro & Transportation',
    hindiSubtitle: 'ऑटो, मेट्रो, बस और सफ़र',
    description:
        'Hail autos, negotiate meter fares, navigate Namma Metro stations, and give live turn-by-turn directions.',
    badgeLabel: 'Transit & Routes',
    layoutStyle: SpaceLayoutStyle.transitRoute,
    scenarios: [
      Scenario(
        id: 'transit_01',
        spaceId: 'space_transit',
        title: 'Hailing an Auto & Meter Check',
        hindiTitle: 'ऑटो रोकना और मीटर की बात',
        situationalContext: 'You need an auto to Koramangala and want to go by meter.',
        learningObjective: 'Ask destination availability and request the meter.',
        phrases: [
          PhraseItem(
            id: 'tr_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कोरमंगला चलेंगे क्या?',
              devanagari: 'कोरमंगला बर्तीरा?',
              romanHindi: 'Koramangala barteera?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'चलेंगे क्या?', devanagari: 'बर्तीरा?', romanHindi: 'Barteera?'),
                roleNote: 'Literally "will you come?".',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मीटर के हिसाब से चलिए।',
              devanagari: 'मीटर हाकी होगोण।',
              romanHindi: 'Meter haaki hogona.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'चलिए (चलते हैं)', devanagari: 'होगोण', romanHindi: 'Hogona'),
                roleNote: 'Inclusive "let\'s go".',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_01_p3',
            speakerRole: 'Driver',
            text: TriScriptText(
              hindi: 'थोड़ा ज़्यादा होगा, सौ रुपये दीजिए।',
              devanagari: 'स्वल्प जास्ती आगुत्ते, नूरु रुपायी कोडी।',
              romanHindi: 'Swalpa jaasti aagutte, nooru rupayi kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ज़्यादा होगा', devanagari: 'जास्ती आगुत्ते', romanHindi: 'Jaasti aagutte'),
                roleNote: 'Jaasti = more/extra.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'tr_01_v1',
            text: TriScriptText(hindi: 'किराया', devanagari: 'बाडिगे', romanHindi: 'Baadige'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'tr_01_v2',
            text: TriScriptText(hindi: 'सीधे', devanagari: 'नेरा', romanHindi: 'Nera'),
            partOfSpeech: 'Adverb',
          ),
        ],
        usageTips: [
          'If the fare feels high, say "Nooru jaasti, embattu tagoli" (100 is high, take 80).',
        ],
      ),
      Scenario(
        id: 'transit_02',
        spaceId: 'space_transit',
        title: 'Live Turn-by-Turn Directions',
        hindiTitle: 'रास्ते में दाएँ-बाएँ बताना',
        situationalContext: 'Guiding a cab or auto driver for the last 500 meters to your gate.',
        learningObjective: 'Direct left, right, straight, and stop.',
        phrases: [
          PhraseItem(
            id: 'tr_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आगे बाईं तरफ़ मुड़िए।',
              devanagari: 'मुंदे एडगडे तिरुगी।',
              romanHindi: 'Munde edagade tirugi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'आगे', devanagari: 'मुंदे', romanHindi: 'Munde'),
                roleNote: 'Ahead / forward.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'बाईं तरफ़', devanagari: 'एडगडे', romanHindi: 'Edagade'),
                roleNote: 'Left side (Right = Balagade).',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यहीं दाईं तरफ़ रोक दीजिए।',
              devanagari: 'इल्ले बलगडे निल्लिसी।',
              romanHindi: 'Ille balagade nillisi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'रोकिए', devanagari: 'निल्लिसी', romanHindi: 'Nillisi'),
                roleNote: 'Stop the vehicle.',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_02_p3',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सीधे जाइए।',
              devanagari: 'नेरा होगी।',
              romanHindi: 'Nera hogi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'जाइए', devanagari: 'होगी', romanHindi: 'Hogi'),
                roleNote: 'Polite imperative "go".',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'tr_02_v1',
            text: TriScriptText(hindi: 'दाईं तरफ़', devanagari: 'बलगडे', romanHindi: 'Balagade'),
            partOfSpeech: 'Noun/Adverb',
          ),
          VocabItem(
            id: 'tr_02_v2',
            text: TriScriptText(hindi: 'बाईं तरफ़', devanagari: 'एडगडे', romanHindi: 'Edagade'),
            partOfSpeech: 'Noun/Adverb',
          ),
        ],
        usageTips: [
          'Remember: E-da = Left, Ba-la = Right. You can also say "Left/Right tirugi".',
        ],
      ),
      Scenario(
        id: 'transit_03',
        spaceId: 'space_transit',
        title: 'Namma Metro Ticket & Platform',
        hindiTitle: 'मेट्रो टिकट और प्लेटफॉर्म',
        situationalContext: 'Buying a Metro token and checking which platform goes toward Majestic.',
        learningObjective: 'Ask for tickets and confirm train direction.',
        phrases: [
          PhraseItem(
            id: 'tr_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मैजेस्टिक के लिए एक टिकट दीजिए।',
              devanagari: 'मैजेस्टिक-गे ओंदु टिकट कोडी।',
              romanHindi: 'Majestic-ge ondu ticket kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'के लिए / तक', devanagari: '-गे', romanHindi: '-ge'),
                roleNote: 'Destination suffix.',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यह ट्रेन इंदिरानगर जाएगी क्या?',
              devanagari: 'ई ट्रेन इंदिरानगर-गे होगुत्ता?',
              romanHindi: 'Ee train Indiranagar-ge hogutta?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'जाएगी क्या?', devanagari: 'होगुत्ता?', romanHindi: 'Hogutta?'),
                roleNote: 'Question form of hogutte (goes).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'tr_03_v1',
            text: TriScriptText(hindi: 'आखिरी स्टॉप', devanagari: 'कोने स्टॉप', romanHindi: 'Kone stop'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'tr_03_v2',
            text: TriScriptText(hindi: 'सीढ़ियाँ', devanagari: 'मेट्टिलु', romanHindi: 'Mettilu'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Metro announcements are in Kannada, Hindi/English—listen for "Mundina nildana" (अगला स्टेशन).',
        ],
      ),
      Scenario(
        id: 'transit_04',
        spaceId: 'space_transit',
        title: 'BMTC Bus Boarding & Conductor',
        hindiTitle: 'बस में चढ़ना और कंडक्टर से बात',
        situationalContext: 'Checking if a city bus goes to Silk Board and buying a ticket.',
        learningObjective: 'Confirm bus route and request ticket.',
        phrases: [
          PhraseItem(
            id: 'tr_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सिल्क बोर्ड जाएगी क्या?',
              devanagari: 'सिल्क बोर्ड होगुत्ता?',
              romanHindi: 'Silk Board hogutta?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'जाती है क्या?', devanagari: 'होगुत्ता?', romanHindi: 'Hogutta?'),
                roleNote: 'Short, clear question at bus stops.',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सिल्क बोर्ड आने पर बताइए।',
              devanagari: 'सिल्क बोर्ड बंदाग हेळी।',
              romanHindi: 'Silk Board bandaaga heli.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'आने पर', devanagari: 'बंदाग', romanHindi: 'Bandaaga'),
                roleNote: 'When it arrives.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'बताइए', devanagari: 'हेळी', romanHindi: 'Heli'),
                roleNote: 'Tell / inform.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'tr_04_v1',
            text: TriScriptText(hindi: 'अगला स्टॉप', devanagari: 'मुंदिन स्टॉप', romanHindi: 'Mundina stop'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'tr_04_v2',
            text: TriScriptText(hindi: 'उतरना', devanagari: 'इळियुवुदु', romanHindi: 'Iliyuvudu'),
            partOfSpeech: 'Verb',
          ),
        ],
        usageTips: [
          '"[Place] bandaaga heli" is super helpful when you are new to a bus route.',
        ],
      ),
      Scenario(
        id: 'transit_05',
        spaceId: 'space_transit',
        title: 'Cab Pickup & Waiting',
        hindiTitle: 'कैब ड्राइवर को लोकेशन बताना',
        situationalContext: 'Calling your cab driver who is waiting near the main gate.',
        learningObjective: 'State your exact waiting spot and ask ETA.',
        phrases: [
          PhraseItem(
            id: 'tr_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मैं मेन गेट के पास खड़ा हूँ।',
              devanagari: 'नानु मेन गेट हत्तिरा निंतिद्दीनि।',
              romanHindi: 'Naanu main gate hattira nintiddeeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'पास', devanagari: 'हत्तिरा', romanHindi: 'Hattira'),
                roleNote: 'Near / beside.',
              ),
            ],
          ),
          PhraseItem(
            id: 'tr_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कितनी देर में आएंगे?',
              devanagari: 'एष्टु होत्तल्लि बर्तीरा?',
              romanHindi: 'Eshtu hottalli barteera?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कितनी देर में', devanagari: 'एष्टु होत्तल्लि', romanHindi: 'Eshtu hottalli'),
                roleNote: 'Hottu = time/duration.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'tr_05_v1',
            text: TriScriptText(hindi: 'दो मिनट', devanagari: 'एरडु निमिष', romanHindi: 'Eradu nimisha'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'tr_05_v2',
            text: TriScriptText(hindi: 'सामने', devanagari: 'एदुरुगडे', romanHindi: 'Edurugade'),
            partOfSpeech: 'Adverb',
          ),
        ],
        usageTips: [
          'Using "hattira" (पास) with landmarks helps drivers spot you immediately.',
        ],
      ),
    ],
  ),

  // 3. Shopping & Markets
  RealSpace(
    id: 'space_shopping',
    order: 3,
    title: 'Shopping & Markets',
    hindiSubtitle: 'बाज़ार, किराना और मोलभाव',
    description:
        'Buy vegetables by weight, ask for fresh stock, negotiate politely, and check exchange policies.',
    badgeLabel: 'Stalls & Shops',
    layoutStyle: SpaceLayoutStyle.marketStall,
    scenarios: [
      Scenario(
        id: 'shop_01',
        spaceId: 'space_shopping',
        title: 'Buying Vegetables by Weight',
        hindiTitle: 'सब्ज़ी और फल तौलवाकर लेना',
        situationalContext: 'At a local vegetable cart buying tomatoes, onions, and coriander.',
        learningObjective: 'Ask for half kilo, quarter kilo, and price per kg.',
        phrases: [
          PhraseItem(
            id: 'sh_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'टमाटर एक किलो कितना है?',
              devanagari: 'टमाटर ओंदु केजी एष्टु?',
              romanHindi: 'Tomato ondu KG eshtu?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कितना', devanagari: 'एष्टु', romanHindi: 'Eshtu'),
                roleNote: 'Price question.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sh_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आधा किलो प्याज़ दीजिए।',
              devanagari: 'अर्ध केजी ईरुळ्ळी कोडी।',
              romanHindi: 'Ardha KG eerulli kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'आधा', devanagari: 'अर्ध', romanHindi: 'Ardha'),
                roleNote: 'Shared Sanskrit word for half.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sh_01_v1',
            text: TriScriptText(hindi: 'धनिया पत्ती', devanagari: 'कोत्तमबरी सोप्पु', romanHindi: 'Kottambari soppu'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sh_01_v2',
            text: TriScriptText(hindi: 'आलू', devanagari: 'आलूगड्डे', romanHindi: 'Aloogadde'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Ask for "swalpa kottambari soppu" (a little coriander) at the end of vegetable shopping!',
        ],
      ),
      Scenario(
        id: 'shop_02',
        spaceId: 'space_shopping',
        title: 'Polite Bargaining at Markets',
        hindiTitle: 'सही दाम पूछना और मोलभाव',
        situationalContext: 'Buying household items at Chickpet or Commercial Street.',
        learningObjective: 'Negotiate gently without sounding rude.',
        phrases: [
          PhraseItem(
            id: 'sh_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'थोड़ा ज़्यादा लग रहा है, कम कीजिए।',
              devanagari: 'स्वल्प जास्ती आइटु, कडिमे माडी।',
              romanHindi: 'Swalpa jaasti aaytu, kadime maadi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कम कीजिए', devanagari: 'कडिमे माडी', romanHindi: 'Kadime maadi'),
                roleNote: 'Standard polite bargaining phrase.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sh_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आखिरी दाम क्या लगाएंगे?',
              devanagari: 'फाइनल एष्टक्के कोड्तीरा?',
              romanHindi: 'Final eshtakke kodteera?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कितने में देंगे?', devanagari: 'एष्टक्के कोड्तीरा?', romanHindi: 'Eshtakke kodteera?'),
                roleNote: 'Asks for final selling price.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sh_02_v1',
            text: TriScriptText(hindi: 'दाम / कीमत', devanagari: 'बेले', romanHindi: 'Bele'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sh_02_v2',
            text: TriScriptText(hindi: 'सस्ता', devanagari: 'कडिमे बेले', romanHindi: 'Kadime bele'),
            partOfSpeech: 'Phrase',
          ),
        ],
        usageTips: [
          'Adding "swalpa" before "kadime maadi" softens the negotiation.',
        ],
      ),
      Scenario(
        id: 'shop_03',
        spaceId: 'space_shopping',
        title: 'Kirana Store Essentials',
        hindiTitle: 'किराने की दुकान पर सामान लेना',
        situationalContext: 'Picking up milk, curd, and rice from your neighbourhood angadi.',
        learningObjective: 'Ask if items are in stock and request a carry bag.',
        phrases: [
          PhraseItem(
            id: 'sh_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'ताज़ा दूध आया है क्या?',
              devanagari: 'ताज़ा हालु बंदिदिया?',
              romanHindi: 'Taaza haalu bandidiya?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'आया है क्या?', devanagari: 'बंदिदिया?', romanHindi: 'Bandidiya?'),
                roleNote: 'Has it arrived?',
              ),
            ],
          ),
          PhraseItem(
            id: 'sh_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'एक छोटा बैग दीजिए।',
              devanagari: 'ओंदु चिक्क बैग कोडी।',
              romanHindi: 'Ondu chikka bag kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'छोटा', devanagari: 'चिक्क', romanHindi: 'Chikka'),
                roleNote: 'Small (Big = Dodda).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sh_03_v1',
            text: TriScriptText(hindi: 'बड़ा', devanagari: 'दोड्ड', romanHindi: 'Dodda'),
            partOfSpeech: 'Adjective',
          ),
          VocabItem(
            id: 'sh_03_v2',
            text: TriScriptText(hindi: 'दुकान', devanagari: 'अंगडी', romanHindi: 'Angadi'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Chikka (छोटा) and Dodda (बड़ा) are useful for sizes everywhere.',
        ],
      ),
      Scenario(
        id: 'shop_04',
        spaceId: 'space_shopping',
        title: 'Clothing Sizes & Fitting',
        hindiTitle: 'कपड़ों का साइज़ और रंग देखना',
        situationalContext: 'Looking for a different size or colour at a clothing store.',
        learningObjective: 'Ask for another colour or bigger size.',
        phrases: [
          PhraseItem(
            id: 'sh_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इसमें दूसरा रंग दिखाइए।',
              devanagari: 'इदरल्लि बेरे कलर तोरिसी।',
              romanHindi: 'Idaralli bere colour torisi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'दूसरा / अलग', devanagari: 'बेरे', romanHindi: 'Bere'),
                roleNote: 'Other / different.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'दिखाइए', devanagari: 'तोरिसी', romanHindi: 'Torisi'),
                roleNote: 'Show.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sh_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इससे बड़ा साइज़ है क्या?',
              devanagari: 'इदक्किंत दोड्ड साइज़ इदिया?',
              romanHindi: 'Idakkinta dodda size idiya?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'इससे बड़ा', devanagari: 'इदक्किंत दोड्ड', romanHindi: 'Idakkinta dodda'),
                roleNote: 'Comparative "-kinta" = than this.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sh_04_v1',
            text: TriScriptText(hindi: 'रंग', devanagari: 'बण्ण', romanHindi: 'Banna'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sh_04_v2',
            text: TriScriptText(hindi: 'नया', devanagari: 'होस', romanHindi: 'Hosa'),
            partOfSpeech: 'Adjective',
          ),
        ],
        usageTips: [
          '"Bere ... torisi" (show a different ...) works for clothes, shoes, and electronics.',
        ],
      ),
      Scenario(
        id: 'shop_05',
        spaceId: 'space_shopping',
        title: 'Returns & Exchanges',
        hindiTitle: 'सामान बदलना या वापस करना',
        situationalContext: 'Returning a damaged or wrong item with your receipt.',
        learningObjective: 'Politely ask for a replacement.',
        phrases: [
          PhraseItem(
            id: 'sh_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यह ठीक से काम नहीं कर रहा।',
              devanagari: 'इदु सरियागि केलसा माड्ता इल्ला।',
              romanHindi: 'Idu sariyaagi kelasa maadta illa.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ठीक से', devanagari: 'सरियागि', romanHindi: 'Sariyaagi'),
                roleNote: 'Properly.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sh_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'क्या इसे बदल सकते हैं?',
              devanagari: 'इदन्नु एक्सचेंज माडबोदा?',
              romanHindi: 'Idannu exchange maadboda?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कर सकते हैं क्या?', devanagari: 'माडबोदा?', romanHindi: 'Maadboda?'),
                roleNote: 'Polite permission "-bahuda / -boda".',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sh_05_v1',
            text: TriScriptText(hindi: 'वापस', devanagari: 'वापस', romanHindi: 'Vaapas'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'sh_05_v2',
            text: TriScriptText(hindi: 'टूटा हुआ', devanagari: 'ओडेदिदे', romanHindi: 'Odedide'),
            partOfSpeech: 'Adjective',
          ),
        ],
        usageTips: [
          'Adding "-boda?" to any verb stem means "Can we/I ...?".',
        ],
      ),
    ],
  ),

  // 4. Work & Office
  RealSpace(
    id: 'space_work',
    order: 4,
    title: 'Work & Office',
    hindiSubtitle: 'ऑफिस, मीटिंग और सहकर्मी',
    description:
        'Coordinate meetings, ask colleagues for help, handle cafeteria breaks, and talk about schedules.',
    badgeLabel: 'Workplace',
    layoutStyle: SpaceLayoutStyle.officeDesk,
    scenarios: [
      Scenario(
        id: 'work_01',
        spaceId: 'space_work',
        title: 'Morning Office Greeting & Chai Break',
        hindiTitle: 'सुबह की नमस्ते और कॉफी ब्रेक',
        situationalContext: 'Greeting a Kannadiga colleague in the office pantry.',
        learningObjective: 'Make natural, friendly office small talk.',
        phrases: [
          PhraseItem(
            id: 'wk_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सुप्रभात, नाश्ता हो गया क्या?',
              devanagari: 'शुभोदय, तिंडी आइटआ?',
              romanHindi: 'Shubhodaya, tindi aaytaa?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'हो गया क्या?', devanagari: 'आइटआ?', romanHindi: 'Aaytaa?'),
                roleNote: 'Classic friendly check-in: "Did you eat?".',
              ),
            ],
          ),
          PhraseItem(
            id: 'wk_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'चलिए, कॉफी पीकर आते हैं।',
              devanagari: 'बन्नी, कॉफी कुडिदु बरोण।',
              romanHindi: 'Banni, coffee kudidu barona.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'पीकर आते हैं', devanagari: 'कुडिदु बरोण', romanHindi: 'Kudidu barona'),
                roleNote: 'Inviting someone for a quick break.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'wk_01_v1',
            text: TriScriptText(hindi: 'दोपहर का खाना', devanagari: 'ऊटा', romanHindi: 'Oota'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'wk_01_v2',
            text: TriScriptText(hindi: 'काम', devanagari: 'केलसा', romanHindi: 'Kelasa'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Oota aaytaa?" (खाना हो गया?) is the warmest way to greet colleagues after 1 PM.',
        ],
      ),
      Scenario(
        id: 'work_02',
        spaceId: 'space_work',
        title: 'Scheduling & Meeting Updates',
        hindiTitle: 'मीटिंग का समय और अपडेट पूछना',
        situationalContext: 'Checking when the team sync starts and whether everyone has joined.',
        learningObjective: 'Ask "when" (Yaavaga) and say "I will be ready in 5 minutes".',
        phrases: [
          PhraseItem(
            id: 'wk_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मीटिंग कितने बजे है?',
              devanagari: 'मीटिंग एष्टु गंटेगे इदे?',
              romanHindi: 'Meeting eshtu gantege ide?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कितने बजे', devanagari: 'एष्टु गंटेगे', romanHindi: 'Eshtu gantege'),
                roleNote: 'Gante = hour/o\'clock.',
              ),
            ],
          ),
          PhraseItem(
            id: 'wk_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'पाँच मिनट में शुरू करते हैं।',
              devanagari: 'ऐदु निमिषदल्लि शुरू माडोण।',
              romanHindi: 'Aidu nimishadalli shuru maadona.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'शुरू करते हैं', devanagari: 'शुरू माडोण', romanHindi: 'Shuru maadona'),
                roleNote: 'Maadona = let us do.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'wk_02_v1',
            text: TriScriptText(hindi: 'आज', devanagari: 'इवत्तु', romanHindi: 'Ivattu'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'wk_02_v2',
            text: TriScriptText(hindi: 'कल (आने वाला)', devanagari: 'नाळे', romanHindi: 'Naale'),
            partOfSpeech: 'Adverb',
          ),
        ],
        usageTips: [
          '"Naale" means tomorrow, while "Ninne" means yesterday.',
        ],
      ),
      Scenario(
        id: 'work_03',
        spaceId: 'space_work',
        title: 'Asking a Colleague for Help',
        hindiTitle: 'सहकर्मी से मदद मांगना',
        situationalContext: 'You need a teammate to review a document or explain a process.',
        learningObjective: 'Ask politely if someone has a free moment.',
        phrases: [
          PhraseItem(
            id: 'wk_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'क्या अभी दो मिनट समय है?',
              devanagari: 'ईग एरडु निमिष समय इदिया?',
              romanHindi: 'Eega eradu nimisha samaya idiya?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'समय है क्या?', devanagari: 'समय इदिया?', romanHindi: 'Samaya idiya?'),
                roleNote: 'Polite opener before asking a favor.',
              ),
            ],
          ),
          PhraseItem(
            id: 'wk_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कृपया इसे एक बार देखिए।',
              devanagari: 'दयविट्टु इदन्नु ओंदु सारी नोडी।',
              romanHindi: 'Dayavittu idannu ondu saari nodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'एक बार', devanagari: 'ओंदु सारी', romanHindi: 'Ondu saari'),
                roleNote: 'Once.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'देखिए', devanagari: 'नोडी', romanHindi: 'Nodi'),
                roleNote: 'Look / check.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'wk_03_v1',
            text: TriScriptText(hindi: 'मदद', devanagari: 'सहाय', romanHindi: 'Sahaaya'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'wk_03_v2',
            text: TriScriptText(hindi: 'समझना', devanagari: 'अर्थ', romanHindi: 'Artha'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Ondu saari nodi" (एक बार देख लीजिए) is polite and natural in any office.',
        ],
      ),
      Scenario(
        id: 'work_04',
        spaceId: 'space_work',
        title: 'Security Gate & Reception',
        hindiTitle: 'रिसेप्शन और सुरक्षा गेट पर बात',
        situationalContext: 'Visiting a client office or registering a guest pass.',
        learningObjective: 'State whom you are meeting and ask for directions.',
        phrases: [
          PhraseItem(
            id: 'wk_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मुझे तीसरे माले पर जाना है।',
              devanagari: 'ननगे मूरने फ्लोर-गे होगबेकु।',
              romanHindi: 'Nanage moorane floor-ge hogbeku.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'तीसरे', devanagari: 'मूरने', romanHindi: 'Moorane'),
                roleNote: 'Ordinal suffix "-ane" (1st = Ondane, 2nd = Eradane).',
              ),
            ],
          ),
          PhraseItem(
            id: 'wk_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'लिफ्ट किस तरफ़ है?',
              devanagari: 'लिफ्ट याव कडे इदे?',
              romanHindi: 'Lift yaava kade ide?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'किस तरफ़', devanagari: 'याव कडे', romanHindi: 'Yaava kade'),
                roleNote: 'Kade = side/direction.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'wk_04_v1',
            text: TriScriptText(hindi: 'पहचान पत्र / आईडी', devanagari: 'आईडी कार्ड', romanHindi: 'ID card'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'wk_04_v2',
            text: TriScriptText(hindi: 'हस्ताक्षर / साइन', devanagari: 'सही', romanHindi: 'Sahi'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Adding "-ane" to any Kannada number turns it into an ordinal (1st, 2nd, 3rd).',
        ],
      ),
      Scenario(
        id: 'work_05',
        spaceId: 'space_work',
        title: 'Leaving for the Day & Leave Notice',
        hindiTitle: 'छुट्टी और घर निकलते समय की बात',
        situationalContext: 'Wrapping up work for the day or informing your team about tomorrow.',
        learningObjective: 'Say you are leaving and mention tomorrow\'s plans.',
        phrases: [
          PhraseItem(
            id: 'wk_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आज का काम पूरा हो गया, मैं निकल रहा हूँ।',
              devanagari: 'इवत्तिन केलसा मुगितु, नानु होर्तीनि।',
              romanHindi: 'Ivattina kelasa mugitu, naanu horteeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ख़त्म / पूरा हुआ', devanagari: 'मुगितु', romanHindi: 'Mugitu'),
                roleNote: 'Finished / completed.',
              ),
            ],
          ),
          PhraseItem(
            id: 'wk_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कल मिलते हैं, शुभ रात्रि।',
              devanagari: 'नाळे सिगोण, शुभ रात्रि।',
              romanHindi: 'Naale sigona, shubha raatri.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'मिलते हैं', devanagari: 'सिगोण', romanHindi: 'Sigona'),
                roleNote: 'Let us meet (literally "let us find each other").',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'wk_05_v1',
            text: TriScriptText(hindi: 'छुट्टी', devanagari: 'रजे', romanHindi: 'Raje'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'wk_05_v2',
            text: TriScriptText(hindi: 'जल्दी', devanagari: 'बेग', romanHindi: 'Bega'),
            partOfSpeech: 'Adverb',
          ),
        ],
        usageTips: [
          '"Naale sigona" (कल मिलते हैं) is the most natural goodbye among friends and coworkers.',
        ],
      ),
    ],
  ),
];
