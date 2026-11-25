import '../models/reading_mode.dart';
import '../models/real_space.dart';

/// Spaces 5 to 8 (20 complete scenarios).
const List<RealSpace> realSpacesPart2 = [
  // 5. Home & Neighbourhood
  RealSpace(
    id: 'space_home',
    order: 5,
    title: 'Home & Neighbourhood',
    hindiSubtitle: 'घर, पड़ोसी और सोसाइटी',
    description:
        'Talk with domestic help, delivery partners, watchmen, and neighbours with warmth and clarity.',
    badgeLabel: 'Home & Doorstep',
    layoutStyle: SpaceLayoutStyle.neighbourhoodDoor,
    scenarios: [
      Scenario(
        id: 'home_01',
        spaceId: 'space_home',
        title: 'Delivery & Apartment Gate',
        hindiTitle: 'डिलीवरी और अपार्टमेंट गेट पर बात',
        situationalContext: 'Receiving a food or parcel delivery at your apartment.',
        learningObjective: 'Direct the delivery partner to leave the parcel or come up.',
        phrases: [
          PhraseItem(
            id: 'hm_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सिक्योरिटी के पास रख दीजिए।',
              devanagari: 'सिक्योरिटी हत्तिरा इडी।',
              romanHindi: 'Security hattira idi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'रख दीजिए', devanagari: 'इडी', romanHindi: 'Idi'),
                roleNote: 'Put / keep (polite imperative).',
              ),
            ],
          ),
          PhraseItem(
            id: 'hm_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मैं पाँच मिनट में नीचे आ रहा हूँ।',
              devanagari: 'नानु ऐदु निमिषदल्लि केळगे बर्तीनि।',
              romanHindi: 'Naanu aidu nimishadalli kelage barteeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'नीचे', devanagari: 'केळगे', romanHindi: 'Kelage'),
                roleNote: 'Down / downstairs (Up = Mele).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hm_01_v1',
            text: TriScriptText(hindi: 'ऊपर', devanagari: 'मेले', romanHindi: 'Mele'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'hm_01_v2',
            text: TriScriptText(hindi: 'दरवाज़ा', devanagari: 'बागिलु', romanHindi: 'Baagilu'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Security hattira idi" is one of the most useful phrases in apartment living.',
        ],
      ),
      Scenario(
        id: 'home_02',
        spaceId: 'space_home',
        title: 'Talking with Domestic Help / Cook',
        hindiTitle: 'घरेलू सहायक / रसोइए से बात',
        situationalContext: 'Coordinating cleaning, cooking, and timings at home.',
        learningObjective: 'Give polite daily instructions and confirm arrival time.',
        phrases: [
          PhraseItem(
            id: 'hm_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कल सुबह आठ बजे आइए।',
              devanagari: 'नाळे बेळिग्गे एंटु गंटेगे बन्नी।',
              romanHindi: 'Naale beligge entu gantege banni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'सुबह', devanagari: 'बेळिग्गे', romanHindi: 'Beligge'),
                roleNote: 'Morning.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hm_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आज सफ़ाई अच्छे से कीजिए।',
              devanagari: 'इवत्तु क्लीन सरियागि माडी।',
              romanHindi: 'Ivattu clean sariyaagi maadi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'अच्छे से', devanagari: 'सरियागि', romanHindi: 'Sariyaagi'),
                roleNote: 'Properly / neatly.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hm_02_v1',
            text: TriScriptText(hindi: 'शाम', devanagari: 'संजे', romanHindi: 'Sanje'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hm_02_v2',
            text: TriScriptText(hindi: 'कपड़े', devanagari: 'बट्टे', romanHindi: 'Batte'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Always use "Banni" (आइए) rather than "Baa" (आ) to maintain respectful warmth.',
        ],
      ),
      Scenario(
        id: 'home_03',
        spaceId: 'space_home',
        title: 'Plumber, Electrician & Maintenance',
        hindiTitle: 'नल, बिजली और मरम्मत की बात',
        situationalContext: 'Explaining a leaking tap or power issue to the society technician.',
        learningObjective: 'Point out what is broken and ask when it will be fixed.',
        phrases: [
          PhraseItem(
            id: 'hm_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यहाँ पानी टपक रहा है।',
              devanagari: 'इल्लि नीरु सोर्ता इदे।',
              romanHindi: 'Illi neeru sorta ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'टपक रहा है', devanagari: 'सोर्ता इदे', romanHindi: 'Sorta ide'),
                roleNote: 'Leaking / dripping.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hm_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कृपया इसे जल्दी ठीक कर दीजिए।',
              devanagari: 'दयविट्टु इदन्नु बेग सरी माडी।',
              romanHindi: 'Dayavittu idannu bega sari maadi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ठीक कर दीजिए', devanagari: 'सरी माडी', romanHindi: 'Sari maadi'),
                roleNote: 'Fix / repair.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hm_03_v1',
            text: TriScriptText(hindi: 'बिजली / लाइट', devanagari: 'करेंट', romanHindi: 'Current'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hm_03_v2',
            text: TriScriptText(hindi: 'नल', devanagari: 'नल्ली', romanHindi: 'Nalli'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Current illa" is the universal phrase for a power cut across Karnataka.',
        ],
      ),
      Scenario(
        id: 'home_04',
        spaceId: 'space_home',
        title: 'Meeting Neighbours',
        hindiTitle: 'पड़ोसियों से परिचय और बात',
        situationalContext: 'Chatting briefly with your neighbour in the elevator or corridor.',
        learningObjective: 'Introduce yourself and ask about their family.',
        phrases: [
          PhraseItem(
            id: 'hm_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मेरा नाम राहुल है, मैं बगल वाले घर में रहता हूँ।',
              devanagari: 'नन्न हेसरु राहुल, नानु पक्कदा मनेयल्लि इद्देनी।',
              romanHindi: 'Nanna hesaru Rahul, naanu pakkada maneyalli iddeeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'बगल वाला', devanagari: 'पक्कदा', romanHindi: 'Pakkada'),
                roleNote: 'Next-door / beside.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hm_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'घर में सब लोग कैसे हैं?',
              devanagari: 'मनेयल्लि एल्लारू हेगिद्दारे?',
              romanHindi: 'Maneyalli ellaaru hegiddeere?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'सब लोग', devanagari: 'एल्लारू', romanHindi: 'Ellaaru'),
                roleNote: 'Everyone.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hm_04_v1',
            text: TriScriptText(hindi: 'नाम', devanagari: 'हेसरु', romanHindi: 'Hesaru'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hm_04_v2',
            text: TriScriptText(hindi: 'घर', devanagari: 'मने', romanHindi: 'Mane'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Remember: "Mane" (मने) is house/home, while "Maneyalli" means "at home".',
        ],
      ),
      Scenario(
        id: 'home_05',
        spaceId: 'space_home',
        title: 'House Hunting & Landlord Talk',
        hindiTitle: 'किराए के घर और मकान मालिक से बात',
        situationalContext: 'Asking about rent, water supply, and parking when viewing a flat.',
        learningObjective: 'Ask about monthly rent and basic facilities.',
        phrases: [
          PhraseItem(
            id: 'hm_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'महीने का किराया कितना है?',
              devanagari: 'तिंगळ बाडिगे एष्टु?',
              romanHindi: 'Tingala baadige eshtu?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'महीने का', devanagari: 'तिंगळ', romanHindi: 'Tingala'),
                roleNote: 'Monthly.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hm_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'पानी की कोई समस्या तो नहीं है?',
              devanagari: 'नीरिन समस्ये एनु इल्ला अल्वा?',
              romanHindi: 'Neerina samasye enu illa alva?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'है ना? / सही है ना?', devanagari: 'अल्वा?', romanHindi: 'Alva?'),
                roleNote: 'Tag question seeking confirmation.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hm_05_v1',
            text: TriScriptText(hindi: 'चाबी', devanagari: 'की', romanHindi: 'Key'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hm_05_v2',
            text: TriScriptText(hindi: 'महीना', devanagari: 'तिंगळु', romanHindi: 'Tingalu'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Ending a sentence with "Alva?" (है ना?) sounds super natural in Bengaluru Kannada.',
        ],
      ),
    ],
  ),

  // 6. Healthcare & Emergencies
  RealSpace(
    id: 'space_health',
    order: 6,
    title: 'Healthcare & Emergencies',
    hindiSubtitle: 'अस्पताल, दवाई और आपातकाल',
    description:
        'Describe symptoms clearly, buy medicines at a pharmacy, and ask for urgent assistance.',
    badgeLabel: 'Care & Urgent',
    layoutStyle: SpaceLayoutStyle.clinicTriage,
    scenarios: [
      Scenario(
        id: 'health_01',
        spaceId: 'space_health',
        title: 'Describing Fever & Pain to a Doctor',
        hindiTitle: 'डॉक्टर को बुखार और दर्द बताना',
        situationalContext: 'At a neighbourhood clinic explaining your symptoms.',
        learningObjective: 'State pain, fever, and duration clearly.',
        phrases: [
          PhraseItem(
            id: 'hl_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कल से बुखार है।',
              devanagari: 'निन्नेइंद ज्वर इदे।',
              romanHindi: 'Ninneyinda jwara ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कल से', devanagari: 'निन्नेइंद', romanHindi: 'Ninneyinda'),
                roleNote: 'Ninne (yesterday) + inda (from/since).',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'बुखार', devanagari: 'ज्वर', romanHindi: 'Jwara'),
                roleNote: 'Sanskrit Tatsama for fever.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hl_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मेरा सिर दर्द कर रहा है।',
              devanagari: 'ननगे तले नोवु इदे।',
              romanHindi: 'Nanage tale novu ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'सिर', devanagari: 'तले', romanHindi: 'Tale'),
                roleNote: 'Head.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'दर्द', devanagari: 'नोवु', romanHindi: 'Novu'),
                roleNote: 'Pain / ache.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hl_01_v1',
            text: TriScriptText(hindi: 'पेट दर्द', devanagari: 'होट्टे नोवु', romanHindi: 'Hotte novu'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hl_01_v2',
            text: TriScriptText(hindi: 'खांसी', devanagari: 'केम्मु', romanHindi: 'Kemmu'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Combine any body part with "novu" (दर्द): "Tale novu" (headache), "Hotte novu" (stomach ache).',
        ],
      ),
      Scenario(
        id: 'health_02',
        spaceId: 'space_health',
        title: 'At the Pharmacy / Medical Store',
        hindiTitle: 'मेडिकल स्टोर पर दवाई लेना',
        situationalContext: 'Showing a prescription and asking how to take the tablets.',
        learningObjective: 'Ask dosage timing (before/after food).',
        phrases: [
          PhraseItem(
            id: 'hl_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'यह गोली खाने के बाद लेनी है क्या?',
              devanagari: 'ई मात्रे ऊटा आद मेले तगोंडबेका?',
              romanHindi: 'Ee maatre oota aada mele tagondbeka?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'गोली', devanagari: 'मात्रे', romanHindi: 'Maatre'),
                roleNote: 'Tablet / pill.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'खाने के बाद', devanagari: 'ऊटा आद मेले', romanHindi: 'Oota aada mele'),
                roleNote: 'After meal.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hl_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'दवाई का पर्चा यहाँ है।',
              devanagari: 'औषध चिट्टी इल्लि इदे।',
              romanHindi: 'Aushadha chitti illi ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'पर्चा / पर्ची', devanagari: 'चिट्टी', romanHindi: 'Chitti'),
                roleNote: 'Prescription slip.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hl_02_v1',
            text: TriScriptText(hindi: 'दवाई', devanagari: 'औषध', romanHindi: 'Aushadha'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hl_02_v2',
            text: TriScriptText(hindi: 'पहले', devanagari: 'मुंचे', romanHindi: 'Munche'),
            partOfSpeech: 'Adverb',
          ),
        ],
        usageTips: [
          'Remember: "Oota aada mele" (after food) vs "Ootakke munche" (before food).',
        ],
      ),
      Scenario(
        id: 'health_03',
        spaceId: 'space_health',
        title: 'Urgent Help & Nearest Hospital',
        hindiTitle: 'तुरंत मदद और नज़दीकी अस्पताल',
        situationalContext: 'Someone feels dizzy or injured and you need immediate directions.',
        learningObjective: 'Call for urgent help and locate the nearest clinic.',
        phrases: [
          PhraseItem(
            id: 'hl_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कृपया जल्दी मदद कीजिए!',
              devanagari: 'दयविट्टु बेग सहाय माडी!',
              romanHindi: 'Dayavittu bega sahaaya maadi!',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'जल्दी', devanagari: 'बेग', romanHindi: 'Bega'),
                roleNote: 'Quickly / urgently.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hl_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'पास में अस्पताल कहाँ है?',
              devanagari: 'हत्तिरादल्लि आस्पत्रे एल्लि इदे?',
              romanHindi: 'Hattiradalli aaspatre elli ide?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'नज़दीक में', devanagari: 'हत्तिरादल्लि', romanHindi: 'Hattiradalli'),
                roleNote: 'Nearby.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hl_03_v1',
            text: TriScriptText(hindi: 'अस्पताल', devanagari: 'आस्पत्रे', romanHindi: 'Aaspatre'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hl_03_v2',
            text: TriScriptText(hindi: 'एम्बुलेंस बुलाइए', devanagari: 'एम्बुलेंस करीसी', romanHindi: 'Ambulance karisi'),
            partOfSpeech: 'Phrase',
          ),
        ],
        usageTips: [
          '108 is the free emergency ambulance number across Karnataka.',
        ],
      ),
      Scenario(
        id: 'health_04',
        spaceId: 'space_health',
        title: 'Booking a Clinic Appointment',
        hindiTitle: 'क्लिनिक में अपॉइंटमेंट और इंतज़ार',
        situationalContext: 'Checking with the clinic receptionist when the doctor will see you.',
        learningObjective: 'Ask about waiting time and doctor availability.',
        phrases: [
          PhraseItem(
            id: 'hl_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'डॉक्टर अभी हैं क्या?',
              devanagari: 'डॉक्टर ईग इद्दारा?',
              romanHindi: 'Doctor eega iddara?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'क्या वे हैं?', devanagari: 'इद्दारा?', romanHindi: 'Iddara?'),
                roleNote: 'Respectful presence question for people.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hl_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कितनी देर इंतज़ार करना होगा?',
              devanagari: 'एष्टु होत्तु वेट माडबेकु?',
              romanHindi: 'Eshtu hottu wait maadbeku?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कितनी देर', devanagari: 'एष्टु होत्तु', romanHindi: 'Eshtu hottu'),
                roleNote: 'How long.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hl_04_v1',
            text: TriScriptText(hindi: 'तबीयत', devanagari: 'आरोग्य', romanHindi: 'Aarogya'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'hl_04_v2',
            text: TriScriptText(hindi: 'रिपोर्ट', devanagari: 'रिपोर्ट', romanHindi: 'Report'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Use "Iddara?" for people (doctors, managers) and "Idiya?" for objects/places.',
        ],
      ),
      Scenario(
        id: 'health_05',
        spaceId: 'space_health',
        title: 'Allergies & Food Safety',
        hindiTitle: 'एलर्जी और स्वास्थ्य सावधानी',
        situationalContext: 'Informing a nurse or host about an allergy or dietary restriction.',
        learningObjective: 'State clearly what you cannot take.',
        phrases: [
          PhraseItem(
            id: 'hl_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मुझे इससे एलर्जी है।',
              devanagari: 'ननगे इदर एलर्जी इदे।',
              romanHindi: 'Nanage idara allergy ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'इसकी', devanagari: 'इदर', romanHindi: 'Idara'),
                roleNote: 'Of this.',
              ),
            ],
          ),
          PhraseItem(
            id: 'hl_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'ठंडा पानी मत दीजिए, गरम पानी दीजिए।',
              devanagari: 'तण्णने नीरु बेडा, बिसी नीरु कोडी।',
              romanHindi: 'Tannane neeru beda, bisi neeru kodi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ठंडा', devanagari: 'तण्णने', romanHindi: 'Tannane'),
                roleNote: 'Cold (opposite of bisi).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'hl_05_v1',
            text: TriScriptText(hindi: 'ठंडा', devanagari: 'तण्णगे', romanHindi: 'Tannage'),
            partOfSpeech: 'Adjective',
          ),
          VocabItem(
            id: 'hl_05_v2',
            text: TriScriptText(hindi: 'आराम', devanagari: 'विश्रांति', romanHindi: 'Vishraanti'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Bisi neeru" (गरम पानी) is easy to get at any restaurant or clinic.',
        ],
      ),
    ],
  ),

  // 7. Social Conversations
  RealSpace(
    id: 'space_social',
    order: 7,
    title: 'Social Conversations',
    hindiSubtitle: 'दोस्ती, परिचय और बातचीत',
    description:
        'Break the ice, share where you are from, compliment food or weather, and build genuine connections.',
    badgeLabel: 'Social & Warmth',
    layoutStyle: SpaceLayoutStyle.socialCircle,
    scenarios: [
      Scenario(
        id: 'social_01',
        spaceId: 'space_social',
        title: 'Introducing Yourself Warmly',
        hindiTitle: 'अपना परिचय देना',
        situationalContext: 'Meeting new friends or a friend\'s family in Bengaluru or Mysuru.',
        learningObjective: 'Share your name, hometown, and how long you\'ve lived in Karnataka.',
        phrases: [
          PhraseItem(
            id: 'sc_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मैं दिल्ली से हूँ, अभी बेंगलुरु में रहता हूँ।',
              devanagari: 'नानु दिल्लीइंद बंदिद्दीनि, ईग बेंगळूरुअल्लि इद्देनी।',
              romanHindi: 'Naanu Delhi-inda bandiddeeni, eega Bengalooru-alli iddeeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'से आया हूँ', devanagari: 'इंद बंदिद्दीनि', romanHindi: 'Inda bandiddeeni'),
                roleNote: 'From [City] + have come.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sc_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आपसे मिलकर बहुत खुशी हुई।',
              devanagari: 'निम्मन्नु भेटियागि तुंबा संतोष आइटु।',
              romanHindi: 'Nimmannu bhetiyaagi tumba santosha aaytu.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'मिलकर', devanagari: 'भेटियागि', romanHindi: 'Bhetiyaagi'),
                roleNote: 'Having met (from Sanskrit bheti).',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sc_01_v1',
            text: TriScriptText(hindi: 'गाँव / शहर', devanagari: 'ऊरु', romanHindi: 'Ooru'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sc_01_v2',
            text: TriScriptText(hindi: 'परिवार', devanagari: 'कुटुंब', romanHindi: 'Kutumba'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'Ask someone "Nimma ooru yaavudu?" (आपका शहर कौनसा है?) to spark instant conversation.',
        ],
      ),
      Scenario(
        id: 'social_02',
        spaceId: 'space_social',
        title: 'Talking About Weather & City Life',
        hindiTitle: 'मौसम और शहर की बातें',
        situationalContext: 'Casual chat during a walk or over evening tea.',
        learningObjective: 'Comment on Bengaluru weather and traffic.',
        phrases: [
          PhraseItem(
            id: 'sc_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आज मौसम बहुत सुहावना है।',
              devanagari: 'इवत्तु वातावरण तुंबा चनागिदे।',
              romanHindi: 'Ivattu vaataavarana tumba channagide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'बहुत अच्छा है', devanagari: 'तुंबा चनागिदे', romanHindi: 'Tumba channagide'),
                roleNote: 'Universal positive expression.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sc_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आज ट्रैफ़िक बहुत ज़्यादा है।',
              devanagari: 'इवत्तु ट्रैफ़िक तुंबा जास्ती इदे।',
              romanHindi: 'Ivattu traffic tumba jaasti ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'बहुत ज़्यादा', devanagari: 'तुंबा जास्ती', romanHindi: 'Tumba jaasti'),
                roleNote: 'Too much / very high.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sc_02_v1',
            text: TriScriptText(hindi: 'बारिश', devanagari: 'मळे', romanHindi: 'Male'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sc_02_v2',
            text: TriScriptText(hindi: 'धूप', devanagari: 'बिसिलु', romanHindi: 'Bisilu'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Male barta ide" means "It is raining"—handy during Bengaluru evenings!',
        ],
      ),
      Scenario(
        id: 'social_03',
        spaceId: 'space_social',
        title: 'Visiting Someone\'s Home',
        hindiTitle: 'किसी के घर मेहमान बनकर जाना',
        situationalContext: 'Being welcomed into a colleague\'s or friend\'s home.',
        learningObjective: 'Accept hospitality graciously and compliment the home.',
        phrases: [
          PhraseItem(
            id: 'sc_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'आपका घर बहुत सुंदर है।',
              devanagari: 'निम्म मने तुंबा सुंदरवागिदे।',
              romanHindi: 'Nimma mane tumba sundaravaagide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'सुंदर है', devanagari: 'सुंदरवागिदे', romanHindi: 'Sundaravaagide'),
                roleNote: 'Sundara (beautiful) + aagide (is).',
              ),
            ],
          ),
          PhraseItem(
            id: 'sc_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'सिर्फ़ थोड़ा सा काफी है, धन्यवाद।',
              devanagari: 'स्वल्प मात्र साकु, धन्यवादगळु।',
              romanHindi: 'Swalpa maatra saaku, dhanyavaadagalu.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'काफ़ी है / बस', devanagari: 'साकु', romanHindi: 'Saaku'),
                roleNote: 'Enough / sufficient.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sc_03_v1',
            text: TriScriptText(hindi: 'काफ़ी / बस', devanagari: 'साकु', romanHindi: 'Saaku'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'sc_03_v2',
            text: TriScriptText(hindi: 'आइए, बैठिए', devanagari: 'बन्नी, कूत्कोळी', romanHindi: 'Banni, kootkoli'),
            partOfSpeech: 'Phrase',
          ),
        ],
        usageTips: [
          'Saying "Saaku" (बस / काफी है) with a polite hand gesture prevents over-serving.',
        ],
      ),
      Scenario(
        id: 'social_04',
        spaceId: 'space_social',
        title: 'Weekend Plans & Hobbies',
        hindiTitle: 'वीकेंड के प्लान और शौक',
        situationalContext: 'Chatting about weekend trips or movies.',
        learningObjective: 'Ask "What are your plans?" and share yours.',
        phrases: [
          PhraseItem(
            id: 'sc_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इस वीकेंड आपका क्या प्लान है?',
              devanagari: 'ई वीकेंड निम्म प्लान एनु?',
              romanHindi: 'Ee weekend nimma plan enu?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'क्या है?', devanagari: 'एनु?', romanHindi: 'Enu?'),
                roleNote: 'What?',
              ),
            ],
          ),
          PhraseItem(
            id: 'sc_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'हम सब साथ में चलेंगे।',
              devanagari: 'नावु एल्लारू ओट्टिगे होगोण।',
              romanHindi: 'Naavu ellaaru ottige hogona.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'साथ में', devanagari: 'ओट्टिगे', romanHindi: 'Ottige'),
                roleNote: 'Together.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sc_04_v1',
            text: TriScriptText(hindi: 'फिल्म / सिनेमा', devanagari: 'सिनेमा', romanHindi: 'Cinema'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'sc_04_v2',
            text: TriScriptText(hindi: 'घूमना', devanagari: 'सुत्ताडोडु', romanHindi: 'Suttaadodu'),
            partOfSpeech: 'Verb',
          ),
        ],
        usageTips: [
          '"Ottige hogona" (साथ चलते हैं) is a warm way to invite friends.',
        ],
      ),
      Scenario(
        id: 'social_05',
        spaceId: 'space_social',
        title: 'Saying Goodbye & Staying in Touch',
        hindiTitle: 'अलविदा कहना और संपर्क रखना',
        situationalContext: 'Parting ways after a pleasant meetup.',
        learningObjective: 'Say "See you again" and "Take care" naturally.',
        phrases: [
          PhraseItem(
            id: 'sc_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'फिर मिलेंगे!',
              devanagari: 'मत्ते सिगोण!',
              romanHindi: 'Matte sigona!',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'फिर / दोबारा', devanagari: 'मत्ते', romanHindi: 'Matte'),
                roleNote: 'Again.',
              ),
            ],
          ),
          PhraseItem(
            id: 'sc_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'अपना ध्यान रखिए, घर पहुँचकर कॉल कीजिए।',
              devanagari: 'हुशारु, मनेगे होगि कॉल माडी।',
              romanHindi: 'Hushaaru, manege hogi call maadi.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ध्यान रखना', devanagari: 'हुशारु', romanHindi: 'Hushaaru'),
                roleNote: 'Take care / be careful.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'sc_05_v1',
            text: TriScriptText(hindi: 'अच्छा, चलता हूँ', devanagari: 'सरी, बर्तीनि', romanHindi: 'Sari, barteeni'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'sc_05_v2',
            text: TriScriptText(hindi: 'दोस्त', devanagari: 'स्नेहित', romanHindi: 'Snehita'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          'In Kannada culture, people say "Barteeni" (मैं आता हूँ / I\'ll come back) instead of "I\'m leaving"!',
        ],
      ),
    ],
  ),

  // 8. Everyday Problems & Survival
  RealSpace(
    id: 'space_problems',
    order: 8,
    title: 'Everyday Problems & Survival',
    hindiSubtitle: 'रोज़मर्रा की दिक्कतें और समाधान',
    description:
        'Handle language barriers, lost items, wrong orders, phone battery/network issues, and misunderstandings calmly.',
    badgeLabel: 'Problem Solver',
    layoutStyle: SpaceLayoutStyle.problemResolver,
    scenarios: [
      Scenario(
        id: 'prob_01',
        spaceId: 'space_problems',
        title: 'When You Don\'t Understand Fast Kannada',
        hindiTitle: 'तेज़ कन्नड़ समझ न आने पर',
        situationalContext: 'Someone speaks quickly and you need them to pause or simplify.',
        learningObjective: 'Politely ask to repeat slowly without feeling awkward.',
        phrases: [
          PhraseItem(
            id: 'pr_01_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'माफ़ कीजिए, मुझे ठीक से समझ नहीं आया।',
              devanagari: 'क्षमिसि, ननगे सरियागि अर्थ आगिल्ला।',
              romanHindi: 'Kshamisi, nanage sariyaagi artha aagilla.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'माफ़ कीजिए', devanagari: 'क्षमिसि', romanHindi: 'Kshamisi'),
                roleNote: 'Excuse me / sorry.',
              ),
              PhraseChunk(
                text: TriScriptText(hindi: 'समझ नहीं आया', devanagari: 'अर्थ आगिल्ला', romanHindi: 'Artha aagilla'),
                roleNote: 'Did not understand.',
              ),
            ],
          ),
          PhraseItem(
            id: 'pr_01_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'कृपया एक बार फिर धीरे बोलिए।',
              devanagari: 'दयविट्टु इन्नोम्मे निधानवागि हेळी।',
              romanHindi: 'Dayavittu innome nidhaanavaagi heli.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'एक बार फिर', devanagari: 'इन्नोम्मे', romanHindi: 'Innome'),
                roleNote: 'Once more.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'pr_01_v1',
            text: TriScriptText(hindi: 'धीरे', devanagari: 'निधानवागि', romanHindi: 'Nidhaanavaagi'),
            partOfSpeech: 'Adverb',
          ),
          VocabItem(
            id: 'pr_01_v2',
            text: TriScriptText(hindi: 'लिखकर दीजिए', devanagari: 'बरेदु कोडी', romanHindi: 'Baredu kodi'),
            partOfSpeech: 'Phrase',
          ),
        ],
        usageTips: [
          '"Kshamisi, nanage Kannada kalita iddeeni" (माफ़ कीजिए, मैं कन्नड़ सीख रहा हूँ) wins instant patience.',
        ],
      ),
      Scenario(
        id: 'prob_02',
        spaceId: 'space_problems',
        title: 'Wrong Order or Missing Item',
        hindiTitle: 'गलत ऑर्डर या छूटा हुआ सामान',
        situationalContext: 'Your parcel or food order has a missing item.',
        learningObjective: 'Point out what is missing politely.',
        phrases: [
          PhraseItem(
            id: 'pr_02_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मैंने यह ऑर्डर नहीं किया था।',
              devanagari: 'नानु इदन्नु ऑर्डर माडिरलिल्ला।',
              romanHindi: 'Naanu idannu order maadiralilla.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'नहीं किया था', devanagari: 'माडिरलिल्ला', romanHindi: 'Maadiralilla'),
                roleNote: 'Had not done.',
              ),
            ],
          ),
          PhraseItem(
            id: 'pr_02_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'इसमें एक चीज़ कम है।',
              devanagari: 'इदरल्लि ओंदु वस्तु कडिमे इदे।',
              romanHindi: 'Idaralli ondu vastu kadime ide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'कम है', devanagari: 'कडिमे इदे', romanHindi: 'Kadime ide'),
                roleNote: 'Is short / missing.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'pr_02_v1',
            text: TriScriptText(hindi: 'गलती', devanagari: 'तप्पु', romanHindi: 'Tappu'),
            partOfSpeech: 'Noun',
          ),
          VocabItem(
            id: 'pr_02_v2',
            text: TriScriptText(hindi: 'सही', devanagari: 'सरी', romanHindi: 'Sari'),
            partOfSpeech: 'Adjective',
          ),
        ],
        usageTips: [
          'Keep your tone calm—"Tappu aagide" (गलती हो गई है) states the issue without blame.',
        ],
      ),
      Scenario(
        id: 'prob_03',
        spaceId: 'space_problems',
        title: 'Phone Battery Dead & Asking for a Call',
        hindiTitle: 'फोन बंद होने पर मदद मांगना',
        situationalContext: 'Your phone died and you need to check directions or make an urgent call.',
        learningObjective: 'Ask for charging or a quick phone call.',
        phrases: [
          PhraseItem(
            id: 'pr_03_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मेरा फोन स्विच ऑफ हो गया है।',
              devanagari: 'नन्न फोन चार्ज इल्ला, ऑफ आइटु।',
              romanHindi: 'Nanna phone charge illa, off aaytu.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'ख़त्म हो गया', devanagari: 'ऑफ आइटु', romanHindi: 'Off aaytu'),
                roleNote: 'Turned off.',
              ),
            ],
          ),
          PhraseItem(
            id: 'pr_03_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'क्या मैं यहाँ से एक कॉल कर सकता हूँ?',
              devanagari: 'नानु इल्लिंद ओंदु कॉल माडबोदा?',
              romanHindi: 'Naanu illinda ondu call maadboda?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'यहाँ से', devanagari: 'इल्लिंद', romanHindi: 'Illinda'),
                roleNote: 'From here.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'pr_03_v1',
            text: TriScriptText(hindi: 'नेटवर्क नहीं है', devanagari: 'सिग्नल इल्ला', romanHindi: 'Signal illa'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'pr_03_v2',
            text: TriScriptText(hindi: 'चार्जर', devanagari: 'चार्जर', romanHindi: 'Charger'),
            partOfSpeech: 'Noun',
          ),
        ],
        usageTips: [
          '"Maadboda?" (कर सकता हूँ क्या?) is polite and clear for any small favour.',
        ],
      ),
      Scenario(
        id: 'prob_04',
        spaceId: 'space_problems',
        title: 'Lost Bag or Forgotten Item',
        hindiTitle: 'खोया हुआ बैग या सामान ढूँढना',
        situationalContext: 'You left your umbrella or bag at a shop or auto.',
        learningObjective: 'Ask if anyone saw your item.',
        phrases: [
          PhraseItem(
            id: 'pr_04_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मेरा बैग यहीं छूट गया है।',
              devanagari: 'नन्न बैग इल्ले बिट्टु होगिदे।',
              romanHindi: 'Nanna bag ille bittu hogide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'छूट गया है', devanagari: 'बिट्टु होगिदे', romanHindi: 'Bittu hogide'),
                roleNote: 'Left behind.',
              ),
            ],
          ),
          PhraseItem(
            id: 'pr_04_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'क्या आपने देखा है?',
              devanagari: 'नीवु नोडिद्दीरा?',
              romanHindi: 'Neevu nodiddeera?',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'देखा है क्या?', devanagari: 'नोडिद्दीरा?', romanHindi: 'Nodiddeera?'),
                roleNote: 'Have you seen?',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'pr_04_v1',
            text: TriScriptText(hindi: 'खो गया', devanagari: 'कळेदु होगितु', romanHindi: 'Kaledu hogitu'),
            partOfSpeech: 'Verb',
          ),
          VocabItem(
            id: 'pr_04_v2',
            text: TriScriptText(hindi: 'मिला', devanagari: 'सिक्कितु', romanHindi: 'Sikkitu'),
            partOfSpeech: 'Verb',
          ),
        ],
        usageTips: [
          '"Sikkitu!" means "Found it!"—useful when confirming you got your item back.',
        ],
      ),
      Scenario(
        id: 'prob_05',
        spaceId: 'space_problems',
        title: 'Resolving a Billing Confusion',
        hindiTitle: 'बिल या पेमेंट की उलझन सुलझाना',
        situationalContext: 'A UPI payment shows pending or the bill total looks different.',
        learningObjective: 'Stay calm and verify payment status.',
        phrases: [
          PhraseItem(
            id: 'pr_05_p1',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'मेरे खाते से पैसे कट गए हैं।',
              devanagari: 'नन्न अकाउंटइंद दुड्डु कट आगिदे।',
              romanHindi: 'Nanna account-inda duddu cut aagide.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'पैसे', devanagari: 'दुड्डु', romanHindi: 'Duddu'),
                roleNote: 'Money.',
              ),
            ],
          ),
          PhraseItem(
            id: 'pr_05_p2',
            speakerRole: 'You',
            text: TriScriptText(
              hindi: 'एक मिनट रुकिए, मैं रसीद दिखाता हूँ।',
              devanagari: 'ओंदु निमिष इरी, रसीदी तोरिस्तीनि।',
              romanHindi: 'Ondu nimisha iri, raseedi toristeeni.',
            ),
            chunks: [
              PhraseChunk(
                text: TriScriptText(hindi: 'रुकिए', devanagari: 'इरी', romanHindi: 'Iri'),
                roleNote: 'Wait / hold on.',
              ),
            ],
          ),
        ],
        vocabulary: [
          VocabItem(
            id: 'pr_05_v1',
            text: TriScriptText(hindi: 'पैसे वापस', devanagari: 'दुड्डु वापस', romanHindi: 'Duddu vaapas'),
            partOfSpeech: 'Phrase',
          ),
          VocabItem(
            id: 'pr_05_v2',
            text: TriScriptText(hindi: 'कोई बात नहीं', devanagari: 'परवागिल्ला', romanHindi: 'Paravaagilla'),
            partOfSpeech: 'Phrase',
          ),
        ],
        usageTips: [
          '"Ondu nimisha iri" (एक मिनट रुकिए) gives you breathing room in any busy situation.',
        ],
      ),
    ],
  ),
];
