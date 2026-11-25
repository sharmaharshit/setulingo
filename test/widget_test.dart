import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:setulingo/data/lessons_data.dart';
import 'package:setulingo/models/reading_mode.dart';
import 'package:setulingo/screens/auth_page.dart';
import 'package:setulingo/screens/lesson_page.dart';
import 'package:setulingo/services/audio_service.dart';
import 'package:setulingo/services/persistence_service.dart';
import 'package:setulingo/stores/app_state_store.dart';
import 'package:setulingo/stores/user_auth_store.dart';
import 'package:setulingo/stores/vault_store.dart';
import 'package:setulingo/widgets/tri_script_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('TriScriptView responds to global ReaderMode changes',
      (tester) async {
    final persistence = await PersistenceService.create();
    final appState = AppStateStore(persistence);

    const sample = TriScriptText(
      hindi: 'एक कॉफी दीजिए',
      devanagari: 'ओंदु कॉफी कोडी',
      romanHindi: 'Ondu coffee kodi',
    );

    await tester.pumpWidget(
      ChangeNotifierProvider<AppStateStore>.value(
        value: appState,
        child: const MaterialApp(
          home: Scaffold(body: TriScriptView(text: sample)),
        ),
      ),
    );

    expect(find.text('ओंदु कॉफी कोडी'), findsOneWidget);
    expect(find.text('Ondu coffee kodi'), findsOneWidget);
    expect(find.text('एक कॉफी दीजिए'), findsOneWidget);

    await appState.setReaderMode(ReaderMode.roman);
    await tester.pump();

    expect(find.text('ओंदु कॉफी कोडी'), findsNothing);
    expect(find.text('Ondu coffee kodi'), findsOneWidget);
    expect(find.text('एक कॉफी दीजिए'), findsOneWidget);
  });

  testWidgets('AuthPage validates and switches between Sign Up and Sign In',
      (tester) async {
    final persistence = await PersistenceService.create();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserAuthStore(persistence)),
          ChangeNotifierProvider(create: (_) => AppStateStore(persistence)),
        ],
        child: const MaterialApp(home: AuthPage()),
      ),
    );

    expect(find.text('Speak Kannada through Hindi'), findsOneWidget);
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back to SetuLingo'), findsOneWidget);
  });

  testWidgets('LessonPage renders PhraseStep and advances to SpeakPracticeStep',
      (tester) async {
    final persistence = await PersistenceService.create();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppStateStore(persistence)),
          ChangeNotifierProvider(create: (_) => VaultStore(persistence)),
          ChangeNotifierProvider(create: (_) => AudioService()),
        ],
        child: MaterialApp(
          home: LessonPage(lesson: LessonsData.lessons.first),
        ),
      ),
    );

    expect(find.text('STEP 1 OF 4'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('STEP 2 OF 4'), findsOneWidget);
  });
}
