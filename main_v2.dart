import 'package:flutter/material.dart';

import 'v2/pages.dart';
import 'v2/store.dart';
import 'v2/tts_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsStore.instance.load();
  await MyWordsStore.instance.load();
  await MySentencesStore.instance.load();
  await TtsService.instance.init();
  runApp(const SetuLingoV2App());
}

class SetuLingoV2App extends StatelessWidget {
  const SetuLingoV2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6D00),
          brightness: Brightness.dark,
          surface: const Color(0xFF141416),
        ),
        scaffoldBackgroundColor: const Color(0xFF0D0D0E),
        cardTheme: CardThemeData(
          color: const Color(0xFF1B1B1E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFF2B2B30), width: 1),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0D0E),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF141416),
          indicatorColor: const Color(0xFFFF6D00).withValues(alpha: 0.25),
        ),
      ),
      home: const HomePage(),
    );
  }
}
