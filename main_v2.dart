import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'v2/pages.dart';
import 'v2/sentence_lab_vocab.dart';
import 'v2/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettingsStore.instance.load();
  await MyWordsStore.instance.load();
  await MySentencesStore.instance.load();
  await TtsService.instance.init();
  await ProfileStore.instance.load();
  await AppPreferencesStore.instance.load();
  await LearningPathStore.instance.load();
  await GamificationStore.instance.load();
  await SentenceLabVocabStore.instance.load();
  await HelperBannerStore.instance.load();
  runApp(const SetuLingoV2App());
}

/// "Bengaluru Dusk" — a warm, editorial dark theme built around the amber
/// streetlights and jacaranda-violet evenings of the city, instead of a
/// generic dark-mode blue. Fraunces (serif, warm, a little literary) carries
/// headlines; Plus Jakarta Sans (clean geometric sans) carries UI and body.
class AppColors {
  static const bg = Color(0xFF0B0710);
  static const surface = Color(0xFF150F1E);
  static const surfaceElevated = Color(0xFF1E1730);
  static const surfaceHighest = Color(0xFF281F3D);
  static const outline = Color(0xFF2C2340);
  static const outlineSoft = Color(0xFF1F1830);

  static const marigold = Color(0xFFF2A93B);
  static const marigoldDeep = Color(0xFF3D2A0E);
  static const jacaranda = Color(0xFF9B7BF0);
  static const skyAccent = Color(0xFF5FD4C8);

  static const textHigh = Color(0xFFF7F3FB);
  static const textMid = Color(0xFFB6A8CC);
  static const textFaint = Color(0xFF7C6E94);

  static const success = Color(0xFF5FD4A0);
  static const danger = Color(0xFFE8697A);
}

class SetuLingoV2App extends StatelessWidget {
  const SetuLingoV2App({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme);
    final displayFont = GoogleFonts.fraunces;

    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        textTheme: baseTextTheme.copyWith(
          headlineLarge: displayFont(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.4),
          headlineMedium: displayFont(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.3),
          headlineSmall: displayFont(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.2),
          titleLarge: displayFont(fontSize: 19, fontWeight: FontWeight.w600, color: AppColors.textHigh),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.marigold,
          onPrimary: Color(0xFF2B1B02),
          primaryContainer: AppColors.marigoldDeep,
          onPrimaryContainer: AppColors.marigold,
          secondary: AppColors.jacaranda,
          onSecondary: Colors.white,
          tertiary: AppColors.skyAccent,
          surface: AppColors.surface,
          onSurface: AppColors.textHigh,
          surfaceContainer: AppColors.surfaceElevated,
          surfaceContainerHighest: AppColors.surfaceHighest,
          onSurfaceVariant: AppColors.textMid,
          outline: AppColors.outline,
          outlineVariant: AppColors.outlineSoft,
          error: AppColors.danger,
        ),
        scaffoldBackgroundColor: AppColors.bg,
        cardTheme: CardThemeData(
          color: AppColors.surfaceElevated,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.outline, width: 1.0),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.bg,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: displayFont(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColors.textHigh,
            letterSpacing: -0.3,
          ),
          iconTheme: const IconThemeData(color: AppColors.textHigh),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF0E0816),
          indicatorColor: AppColors.marigold.withValues(alpha: 0.16),
          height: 64,
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 11,
              fontWeight: states.contains(WidgetState.selected) ? FontWeight.w800 : FontWeight.w500,
              letterSpacing: 0.2,
              color: states.contains(WidgetState.selected) ? AppColors.marigold : AppColors.textFaint,
            ),
          ),
        ),
        dividerTheme: const DividerThemeData(color: AppColors.outlineSoft, thickness: 1),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.surfaceHighest,
          side: const BorderSide(color: AppColors.outline),
          labelStyle: const TextStyle(color: AppColors.textHigh, fontWeight: FontWeight.w600, fontSize: 13),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.surfaceHighest,
          contentTextStyle: const TextStyle(color: AppColors.textHigh),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.marigold,
          unselectedLabelColor: AppColors.textFaint,
          indicatorColor: AppColors.marigold,
        ),
      ),
      home: const HomePage(),
    );
  }
}
