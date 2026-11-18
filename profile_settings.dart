import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'store.dart';
import 'widgets.dart';

class UserAuthStore extends ChangeNotifier {
  UserAuthStore._();
  static final UserAuthStore instance = UserAuthStore._();

  bool isLoggedIn = false;
  String userIdentifier = '';

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool('auth_logged_in') ?? false;
      userIdentifier = prefs.getString('auth_identifier') ?? '';
    } catch (_) {}
    notifyListeners();
  }

  Future<void> login(String identifier) async {
    isLoggedIn = true;
    userIdentifier = identifier;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth_logged_in', true);
      await prefs.setString('auth_identifier', identifier);
    } catch (_) {}
  }

  Future<void> logout() async {
    isLoggedIn = false;
    userIdentifier = '';
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('auth_logged_in', false);
      await prefs.remove('auth_identifier');
    } catch (_) {}
  }
}

class ProfileEntryAction extends StatelessWidget {
  const ProfileEntryAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_outline),
      tooltip: 'Profile & Settings',
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileSettingsPage())),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = UserAuthStore.instance;

    return ListenableBuilder(
      listenable: auth,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Profile & Settings')),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.outline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('👤 User Account', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.marigold)),
                    const SizedBox(height: 8),
                    Text(
                      auth.isLoggedIn ? auth.userIdentifier : 'Not Signed In',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textHigh),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      auth.isLoggedIn ? 'Account data synced securely.' : 'Sign in to save and sync your spoken Kannada progress.',
                      style: const TextStyle(fontSize: 12, color: AppColors.textMid),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (auth.isLoggedIn) {
                            await auth.logout();
                          } else {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthPage()));
                          }
                        },
                        child: Text(auth.isLoggedIn ? 'Sign Out' : 'Sign In Now', style: const TextStyle(fontWeight: FontWeight.w800)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('App Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textFaint)),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.translate, color: AppColors.marigold),
                  title: const Text('Script Mode', style: TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: const Text('Toggle between Roman Hindi and Devanagari script'),
                  trailing: const ScriptToggleAction(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
