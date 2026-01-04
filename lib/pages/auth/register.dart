import 'dart:io';
import 'package:ConnectUs/services/session_manager.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _sessionManager = SessionManager();

  String _email = '';
  String _password = '';
  bool _isLoading = false;

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() => _isLoading = true);
        // Only perform the Auth Sign Up here. 
        // Profile data will be handled in the next step (RegisterPhone page).
        await Supabase.instance.client.auth.signUp(
          email: _email,
          password: _password,
        );
        // AuthChecker will detect the session and redirect to /registerPhone
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed: $error")));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      await _sessionManager.signInWithGoogle();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Google Registration failed: ${error.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                children: [
                  Text("Register", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.accentDark)),
                  const SizedBox(height: 60),
                  TextFormField(
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppTheme.accent),
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle: TextStyle(color: AppTheme.accentDark),
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
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle: TextStyle(color: AppTheme.accent),
                    ),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentDark,
                      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: _isLoading ? null : () => _submitForm(context),
                    child: _isLoading
                        ? CircularProgressIndicator(color: AppTheme.background)
                        : Text("Register", style: TextStyle(color: AppTheme.background, fontSize: 16.0)),
                  ),
                  const SizedBox(height: 24),
                  Row(children: [
                    Expanded(child: Divider(color: AppTheme.accent.withOpacity(0.5))),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
                    Expanded(child: Divider(color: AppTheme.accent.withOpacity(0.5))),
                  ]),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppTheme.accentDark, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    ),
                    icon: const Icon(Icons.g_mobiledata, size: 32, color: Colors.blue),
                    label: Text("Register with Google", style: TextStyle(color: AppTheme.accentDark, fontSize: 16, fontWeight: FontWeight.bold)),
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                    child: Text("Already have an account? Login", style: TextStyle(color: AppTheme.accentDark)),
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