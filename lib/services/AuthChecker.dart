import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/pages/landing.dart';
import 'session_manager.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  bool _isLoading = true;
  final _supabase = Supabase.instance.client;
  final _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  void _initializeSession() async {
    await _sessionManager.initialize();

    // Try auto-login first
    final autoLoginSuccess = await _sessionManager.tryAutoLogin();
    if (autoLoginSuccess && mounted) {
      await _checkProfileAndNavigate(); // Check phone before home
      return;
    }

    _checkSession();
    _listenToAuthChanges();
  }

  /// NEW: Centralized check for profile completeness
  Future<void> _checkProfileAndNavigate() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      // Check if the user has a phone number in your public 'users' table
      final data = await _supabase
          .from('users')
          .select('phone_number')
          .eq('id', user.id)
          .maybeSingle();

      if (mounted) {
        if (data == null || data['phone_number'] == null) {
          // Logged in but no phone -> Onboarding
          Navigator.of(context).pushReplacementNamed('/registerPhone');
        } else {
          // Fully registered -> Home
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _checkSession() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session != null) {
        final user = await _supabase.auth.getUser();
        if (user.user != null) {
          await _checkProfileAndNavigate(); // Keep logic intact
          return;
        }
      }
      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _listenToAuthChanges() {
    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        _checkProfileAndNavigate(); // Redirect to phone check if needed
      } else if (data.event == AuthChangeEvent.signedOut) {
        if (mounted) Navigator.of(context).pushReplacementNamed('/landing');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/images/logo.png'),
                  height: 250,
                  width: 250),
              const SizedBox(height: 32),
              CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.accentDark)),
              const SizedBox(height: 32),
              const Text("Checking Authentication...",
                  style: TextStyle(color: AppTheme.accent)),
            ],
          ),
        ),
      );
    }
    return const Landing();
  }
}
