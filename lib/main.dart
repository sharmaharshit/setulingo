import 'package:flutter/material.dart';
import 'data/app_database.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await AppDatabase.instance.database;
  await AppDatabase.instance.seedIfNeeded(db);
  runApp(const SetuLingoApp());
}

class SetuLingoApp extends StatelessWidget {
  const SetuLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5B4BDB);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SetuLingo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        scaffoldBackgroundColor: const Color(0xFFF8F7FC),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
      ),
      home: const HomeScreen(),
    );
  }
}
