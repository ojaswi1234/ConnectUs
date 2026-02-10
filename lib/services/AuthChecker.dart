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

    // 1. Try auto-login (session persistence)
    final autoLoginSuccess = await _sessionManager.tryAutoLogin();
    if (autoLoginSuccess && mounted) {
      await _checkProfileAndNavigate();
      return;
    }

    // 2. Check current session
    _checkSession();

    // 3. Listen for real-time auth changes (like Google Login completion)
    _listenToAuthChanges();
  }

  Future<void> _checkProfileAndNavigate() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      // Check if user has a phone number in the public 'users' table
      final data = await _supabase
          .from('users')
          .select('phone_number, usrname')
          .eq('id', user.id)
          .maybeSingle();

      if (mounted) {
        // If user record doesn't exist OR phone_number is null, go to RegisterPhone
        if (data == null ||
            data['phone_number'] == null ||
            data['usrname'] == null) {
          Navigator.of(context).pushReplacementNamed('/registerPhone');
        } else {
          // Profile complete -> Home
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      debugPrint('Error checking profile: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _checkSession() async {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      await _checkProfileAndNavigate();
    } else {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _listenToAuthChanges() {
    _supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        _checkProfileAndNavigate();
      } else if (data.event == AuthChangeEvent.signedOut) {
        if (mounted) Navigator.of(context).pushReplacementNamed('/landing');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('assets/images/logo.png'), height: 150),
              SizedBox(height: 32),
              CircularProgressIndicator(color: AppTheme.accentDark),
            ],
          ),
        ),
      );
    }
    return const Landing();
  }
}
