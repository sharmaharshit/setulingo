import '../models/reading_mode.dart';
import '../models/sentence_lab.dart';

/// Curated 81-word tagged dataset for Sentence Lab:
/// - 22 Anchors
/// - 32 Nouns
/// - 27 Verbs / Predicates
/// Total: 81 entries.
class SentenceLabData {
  SentenceLabData._();

  static const List<AnchorWord> anchors = [
    // Dative (4)
    AnchorWord(
      id: 'anc_01',
      text: TriScriptText(
        hindi: 'मुझे',
        devanagari: 'ननगे',
        romanHindi: 'Nanage',
      ),
      anchorType: AnchorType.dative,
      allowedNounTags: {'consumable', 'object', 'place', 'info', 'service', 'time'},
    ),
    AnchorWord(
      id: 'anc_02',
      text: TriScriptText(
        hindi: 'आपको',
        devanagari: 'निमगे',
        romanHindi: 'Nimage',
      ),
      anchorType: AnchorType.dative,
      allowedNounTags: {'consumable', 'object', 'place', 'info', 'service'},
    ),
    AnchorWord(
      id: 'anc_03',
      text: TriScriptText(
        hindi: 'हमें',
        devanagari: 'नमगे',
        romanHindi: 'Namage',
      ),
      anchorType: AnchorType.dative,
      allowedNounTags: {'consumable', 'object', 'place', 'info', 'service'},
    ),
    AnchorWord(
      id: 'anc_04',
      text: TriScriptText(
        hindi: 'सर / मैडम को',
        devanagari: 'अवरिगे',
        romanHindi: 'Avarige',
      ),
      anchorType: AnchorType.dative,
      allowedNounTags: {'consumable', 'object', 'info', 'service'},
    ),

    // Possessive (3)
    AnchorWord(
      id: 'anc_05',
      text: TriScriptText(
        hindi: 'मेरा / मेरी',
        devanagari: 'नन्न',
        romanHindi: 'Nanna',
      ),
      anchorType: AnchorType.possessive,
      allowedNounTags: {'object', 'place', 'work', 'person', 'travel'},
    ),
    AnchorWord(
      id: 'anc_06',
      text: TriScriptText(
        hindi: 'आपका / आपकी',
        devanagari: 'निम्म',
        romanHindi: 'Nimma',
      ),
      anchorType: AnchorType.possessive,
      allowedNounTags: {'object', 'place', 'work', 'person', 'info'},
    ),
    AnchorWord(
      id: 'anc_07',
      text: TriScriptText(
        hindi: 'हमारा / हमारी',
        devanagari: 'नम्म',
        romanHindi: 'Namma',
      ),
      anchorType: AnchorType.possessive,
      allowedNounTags: {'place', 'work', 'person', 'travel'},
    ),

    // Modifier (3)
    AnchorWord(
      id: 'anc_08',
      text: TriScriptText(
        hindi: 'यह',
        devanagari: 'ई',
        romanHindi: 'Ee',
      ),
      anchorType: AnchorType.modifier,
      allowedNounTags: {'consumable', 'object', 'place', 'travel', 'work', 'info'},
    ),
    AnchorWord(
      id: 'anc_09',
      text: TriScriptText(
        hindi: 'वह',
        devanagari: 'आ',
        romanHindi: 'Aa',
      ),
      anchorType: AnchorType.modifier,
      allowedNounTags: {'object', 'place', 'travel', 'person'},
    ),
    AnchorWord(
      id: 'anc_10',
      text: TriScriptText(
        hindi: 'अच्छा / बढ़िया',
        devanagari: 'ओळ्ळे',
        romanHindi: 'Olle',
      ),
      anchorType: AnchorType.modifier,
      allowedNounTags: {'consumable', 'object', 'place', 'work'},
    ),

    // Quantifiers (3)
    AnchorWord(
      id: 'anc_11',
      text: TriScriptText(
        hindi: 'एक',
        devanagari: 'ओंदु',
        romanHindi: 'Ondu',
      ),
      anchorType: AnchorType.quantifier,
      allowedNounTags: {'countable'},
    ),
    AnchorWord(
      id: 'anc_12',
      text: TriScriptText(
        hindi: 'दो',
        devanagari: 'एरडु',
        romanHindi: 'Eradu',
      ),
      anchorType: AnchorType.quantifier,
      allowedNounTags: {'countable'},
    ),
    AnchorWord(
      id: 'anc_13',
      text: TriScriptText(
        hindi: 'थोड़ा',
        devanagari: 'स्वल्प',
        romanHindi: 'Swalpa',
      ),
      anchorType: AnchorType.quantifier,
      allowedNounTags: {'uncountable', 'consumable', 'info', 'time'},
    ),

    // Nominative (3)
    AnchorWord(
      id: 'anc_14',
      text: TriScriptText(
        hindi: 'मैं',
        devanagari: 'नानु',
        romanHindi: 'Naanu',
      ),
      anchorType: AnchorType.nominative,
      allowedNounTags: {'place', 'travel', 'work', 'consumable', 'object'},
    ),
    AnchorWord(
      id: 'anc_15',
      text: TriScriptText(
        hindi: 'आप',
        devanagari: 'नीवु',
        romanHindi: 'Neevu',
      ),
      anchorType: AnchorType.nominative,
      allowedNounTags: {'place', 'travel', 'work', 'consumable', 'info'},
    ),
    AnchorWord(
      id: 'anc_16',
      text: TriScriptText(
        hindi: 'हम',
        devanagari: 'नावु',
        romanHindi: 'Naavu',
      ),
      anchorType: AnchorType.nominative,
      allowedNounTags: {'place', 'travel', 'work', 'consumable'},
    ),

    // Locative (2)
    AnchorWord(
      id: 'anc_17',
      text: TriScriptText(
        hindi: 'यहाँ',
        devanagari: 'इल्लि',
        romanHindi: 'Illi',
      ),
      anchorType: AnchorType.locative,
      allowedNounTags: {'consumable', 'object', 'place', 'service', 'travel'},
    ),
    AnchorWord(
      id: 'anc_18',
      text: TriScriptText(
        hindi: 'वहाँ',
        devanagari: 'अल्लि',
        romanHindi: 'Alli',
      ),
      anchorType: AnchorType.locative,
      allowedNounTags: {'place', 'service', 'travel', 'object'},
    ),

    // Temporal (2)
    AnchorWord(
      id: 'anc_19',
      text: TriScriptText(
        hindi: 'अभी',
        devanagari: 'ईग',
        romanHindi: 'Eega',
      ),
      anchorType: AnchorType.temporal,
      allowedNounTags: {'travel', 'work', 'consumable', 'service', 'time'},
    ),
    AnchorWord(
      id: 'anc_20',
      text: TriScriptText(
        hindi: 'आज',
        devanagari: 'इवत्तु',
        romanHindi: 'Ivattu',
      ),
      anchorType: AnchorType.temporal,
      allowedNounTags: {'work', 'travel', 'consumable', 'place'},
    ),

    // Interrogative (2)
    AnchorWord(
      id: 'anc_21',
      text: TriScriptText(
        hindi: 'कौनसा / कहाँ का',
        devanagari: 'याव',
        romanHindi: 'Yaava',
      ),
      anchorType: AnchorType.interrogative,
      allowedNounTags: {'place', 'travel', 'time', 'work', 'object'},
    ),
    AnchorWord(
      id: 'anc_22',
      text: TriScriptText(
        hindi: 'कितना',
        devanagari: 'एष्टु',
        romanHindi: 'Eshtu',
      ),
      anchorType: AnchorType.interrogative,
      allowedNounTags: {'time', 'travel', 'consumable', 'object'},
    ),
  ];

  static const List<NounWord> nouns = [
    // Drinks (4)
    NounWord(
      id: 'noun_01',
      category: NounCategory.drinks,
      text: TriScriptText(hindi: 'पानी', devanagari: 'नीरु', romanHindi: 'Neeru'),
      isCountable: false,
      semanticTags: {'consumable', 'uncountable', 'drink'},
    ),
    NounWord(
      id: 'noun_02',
      category: NounCategory.drinks,
      text: TriScriptText(hindi: 'कॉफी', devanagari: 'कॉफी', romanHindi: 'Coffee'),
      isCountable: true,
      semanticTags: {'consumable', 'countable', 'drink'},
    ),
    NounWord(
      id: 'noun_03',
      category: NounCategory.drinks,
      text: TriScriptText(hindi: 'चाय', devanagari: 'चा', romanHindi: 'Chaa'),
      isCountable: true,
      semanticTags: {'consumable', 'countable', 'drink'},
    ),
    NounWord(
      id: 'noun_04',
      category: NounCategory.drinks,
      text: TriScriptText(hindi: 'दूध', devanagari: 'हालु', romanHindi: 'Haalu'),
      isCountable: false,
      semanticTags: {'consumable', 'uncountable', 'drink'},
    ),

    // Food (5)
    NounWord(
      id: 'noun_05',
      category: NounCategory.food,
      text: TriScriptText(hindi: 'खाना / भोजन', devanagari: 'ऊटा', romanHindi: 'Oota'),
      isCountable: false,
      semanticTags: {'consumable', 'uncountable', 'food'},
    ),
    NounWord(
      id: 'noun_06',
      category: NounCategory.food,
      text: TriScriptText(hindi: 'नाश्ता', devanagari: 'तिंडी', romanHindi: 'Tindi'),
      isCountable: false,
      semanticTags: {'consumable', 'uncountable', 'food'},
    ),
    NounWord(
      id: 'noun_07',
      category: NounCategory.food,
      text: TriScriptText(hindi: 'इडली', devanagari: 'इड्ली', romanHindi: 'Idli'),
      isCountable: true,
      semanticTags: {'consumable', 'countable', 'food'},
    ),
    NounWord(
      id: 'noun_08',
      category: NounCategory.food,
      text: TriScriptText(hindi: 'दोसा', devanagari: 'दोसे', romanHindi: 'Dose'),
      isCountable: true,
      semanticTags: {'consumable', 'countable', 'food'},
    ),
    NounWord(
      id: 'noun_09',
      category: NounCategory.food,
      text: TriScriptText(hindi: 'चावल', devanagari: 'अन्ना', romanHindi: 'Anna'),
      isCountable: false,
      semanticTags: {'consumable', 'uncountable', 'food'},
    ),

    // Objects (5)
    NounWord(
      id: 'noun_10',
      category: NounCategory.objects,
      text: TriScriptText(hindi: 'बिल', devanagari: 'बिल', romanHindi: 'Bill'),
      isCountable: true,
      semanticTags: {'object', 'countable', 'service'},
    ),
    NounWord(
      id: 'noun_11',
      category: NounCategory.objects,
      text: TriScriptText(hindi: 'पैसे / छुट्टे', devanagari: 'दुड्डु', romanHindi: 'Duddu'),
      isCountable: false,
      semanticTags: {'object', 'uncountable', 'money'},
    ),
    NounWord(
      id: 'noun_12',
      category: NounCategory.objects,
      text: TriScriptText(hindi: 'थैला / बैग', devanagari: 'बैग', romanHindi: 'Bag'),
      isCountable: true,
      semanticTags: {'object', 'countable'},
    ),
    NounWord(
      id: 'noun_13',
      category: NounCategory.objects,
      text: TriScriptText(hindi: 'फोन', devanagari: 'फोन', romanHindi: 'Phone'),
      isCountable: true,
      semanticTags: {'object', 'countable'},
    ),
    NounWord(
      id: 'noun_14',
      category: NounCategory.objects,
      text: TriScriptText(hindi: 'चाबी', devanagari: 'की', romanHindi: 'Key'),
      isCountable: true,
      semanticTags: {'object', 'countable'},
    ),

    // Places (5)
    NounWord(
      id: 'noun_15',
      category: NounCategory.places,
      text: TriScriptText(hindi: 'घर', devanagari: 'मने', romanHindi: 'Mane'),
      isCountable: true,
      semanticTags: {'place', 'countable'},
    ),
    NounWord(
      id: 'noun_16',
      category: NounCategory.places,
      text: TriScriptText(hindi: 'ऑफिस', devanagari: 'ऑफिस', romanHindi: 'Office'),
      isCountable: true,
      semanticTags: {'place', 'work', 'countable'},
    ),
    NounWord(
      id: 'noun_17',
      category: NounCategory.places,
      text: TriScriptText(hindi: 'अस्पताल', devanagari: 'आस्पत्रे', romanHindi: 'Aaspatre'),
      isCountable: true,
      semanticTags: {'place', 'service', 'countable'},
    ),
    NounWord(
      id: 'noun_18',
      category: NounCategory.places,
      text: TriScriptText(hindi: 'दुकान', devanagari: 'अंगडी', romanHindi: 'Angadi'),
      isCountable: true,
      semanticTags: {'place', 'service', 'countable'},
    ),
    NounWord(
      id: 'noun_19',
      category: NounCategory.places,
      text: TriScriptText(hindi: 'बाज़ार', devanagari: 'मारुकाट्टे', romanHindi: 'Maarukatte'),
      isCountable: true,
      semanticTags: {'place', 'countable'},
    ),

    // Travel (4)
    NounWord(
      id: 'noun_20',
      category: NounCategory.travel,
      text: TriScriptText(hindi: 'ऑटो', devanagari: 'ऑटो', romanHindi: 'Auto'),
      isCountable: true,
      semanticTags: {'travel', 'countable', 'service'},
    ),
    NounWord(
      id: 'noun_21',
      category: NounCategory.travel,
      text: TriScriptText(hindi: 'मेट्रो', devanagari: 'मेट्रो', romanHindi: 'Metro'),
      isCountable: true,
      semanticTags: {'travel', 'service', 'place'},
    ),
    NounWord(
      id: 'noun_22',
      category: NounCategory.travel,
      text: TriScriptText(hindi: 'बस', devanagari: 'बस', romanHindi: 'Bus'),
      isCountable: true,
      semanticTags: {'travel', 'countable', 'service'},
    ),
    NounWord(
      id: 'noun_23',
      category: NounCategory.travel,
      text: TriScriptText(hindi: 'टिकट', devanagari: 'टिकट', romanHindi: 'Ticket'),
      isCountable: true,
      semanticTags: {'travel', 'object', 'countable'},
    ),

    // Work (3)
    NounWord(
      id: 'noun_24',
      category: NounCategory.work,
      text: TriScriptText(hindi: 'काम', devanagari: 'केलसा', romanHindi: 'Kelasa'),
      isCountable: false,
      semanticTags: {'work', 'uncountable'},
    ),
    NounWord(
      id: 'noun_25',
      category: NounCategory.work,
      text: TriScriptText(hindi: 'मीटिंग', devanagari: 'मीटिंग', romanHindi: 'Meeting'),
      isCountable: true,
      semanticTags: {'work', 'countable', 'time'},
    ),
    NounWord(
      id: 'noun_26',
      category: NounCategory.work,
      text: TriScriptText(hindi: 'मदद', devanagari: 'सहाय', romanHindi: 'Sahaaya'),
      isCountable: false,
      semanticTags: {'work', 'service', 'uncountable'},
    ),

    // Information (3)
    NounWord(
      id: 'noun_27',
      category: NounCategory.information,
      text: TriScriptText(hindi: 'कन्नड़', devanagari: 'कन्नड', romanHindi: 'Kannada'),
      isCountable: false,
      semanticTags: {'info', 'uncountable'},
    ),
    NounWord(
      id: 'noun_28',
      category: NounCategory.information,
      text: TriScriptText(hindi: 'रास्ता / पता', devanagari: 'दारी', romanHindi: 'Daari'),
      isCountable: true,
      semanticTags: {'info', 'place', 'travel'},
    ),
    NounWord(
      id: 'noun_29',
      category: NounCategory.information,
      text: TriScriptText(hindi: 'नाम', devanagari: 'हेसरु', romanHindi: 'Hesaru'),
      isCountable: true,
      semanticTags: {'info', 'person'},
    ),

    // People & Time (3)
    NounWord(
      id: 'noun_30',
      category: NounCategory.peopleAndTime,
      text: TriScriptText(hindi: 'समय / टाइम', devanagari: 'समय', romanHindi: 'Samaya'),
      isCountable: false,
      semanticTags: {'time', 'uncountable'},
    ),
    NounWord(
      id: 'noun_31',
      category: NounCategory.peopleAndTime,
      text: TriScriptText(hindi: 'दोस्त', devanagari: 'स्नेहितरु', romanHindi: 'Snehitaru'),
      isCountable: true,
      semanticTags: {'person', 'countable'},
    ),
    NounWord(
      id: 'noun_32',
      category: NounCategory.peopleAndTime,
      text: TriScriptText(hindi: 'डॉक्टर', devanagari: 'डॉक्टर', romanHindi: 'Doctor'),
      isCountable: true,
      semanticTags: {'person', 'service', 'countable'},
    ),
  ];

  static const List<VerbWord> verbs = [
    // Needs & Desires (4)
    VerbWord(
      id: 'verb_01',
      category: VerbCategory.needsAndDesires,
      text: TriScriptText(hindi: 'चाहिए', devanagari: 'बेकु', romanHindi: 'Beku'),
      allowedAnchorTypes: {
        AnchorType.dative,
        AnchorType.quantifier,
        AnchorType.modifier,
      },
      requiredNounTags: {'consumable', 'object', 'service', 'travel', 'info', 'time'},
    ),
    VerbWord(
      id: 'verb_02',
      category: VerbCategory.needsAndDesires,
      text: TriScriptText(hindi: 'नहीं चाहिए', devanagari: 'बेडा', romanHindi: 'Beda'),
      allowedAnchorTypes: {
        AnchorType.dative,
        AnchorType.modifier,
      },
      requiredNounTags: {'consumable', 'object', 'service', 'travel'},
    ),
    VerbWord(
      id: 'verb_03',
      category: VerbCategory.needsAndDesires,
      text: TriScriptText(hindi: 'पसंद है', devanagari: 'इष्ट', romanHindi: 'Ishta'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'consumable', 'place', 'work'},
    ),
    VerbWord(
      id: 'verb_04',
      category: VerbCategory.needsAndDesires,
      text: TriScriptText(hindi: 'जरूरी है', devanagari: 'अवश्यक', romanHindi: 'Avashyaka'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier, AnchorType.temporal},
      requiredNounTags: {'info', 'service', 'object', 'work', 'time'},
    ),

    // Knowledge (3)
    VerbWord(
      id: 'verb_05',
      category: VerbCategory.knowledge,
      text: TriScriptText(hindi: 'मालूम है / आता है', devanagari: 'गोत्तु', romanHindi: 'Gottu'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'info', 'place', 'work', 'person'},
    ),
    VerbWord(
      id: 'verb_06',
      category: VerbCategory.knowledge,
      text: TriScriptText(hindi: 'मालूम नहीं है', devanagari: 'गोत्तिल्ला', romanHindi: 'Gottilla'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'info', 'place', 'work'},
    ),
    VerbWord(
      id: 'verb_07',
      category: VerbCategory.knowledge,
      text: TriScriptText(hindi: 'समझ आया', devanagari: 'अर्थ आइटु', romanHindi: 'Artha aaytu'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'info', 'work'},
    ),

    // Existence & Availability (4)
    VerbWord(
      id: 'verb_08',
      category: VerbCategory.existenceAndAvailability,
      text: TriScriptText(hindi: 'है / उपलब्ध है', devanagari: 'इदे', romanHindi: 'Ide'),
      allowedAnchorTypes: {
        AnchorType.locative,
        AnchorType.possessive,
        AnchorType.modifier,
        AnchorType.temporal,
      },
      requiredNounTags: {'consumable', 'object', 'place', 'service', 'travel', 'work', 'time'},
    ),
    VerbWord(
      id: 'verb_09',
      category: VerbCategory.existenceAndAvailability,
      text: TriScriptText(hindi: 'नहीं है', devanagari: 'इल्ला', romanHindi: 'Illa'),
      allowedAnchorTypes: {
        AnchorType.locative,
        AnchorType.possessive,
        AnchorType.dative,
      },
      requiredNounTags: {'consumable', 'object', 'service', 'time', 'money', 'work'},
    ),
    VerbWord(
      id: 'verb_10',
      category: VerbCategory.existenceAndAvailability,
      text: TriScriptText(hindi: 'मिलता है', devanagari: 'सिगुत्ते', romanHindi: 'Sigutte'),
      allowedAnchorTypes: {AnchorType.locative, AnchorType.dative},
      requiredNounTags: {'consumable', 'object', 'travel', 'service'},
    ),
    VerbWord(
      id: 'verb_11',
      category: VerbCategory.existenceAndAvailability,
      text: TriScriptText(hindi: 'हैं (लोग/व्यक्ति)', devanagari: 'इद्दारे', romanHindi: 'Iddare'),
      allowedAnchorTypes: {AnchorType.locative, AnchorType.possessive},
      requiredNounTags: {'person'},
    ),

    // Quality (3)
    VerbWord(
      id: 'verb_12',
      category: VerbCategory.quality,
      text: TriScriptText(hindi: 'अच्छा है', devanagari: 'चनागिदे', romanHindi: 'Channagide'),
      allowedAnchorTypes: {AnchorType.modifier, AnchorType.possessive, AnchorType.locative},
      requiredNounTags: {'consumable', 'object', 'place', 'work', 'service'},
    ),
    VerbWord(
      id: 'verb_13',
      category: VerbCategory.quality,
      text: TriScriptText(hindi: 'तैयार है', devanagari: 'रेडी इदे', romanHindi: 'Ready ide'),
      allowedAnchorTypes: {AnchorType.modifier, AnchorType.possessive, AnchorType.temporal},
      requiredNounTags: {'consumable', 'object', 'work', 'travel'},
    ),
    VerbWord(
      id: 'verb_14',
      category: VerbCategory.quality,
      text: TriScriptText(hindi: 'बहुत अच्छा है', devanagari: 'तुंबा चनागिदे', romanHindi: 'Tumba channagide'),
      allowedAnchorTypes: {AnchorType.modifier, AnchorType.possessive},
      requiredNounTags: {'consumable', 'place', 'work'},
    ),

    // Imperatives (3)
    VerbWord(
      id: 'verb_15',
      category: VerbCategory.imperatives,
      text: TriScriptText(hindi: 'दीजिए', devanagari: 'कोडी', romanHindi: 'Kodi'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.quantifier, AnchorType.modifier},
      requiredNounTags: {'consumable', 'object', 'travel'},
    ),
    VerbWord(
      id: 'verb_16',
      category: VerbCategory.imperatives,
      text: TriScriptText(hindi: 'लाइए', devanagari: 'तन्नी', romanHindi: 'Tanni'),
      allowedAnchorTypes: {AnchorType.quantifier, AnchorType.modifier, AnchorType.dative},
      requiredNounTags: {'consumable', 'object'},
    ),
    VerbWord(
      id: 'verb_17',
      category: VerbCategory.imperatives,
      text: TriScriptText(hindi: 'दिखाइए', devanagari: 'तोरिसी', romanHindi: 'Torisi'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'object', 'info', 'place'},
    ),

    // Requests (3)
    VerbWord(
      id: 'verb_18',
      category: VerbCategory.requests,
      text: TriScriptText(hindi: 'कृपया बोलिए', devanagari: 'दयविट्टु हेळी', romanHindi: 'Dayavittu heli'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier},
      requiredNounTags: {'info', 'place'},
    ),
    VerbWord(
      id: 'verb_19',
      category: VerbCategory.requests,
      text: TriScriptText(hindi: 'कृपया कीजिए', devanagari: 'दयविट्टु माडी', romanHindi: 'Dayavittu maadi'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.modifier, AnchorType.temporal},
      requiredNounTags: {'service', 'work', 'object'},
    ),
    VerbWord(
      id: 'verb_20',
      category: VerbCategory.requests,
      text: TriScriptText(hindi: 'भेजिए', devanagari: 'कळुहिसी', romanHindi: 'Kaluhisi'),
      allowedAnchorTypes: {AnchorType.dative, AnchorType.temporal, AnchorType.modifier},
      requiredNounTags: {'object', 'info', 'travel'},
    ),

    // Questions (4)
    VerbWord(
      id: 'verb_21',
      category: VerbCategory.questions,
      text: TriScriptText(hindi: 'कहाँ है?', devanagari: 'एल्लि इदे?', romanHindi: 'Elli ide?'),
      allowedAnchorTypes: {AnchorType.possessive, AnchorType.modifier},
      requiredNounTags: {'place', 'object', 'travel', 'service'},
    ),
    VerbWord(
      id: 'verb_22',
      category: VerbCategory.questions,
      text: TriScriptText(hindi: 'कितना है?', devanagari: 'एष्टु इदे?', romanHindi: 'Eshtu ide?'),
      allowedAnchorTypes: {AnchorType.modifier, AnchorType.quantifier},
      requiredNounTags: {'consumable', 'object', 'travel', 'time'},
    ),
    VerbWord(
      id: 'verb_23',
      category: VerbCategory.questions,
      text: TriScriptText(hindi: 'क्या यह है?', devanagari: 'इदिया?', romanHindi: 'Idiya?'),
      allowedAnchorTypes: {AnchorType.locative, AnchorType.interrogative},
      requiredNounTags: {'consumable', 'object', 'travel', 'service', 'time'},
    ),
    VerbWord(
      id: 'verb_24',
      category: VerbCategory.questions,
      text: TriScriptText(hindi: 'कब है?', devanagari: 'यावाग इदे?', romanHindi: 'Yaavaga ide?'),
      allowedAnchorTypes: {AnchorType.possessive, AnchorType.modifier, AnchorType.temporal},
      requiredNounTags: {'travel', 'work', 'time'},
    ),

    // First-person present actions (3)
    VerbWord(
      id: 'verb_25',
      category: VerbCategory.presentActions,
      text: TriScriptText(hindi: 'जा रहा हूँ / जाते हैं', devanagari: 'होग्तीनि', romanHindi: 'Hogteeni'),
      allowedAnchorTypes: {AnchorType.nominative, AnchorType.temporal},
      requiredNounTags: {'place', 'travel'},
    ),
    VerbWord(
      id: 'verb_26',
      category: VerbCategory.presentActions,
      text: TriScriptText(hindi: 'कर रहा हूँ / करता हूँ', devanagari: 'माड्तीनि', romanHindi: 'Maadteeni'),
      allowedAnchorTypes: {AnchorType.nominative, AnchorType.temporal},
      requiredNounTags: {'work', 'service'},
    ),
    VerbWord(
      id: 'verb_27',
      category: VerbCategory.presentActions,
      text: TriScriptText(hindi: 'खाता/पीता हूँ', devanagari: 'सेविसुत्तीनि / तगोंडतीनि', romanHindi: 'Tagondteeni'),
      allowedAnchorTypes: {AnchorType.nominative, AnchorType.temporal},
      requiredNounTags: {'consumable'},
    ),
  ];
}
