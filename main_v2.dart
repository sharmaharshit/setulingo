import 'package:flutter/material.dart';

import 'v2/pages.dart';
import 'v2/store.dart';

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
    const primaryGold = Color(0xFFF3A762);
    const bgObsidian = Color(0xFF0C0C0E);
    const cardSurface = Color(0xFF16161B);
    const textHigh = Color(0xFFF4F4F7);
    const textMid = Color(0xFFA2A2AE);

    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryGold,
          onPrimary: Color(0xFF1F1200),
          primaryContainer: Color(0xFF2E1C0F),
          onPrimaryContainer: Color(0xFFFFDBC0),
          surface: cardSurface,
          onSurface: textHigh,
          surfaceContainer: Color(0xFF1A1A21),
          surfaceContainerHighest: Color(0xFF24242E),
          onSurfaceVariant: textMid,
          outline: Color(0xFF2F2F3B),
          outlineVariant: Color(0xFF23232D),
        ),
        scaffoldBackgroundColor: bgObsidian,
        cardTheme: CardThemeData(
          color: cardSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF272733), width: 0.8),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            color: textHigh,
            height: 1.15,
          ),
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: textHigh,
            height: 1.25,
          ),
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
            color: textHigh,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: Color(0xFFDCDCE2),
            height: 1.45,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            color: textMid,
            height: 1.4,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
            color: primaryGold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgObsidian,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: textHigh,
            letterSpacing: -0.5,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF101014),
          indicatorColor: primaryGold.withValues(alpha: 0.18),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 12,
              fontWeight: states.contains(WidgetState.selected) ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 0.2,
              color: states.contains(WidgetState.selected) ? primaryGold : textMid,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
