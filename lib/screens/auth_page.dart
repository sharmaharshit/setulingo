import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../stores/user_auth_store.dart';
import '../theme/app_theme.dart';
import '../widgets/reader_mode_pill.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isSignUp = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _signInIdentifierController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _signInIdentifierController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final auth = context.read<UserAuthStore>();
    bool success;
    if (_isSignUp) {
      success = await auth.signUp(
        displayName: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
      );
    } else {
      success = await auth.signIn(
        identifier: _signInIdentifierController.text,
      );
    }

    if (mounted) {
      setState(() => _isSubmitting = false);
      if (!success && auth.lastError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(auth.lastError!),
            backgroundColor: AppTheme.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.paper,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.terracottaSoft,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'SETULINGO · सेतुलिंगो',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: AppTheme.terracotta,
                          ),
                        ),
                      ),
                      const ReaderModePill(),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _isSignUp
                        ? 'Speak Kannada through Hindi'
                        : 'Welcome back to SetuLingo',
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isSignUp
                        ? 'बिना कन्नड़ लिपि सीखे, देवनागरी और रोमन हिंदी के साथ रोज़मर्रा की कन्नड़ बोलना सीखें।'
                        : 'Sign in with your phone number or Gmail/email to continue your saved progress.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.indigoSoft,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.indigo.withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.devices_rounded,
                          size: 18,
                          color: AppTheme.indigo,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Local Authentication Mode: Your profile and progress are saved securely on this device. Phone and email are not remotely verified.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.indigo,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceSubtle,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _ModeTab(
                            label: 'Create Profile (Sign Up)',
                            selected: _isSignUp,
                            onTap: () => setState(() => _isSignUp = true),
                          ),
                        ),
                        Expanded(
                          child: _ModeTab(
                            label: 'Sign In',
                            selected: !_isSignUp,
                            onTap: () => setState(() => _isSignUp = false),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_isSignUp) ...[
                          TextFormField(
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              labelText: 'Full Name (आपका नाम)',
                              hintText: 'e.g., Aarav Sharma',
                              prefixIcon: Icon(Icons.person_outline_rounded),
                            ),
                            validator: (v) {
                              if ((v ?? '').trim().length < 2) {
                                return 'Please enter at least 2 characters.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number (फ़ोन नंबर)',
                              hintText: '+91 9876543210',
                              prefixIcon: Icon(Icons.phone_outlined),
                            ),
                            validator: UserAuthStore.validatePhone,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Gmail / Email',
                              hintText: 'name@gmail.com',
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                            ),
                            validator: UserAuthStore.validateEmail,
                          ),
                        ] else ...[
                          TextFormField(
                            controller: _signInIdentifierController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number or Gmail / Email',
                              hintText: 'name@gmail.com or +91 9876543210',
                              prefixIcon: Icon(Icons.login_rounded),
                            ),
                            validator: (v) {
                              final raw = (v ?? '').trim();
                              if (raw.isEmpty) {
                                return 'Enter your phone number or email.';
                              }
                              if (raw.contains('@')) {
                                return UserAuthStore.validateEmail(raw);
                              }
                              return UserAuthStore.validatePhone(raw);
                            },
                          ),
                        ],
                        const SizedBox(height: 22),
                        ElevatedButton(
                          onPressed: _isSubmitting ? null : _submit,
                          child: _isSubmitting
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  _isSignUp
                                      ? 'Start Learning Kannada'
                                      : 'Continue Learning',
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ModeTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? AppTheme.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          border: selected ? Border.all(color: AppTheme.border) : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? AppTheme.ink : AppTheme.inkMuted,
          ),
        ),
      ),
    );
  }
}
