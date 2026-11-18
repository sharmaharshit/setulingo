import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'content.dart';
import 'grammar_content.dart';
import 'lesson_page.dart';
import 'profile_settings.dart';
import 'quiz_page.dart';
import 'search_page.dart';
import 'store.dart';
import 'widgets.dart';

void _open(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => page));
}

/// Lets any screen jump to a bottom-nav tab.
class HomeTabs {
  static const int situations = 0;
  static const int sentenceLab = 1;
  static const int vault = 2;

  static final ValueNotifier<int?> request = ValueNotifier<int?>(null);

  static void go(BuildContext context, int tab) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    request.value = tab;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  final List<Widget> _pages = const [
    CommunicatePage(),
    SentenceLabPage(),
    MyWordsPage(),
  ];

  void _onTabRequest() {
    final requested = HomeTabs.request.value;
    if (requested == null) return;
    HomeTabs.request.value = null;
    if (!mounted || requested < 0 || requested >= _pages.length) return;
    setState(() => _tab = requested);
  }

  @override
  void dispose() {
    HomeTabs.request.
