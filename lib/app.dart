import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../screens/auth_page.dart';
import '../screens/main_shell.dart';
import '../services/audio_service.dart';
import '../services/persistence_service.dart';
import '../stores/app_state_store.dart';
import '../stores/user_auth_store.dart';
import '../stores/vault_store.dart';
import '../theme/app_theme.dart';

class SetuLingoApp extends StatelessWidget {
  final PersistenceService persistence;
  final AudioService? audioService;

  const SetuLingoApp({
    super.key,
    required this.persistence,
    this.audioService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthStore>(
          create: (_) => UserAuthStore(persistence),
        ),
        ChangeNotifierProvider<AppStateStore>(
          create: (_) => AppStateStore(persistence),
        ),
        ChangeNotifierProvider<VaultStore>(
          create: (_) => VaultStore(persistence),
        ),
        ChangeNotifierProvider<AudioService>(
          create: (ctx) {
            final service = audioService ?? AudioService();
            final prefs = ctx.read<AppStateStore>().audioPreferences;
            service.initialize(prefs: prefs);
            return service;
          },
        ),
      ],
      child: MaterialApp(
        title: 'SetuLingo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const _RootGate(),
      ),
    );
  }
}

class _RootGate extends StatelessWidget {
  const _RootGate();

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.watch<UserAuthStore>().isAuthenticated;
    return isAuthenticated ? const MainShell() : const AuthPage();
  }
}
