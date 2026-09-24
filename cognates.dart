// Part 5: 100 Sanskrit Cognates & Lesson Generation Helpers
import 'dart:math';
import 'models.dart';
import 'categories.dart';

final List<WordConnection> connections = [
  // TIME
  const WordConnection(category: 'Time', hindi: 'समय', kannadaRoman: 'samaya', kannadaDeva: 'समय', type: 'Tatsama', note: 'दोनों भाषाओं में एक ही संस्कृत शब्द जस का तस उपयोग होता है।'),
  const WordConnection(category: 'Time', hindi: 'वर्ष', kannadaRoman: 'varsha', kannadaDeva: 'वर्ष', type: 'Tatsama', note: 'साल के लिए औपचारिक शब्द, दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Time', hindi: 'दिन', kannadaRoman: 'dina', kannadaDeva: 'दिन', type: 'Tatsama', note: 'रोज़मर्रा की बातचीत में भी समान रूप से इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'रात्रि', kannadaRoman: 'raatri', kannadaDeva: 'रात्रि', type: 'Tatsama', note: 'औपचारिक रूप से रात के लिए इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'काल', kannadaRoman: 'kaala', kannadaDeva: 'काल', type: 'Tatsama', note: 'समय या युग के अर्थ में दोनों भाषाओं में सामान्य।'),
  const WordConnection(category: 'Time', hindi: 'मास', kannadaRoman: 'maasa', kannadaDeva: 'मास', type: 'Tatsama', note: 'महीने का औपचारिक/संस्कृत रूप।'),
  const WordConnection(category: 'Time', hindi: 'युग', kannadaRoman: 'yuga', kannadaDeva: 'युग', type: 'Tatsama', note: 'लंबे कालखंड के लिए इस्तेमाल होता है।'),
  const WordConnection(category: 'Time', hindi: 'निमिष', kannadaRoman: 'nimisha', kannadaDeva: 'निमिष', type: 'Tatsama', note: 'एक पल के लिए काव्यात्मक शब्द।'),
  const WordConnection(category: 'Time', hindi: 'प्रहर', kannadaRoman: 'prahara', kannadaDeva: 'प्रहर', type: 'Tatsama', note: 'दिन के भाग/पहर के लिए।'),
  const WordConnection(category: 'Time', hindi: 'प्रतिदिन', kannadaRoman: 'pratidina', kannadaDeva: 'प्रतिदिन', type: 'Tatsama', note: '"हर रोज़" के लिए औपचारिक शब्द।'),

  // FAMILY
  const WordConnection(category: 'Family', hindi: 'माता', kannadaRoman: 'maata', kannadaDeva: 'माता', type: 'Tatsama', note: 'औपचारिक रूप से माँ के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पिता', kannadaRoman: 'pita', kannadaDeva: 'पिता', type: 'Tatsama', note: 'औपचारिक रूप से पिता के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पुत्र', kannadaRoman: 'putra', kannadaDeva: 'पुत्र', type: 'Tatsama', note: 'बेटे के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'पुत्री', kannadaRoman: 'putri', kannadaDeva: 'पुत्री', type: 'Tatsama', note: 'बेटी के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'सहोदर', kannadaRoman: 'sahodara', kannadaDeva: 'सहोदर', type: 'Tatsama', note: 'भाई के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'सहोदरी', kannadaRoman: 'sahodari', kannadaDeva: 'सहोदरी', type: 'Tatsama', note: 'बहन के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'पति', kannadaRoman: 'pati', kannadaDeva: 'पति', type: 'Tatsama', note: 'दोनों भाषाओं में समान रूप से पति के लिए।'),
  const WordConnection(category: 'Family', hindi: 'पत्नी', kannadaRoman: 'patni', kannadaDeva: 'पत्नी', type: 'Tatsama', note: 'दोनों भाषाओं में समान रूप से पत्नी के लिए।'),
  const WordConnection(category: 'Family', hindi: 'विवाह', kannadaRoman: 'vivaaha', kannadaDeva: 'विवाह', type: 'Tatsama', note: 'शादी के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Family', hindi: 'कुटुंब', kannadaRoman: 'kutumba', kannadaDeva: 'कुटुंब', type: 'Tatsama', note: 'परिवार के लिए औपचारिक शब्द।'),

  // GREETINGS & SOCIAL
  const WordConnection(category: 'Greetings & Social', hindi: 'नमस्कार', kannadaRoman: 'namaskaara', kannadaDeva: 'नमस्कार', type: 'Tatsama', note: 'सबसे आम साझा अभिवादन।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'स्वागत', kannadaRoman: 'swaagata', kannadaDeva: 'स्वागत', type: 'Tatsama', note: 'स्वागत करने के लिए दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'आशीर्वाद', kannadaRoman: 'aashirvaada', kannadaDeva: 'आशीर्वाद', type: 'Tatsama', note: 'बुज़ुर्गों से आशीर्वाद माँगने के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'अभिनंदन', kannadaRoman: 'abhinandana', kannadaDeva: 'अभिनंदन', type: 'Tatsama', note: 'बधाई देने के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'धन्यवाद', kannadaRoman: 'dhanyavaadagalu', kannadaDeva: 'धन्यवादगळु', type: 'Tatsama', note: 'कन्नड़ में बहुवचन प्रत्यय (-गळु) जोड़कर अधिक सम्मान दिया जाता है।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'क्षमा', kannadaRoman: 'kshama', kannadaDeva: 'क्षमा', type: 'Tatsama', note: 'माफ़ी माँगने के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'आग्रह', kannadaRoman: 'aagraha', kannadaDeva: 'आग्रह', type: 'Tatsama', note: 'विनम्र अनुरोध के लिए।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'अनुमति', kannadaRoman: 'anumati', kannadaDeva: 'अनुमति', type: 'Tatsama', note: 'इजाज़त माँगने के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'परिचय', kannadaRoman: 'parichaya', kannadaDeva: 'परिचय', type: 'Tatsama', note: 'अपना परिचय देते समय इस्तेमाल होता है।'),
  const WordConnection(category: 'Greetings & Social', hindi: 'सम्मान', kannadaRoman: 'sammaana', kannadaDeva: 'सम्मान', type: 'Tatsama', note: 'आदर या इज़्ज़त के लिए।'),

  // RELIGION & SPIRITUALITY
  const WordConnection(category: 'Religion & Spirituality', hindi: 'धर्म', kannadaRoman: 'dharma', kannadaDeva: 'धर्म', type: 'Tatsama', note: 'कर्तव्य और आस्था दोनों अर्थों में साझा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'कर्म', kannadaRoman: 'karma', kannadaDeva: 'कर्म', type: 'Tatsama', note: 'कर्मों के फल के अर्थ में समान रूप से समझा जाता है।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'मोक्ष', kannadaRoman: 'moksha', kannadaDeva: 'मोक्ष', type: 'Tatsama', note: 'मुक्ति के लिए साझा अवधारणा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'आत्मा', kannadaRoman: 'aatma', kannadaDeva: 'आत्मा', type: 'Tatsama', note: 'आत्मा/स्वयं के अर्थ में।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'भगवान', kannadaRoman: 'bhagavaan', kannadaDeva: 'भगवान', type: 'Tatsama', note: 'ईश्वर के लिए साझा शब्द।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'मंदिर', kannadaRoman: 'mandira', kannadaDeva: 'मंदिर', type: 'Tatsama', note: 'मंदिर के लिए दोनों भाषाओं में समान।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'पूजा', kannadaRoman: 'puja', kannadaDeva: 'पूजा', type: 'Tatsama', note: 'पूजा-पाठ के लिए।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'प्रसाद', kannadaRoman: 'prasaada', kannadaDeva: 'प्रसाद', type: 'Tatsama', note: 'मंदिर से मिलने वाले भोग के लिए।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'शांति', kannadaRoman: 'shanti', kannadaDeva: 'शांति', type: 'Tatsama', note: 'शांति के अर्थ में साझा।'),
  const WordConnection(category: 'Religion & Spirituality', hindi: 'सत्य', kannadaRoman: 'satya', kannadaDeva: 'सत्य', type: 'Tatsama', note: 'सच्चाई के लिए साझा शब्द।'),

  // EDUCATION & KNOWLEDGE
  const WordConnection(category: 'Education & Knowledge', hindi: 'विद्या', kannadaRoman: 'vidya', kannadaDeva: 'विद्या', type: 'Tatsama', note: 'शिक्षा/विद्या के लिए साझा।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'ज्ञान', kannadaRoman: 'gnaana', kannadaDeva: 'ज्ञान', type: 'Tatsama', note: 'ज्ञान के लिए साझा शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'पुस्तक', kannadaRoman: 'pustaka', kannadaDeva: 'पुस्तक', type: 'Tatsama', note: 'किताब के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'शिक्षक', kannadaRoman: 'shikshaka', kannadaDeva: 'शिक्षक', type: 'Tatsama', note: 'अध्यापक के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'विद्यालय', kannadaRoman: 'vidyaalaya', kannadaDeva: 'विद्यालय', type: 'Tatsama', note: 'स्कूल के लिए औपचारिक शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'परीक्षा', kannadaRoman: 'pariksha', kannadaDeva: 'परीक्षा', type: 'Tatsama', note: 'इम्तिहान के लिए साझा शब्द।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'बुद्धि', kannadaRoman: 'buddhi', kannadaDeva: 'बुद्धि', type: 'Tatsama', note: 'समझ/अक्ल के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'विचार', kannadaRoman: 'vichaara', kannadaDeva: 'विचार', type: 'Tatsama', note: 'सोच/विचार के लिए।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'भाषा', kannadaRoman: 'bhasha', kannadaDeva: 'भाषा', type: 'Tatsama', note: 'भाषा के लिए साझा शब्द — जो इस ऐप का आधार भी है।'),
  const WordConnection(category: 'Education & Knowledge', hindi: 'अक्षर', kannadaRoman: 'akshara', kannadaDeva: 'अक्षर', type: 'Tatsama', note: 'अक्षर/लिपि के लिए।'),

  // GOVERNMENT & FORMAL
  const WordConnection(category: 'Government & Formal', hindi: 'सरकार', kannadaRoman: 'sarakaara', kannadaDeva: 'सरकार', type: 'Tatsama', note: 'सरकार के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'राज्य', kannadaRoman: 'raajya', kannadaDeva: 'राज्य', type: 'Tatsama', note: 'राज्य के लिए साझा।'),
  const WordConnection(category: 'Government & Formal', hindi: 'नियम', kannadaRoman: 'niyama', kannadaDeva: 'नियम', type: 'Tatsama', note: 'क़ानून/नियम के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'न्याय', kannadaRoman: 'nyaaya', kannadaDeva: 'न्याय', type: 'Tatsama', note: 'इंसाफ़ के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'अधिकार', kannadaRoman: 'adhikaara', kannadaDeva: 'अधिकार', type: 'Tatsama', note: 'हक़/अधिकार के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'अध्यक्ष', kannadaRoman: 'adhyaksha', kannadaDeva: 'अध्यक्ष', type: 'Tatsama', note: 'अध्यक्ष/प्रमुख के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'मंत्री', kannadaRoman: 'mantri', kannadaDeva: 'मंत्री', type: 'Tatsama', note: 'मंत्री के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'प्रशासन', kannadaRoman: 'prashaasana', kannadaDeva: 'प्रशासन', type: 'Tatsama', note: 'प्रशासन के लिए।'),
  const WordConnection(category: 'Government & Formal', hindi: 'सुरक्षा', kannadaRoman: 'suraksha', kannadaDeva: 'सुरक्षा', type: 'Tatsama', note: 'सुरक्षा के लिए साझा शब्द।'),
  const WordConnection(category: 'Government & Formal', hindi: 'स्वतंत्र', kannadaRoman: 'swatantra', kannadaDeva: 'स्वतंत्र', type: 'Tatsama', note: 'आज़ाद/स्वतंत्र के लिए।'),

  // NUMBERS & QUANTITY
  const WordConnection(category: 'Numbers & Quantity', hindi: 'एक (औपचारिक)', kannadaRoman: 'eka', kannadaDeva: 'एक', type: 'Tatsama', note: 'रोज़मर्रा में "ondu" चलता है, पर औपचारिक रूप साझा है।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'द्वितीय', kannadaRoman: 'dvitiya', kannadaDeva: 'द्वितीय', type: 'Tatsama', note: '"दूसरा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'तृतीय', kannadaRoman: 'tritiya', kannadaDeva: 'तृतीय', type: 'Tatsama', note: '"तीसरा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'चतुर्थ', kannadaRoman: 'chaturtha', kannadaDeva: 'चतुर्थ', type: 'Tatsama', note: '"चौथा" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'पंच', kannadaRoman: 'pancha', kannadaDeva: 'पंच', type: 'Tatsama', note: '"पाँच" की जड़, कई शब्दों में मिलती है।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'शत', kannadaRoman: 'shata', kannadaDeva: 'शत', type: 'Tatsama', note: '"सौ" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'सहस्र', kannadaRoman: 'sahasra', kannadaDeva: 'सहस्र', type: 'Tatsama', note: '"हज़ार" के औपचारिक रूप में।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'अर्ध', kannadaRoman: 'ardha', kannadaDeva: 'अर्ध', type: 'Tatsama', note: 'आधे के लिए साझा शब्द।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'पूर्ण', kannadaRoman: 'poorna', kannadaDeva: 'पूर्ण', type: 'Tatsama', note: 'पूरा/संपूर्ण के लिए।'),
  const WordConnection(category: 'Numbers & Quantity', hindi: 'अल्प', kannadaRoman: 'alpa', kannadaDeva: 'अल्प', type: 'Tatsama', note: 'थोड़ा/कम के औपचारिक रूप में — "swalpa" इसी से आता है।'),

  // EMOTIONS & QUALITIES
  const WordConnection(category: 'Emotions & Qualities', hindi: 'प्रेम', kannadaRoman: 'prema', kannadaDeva: 'प्रेम', type: 'Tatsama', note: 'प्यार के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'क्रोध', kannadaRoman: 'krodha', kannadaDeva: 'क्रोध', type: 'Tatsama', note: 'गुस्से के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'दुःख', kannadaRoman: 'dukha', kannadaDeva: 'दुःख', type: 'Tatsama', note: 'दुःख/ग़म के लिए साझा।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'सुख', kannadaRoman: 'sukha', kannadaDeva: 'सुख', type: 'Tatsama', note: 'ख़ुशी के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'आशा', kannadaRoman: 'aashaa', kannadaDeva: 'आशा', type: 'Tatsama', note: 'उम्मीद के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'भय', kannadaRoman: 'bhaya', kannadaDeva: 'भय', type: 'Tatsama', note: 'डर के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'उत्साह', kannadaRoman: 'utsaaha', kannadaDeva: 'उत्साह', type: 'Tatsama', note: 'जोश/उत्साह के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'संतोष', kannadaRoman: 'santosha', kannadaDeva: 'संतोष', type: 'Tatsama', note: 'संतुष्टि के लिए।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'विश्वास', kannadaRoman: 'vishwaasa', kannadaDeva: 'विश्वास', type: 'Tatsama', note: 'भरोसे के लिए साझा शब्द।'),
  const WordConnection(category: 'Emotions & Qualities', hindi: 'साहस', kannadaRoman: 'saahasa', kannadaDeva: 'साहस', type: 'Tatsama', note: 'हिम्मत के लिए।'),

  // NATURE
  const WordConnection(category: 'Nature', hindi: 'सूर्य', kannadaRoman: 'surya', kannadaDeva: 'सूर्य', type: 'Tatsama', note: 'सूरज के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'चंद्र', kannadaRoman: 'chandra', kannadaDeva: 'चंद्र', type: 'Tatsama', note: 'चाँद के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'वायु', kannadaRoman: 'vaayu', kannadaDeva: 'वायु', type: 'Tatsama', note: 'हवा के औपचारिक रूप में।'),
  const WordConnection(category: 'Nature', hindi: 'जल', kannadaRoman: 'jala', kannadaDeva: 'जल', type: 'Tatsama', note: 'पानी के औपचारिक रूप में — रोज़मर्रा में "neeru" चलता है।'),
  const WordConnection(category: 'Nature', hindi: 'अग्नि', kannadaRoman: 'agni', kannadaDeva: 'अग्नि', type: 'Tatsama', note: 'आग के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'पृथ्वी', kannadaRoman: 'prithvi', kannadaDeva: 'पृथ्वी', type: 'Tatsama', note: 'धरती के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'आकाश', kannadaRoman: 'aakaasha', kannadaDeva: 'आकाश', type: 'Tatsama', note: 'आसमान के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'नदी', kannadaRoman: 'nadi', kannadaDeva: 'नदी', type: 'Tatsama', note: 'नदी के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'पर्वत', kannadaRoman: 'parvata', kannadaDeva: 'पर्वत', type: 'Tatsama', note: 'पहाड़ के लिए साझा शब्द।'),
  const WordConnection(category: 'Nature', hindi: 'वृक्ष', kannadaRoman: 'vriksha', kannadaDeva: 'वृक्ष', type: 'Tatsama', note: 'पेड़ के औपचारिक रूप में।'),

  // BODY & HEALTH
  const WordConnection(category: 'Body & Health', hindi: 'शरीर', kannadaRoman: 'shareera', kannadaDeva: 'शरीर', type: 'Tatsama', note: 'शरीर के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'स्वास्थ्य', kannadaRoman: 'swaasthya', kannadaDeva: 'स्वास्थ्य', type: 'Tatsama', note: 'सेहत के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'हृदय', kannadaRoman: 'hridaya', kannadaDeva: 'हृदय', type: 'Tatsama', note: 'दिल के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'नेत्र', kannadaRoman: 'netra', kannadaDeva: 'नेत्र', type: 'Tatsama', note: 'आँख के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'रोग', kannadaRoman: 'roga', kannadaDeva: 'रोग', type: 'Tatsama', note: 'बीमारी के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'औषध', kannadaRoman: 'aushadha', kannadaDeva: 'औषध', type: 'Tatsama', note: 'दवा के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'चिकित्सा', kannadaRoman: 'chikitsa', kannadaDeva: 'चिकित्सा', type: 'Tatsama', note: 'इलाज के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'शक्ति', kannadaRoman: 'shakti', kannadaDeva: 'शक्ति', type: 'Tatsama', note: 'ताक़त के लिए साझा शब्द।'),
  const WordConnection(category: 'Body & Health', hindi: 'आयु', kannadaRoman: 'aayu', kannadaDeva: 'आयु', type: 'Tatsama', note: 'उम्र के औपचारिक रूप में।'),
  const WordConnection(category: 'Body & Health', hindi: 'विश्राम', kannadaRoman: 'vishraama', kannadaDeva: 'विश्राम', type: 'Tatsama', note: 'आराम के लिए साझा शब्द।'),
];

List<String> get cognateCategories {
  final seen = <String>{};
  final ordered = <String>[];
  for (final c in connections) {
    if (seen.add(c.category)) ordered.add(c.category);
  }
  return ordered;
}

const List<Chunk> _distractorPool = [
  Chunk('illa', 'इल्ल', 'नहीं'),
  Chunk('yenu', 'येनु', 'क्या'),
  Chunk('naale', 'नाळे', 'कल'),
  Chunk('sari', 'सरी', 'ठीक है'),
  Chunk('idu', 'इदु', 'यह'),
  Chunk('bega', 'बेग', 'जल्दी'),
];

KSituation getDailyScenario() {
  final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  final allSituations = categories.expand((c) => c.situations).toList();
  return allSituations[dayOfYear % allSituations.length];
}

Lesson generateLessonFromSituation(KSituation situation) {
  final steps = <LessonStep>[];
  final rng = Random(situation.id.hashCode);

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

    if (sentence.chunks.length >= 2) {
      final answerRoman = sentence.chunks.map((c) => c.roman).toList();
      final answerDeva = sentence.chunks.map((c) => c.deva).toList();

      final available = _distractorPool.where((d) => !answerRoman.contains(d.roman)).toList()..shuffle(rng);
      final distractors = available.take(2).toList();

      final tilesRoman = [...answerRoman, ...distractors.map((d) => d.roman)]..shuffle(rng);
      final tilesDeva = [...answerDeva, ...distractors.map((d) => d.deva)]..shuffle(rng);

      steps.add(
        BuildStep(
          promptHindi: sentence.hindi,
          answerRoman: answerRoman,
          answerDeva: answerDeva,
          tilesRoman: tilesRoman,
          tilesDeva: tilesDeva,
          revealRoman: sentence.roman,
          revealDeva: sentence.deva,
        ),
      );
    }
  }
  return Lesson(
    id: situation.id,
    title: situation.title,
    subtitle: situation.hindiTitle,
    steps: steps,
  );
}
