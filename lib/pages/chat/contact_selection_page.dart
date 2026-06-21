import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class ContactSelectionPage extends StatefulWidget {
  final File? imageFile;
  const ContactSelectionPage({super.key, required this.imageFile});

  @override
  State<ContactSelectionPage> createState() => _ContactSelectionPageState();
}

class _ContactSelectionPageState extends State<ContactSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Send Photo', style: TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.imageFile != null)
              Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20)],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.file(widget.imageFile!, height: 300, fit: BoxFit.cover),
                ),
              ),
            const SizedBox(height: 32),
            const Icon(Icons.build_circle_outlined, size: 64, color: AppTheme.coral),
            const SizedBox(height: 16),
            const Text(
              "Feature in Development",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark),
            ),
            const SizedBox(height: 8),
            Text(
              "Selecting contacts to send media\nis coming soon!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppTheme.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}