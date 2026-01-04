import 'dart:io';
import 'package:ConnectUs/services/session_manager.dart'; // Import SessionManager
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _sessionManager = SessionManager(); // Initialize SessionManager

  String _email = '';
  String _password = '';
  String _username = '';
  String _phone = '';
  bool _isLoading = false; // Loading state to handle UI feedback

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Logic for traditional Email/Password registration
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        setState(() => _isLoading = true);
        final response = await Supabase.instance.client.auth.signUp(
          email: _email,
          password: _password,
        );

        if (response.user != null) {
          // Insert basic profile info
          await Supabase.instance.client.from('users').insert({
            'id': response.user!.id,
            'usrname': _username,
          });
          // AuthChecker will automatically catch the 'signedIn' event
          // and redirect to /registerPhone
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed: $error")));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  /// NEW: Logic for Google Registration (Sign-up/Sign-in)
  void _handleGoogleSignIn() async {
    try {
      setState(() => _isLoading = true);
      await _sessionManager.signInWithGoogle();
      // AuthChecker.dart will automatically handle navigation once logged in
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.accentDark,
                    ),
                  ),
                  const SizedBox(height: 60),
                  MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Upload Your Profile Picture",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          content: Container(
                            alignment: Alignment.center,
                            height: 100,
                            child: const Text(
                                "This Feature is in development....\n We believe in privacy"),
                          ),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/profile.png"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: AppTheme.accent),
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: AppTheme.accentDark, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle:
                          TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your username' : null,
                    onSaved: (value) => _username = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: AppTheme.accent),
                      prefix: SizedBox(
                        width: 70,
                        child: Text("+91",
                            style: TextStyle(
                                color: AppTheme.accentDark,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: AppTheme.accent, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle:
                          TextStyle(color: AppTheme.accentDark, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) => value!.isEmpty
                        ? 'Please enter your phone number'
                        : null,
                    onSaved: (value) => _phone = value!,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppTheme.accent),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            BorderSide(color: AppTheme.accentDark, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle:
                          TextStyle(color: AppTheme.accentDark, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
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
                        borderSide:
                            BorderSide(color: AppTheme.accentDark, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      labelStyle:
                          TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                    onSaved: (value) => _password = value!,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentDark,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: _isLoading ? null : () => _submitForm(context),
                    child: _isLoading
                        ? CircularProgressIndicator(color: AppTheme.background)
                        : Text("Register",
                            style: TextStyle(
                                color: AppTheme.background, fontSize: 16.0)),
                  ),

                  // --- NEW GOOGLE REGISTRATION SECTION ---
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                          child:
                              Divider(color: AppTheme.accent.withOpacity(0.5))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("OR",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                          child:
                              Divider(color: AppTheme.accent.withOpacity(0.5))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      side: BorderSide(color: AppTheme.accentDark, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                    icon: const Icon(Icons.g_mobiledata,
                        size: 32, color: Colors.blue),
                    label: Text(
                      "Register with Google",
                      style: TextStyle(
                          color: AppTheme.accentDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
                  ),
                  // --- END GOOGLE REGISTRATION SECTION ---

                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/login'),
                    child: Text(
                      "Already have an account? Click here to login",
                      style: TextStyle(
                          color: AppTheme.accentDark,
                          fontSize: (!isMobile) ? 16 : 12),
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
