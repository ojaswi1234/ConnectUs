import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ConnectUs/services/session_manager.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _rememberMe = false;
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  final _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _loadLastLoginEmail();
  }

  void _loadLastLoginEmail() async {
    final lastEmail = await _sessionManager.getLastLoginEmail();
    final rememberMe = await _sessionManager.getRememberMe();
    setState(() {
      _email = lastEmail ?? '';
      _rememberMe = rememberMe;
    });
  }

  void _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      await _sessionManager.signInWithGoogle();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Login failed: ${error.toString()}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _validateUser() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    try {
      setState(() => _isLoading = true);
      final response = await _sessionManager.signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
        rememberMe: _rememberMe,
      );
      if (response.session != null && mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${error.toString()}'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 32 : 400, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppTheme.textDark),
                  ),
                ),
                const SizedBox(height: 40),
                const Text('Welcome\nBack!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.textDark, height: 1.2)),
                const SizedBox(height: 8),
                Text('Sign in to continue', style: TextStyle(fontSize: 16, color: AppTheme.textMuted.withOpacity(0.8))),
                const SizedBox(height: 48),
                _GlassInput(hint: 'Email', icon: Icons.email_outlined, onSaved: (v) => _email = v!, validator: (v) => v!.isEmpty ? 'Enter email' : null),
                const SizedBox(height: 20),
                _GlassInput(hint: 'Password', icon: Icons.lock_outline, obscure: true, onSaved: (v) => _password = v!, validator: (v) => v!.isEmpty ? 'Enter password' : null),
                const SizedBox(height: 24),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _rememberMe = !_rememberMe),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: _rememberMe ? AppTheme.coralGradient : null,
                          color: _rememberMe ? null : AppTheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: _rememberMe ? Colors.transparent : AppTheme.receivedBubbleBorder),
                        ),
                        child: _rememberMe ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('Remember me', style: TextStyle(color: AppTheme.textDark, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: _isLoading ? null : _validateUser,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppTheme.coralGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: AppTheme.coral.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                      ],
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _isLoading ? null : _handleGoogleSignIn,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.receivedBubbleBorder),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.g_mobiledata, color: AppTheme.coral, size: 28),
                        const SizedBox(width: 12),
                        const Text('Continue with Google', style: TextStyle(color: AppTheme.textDark, fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/getStarted'),
                    child: const Text("Don't have an account? Sign Up", style: TextStyle(color: AppTheme.coral, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  const _GlassInput({required this.hint, required this.icon, this.obscure = false, this.validator, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardShadow,
      child: TextFormField(
        obscureText: obscure,
        style: const TextStyle(color: AppTheme.textDark),
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.5)),
          prefixIcon: Icon(icon, color: AppTheme.textMuted, size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
