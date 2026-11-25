import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/global_search_sheet.dart';
import '../widgets/reader_mode_pill.dart';
import 'home_page.dart';
import 'profile_settings_page.dart';
import 'real_spaces_page.dart';
import 'root_bridge_page.dart';
import 'sentence_lab_page.dart';
import 'vault_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _setTab(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        onOpenSentenceLab: () => _setTab(2),
        onOpenRealSpacesTab: () => _setTab(1),
      ),
      const RealSpacesPage(),
      const SentenceLabPage(),
      const RootBridgePage(),
      VaultPage(onJumpToSentenceLab: () => _setTab(2)),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('SetuLingo'),
        actions: [
          IconButton(
            tooltip: 'Search everywhere',
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GlobalSearchPage(onNavigateTab: _setTab),
                ),
              );
            },
          ),
          const ReaderModePill(),
          IconButton(
            tooltip: 'Profile & Settings',
            icon: const Icon(Icons.person_outline_rounded),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProfileSettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: AppTheme.surface,
        indicatorColor: AppTheme.terracottaSoft,
        onDestinationSelected: _setTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: AppTheme.terracotta),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon:
                Icon(Icons.explore_rounded, color: AppTheme.terracotta),
            label: 'Spaces',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune_rounded, color: AppTheme.terracotta),
            label: 'Lab',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon:
                Icon(Icons.account_tree_rounded, color: AppTheme.terracotta),
            label: 'Roots',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmarks_outlined),
            selectedIcon:
                Icon(Icons.bookmarks_rounded, color: AppTheme.terracotta),
            label: 'Vault',
          ),
        ],
      ),
    );
  }
}
