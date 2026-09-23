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
    const primaryMint = Color(0xFF00E5A3);
    const bgSlate = Color(0xFF080A11);
    const cardSurface = Color(0xFF0F1422);
    const textHigh = Color(0xFFFFFFFF);
    const textMid = Color(0xFF94A3B8);

    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryMint,
          onPrimary: Color(0xFF00291B),
          primaryContainer: Color(0xFF063B29),
          onPrimaryContainer: Color(0xFF67FFC9),
          secondary: Color(0xFF6366F1),
          surface: cardSurface,
          onSurface: textHigh,
          surfaceContainer: Color(0xFF161D30),
          surfaceContainerHighest: Color(0xFF1E2740),
          onSurfaceVariant: textMid,
          outline: Color(0xFF1E293B),
          outlineVariant: Color(0xFF141C2B),
        ),
        scaffoldBackgroundColor: bgSlate,
        cardTheme: CardThemeData(
          color: cardSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFF1E293B), width: 1.0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgSlate,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: textHigh,
            letterSpacing: -0.6,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0A0D17),
          indicatorColor: primaryMint.withValues(alpha: 0.15),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 11,
              fontWeight: states.contains(WidgetState.selected) ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 0.2,
              color: states.contains(WidgetState.selected) ? primaryMint : textMid,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
