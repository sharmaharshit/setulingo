import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final path = join(await getDatabasesPath(), 'setulingo_v1.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, _) async {
      await db.execute('''CREATE TABLE vocabulary (
        id VARCHAR(12) PRIMARY KEY, kannada_script TEXT NOT NULL,
        transliteration TEXT NOT NULL, devanagari TEXT NOT NULL,
        hindi_meaning TEXT NOT NULL, cognate_root TEXT,
        category VARCHAR(40) NOT NULL, tier INTEGER NOT NULL,
        audio_filename VARCHAR(50) NOT NULL)''');
      await db.execute('''CREATE TABLE sentences (
        id VARCHAR(12) PRIMARY KEY, kannada_script TEXT NOT NULL,
        transliteration TEXT NOT NULL, devanagari TEXT NOT NULL,
        hindi_translation TEXT NOT NULL, scenario_tag VARCHAR(40) NOT NULL,
        tier INTEGER NOT NULL, reveal_tip TEXT NOT NULL,
        audio_filename VARCHAR(50) NOT NULL)''');
      await db.execute('''CREATE TABLE days (
        day_number INTEGER PRIMARY KEY, title_en TEXT NOT NULL,
        title_hi TEXT NOT NULL, tier_dominant INTEGER NOT NULL,
        estimated_duration_min INTEGER DEFAULT 4, is_unlocked INTEGER DEFAULT 0,
        is_completed INTEGER DEFAULT 0, accuracy_score REAL DEFAULT 0.0)''');
      await db.execute('''CREATE TABLE day_exercises (
        id VARCHAR(12) PRIMARY KEY, day_number INTEGER REFERENCES days(day_number),
        step_order INTEGER NOT NULL, exercise_type VARCHAR(30) NOT NULL,
        prompt_hindi TEXT NOT NULL, context_note TEXT, audio_asset VARCHAR(50),
        target_data_json TEXT NOT NULL, reveal_tip TEXT NOT NULL)''');
      await db.execute('''CREATE TABLE user_state (
        id INTEGER PRIMARY KEY DEFAULT 1, current_day INTEGER DEFAULT 1,
        current_streak INTEGER DEFAULT 0, last_completed_timestamp INTEGER DEFAULT 0,
        total_words_learned INTEGER DEFAULT 0)''');
    });
    return _db!;
  }

  Future<void> seedIfNeeded(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM days')) ?? 0;
    if (count > 0) return;
    await db.transaction((txn) async {
      await txn.insert('user_state', {'id': 1});
      final days = <Map<String, dynamic>>[];
      for (var d = 1; d <= 30; d++) {
        days.add({
          'day_number': d,
          'title_en': d == 1 ? 'Street Survival: First Auto Ride' : d == 2 ? 'Darshini Eats: Dosa & Filter Coffee' : 'Coming Soon — Day $d',
          'title_hi': d == 1 ? 'सड़क पर बातचीत: पहली ऑटो की सवारी' : d == 2 ? 'होटल में ऑर्डर: डोसा और फ़िल्टर कॉफ़ी' : 'आगे का पाठ — दिन $d',
          'tier_dominant': d <= 7 ? 1 : d <= 18 ? 2 : d <= 24 ? 3 : 4,
          'estimated_duration_min': 4,
          'is_unlocked': d == 1 ? 1 : 0,
          'is_completed': 0,
          'accuracy_score': 0.0,
        });
      }
      for (final row in days) { await txn.insert('days', row); }

      final seedJson = _seedJson;
      final root = jsonDecode(seedJson) as List<dynamic>;
      for (final day in root) {
        for (final v in (day['vocabulary'] as List<dynamic>)) {
          await txn.insert('vocabulary', Map<String, dynamic>.from(v));
        }
        for (final e in (day['exercises'] as List<dynamic>)) {
          await txn.insert('day_exercises', {
            'id': e['id'], 'day_number': day['day_number'], 'step_order': e['step_order'],
            'exercise_type': e['exercise_type'], 'prompt_hindi': e['prompt_hindi'],
            'context_note': null, 'audio_asset': e['audio_asset'],
            'target_data_json': e['target_data_json'], 'reveal_tip': e['reveal_tip'],
          });
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> days() async => (await database).query('days', orderBy: 'day_number');
  Future<Map<String, dynamic>> day(int n) async => (await database).query('days', where: 'day_number=?', whereArgs: [n]).then((x) => x.first);
  Future<List<Map<String, dynamic>>> exercises(int n) async => (await database).query('day_exercises', where: 'day_number=?', whereArgs: [n], orderBy: 'step_order');
  Future<Map<String, dynamic>> state() async => (await database).query('user_state', where: 'id=1').then((x) => x.first);

  Future<void> completeDay(int n, double accuracy, int wordCount) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final state = await this.state();
    final last = (state['last_completed_timestamp'] as int?) ?? 0;
    final previous = last == 0 ? null : DateTime.fromMillisecondsSinceEpoch(last);
    final today = DateTime.now();
    final yesterday = DateTime(today.year, today.month, today.day).subtract(const Duration(days: 1));
    final prevDate = previous == null ? null : DateTime(previous.year, previous.month, previous.day);
    final streak = prevDate == null ? 1 : (prevDate == yesterday ? ((state['current_streak'] as int) + 1) : 1);
    await db.transaction((txn) async {
      await txn.update('days', {'is_completed': 1, 'accuracy_score': accuracy}, where: 'day_number=?', whereArgs: [n]);
      if (n < 30) await txn.update('days', {'is_unlocked': 1}, where: 'day_number=?', whereArgs: [n + 1]);
      await txn.update('user_state', {
        'current_day': n < 30 ? n + 1 : 30,
        'current_streak': streak,
        'last_completed_timestamp': now,
        'total_words_learned': (state['total_words_learned'] as int) + wordCount,
      }, where: 'id=1');
    });
  }

  static const _seedJson = r'''[
    {"day_number":1,"vocabulary":[
      {"id":"VOC_001","kannada_script":"ನಮಸ್ಕಾರ","transliteration":"Namaskaara","devanagari":"नमस्कार","hindi_meaning":"नमस्ते","cognate_root":"नमस्कार (Sanskrit)","category":"greeting","tier":1,"audio_filename":"voc_001.m4a"},
      {"id":"VOC_002","kannada_script":"ಬಾಸ್ / ಅಣ್ಣಾ","transliteration":"Boss / Anna","devanagari":"बॉस / अण्णा","hindi_meaning":"भाईसाहब / भैया","cognate_root":null,"category":"kinship","tier":1,"audio_filename":"voc_002.m4a"},
      {"id":"VOC_003","kannada_script":"ಇಲ್ಲಿ","transliteration":"Illi","devanagari":"इल्ली","hindi_meaning":"यहाँ","cognate_root":null,"category":"direction","tier":1,"audio_filename":"voc_003.m4a"},
      {"id":"VOC_004","kannada_script":"ಎಲ್ಲಿ","transliteration":"Yelli","devanagari":"येल्ली","hindi_meaning":"कहाँ","cognate_root":null,"category":"question","tier":1,"audio_filename":"voc_004.m4a"},
      {"id":"VOC_005","kannada_script":"ನಿಲ್ಲಿಸಿ","transliteration":"Nillisi","devanagari":"निल्लिसि","hindi_meaning":"रोकिए (Polite)","cognate_root":null,"category":"imperative","tier":1,"audio_filename":"voc_005.m4a"}
    ],"exercises":[
      {"id":"EX_D01_01","step_order":1,"exercise_type":"listen_select","prompt_hindi":"'यहाँ' के लिए सही कन्नड़ शब्द पहचानिए:","audio_asset":"voc_003.m4a","target_data_json":"{\"correct_answer\":\"Illi (इल्ली)\",\"options\":[\"Illi (इल्ली)\",\"Alli (अल्ली)\",\"Yelli (येल्ली)\",\"Eshtu (एष्टु)\"]}","reveal_tip":"इल्ली मतलब यहाँ, अल्ली मतलब वहाँ, और येल्ली मतलब कहाँ।"},
      {"id":"EX_D01_02","step_order":2,"exercise_type":"sov_tile_arrange","prompt_hindi":"वाक्य बनाइए: 'भैया यहाँ रोकिए'","audio_asset":null,"target_data_json":"{\"correct_sequence\":[\"Anna\",\"illi\",\"nillisi\"],\"tiles\":[\"nillisi\",\"Anna\",\"illi\",\"hogi\",\"banni\"]}","reveal_tip":"हिंदी की तरह कन्नड़ में भी क्रिया (रोकिए -> निल्लिसि) वाक्य के अंत में आती है।"},
      {"id":"EX_D01_03","step_order":3,"exercise_type":"cloze_selection","prompt_hindi":"खाली स्थान भरिए: 'कोरमंगला चलोगे क्या?'","audio_asset":null,"target_data_json":"{\"sentence_display\":\"Boss, Koramangalakke ______?\",\"correct_answer\":\"barthiraa? (बर्तिरा?)\",\"options\":[\"barthiraa? (बर्तिरा?)\",\"hogtiini (होग्तीनि)\",\"banni (बन्नि)\",\"nillisi (निल्लिसि)\"]}","reveal_tip":"आदर से पूछने के लिए क्रिया के अंत में '-तीरा?' जोड़ते हैं, जैसे 'बर्तिरा?' (आएँगे क्या?)"},
      {"id":"EX_D01_04","step_order":4,"exercise_type":"dialogue_branch","prompt_hindi":"ड्राइवर ने मीटर से चलने से मना किया। आप क्या कहेंगे?","audio_asset":"sen_d01_drv.m4a","target_data_json":"{\"prompt_speaker\":\"Meter aagalla saar, extra aagutthe.\",\"correct_answer\":\"Meter haaki banni guru.\",\"options\":[\"Meter haaki banni guru.\",\"Oota aaytha anna?\",\"Illi nillisi.\"]}","reveal_tip":"'Meter haaki banni guru' (मीटर डालकर चलिए भाई) बैंगलोर का ज़रूरी सड़क वाक्य है।"}
    ]},
    {"day_number":2,"vocabulary":[
      {"id":"VOC_006","kannada_script":"ತಿಂಡಿ","transliteration":"Thindi","devanagari":"थिंडी","hindi_meaning":"नाश्ता","cognate_root":null,"category":"food","tier":1,"audio_filename":"voc_006.m4a"},
      {"id":"VOC_007","kannada_script":"ಊಟ","transliteration":"Oota","devanagari":"ऊटा","hindi_meaning":"भोजन / खाना","cognate_root":null,"category":"food","tier":1,"audio_filename":"voc_007.m4a"},
      {"id":"VOC_008","kannada_script":"ಬೇಕು","transliteration":"Beku","devanagari":"बेकु","hindi_meaning":"चाहिए","cognate_root":null,"category":"modal","tier":1,"audio_filename":"voc_008.m4a"},
      {"id":"VOC_009","kannada_script":"ಬೇಡ","transliteration":"Beda","devanagari":"बेड","hindi_meaning":"नहीं चाहिए","cognate_root":null,"category":"modal","tier":1,"audio_filename":"voc_009.m4a"},
      {"id":"VOC_010","kannada_script":"ಸಾಕು","transliteration":"Saaku","devanagari":"साकु","hindi_meaning":"काफ़ी है / बस","cognate_root":null,"category":"modal","tier":1,"audio_filename":"voc_010.m4a"}
    ],"exercises":[
      {"id":"EX_D02_01","step_order":1,"exercise_type":"listen_select","prompt_hindi":"'चाहिए' के लिए सही शब्द चुनिए:","audio_asset":"voc_008.m4a","target_data_json":"{\"correct_answer\":\"Beku (बेकु)\",\"options\":[\"Beku (बेकु)\",\"Beda (बेड)\",\"Saaku (साकु)\",\"Illa (इल्ला)\"]}","reveal_tip":"कन्नड़ में 'बेकु' मतलब चाहिए और 'बेड' मतलब नहीं चाहिए।"},
      {"id":"EX_D02_02","step_order":2,"exercise_type":"cloze_selection","prompt_hindi":"खाली स्थान भरिए: 'सांभर ज़्यादा डालिए, चटनी ______'","audio_asset":null,"target_data_json":"{\"sentence_display\":\"Saambaar jaasthi haaki, chutney ______.\",\"correct_answer\":\"saaku (साकु)\",\"options\":[\"saaku (साकु)\",\"beku (बेकु)\",\"beda (बेड)\",\"hoge (होगे)\"]}","reveal_tip":"जब प्लेट में कुछ परोसा जा रहा हो और आपको रोकना हो, तो कहिए 'साकु' (काफ़ी है / बस)।"},
      {"id":"EX_D02_03","step_order":3,"exercise_type":"sov_tile_arrange","prompt_hindi":"वाक्य बनाइए: 'मुझे कॉफ़ी चाहिए'","audio_asset":null,"target_data_json":"{\"correct_sequence\":[\"Nanage\",\"coffee\",\"beku\"],\"tiles\":[\"beku\",\"Nanage\",\"coffee\",\"saaku\",\"beda\"]}","reveal_tip":"'मुझे' को कन्नड़ में 'ननगे' (Nanage) कहते हैं।"}
    ]}
  ]''';
}
