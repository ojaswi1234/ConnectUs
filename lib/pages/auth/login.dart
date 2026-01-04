import 'dart:io';
import 'package:ConnectUs/services/session_manager.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  /// NEW: Handle Google Sign-In logic
  void _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      await _sessionManager.signInWithGoogle();
      // Note: Navigation is handled automatically by AuthChecker.dart 
      // when it detects the session change.
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _validateUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      setState(() => _isLoading = true);
      
      final response = await _sessionManager.signInWithEmailAndPassword(
        email: _email.trim(),
        password: _password.trim(),
        rememberMe: _rememberMe,
      );

      if (response.session != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 44 : 400.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentDark,
                    ),
                  ),
                  const SizedBox(height: 60),
                  MaterialButton(
                    onPressed: () {},
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _email,
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppTheme.accent),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppTheme.accent, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      labelStyle: TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                    onSaved: (value) => _email = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: AppTheme.accent),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppTheme.accentDark, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      labelStyle: TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) => setState(() => _rememberMe = value ?? false),
                        activeColor: AppTheme.accent,
                        checkColor: AppTheme.background,
                      ),
                      Text('Remember me', style: TextStyle(color: AppTheme.accent, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentDark,
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: _isLoading ? null : _validateUser,
                    child: _isLoading 
                      ? CircularProgressIndicator(color: AppTheme.background) 
                      : const Text("Login", style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 16)),
                  ),

                  // NEW GOOGLE SIGN IN UI SECTION
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppTheme.accent.withOpacity(0.5))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: Divider(color: AppTheme.accent.withOpacity(0.5))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppTheme.accentDark, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    icon: const Icon(Icons.g_mobiledata, size: 32, color: Colors.blue), // Or use an Image.asset
                    label: Text(
                      "Continue with Google",
                      style: TextStyle(color: AppTheme.accentDark, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                  ),
                  // END GOOGLE SIGN IN UI SECTION

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/getStarted'),
                    child: Text(
                      "Don't have an Account? Sign Up", 
                      style: TextStyle(color: AppTheme.accentDark, fontSize: (!isMobile) ? 16 : 12, fontWeight: FontWeight.w500)
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