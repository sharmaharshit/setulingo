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
    const primaryAmber = Color(0xFFFF9E44);
    const bgVoid = Color(0xFF090A10);
    const cardSurface = Color(0xFF13141F);
    const textHigh = Color(0xFFF4F4F8);
    const textMid = Color(0xFF8E92A8);

    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: primaryAmber,
          onPrimary: Color(0xFF1A0E00),
          primaryContainer: Color(0xFF2E1908),
          onPrimaryContainer: Color(0xFFFFD7B3),
          surface: cardSurface,
          onSurface: textHigh,
          surfaceContainer: Color(0xFF191A28),
          surfaceContainerHighest: Color(0xFF222436),
          onSurfaceVariant: textMid,
          outline: Color(0xFF282B3E),
          outlineVariant: Color(0xFF1E2030),
        ),
        scaffoldBackgroundColor: bgVoid,
        cardTheme: CardThemeData(
          color: cardSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFF242738), width: 0.9),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bgVoid,
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
          backgroundColor: const Color(0xFF0D0E17),
          indicatorColor: primaryAmber.withValues(alpha: 0.18),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 11,
              fontWeight: states.contains(WidgetState.selected) ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 0.2,
              color: states.contains(WidgetState.selected) ? primaryAmber : textMid,
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
