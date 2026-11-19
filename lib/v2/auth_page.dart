import 'package:flutter/material.dart';
import '../main_v2.dart';
import 'profile_settings.dart';
import 'pages.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isPhoneMode = true;
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number or email.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    // Offline profile sign-in only; no OTP or OAuth verification is configured.

    await UserAuthStore.instance.login(_controller.text.trim());

    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'SetuLingo 🇮🇳',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Spoken Kannada for Bengaluru Live & Survival',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.textMid),
                  ),
                  const SizedBox(height: 36),
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment<bool>(value: true, label: Text('Phone Number'), icon: Icon(Icons.phone_outlined)),
                      ButtonSegment<bool>(value: false, label: Text('Gmail / Email'), icon: Icon(Icons.email_outlined)),
                    ],
                    selected: {_isPhoneMode},
                    onSelectionChanged: (Set<bool> newSelection) {
                      setState(() {
                        _isPhoneMode = newSelection.first;
                        _controller.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    keyboardType: _isPhoneMode ? TextInputType.phone : TextInputType.emailAddress,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textHigh),
                    decoration: InputDecoration(
                      labelText: _isPhoneMode ? 'Phone Number (e.g. +91 98765 43210)' : 'Gmail Address',
                      prefixIcon: Icon(_isPhoneMode ? Icons.phone : Icons.email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: AppColors.marigold, foregroundColor: const Color(0xFF2B1B02)),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2B1B02)),
                            )
                          : Text(
                              _isPhoneMode ? 'Continue with Phone' : 'Continue with Email',
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Offline profile sign-in: your phone number or email is saved on this device. OTP verification, Google sign-in, and cloud sync are not configured yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: AppColors.textFaint, height: 1.4),
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
