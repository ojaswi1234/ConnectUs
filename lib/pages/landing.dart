import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



// Theme colors
const kPrimaryColor = Color(0xFFA67B00); // Dark Yellow
const kSecondaryColor = Color(0xFFFFC107); // Amber
const kBackgroundColor = Color(0xFF1E1E1E); // Dark Gray-Black
const kAccentColor = Color(0xFFFFCA28); // Light Amber
const kTextColor = Color(0xFFFFD54F); // Warm Yellow


class Landing extends StatelessWidget {
  const Landing({
    super.key
    });
    
 bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    @override
    Widget build(BuildContext context) {
      
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              AvatarGlow(
                glowColor: kSecondaryColor,
                duration: const Duration(seconds: 2),
                repeat: true,
                animate: true,
                glowRadiusFactor: 0.2,

              child:ClipOval(
             child:  Image.asset(
                'assets/images/removebg.png',
                width: 220,
                height: 220,
                color: Colors.yellow,
                
                colorBlendMode: BlendMode.difference
              ),
              ),
              ),
              const SizedBox(height: 30),
              const Text(
                "सूत्र",
                style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'EduNSWACTCursive',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "A place to connect with friends",
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 13,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/getStarted');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: kBackgroundColor,
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                child: const Text("Get Started", style: TextStyle(color: kBackgroundColor, fontSize: 16)),
              ),
            ],
          ),
        ),
      );
    }
  }
     