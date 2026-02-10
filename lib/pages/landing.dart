import 'dart:io';

import 'package:ConnectUs/utils/app_theme.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Theme colors

class Landing extends StatelessWidget {
  const Landing({super.key});

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: !isMobile ? 80 : 170),
              AvatarGlow(
                glowColor: AppTheme.accent,
                duration: const Duration(seconds: 2),
                repeat: true,
                animate: true,
                glowRadiusFactor: 0.2,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/removebg.png',
                    width: 220,
                    height: 220,
                    color: AppTheme.accentDark,
                    colorBlendMode: BlendMode.softLight,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "ConnectUs",
                style: TextStyle(
                  color: AppTheme.accentDark,
                  fontFamily: 'EduNSWACTCursive',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Chat, Connect, Grow",
                style: TextStyle(
                  color: AppTheme.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 50),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/getStarted');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: AppTheme.accentDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                textColor: const Color.fromARGB(255, 41, 24, 24),
                minWidth: isMobile ? 330 : 150,
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    color: AppTheme.background,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: isMobile ? 50 : 100,
                  width: isMobile ? 330 : double.infinity,
                  child: isMobile
                      ? null
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              child: const Text("Try our Android App",
                                  style: TextStyle(color: AppTheme.accent)),
                              onPressed: () {},
                            ),
                            const VerticalDivider(
                              color: AppTheme.accent,
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                            ),
                            TextButton(
                              child: const Text(
                                "Try our iOS App",
                                style: TextStyle(color: AppTheme.accent),
                              ),
                              onPressed: () {},
                            ),
                            const VerticalDivider(
                              color: AppTheme.accent,
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                            ),
                            TextButton(
                              child: const Text("Try our Desktop App",
                                  style: TextStyle(color: AppTheme.accent)),
                              onPressed: () {},
                            )
                          ],
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
