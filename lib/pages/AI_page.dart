import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class AI_Page extends StatefulWidget {
  const AI_Page({super.key});

  @override
  State<AI_Page> createState() => _AI_PageState();
}

class _AI_PageState extends State<AI_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConnectiFy'),
        centerTitle: true,
        backgroundColor: AppTheme.accentDark,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),

      body: Container(
        color: AppTheme.background,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.smart_toy, size: 100, color: AppTheme.accent),
            const SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'AI Feature Coming Soon.......',
                  textStyle: const TextStyle(
                    color: AppTheme.accent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              onTap: () {
                // noop
              },
            ),
          ],
        ),
      ),
    );
  }
}