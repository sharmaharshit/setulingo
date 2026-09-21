import 'package:flutter/material.dart';

import 'v2/pages.dart';
import 'v2/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyWordsStore.instance.load();
  runApp(const SetuLingoV2App());
}

class SetuLingoV2App extends StatelessWidget {
  const SetuLingoV2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SetuLingo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD84315),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF7),
      ),
      home: const HomePage(),
    );
  }
}
