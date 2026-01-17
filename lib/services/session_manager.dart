import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  final _supabase = Supabase.instance.client;
  final _logger = Logger();
  SharedPreferences? _prefs;

  // Keys for storing session data
  static const String _keyRememberMe = 'remember_me';
  static const String _keyLastLoginEmail = 'last_login_email';
  static const String _keySessionExpiry = 'session_expiry';

  /// Initialize session manager
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _logger.i('SessionManager initialized');
  }

  /// Check if user wants to stay logged in
  Future<bool> getRememberMe() async {
    await _ensureInitialized();
    return _prefs?.getBool(_keyRememberMe) ?? false;
  }

  /// Set remember me preference
  Future<void> setRememberMe(bool remember) async {
    await _ensureInitialized();
    await _prefs?.setBool(_keyRememberMe, remember);
    _logger.i('Remember me set to: $remember');
  }

  /// Save last login email
  Future<void> saveLastLoginEmail(String email) async {
    await _ensureInitialized();
    await _prefs?.setString(_keyLastLoginEmail, email);
  }

  /// Get last login email
  Future<String?> getLastLoginEmail() async {
    await _ensureInitialized();
    return _prefs?.getString(_keyLastLoginEmail);
  }

  /// Check if current session is valid
/// Check if current session is valid AND recover it if expired
 /// Check if current session is valid AND recover it if expired
  Future<bool> isSessionValid() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return false;

      final expiresAt = session.expiresAt;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // FIX: If token is expired (or close to it), try to refresh immediately
      // instead of declaring the session invalid.
      if (expiresAt != null && now >= (expiresAt - 60)) { 
        _logger.i('Token expired. Attempting to refresh session...');
        
        try {
          // This uses the long-lived "Refresh Token" to get a new session
          final response = await _supabase.auth.refreshSession();
          
          if (response.session != null) {
             _logger.i('Session successfully recovered via refresh');
             return true; 
          } else {
             _logger.w('Refresh failed: No session returned.');
             return false; // Real logout: Refresh token is invalid/revoked
          }
        } catch (e) {
          _logger.w('Failed to refresh expired session: $e');
          return false; // Real logout: Network or auth error
        }
      }

      return true;
    } catch (e) {
      _logger.e('Session validation error: $e');
      return false;
    }
  }

  /// Refresh session token if needed
  Future<bool> refreshSessionIfNeeded() async {
    try {
      final session = _supabase.auth.currentSession;
      if (session == null) return false;

      // Check if token expires within next 5 minutes
      final expiresAt = session.expiresAt;
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (expiresAt != null && (expiresAt - now) < 300) {
        // 5 minutes
        _logger.i('Refreshing session token...');
        final response = await _supabase.auth.refreshSession();
        if (response.session != null) {
          _logger.i('Session refreshed successfully');
          return true;
        }
      }

      return true;
    } catch (e) {
      _logger.e('Session refresh error: $e');
      return false;
    }
  }

  /// Enhanced login with remember me functionality
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        await setRememberMe(rememberMe);
        await saveLastLoginEmail(email);
        _logger.i('Login successful with remember me: $rememberMe');
      }

      return response;
    } catch (e) {
      _logger.e('Login error: $e');
      rethrow;
    }
  }

  /// NEW: Sign in with Google OAuth
  Future<void> signInWithGoogle() async {
    try {
      _logger.i('Starting Google Sign-In with Deep Linking...');

      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        // redirectTo must match exactly what you put in Supabase Dashboard
        redirectTo: kIsWeb ? null : 'io.supabase.connectus://login-callback/',
        // Forces the browser to open externally so it can redirect back
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
    } catch (e) {
      _logger.e('Google Sign-In error: $e');
      rethrow;
    }
  }

  /// Sign out and clear session data
  Future<void> signOut({bool clearRememberMe = false}) async {
    try {
      await _supabase.auth.signOut();

      if (clearRememberMe) {
        await setRememberMe(false);
        await _prefs?.remove(_keyLastLoginEmail);
        _logger.i('Signed out and cleared remember me data');
      } else {
        _logger.i('Signed out but kept remember me settings');
      }
    } catch (e) {
      _logger.e('Sign out error: $e');
      rethrow;
    }
  }

  /// Get current user info
  User? get currentUser => _supabase.auth.currentUser;

  /// Check if user is currently logged in
  bool get isLoggedIn => currentUser != null;

  /// Ensure SharedPreferences is initialized
  Future<void> _ensureInitialized() async {
    if (_prefs == null) {
      await initialize();
    }
  }

  /// Auto-login if remember me is enabled and session is valid
  /// Auto-login: Always try to restore session if one exists
  Future<bool> tryAutoLogin() async {
    try {
      // REMOVED: The check for 'rememberMe'. 
      // We now assume we always want to restore if a session exists.
      
      final session = _supabase.auth.currentSession;
      if (session == null) {
        return false; // No session stored, user must log in
      }

      // Check validity and refresh if needed
      final isValid = await isSessionValid();
      if (isValid) {
        await refreshSessionIfNeeded();
        _logger.i('Auto-login successful');
        return true;
      }

      _logger.w('Auto-login failed - session invalid and could not be refreshed');
      return false;
    } catch (e) {
      _logger.e('Auto-login error: $e');
      return false;
    }
  }
  /// Clear all session data (for debugging)
  Future<void> clearAllSessionData() async {
    await _ensureInitialized();
    await _prefs?.clear();
    await _supabase.auth.signOut();
    _logger.w('All session data cleared');
  }
}
