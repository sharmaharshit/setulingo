// Part 2: Sentence Lab v2 Engine
import 'models.dart';

enum LabTag { any, food, drinkHot, liquid, place, person, service, abstractThing }

class LabAnchor {
  final String id;
  final String roman;
  final String deva;
  final String hindi;

  const LabAnchor({required this.id, required this.roman, required this.deva, required this.hindi});
}

class LabObject {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final Set<LabTag> tags;

  const LabObject({required this.id, required this.roman, required this.deva, required this.hindi, required this.tags});
}

class LabVerb {
  final String id;
  final String roman;
  final String deva;
  final String hindi;
  final Set<LabTag> compatibleTags;

  const LabVerb({required this.id, required this.roman, required this.deva, required this.hindi, required this.compatibleTags});
}

final List<LabAnchor> labAnchors = const [
  LabAnchor(id: 'Ondu', roman: 'Ondu', deva: 'ओन्दु', hindi: 'एक'),
  LabAnchor(id: 'Innondu', roman: 'Innondu', deva: 'इन्नोन्दु', hindi: 'एक और'),
  LabAnchor(id: 'Swalpa', roman: 'Swalpa', deva: 'स्वल्प', hindi: 'थोड़ा'),
  LabAnchor(id: 'SwalpaJaasti', roman: 'Swalpa jaasti', deva: 'स्वल्प ज्यास्ति', hindi: 'थोड़ा ज़्यादा'),
  LabAnchor(id: 'Kammi', roman: 'Kammi', deva: 'कम्मि', hindi: 'कम'),
  LabAnchor(id: 'Nanage', roman: 'Nanage', deva: 'ननगे', hindi: 'मुझे'),
  LabAnchor(id: 'Namge', roman: 'Namge', deva: 'नमगे', hindi: 'हमें'),
  LabAnchor(id: 'Illi', roman: 'Illi', deva: 'इल्लि', hindi: 'यहाँ'),
  LabAnchor(id: 'Adu', roman: 'Adu', deva: 'अदु', hindi: 'वह'),
  LabAnchor(id: 'Idu', roman: 'Idu', deva: 'इदु', hindi: 'यह'),
];

final List<LabObject> labObjects = const [
  LabObject(id: 'dose', roman: 'dose', deva: 'दोसे', hindi: 'डोसा', tags: {LabTag.food}),
  LabObject(id: 'idli', roman: 'idli', deva: 'इडली', hindi: 'इडली', tags: {LabTag.food}),
  LabObject(id: 'vada', roman: 'vada', deva: 'वड़े', hindi: 'वड़ा', tags: {LabTag.food}),
  LabObject(id: 'chapati', roman: 'chapati', deva: 'चपाती', hindi: 'चपाती', tags: {LabTag.food}),
  LabObject(id: 'poori', roman: 'poori', deva: 'पूरी', hindi: 'पूरी', tags: {LabTag.food}),
  LabObject(id: 'coffee', roman: 'coffee', deva: 'कॉफ़ी', hindi: 'कॉफ़ी', tags: {LabTag.drinkHot}),
  LabObject(id: 'tea', roman: 'tea', deva: 'टी', hindi: 'चाय', tags: {LabTag.drinkHot}),
  LabObject(id: 'haalu', roman: 'haalu', deva: 'हालु', hindi: 'दूध', tags: {LabTag.drinkHot}),
  LabObject(id: 'neeru', roman: 'neeru', deva: 'नीरु', hindi: 'पानी', tags: {LabTag.liquid}),
  LabObject(id: 'sambar', roman: 'sambar', deva: 'सांभर', hindi: 'सांभर', tags: {LabTag.liquid}),
  LabObject(id: 'majjige', roman: 'majjige', deva: 'मज्जिगे', hindi: 'छाछ', tags: {LabTag.liquid}),
  LabObject(id: 'jaga', roman: 'jaga', deva: 'जगा', hindi: 'जगह/सीट', tags: {LabTag.place}),
  LabObject(id: 'stop', roman: 'stop', deva: 'स्टॉप', hindi: 'स्टॉप', tags: {LabTag.place}),
  LabObject(id: 'mane', roman: 'mane', deva: 'मने', hindi: 'घर', tags: {LabTag.place}),
  LabObject(id: 'cover', roman: 'cover', deva: 'कवर', hindi: 'थैली', tags: {LabTag.service}),
  LabObject(id: 'bill', roman: 'bill', deva: 'बिल', hindi: 'बिल', tags: {LabTag.service}),
  LabObject(id: 'auto', roman: 'auto', deva: 'ऑटो', hindi: 'ऑटो', tags: {LabTag.service}),
  LabObject(id: 'parcel', roman: 'parcel', deva: 'पार्सल', hindi: 'पार्सल', tags: {LabTag.service}),
  LabObject(id: 'samaya', roman: 'samaya', deva: 'समय', hindi: 'समय', tags: {LabTag.abstractThing}),
  LabObject(id: 'sahaya', roman: 'sahaya', deva: 'सहाय', hindi: 'मदद', tags: {LabTag.abstractThing}),
  LabObject(id: 'change', roman: 'change', deva: 'चेंज', hindi: 'बाकी पैसे', tags: {LabTag.abstractThing}),
  LabObject(id: 'permission', roman: 'permission', deva: 'परमिशन', hindi: 'इजाज़त', tags: {LabTag.abstractThing}),
];

final List<LabVerb> labVerbs = const [
  LabVerb(id: 'beku', roman: 'beku', deva: 'बेकु', hindi: 'चाहिए', compatibleTags: {LabTag.any}),
  LabVerb(id: 'beda', roman: 'beda', deva: 'बेड़ा', hindi: 'नहीं चाहिए', compatibleTags: {LabTag.any}),
  LabVerb(id: 'kodabedi', roman: 'kodabedi', deva: 'कोडबेडि', hindi: 'मत दीजिए', compatibleTags: {LabTag.any}),
  LabVerb(id: 'kodi', roman: 'kodi', deva: 'कोडि', hindi: 'दीजिए', compatibleTags: {LabTag.food, LabTag.drinkHot, LabTag.service, LabTag.abstractThing}),
  LabVerb(id: 'haaki', roman: 'haaki', deva: 'हाकि', hindi: 'डालिए', compatibleTags: {LabTag.liquid, LabTag.drinkHot}),
  LabVerb(id: 'saaku', roman: 'saaku', deva: 'साकु', hindi: 'बस, काफ़ी है', compatibleTags: {LabTag.liquid, LabTag.drinkHot, LabTag.food}),
  LabVerb(id: 'jastibeku', roman: 'jaasti beku', deva: 'ज्यास्ति बेकु', hindi: 'और ज़्यादा चाहिए', compatibleTags: {LabTag.food, LabTag.drinkHot, LabTag.liquid}),
  LabVerb(id: 'torisi', roman: 'torisi', deva: 'तोरिसि', hindi: 'दिखाइए', compatibleTags: {LabTag.place, LabTag.abstractThing, LabTag.service}),
  LabVerb(id: 'banni', roman: 'banni', deva: 'बन्नि', hindi: 'आइए', compatibleTags: {LabTag.place, LabTag.person}),
  LabVerb(id: 'nilisi', roman: 'nilisi', deva: 'निलिसि', hindi: 'रोकिए', compatibleTags: {LabTag.place, LabTag.service}),
];

List<LabVerb> labVerbsFor(LabObject object) {
  return labVerbs.where((v) => v.compatibleTags.contains(LabTag.any) || v.compatibleTags.intersection(object.tags).isNotEmpty).toList();
}

String labHindiGloss(LabAnchor a, LabObject o, LabVerb v) {
  return '${a.hindi} ${o.hindi} ${v.hindi}';
}
