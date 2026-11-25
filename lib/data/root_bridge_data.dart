import '../models/reading_mode.dart';
import '../models/root_bridge.dart';

/// 40 curated comparative connections between Hindi/Sanskrit and spoken Kannada.
/// Carefully distinguishes Tatsama, Sanskrit-derived, Direct Cognates, and
/// broader areal/cultural relationships without false etymological claims.
class RootBridgeData {
  RootBridgeData._();

  static const List<RootConnection> connections = [
    RootConnection(
      id: 'rb_01',
      rootOrWord: 'समय (Samaya)',
      kannadaForm: TriScriptText(
        hindi: 'समय / वक़्त',
        devanagari: 'समय',
        romanHindi: 'Samaya',
      ),
      hindiCognateOrMeaning: 'समय (Samay)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Direct Sanskrit Tatsama borrowed into both Hindi and Kannada. Spoken Kannada retains the final vowel "-a" (Samaya), whereas Hindi drops it (Samay).',
      exampleUsage: TriScriptText(
        hindi: 'अभी समय नहीं है।',
        devanagari: 'ईग समय इल्ला।',
        romanHindi: 'Eega samaya illa.',
      ),
    ),
    RootConnection(
      id: 'rb_02',
      rootOrWord: 'धन्यवाद (Dhanyavaad)',
      kannadaForm: TriScriptText(
        hindi: 'धन्यवाद / शुक्रिया',
        devanagari: 'धन्यवादगळु',
        romanHindi: 'Dhanyavaadagalu',
      ),
      hindiCognateOrMeaning: 'धन्यवाद (Dhanyavaad)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Sanskrit Tatsama "Dhanyavaada" combined with the Kannada respectful plural suffix "-galu" for formal gratitude.',
      exampleUsage: TriScriptText(
        hindi: 'आपकी मदद के लिए धन्यवाद।',
        devanagari: 'निम्म सहायक्के धन्यवादगळु।',
        romanHindi: 'Nimma sahaayakke dhanyavaadagalu.',
      ),
    ),
    RootConnection(
      id: 'rb_03',
      rootOrWord: 'सहाय (Sahaaya)',
      kannadaForm: TriScriptText(
        hindi: 'मदद / सहायता',
        devanagari: 'सहाय',
        romanHindi: 'Sahaaya',
      ),
      hindiCognateOrMeaning: 'सहायता (Sahaayata)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Both languages draw from Sanskrit "sahaaya" (help/companion). In Bengaluru Kannada, "sahaaya maadi" is a polite way to ask for help.',
      exampleUsage: TriScriptText(
        hindi: 'कृपया थोड़ी मदद कीजिए।',
        devanagari: 'दयविट्टु स्वल्प सहाय माडी।',
        romanHindi: 'Dayavittu swalpa sahaaya maadi.',
      ),
    ),
    RootConnection(
      id: 'rb_04',
      rootOrWord: 'अल्प / स्वल्प (Swalpa)',
      kannadaForm: TriScriptText(
        hindi: 'थोड़ा / ज़रा सा',
        devanagari: 'स्वल्प',
        romanHindi: 'Swalpa',
      ),
      hindiCognateOrMeaning: 'स्वल्प (Swalp - बहुत कम)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'One of the highest-frequency spoken Kannada words! While "swalp" sounds formal in Hindi, "swalpa" is the everyday word for "a little" in Kannada.',
      exampleUsage: TriScriptText(
        hindi: 'थोड़ा धीरे बोलिए।',
        devanagari: 'स्वल्प निधानवागि हेळी।',
        romanHindi: 'Swalpa nidhaanavaagi heli.',
      ),
    ),
    RootConnection(
      id: 'rb_05',
      rootOrWord: 'अवश्यक (Avashyaka)',
      kannadaForm: TriScriptText(
        hindi: 'ज़रूरी / आवश्यक',
        devanagari: 'अवश्यक',
        romanHindi: 'Avashyaka',
      ),
      hindiCognateOrMeaning: 'आवश्यक (Aavashyak)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Shared Sanskrit root meaning necessary or urgent. Widely understood in offices, hospitals, and formal requests.',
      exampleUsage: TriScriptText(
        hindi: 'यह काम बहुत ज़रूरी है।',
        devanagari: 'ई केलसा तुंबा अवश्यक इदे।',
        romanHindi: 'Ee kelasa tumba avashyaka ide.',
      ),
    ),
    RootConnection(
      id: 'rb_06',
      rootOrWord: 'अर्थ (Artha)',
      kannadaForm: TriScriptText(
        hindi: 'मतलब / अर्थ',
        devanagari: 'अर्थ',
        romanHindi: 'Artha',
      ),
      hindiCognateOrMeaning: 'अर्थ (Arth - मतलब)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Identical Sanskrit Tatsama meaning "meaning/sense". Used daily in Kannada with "aaytu" (happened) to say "I understood".',
      exampleUsage: TriScriptText(
        hindi: 'मुझे समझ आ गया।',
        devanagari: 'ननगे अर्थ आइटु।',
        romanHindi: 'Nanage artha aaytu.',
      ),
    ),
    RootConnection(
      id: 'rb_07',
      rootOrWord: 'प्रयत्न (Prayatna)',
      kannadaForm: TriScriptText(
        hindi: 'कोशिश / प्रयास',
        devanagari: 'प्रयत्न',
        romanHindi: 'Prayatna',
      ),
      hindiCognateOrMeaning: 'प्रयत्न (Prayatn)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Sanskrit Tatsama meaning effort or attempt. In Kannada, pair it with "maadi" (do) to say "please try".',
      exampleUsage: TriScriptText(
        hindi: 'मैं कोशिश कर रहा हूँ।',
        devanagari: 'नानु प्रयत्न माड्तीनि।',
        romanHindi: 'Naanu prayatna maadteeni.',
      ),
    ),
    RootConnection(
      id: 'rb_08',
      rootOrWord: 'समस्या (Samasya)',
      kannadaForm: TriScriptText(
        hindi: 'समस्या / परेशानी',
        devanagari: 'समस्ये',
        romanHindi: 'Samasye',
      ),
      hindiCognateOrMeaning: 'समस्या (Samasya)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Feminine Sanskrit "-a" nouns regularly shift to "-e" in Kannada (Samasya → Samasye, Asha → Aashe, Bhasha → Bhaashe).',
      exampleUsage: TriScriptText(
        hindi: 'कोई समस्या नहीं है।',
        devanagari: 'यावुदे समस्ये इल्ला।',
        romanHindi: 'Yaavude samasye illa.',
      ),
    ),
    RootConnection(
      id: 'rb_09',
      rootOrWord: 'भाषा (Bhasha)',
      kannadaForm: TriScriptText(
        hindi: 'भाषा / ज़बान',
        devanagari: 'भाषे',
        romanHindi: 'Bhaashe',
      ),
      hindiCognateOrMeaning: 'भाषा (Bhasha)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Follows the same "-a" to "-e" adaptation rule in Kannada phonology, making it immediately recognizable to Hindi speakers.',
      exampleUsage: TriScriptText(
        hindi: 'कन्नड़ एक सुंदर भाषा है।',
        devanagari: 'कन्नड ओंदु सुंदर भाषे।',
        romanHindi: 'Kannada ondu sundara bhaashe.',
      ),
    ),
    RootConnection(
      id: 'rb_10',
      rootOrWord: 'कथा (Katha)',
      kannadaForm: TriScriptText(
        hindi: 'कहानी / कथा',
        devanagari: 'कथे',
        romanHindi: 'Kathe',
      ),
      hindiCognateOrMeaning: 'कथा (Katha)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Sanskrit "katha" adapts its final vowel to "kathe" in Kannada, used for stories, movies, and news.',
      exampleUsage: TriScriptText(
        hindi: 'यह कहानी अच्छी है।',
        devanagari: 'ई कथे चनागिदे।',
        romanHindi: 'Ee kathe channagide.',
      ),
    ),
    RootConnection(
      id: 'rb_11',
      rootOrWord: 'आशा (Asha)',
      kannadaForm: TriScriptText(
        hindi: 'उम्मीद / आशा',
        devanagari: 'आशे',
        romanHindi: 'Aashe',
      ),
      hindiCognateOrMeaning: 'आशा (Asha)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Another clean "-a" → "-e" correspondence between Hindi/Sanskrit and Kannada.',
      exampleUsage: TriScriptText(
        hindi: 'मुझे उम्मीद है।',
        devanagari: 'ननगे आशे इदे।',
        romanHindi: 'Nanage aashe ide.',
      ),
    ),
    RootConnection(
      id: 'rb_12',
      rootOrWord: 'दया (Daya)',
      kannadaForm: TriScriptText(
        hindi: 'कृपया / मेहरबानी से',
        devanagari: 'दयविट्टु',
        romanHindi: 'Dayavittu',
      ),
      hindiCognateOrMeaning: 'दया (Daya - करुणा)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Built from Sanskrit "daya" (compassion/kindness) + Kannada "ittu" (having placed). Literally "having shown kindness" = "Please".',
      exampleUsage: TriScriptText(
        hindi: 'कृपया यहाँ बैठिए।',
        devanagari: 'दयविट्टु इल्लि कूत्कोळी।',
        romanHindi: 'Dayavittu illi kootkoli.',
      ),
    ),
    RootConnection(
      id: 'rb_13',
      rootOrWord: 'स्नेह (Sneha)',
      kannadaForm: TriScriptText(
        hindi: 'दोस्त / मित्र',
        devanagari: 'स्नेहित / स्नेहितरु',
        romanHindi: 'Snehita / Snehitaru',
      ),
      hindiCognateOrMeaning: 'स्नेह (Sneh - प्रेम/अपनापन)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Derived from Sanskrit "sneha" (affection). While Hindi uses it for affection, Kannada uses "Snehita" as the primary word for "friend".',
      exampleUsage: TriScriptText(
        hindi: 'वह मेरे दोस्त हैं।',
        devanagari: 'अवरु नन्न स्नेहितरु।',
        romanHindi: 'Avaru nanna snehitaru.',
      ),
    ),
    RootConnection(
      id: 'rb_14',
      rootOrWord: 'निधान (Nidhana)',
      kannadaForm: TriScriptText(
        hindi: 'धीरे / आराम से',
        devanagari: 'निधानवागि',
        romanHindi: 'Nidhaanavaagi',
      ),
      hindiCognateOrMeaning: 'निधान / धीमे (Steady/Slow)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Rooted in Sanskrit "nidhana" (settled/calm), Kannada adds adverbial "-vaagi" to mean "slowly" or "carefully".',
      exampleUsage: TriScriptText(
        hindi: 'धीरे चलाइए।',
        devanagari: 'निधानवागि ओडिसी।',
        romanHindi: 'Nidhaanavaagi odisi.',
      ),
    ),
    RootConnection(
      id: 'rb_15',
      rootOrWord: 'कष्ट (Kashta)',
      kannadaForm: TriScriptText(
        hindi: 'मुश्किल / कष्ट',
        devanagari: 'कष्ट',
        romanHindi: 'Kashta',
      ),
      hindiCognateOrMeaning: 'कष्ट (Kasht)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Shared Sanskrit Tatsama. In everyday Kannada, "kashta" means both "difficult" (like a task) and "hardship".',
      exampleUsage: TriScriptText(
        hindi: 'यह थोड़ा मुश्किल है।',
        devanagari: 'इदु स्वल्प कष्ट इदे।',
        romanHindi: 'Idu swalpa kashta ide.',
      ),
    ),
    RootConnection(
      id: 'rb_16',
      rootOrWord: 'सुख (Sukha)',
      kannadaForm: TriScriptText(
        hindi: 'आराम / सुख / ठीक',
        devanagari: 'सुख',
        romanHindi: 'Sukha',
      ),
      hindiCognateOrMeaning: 'सुख (Sukh)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Direct Sanskrit Tatsama denoting comfort, well-being, and ease.',
      exampleUsage: TriScriptText(
        hindi: 'सफ़र आरामदायक था।',
        devanagari: 'प्रयाण सुखवागित्तु।',
        romanHindi: 'Prayaana sukhavaagittu.',
      ),
    ),
    RootConnection(
      id: 'rb_17',
      rootOrWord: 'प्रयाण (Prayaana)',
      kannadaForm: TriScriptText(
        hindi: 'यात्रा / सफ़र',
        devanagari: 'प्रयाण',
        romanHindi: 'Prayaana',
      ),
      hindiCognateOrMeaning: 'प्रयाण (Prayaan - प्रस्थान)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In Hindi "prayaan" sounds literary, but in Kannada "prayaana" is standard for travel/journey on buses and announcements.',
      exampleUsage: TriScriptText(
        hindi: 'आपकी यात्रा शुभ हो।',
        devanagari: 'निम्म प्रयाण शुभवागली।',
        romanHindi: 'Nimma prayaana shubhavaagali.',
      ),
    ),
    RootConnection(
      id: 'rb_18',
      rootOrWord: 'अवकाश (Avakasha)',
      kannadaForm: TriScriptText(
        hindi: 'मौका / छुट्टी / जगह',
        devanagari: 'अवकाश',
        romanHindi: 'Avakaasha',
      ),
      hindiCognateOrMeaning: 'अवकाश (Avakaash - छुट्टी/अवसर)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Shared Sanskrit Tatsama meaning opportunity, space, or leave/holiday.',
      exampleUsage: TriScriptText(
        hindi: 'कल छुट्टी है।',
        devanagari: 'नाळे अवकाश इदे।',
        romanHindi: 'Naale avakaasha ide.',
      ),
    ),
    RootConnection(
      id: 'rb_19',
      rootOrWord: 'विचार (Vichara)',
      kannadaForm: TriScriptText(
        hindi: 'बात / विषय / विचार',
        devanagari: 'विचार',
        romanHindi: 'Vichaara',
      ),
      hindiCognateOrMeaning: 'विचार (Vichaar)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In spoken Kannada, "vichaara" often means "matter" or "topic" in addition to "thought".',
      exampleUsage: TriScriptText(
        hindi: 'यह अच्छी बात है।',
        devanagari: 'इदु ओळ्ळे विचार।',
        romanHindi: 'Idu olle vichaara.',
      ),
    ),
    RootConnection(
      id: 'rb_20',
      rootOrWord: 'विशेष (Vishesha)',
      kannadaForm: TriScriptText(
        hindi: 'ख़ास / विशेष',
        devanagari: 'विशेष',
        romanHindi: 'Vishesha',
      ),
      hindiCognateOrMeaning: 'विशेष (Vishesh)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Commonly heard in casual Kannada greetings: "En vishesha?" ("What\'s special / What\'s new?").',
      exampleUsage: TriScriptText(
        hindi: 'आज क्या ख़ास है?',
        devanagari: 'इवत्तु एनु विशेष?',
        romanHindi: 'Ivattu enu vishesha?',
      ),
    ),
    RootConnection(
      id: 'rb_21',
      rootOrWord: 'निश्चय (Nishchaya)',
      kannadaForm: TriScriptText(
        hindi: 'पक्का / तय',
        devanagari: 'निश्चय',
        romanHindi: 'Nishchaya',
      ),
      hindiCognateOrMeaning: 'निश्चय (Nishchay)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Direct Sanskrit Tatsama used for certainty and firm decisions.',
      exampleUsage: TriScriptText(
        hindi: 'हाँ, यह पक्का है।',
        devanagari: 'हौदु, इदु निश्चय।',
        romanHindi: 'Haudu, idu nishchaya.',
      ),
    ),
    RootConnection(
      id: 'rb_22',
      rootOrWord: 'कारण (Karana)',
      kannadaForm: TriScriptText(
        hindi: 'वजह / कारण',
        devanagari: 'कारण',
        romanHindi: 'Kaarana',
      ),
      hindiCognateOrMeaning: 'कारण (Kaaran)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Identical Sanskrit Tatsama meaning reason or cause.',
      exampleUsage: TriScriptText(
        hindi: 'इसका क्या कारण है?',
        devanagari: 'इदक्के एनु कारण?',
        romanHindi: 'Idakke enu kaarana?',
      ),
    ),
    RootConnection(
      id: 'rb_23',
      rootOrWord: 'उपाय (Upaya)',
      kannadaForm: TriScriptText(
        hindi: 'तरीका / उपाय',
        devanagari: 'उपाय',
        romanHindi: 'Upaaya',
      ),
      hindiCognateOrMeaning: 'उपाय (Upaay)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Shared Sanskrit word for solution, trick, or method.',
      exampleUsage: TriScriptText(
        hindi: 'एक अच्छा उपाय है।',
        devanagari: 'ओंदु ओळ्ळे उपाय इदे।',
        romanHindi: 'Ondu olle upaaya ide.',
      ),
    ),
    RootConnection(
      id: 'rb_24',
      rootOrWord: 'अनुमान (Anumana)',
      kannadaForm: TriScriptText(
        hindi: 'शक / अंदाज़ा',
        devanagari: 'अनुमान',
        romanHindi: 'Anumaana',
      ),
      hindiCognateOrMeaning: 'अनुमान (Anumaan - अंदाज़ा)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Important nuance: while Hindi "anumaan" means estimate/guess, spoken Kannada "anumaana" more often means "doubt" or "suspicion".',
      exampleUsage: TriScriptText(
        hindi: 'कोई शक नहीं है।',
        devanagari: 'यावुदे अनुमान इल्ला।',
        romanHindi: 'Yaavude anumaana illa.',
      ),
    ),
    RootConnection(
      id: 'rb_25',
      rootOrWord: 'स्वतंत्र (Swatantra)',
      kannadaForm: TriScriptText(
        hindi: 'आज़ाद / स्वतंत्र',
        devanagari: 'स्वतंत्र',
        romanHindi: 'Swatantra',
      ),
      hindiCognateOrMeaning: 'स्वतंत्र (Swatantr)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Direct Sanskrit Tatsama used identically in civic and everyday contexts.',
      exampleUsage: TriScriptText(
        hindi: 'आप स्वतंत्र हैं।',
        devanagari: 'नीवु स्वतंत्ररागिद्दीरा।',
        romanHindi: 'Neevu swatantraraagiddeera.',
      ),
    ),
    RootConnection(
      id: 'rb_26',
      rootOrWord: 'बैल / बलीवर्द → एत्तु',
      kannadaForm: TriScriptText(
        hindi: 'ताक़त / शक्ति',
        devanagari: 'शक्ति',
        romanHindi: 'Shakti',
      ),
      hindiCognateOrMeaning: 'शक्ति (Shakti)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Sanskrit Tatsama "Shakti" is used daily in Kannada for strength, energy, and power.',
      exampleUsage: TriScriptText(
        hindi: 'आज शरीर में ताक़त नहीं है।',
        devanagari: 'इवत्तु देहदल्लि शक्ति इल्ला।',
        romanHindi: 'Ivattu dehadalli shakti illa.',
      ),
    ),
    RootConnection(
      id: 'rb_27',
      rootOrWord: 'देह (Deha)',
      kannadaForm: TriScriptText(
        hindi: 'शरीर / बदन',
        devanagari: 'देह',
        romanHindi: 'Deha',
      ),
      hindiCognateOrMeaning: 'देह (Deh)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Sanskrit Tatsama for body, common in health conversations in Kannada.',
      exampleUsage: TriScriptText(
        hindi: 'मेरा शरीर दर्द कर रहा है।',
        devanagari: 'नन्न देह नोवुत्तिदे।',
        romanHindi: 'Nanna deha novuttide.',
      ),
    ),
    RootConnection(
      id: 'rb_28',
      rootOrWord: 'आरोग्य (Arogya)',
      kannadaForm: TriScriptText(
        hindi: 'सेहत / तंदुरुस्ती',
        devanagari: 'आरोग्य',
        romanHindi: 'Aarogya',
      ),
      hindiCognateOrMeaning: 'आरोग्य (Aarogya - स्वास्थ्य)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In Kannada, "aarogya" is the everyday word for health (used far more often than "swasthya").',
      exampleUsage: TriScriptText(
        hindi: 'अपनी सेहत का ध्यान रखें।',
        devanagari: 'निम्म आरोग्य नोडकोळी।',
        romanHindi: 'Nimma aarogya nodkoli.',
      ),
    ),
    RootConnection(
      id: 'rb_29',
      rootOrWord: 'औषध (Aushadha)',
      kannadaForm: TriScriptText(
        hindi: 'दवाई / औषधि',
        devanagari: 'औषध / औषधि',
        romanHindi: 'Aushadha',
      ),
      hindiCognateOrMeaning: 'औषधि (Aushadhi)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Shared Sanskrit term for medicine; spoken Kannada also commonly uses "maatre" (tablet) alongside "aushadha".',
      exampleUsage: TriScriptText(
        hindi: 'दवाई समय पर लीजिए।',
        devanagari: 'समयक्के औषध तगोळी।',
        romanHindi: 'Samayakke aushadha tagoli.',
      ),
    ),
    RootConnection(
      id: 'rb_30',
      rootOrWord: 'वातावरण (Vatavarana)',
      kannadaForm: TriScriptText(
        hindi: 'मौसम / माहौल',
        devanagari: 'वातावरण',
        romanHindi: 'Vaataavarana',
      ),
      hindiCognateOrMeaning: 'वातावरण (Vaataavaran)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Used in Bengaluru daily small talk for both weather and office/home atmosphere.',
      exampleUsage: TriScriptText(
        hindi: 'आज मौसम बहुत अच्छा है।',
        devanagari: 'इवत्तु वातावरण तुंबा चनागिदे।',
        romanHindi: 'Ivattu vaataavarana tumba channagide.',
      ),
    ),
    RootConnection(
      id: 'rb_31',
      rootOrWord: 'चा / चाय (Chaa)',
      kannadaForm: TriScriptText(
        hindi: 'चाय',
        devanagari: 'चा',
        romanHindi: 'Chaa',
      ),
      hindiCognateOrMeaning: 'चाय (Chai)',
      connectionType: ConnectionType.directCognate,
      linguisticExplanation:
          'Shared pan-Indian loanword from Chinese "cha", pronounced "chaa" in casual Kannada tea stalls.',
      exampleUsage: TriScriptText(
        hindi: 'एक चाय दीजिए।',
        devanagari: 'ओंदु चा कोडी।',
        romanHindi: 'Ondu chaa kodi.',
      ),
    ),
    RootConnection(
      id: 'rb_32',
      rootOrWord: 'रस (Rasa)',
      kannadaForm: TriScriptText(
        hindi: 'जूस / रस / रसम',
        devanagari: 'रस',
        romanHindi: 'Rasa',
      ),
      hindiCognateOrMeaning: 'रस (Ras)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Sanskrit Tatsama meaning juice or essence; also gives us South Indian "rasam" (tamarind-pepper soup).',
      exampleUsage: TriScriptText(
        hindi: 'थोड़ा रसम दीजिए।',
        devanagari: 'स्वल्प रसम कोडी।',
        romanHindi: 'Swalpa rasam kodi.',
      ),
    ),
    RootConnection(
      id: 'rb_33',
      rootOrWord: 'अन्न (Anna)',
      kannadaForm: TriScriptText(
        hindi: 'पका हुआ चावल / भोजन',
        devanagari: 'अन्ना',
        romanHindi: 'Anna',
      ),
      hindiCognateOrMeaning: 'अन्न (Ann - अनाज)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'From Sanskrit "anna" (food/grain). In Hindi it means grain in general; in Kannada it specifically means cooked rice.',
      exampleUsage: TriScriptText(
        hindi: 'थोड़ा चावल दीजिए।',
        devanagari: 'स्वल्प अन्ना कोडी।',
        romanHindi: 'Swalpa anna kodi.',
      ),
    ),
    RootConnection(
      id: 'rb_34',
      rootOrWord: 'उद्योग (Udyoga)',
      kannadaForm: TriScriptText(
        hindi: 'नौकरी / काम / उद्योग',
        devanagari: 'उद्योग',
        romanHindi: 'Udyoga',
      ),
      hindiCognateOrMeaning: 'उद्योग (Udyog)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In Hindi "udyog" means industry, whereas in Kannada "udyoga" commonly means job or employment.',
      exampleUsage: TriScriptText(
        hindi: 'मेरी नौकरी बेंगलुरु में है।',
        devanagari: 'नन्न उद्योग बेंगळूरुअल्लि इदे।',
        romanHindi: 'Nanna udyoga Bengalooru-alli ide.',
      ),
    ),
    RootConnection(
      id: 'rb_35',
      rootOrWord: 'अभ्यास (Abhyasa)',
      kannadaForm: TriScriptText(
        hindi: 'अभ्यास / आदत',
        devanagari: 'अभ्यास',
        romanHindi: 'Abhyaasa',
      ),
      hindiCognateOrMeaning: 'अभ्यास (Abhyaas - प्रैक्टिस)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In Kannada, "abhyaasa" means both "practice" and "habit" (e.g., "Coffee kudiyodu abhyaasa").',
      exampleUsage: TriScriptText(
        hindi: 'रोज़ अभ्यास कीजिए।',
        devanagari: 'दिनालू अभ्यास माडी।',
        romanHindi: 'Dinaaloo abhyaasa maadi.',
      ),
    ),
    RootConnection(
      id: 'rb_36',
      rootOrWord: 'संतोष (Santosha)',
      kannadaForm: TriScriptText(
        hindi: 'खुशी / संतोष',
        devanagari: 'संतोष',
        romanHindi: 'Santosha',
      ),
      hindiCognateOrMeaning: 'संतोष (Santosh)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'In Kannada, "santosha" is the everyday word for "happy/glad" (not just contentment as in Hindi).',
      exampleUsage: TriScriptText(
        hindi: 'आपसे मिलकर खुशी हुई।',
        devanagari: 'निम्मन्नु भेटियागि तुंबा संतोष आइटु।',
        romanHindi: 'Nimmannu bhetiyaagi tumba santosha aaytu.',
      ),
    ),
    RootConnection(
      id: 'rb_37',
      rootOrWord: 'परवागिल्ला / परवाह (Parva)',
      kannadaForm: TriScriptText(
        hindi: 'कोई बात नहीं / ठीक है',
        devanagari: 'परवागिल्ला',
        romanHindi: 'Paravaagilla',
      ),
      hindiCognateOrMeaning: 'परवाह नहीं (No worries)',
      connectionType: ConnectionType.directCognate,
      linguisticExplanation:
          'Combines the Perso-Arabic loanword "parva" (common in Hindi) with Kannada "-aagi illa" (is not). Literally "there is no worry" = "No problem".',
      exampleUsage: TriScriptText(
        hindi: 'कोई बात नहीं, सब ठीक है।',
        devanagari: 'परवागिल्ला, एल्ला सरी इदे।',
        romanHindi: 'Paravaagilla, ella sari ide.',
      ),
    ),
    RootConnection(
      id: 'rb_38',
      rootOrWord: 'दिशा / दिक (Dikku)',
      kannadaForm: TriScriptText(
        hindi: 'दिशा / तरफ़',
        devanagari: 'दिक्कु',
        romanHindi: 'Dikku',
      ),
      hindiCognateOrMeaning: 'दिशा / दिक् (Direction)',
      connectionType: ConnectionType.sanskritDerived,
      linguisticExplanation:
          'Derived from Sanskrit "dik" (direction), doubled with "-ku" in Kannada phonology.',
      exampleUsage: TriScriptText(
        hindi: 'किस दिशा में जाना है?',
        devanagari: 'याव दिक्कल्लि होगबेकु?',
        romanHindi: 'Yaava dikkalli hogbeku?',
      ),
    ),
    RootConnection(
      id: 'rb_39',
      rootOrWord: 'वस्तु (Vastu)',
      kannadaForm: TriScriptText(
        hindi: 'चीज़ / सामान',
        devanagari: 'वस्तु',
        romanHindi: 'Vastu',
      ),
      hindiCognateOrMeaning: 'वस्तु (Vastu - चीज़)',
      connectionType: ConnectionType.tatsama,
      linguisticExplanation:
          'Direct Sanskrit Tatsama used for physical items, groceries, or belongings.',
      exampleUsage: TriScriptText(
        hindi: 'यहाँ अच्छी चीज़ें मिलती हैं।',
        devanagari: 'इल्लि ओळ्ळे वस्तुगळु सिगुत्तवे।',
        romanHindi: 'Illi olle vastugalu siguttave.',
      ),
    ),
    RootConnection(
      id: 'rb_40',
      rootOrWord: 'नमस्कार (Namaskara)',
      kannadaForm: TriScriptText(
        hindi: 'नमस्ते / नमस्कार',
        devanagari: 'नमस्कार',
        romanHindi: 'Namaskaara',
      ),
      hindiCognateOrMeaning: 'नमस्कार (Namaskaar)',
      connectionType: ConnectionType.broaderRelationship,
      linguisticExplanation:
          'Pan-Indian respectful greeting rooted in Sanskrit "namah" (bowing). Used identically in Karnataka across all social contexts.',
      exampleUsage: TriScriptText(
        hindi: 'नमस्ते, कैसे हैं आप?',
        devanagari: 'नमस्कार, हेगिद्दीरा?',
        romanHindi: 'Namaskaara, hegiddeera?',
      ),
    ),
  ];
}
