import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'v2/pages.dart';
import 'v2/sentence_lab_vocab.dart';
import 'v2/store.dart';
import 'v2/auth_page.dart';
import 'v2/profile_settings.dart';

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
  await UserAuthStore.instance.load();
  runApp(const SetuLingoV2App());
}

/// "Boutique Editorial" — classy matte charcoals, champagne gold accents,
/// and high-legibility linen typography.
class AppColors {
  static const bg = Color(0xFFFAF9F6);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceElevated = Color(0xFFFFFFFF);
  static const surfaceHighest = Color(0xFFF3F0EA);
  static const outline = Color(0xFFE5E0D7);
  static const outlineSoft = Color(0xFFF0EDE7);
  static const marigold = Color(0xFF9A6B22);
  static const marigoldDeep = Color(0xFFF5EBD8);
  static const jacaranda = Color(0xFF75648E);
  static const skyAccent = Color(0xFF66816D);
  static const textHigh = Color(0xFF28251F);
  static const textMid = Color(0xFF69645B);
  static const textFaint = Color(0xFF898277);
  static const success = Color(0xFF557B5D);
  static const successSurface = Color(0xFFEAF3EB);
  static const danger = Color(0xFFB45B5B);
  static const dangerSurface = Color(0xFFF8ECEB);
}

class SetuLingoV2App extends StatelessWidget {
  const SetuLingoV2App({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(ThemeData.light().textTheme);
    final displayFont = GoogleFonts.fraunces;

    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
        textTheme: baseTextTheme.copyWith(
          headlineLarge: displayFont(fontSize: 30, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.4),
          headlineMedium: displayFont(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.3),
          headlineSmall: displayFont(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textHigh, letterSpacing: -0.2),
          titleLarge: displayFont(fontSize: 19, fontWeight: FontWeight.w600, color: AppColors.textHigh),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppColors.marigold,
          onPrimary: Color(0xFF2B1B02),
          primaryContainer: AppColors.marigoldDeep,
          onPrimaryContainer: AppColors.marigold,
          secondary: AppColors.jacaranda,
          onSecondary: AppColors.textHigh,
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
            borderRadius: BorderRadius.circular(16),
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
          backgroundColor: AppColors.surface,
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
      home: ListenableBuilder(
        listenable: UserAuthStore.instance,
        builder: (context, _) {
          return UserAuthStore.instance.isLoggedIn ? const HomePage() : const AuthPage();
        },
      ),
    );
  }
}
