import 'dart:io';

import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Register extends StatelessWidget {
  Register({super.key});
   bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _username = '';
  String _phone = '';
  final width = WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final supabase = Supabase.instance.client;
        final response = await supabase.auth.signUp(
          email: _email,
          password: _password,
        );
        if (response.user != null) {
          // Optionally, you can store additional user info in your database here
          await supabase.from('users').insert({
            'id': response.user!.id,
            'usrname': _username,
            'phone_number': _phone,
           
          });



          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful!")),
          );
          Navigator.of(context).pushReplacementNamed('/home');
        } 
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: $error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:  isMobile ? 44 :  400.0 ),
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
                      showDialog( context: context, builder: (context) => AlertDialog(
                        title: Text("Upload Your Profile Picture", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        content: Container(alignment: Alignment.center, 
                        child: Text("This Feature is in development....\n We believe in privacy")
                       
                        
                        ),
                      )
                  );

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
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person, color: AppTheme.accent),
                      labelText: "Username",
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
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
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
                        child: Text("+91", style: TextStyle(color: AppTheme.accentDark, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 10,),                          
                      ),
                      labelText: "Phone Number",
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
                      labelStyle: TextStyle(color: AppTheme.accentDark, fontSize: 16.0),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phone = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: TextStyle(color: AppTheme.accentDark),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: AppTheme.accent),
                      labelText: "Email",
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
                        borderSide: BorderSide(color: AppTheme.accentDark, width: 2.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0),
                      ),
                      labelStyle: TextStyle(color: AppTheme.accentDark, fontSize: 16.0),
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
                        borderSide: BorderSide(color:AppTheme.accentDark, width: 2.0),
                      ),
                      filled: true,
                      fillColor: AppTheme.background,
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: AppTheme.accentDark, width: 2.0),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentDark,
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                    ),
                    onPressed: () => _submitForm(context),
                    child: Text("Register", style: TextStyle(color: AppTheme.background, fontSize: 16.0)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(fontSize: (!isMobile) ? 18 : 12, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Text("Already have an account? Click here to login", style: TextStyle(color: AppTheme.accentDark, fontSize: (!isMobile) ? 16 : 12)),
                  ),
                  const SizedBox(height: 20),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
       