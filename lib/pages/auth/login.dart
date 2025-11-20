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

  final width = WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio;

  // Update your existing Login class
void _validateUser() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }
  _formKey.currentState!.save();

  try {
    setState(() => _isLoading = true);
    
    // Use SessionManager for enhanced login with remember me
    final response = await _sessionManager.signInWithEmailAndPassword(
      email: _email.trim(),
      password: _password.trim(),
      rememberMe: _rememberMe,
    );

    if (response.session != null) {
      print('✅ Login successful, session created');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to home page
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
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 44 :  400.0 ),
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
                    onPressed: () {
                      print("Pressed");
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                        "assets/images/profile.png",
                      ),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppTheme.accent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      labelStyle: TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
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
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppTheme.accent, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      labelStyle: TextStyle(color: AppTheme.accent, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Remember Me Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        activeColor: AppTheme.accent,
                        checkColor: AppTheme.background,
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          color: AppTheme.accent,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentDark,
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: _isLoading ? null : () {
                      _validateUser();
                    },
                    child: _isLoading 
                      ? CircularProgressIndicator(color: AppTheme.accentDark) 
                      : Text("Login", style: TextStyle(color: Color(0xFF1E1E1E), fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(fontSize: (!isMobile) ? 18 : 12),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/getStarted');
                    },
                    child: Text("Don't have an Account? Sign Up", style: TextStyle(color: AppTheme.accentDark, fontSize: (!isMobile) ? 16 : 12, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 20),
                 /*  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/loginPhone');
                    },
                    color: kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    child: Text("Use Phone Number Instead", style: TextStyle(color: kBackgroundColor, fontSize: 16)),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}