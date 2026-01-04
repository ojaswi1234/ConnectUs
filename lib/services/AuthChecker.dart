
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'session_manager.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final _supabase = Supabase.instance.client;
  final _sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    _initializeSession();
  }

  void _initializeSession() async {
    // A small delay to ensure the widget is mounted and context is available.
    await Future.delayed(Duration.zero);
    if (!mounted) return;

    await _sessionManager.initialize();

    // Set up the listener for auth state changes.
    _listenToAuthChanges();

    // Attempt to log in automatically.
    final autoLoginSuccess = await _sessionManager.tryAutoLogin();
    if (autoLoginSuccess) {
      // If auto-login is successful, the auth state change listener will trigger
      // the navigation. We can return early.
      return;
    }

    // If auto-login fails, manually check for an existing session.
    final session = _supabase.auth.currentSession;
    if (session != null) {
      await _checkProfileAndNavigate();
    } else {
      // If there's no session, navigate to the landing page.
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/landing');
      }
    }
  }

  Future<void> _checkProfileAndNavigate() async {
    if (!mounted) return;

    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        // If there's no user, navigate to the landing page.
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/landing');
        }
        return;
      }

      // Check for user profile to determine navigation.
      final data = await _supabase
          .from('users')
          .select('phone_number')
          .eq('id', user.id)
          .maybeSingle();

      if (mounted) {
        if (data == null || data['phone_number'] == null) {
          // If no phone number, go to phone registration.
          Navigator.of(context).pushReplacementNamed('/registerPhone');
        } else {
          // If profile is complete, go to the home page.
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (e) {
      // As a fallback in case of an error, navigate to the landing page.
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/landing');
      }
    }
  }

  void _listenToAuthChanges() {
    _supabase.auth.onAuthStateChange.listen((data) {
      if (!mounted) return;

      if (data.event == AuthChangeEvent.signedIn) {
        _checkProfileAndNavigate();
      } else if (data.event == AuthChangeEvent.signedOut) {
        // On sign out, go to the landing page.
        Navigator.of(context).pushReplacementNamed('/landing');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This widget's sole purpose is to check auth and redirect.
    // It should only display a loading indicator.
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 32),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentDark),
            ),
            const SizedBox(height: 32),
            const Text(
              "Checking Authentication...",
              style: TextStyle(color: AppTheme.accent),
            ),
          ],
        ),
      ),
    );
  }
}
