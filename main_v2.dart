import 'package:flutter/material.dart';

import 'v2/pages.dart';
import 'v2/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyWordsStore.instance.load();
  await MySentencesStore.instance.load();
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
          seedColor: const Color(0xFFE65100),
          brightness: Brightness.dark,
          surface: const Color(0xFF141414),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        cardTheme: CardTheme(
          color: const Color(0xFF1C1C1E),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF2C2C2E), width: 1),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F),
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF141414),
          indicatorColor: const Color(0xFFE65100).withValues(alpha: 0.3),
        ),
      ),
      home: const HomePage(),
    );
  }
}
