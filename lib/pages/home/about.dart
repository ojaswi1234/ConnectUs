import 'package:flutter/material.dart';
import 'package:Sutra/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
   About({super.key});
final Uri _url = Uri.parse('mailto:Ojaswideep2020@Outlook.com');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: AppTheme.background,
      appBar: AppBar(
      title: const Text('About'),
      centerTitle: true,
      backgroundColor: AppTheme.accentDark,
      foregroundColor: Colors.black,
      ),
      body: 
      Container(
        decoration: BoxDecoration(
          color: AppTheme.background, // Background: Dark Gray-Black
        ),
        child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
          Icons.info_outline,
          size: 64,
          color: AppTheme.highlight,
          ),
          const SizedBox(height: 24),
          Text(
          'सूत्र',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.accent, // Text: Warm Yellow
          ),
          ),
          const SizedBox(height: 12),
          Text(
          'A modern app built with Flutter.\nStay connected and enjoy a seamless experience.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.accent.withOpacity(0.9), // Text: Warm Yellow
          ),
          ),
          const SizedBox(height: 24),
          const Text("Developer: Ojaswi Bhardwaj",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Handle email action
              launchUrl(_url);
            },
            style: AppTheme.elevatedButtonStyle,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text('Ojaswideep2020@Outlook.com)'),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse('https://github.com/ojaswi1234'));
            },
            child: Text("ojaswi1234 (GitHub)", style: TextStyle(
              color: AppTheme.accent, // Text: Warm Yellow
              decoration: TextDecoration.underline,
            )),
          )
        ],
      ),
      ),
      ),
      ),
    );
  }
  
  
}