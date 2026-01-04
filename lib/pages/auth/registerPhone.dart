import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  /// Directly saves the phone number to the database without OTP
  Future<void> _savePhoneNumber() async {
    final phoneInput = _phoneController.text.trim();

    if (phoneInput.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter a valid 10-digit phone number")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception("User not authenticated");

      final formattedPhone = '+91$phoneInput';

      // Use upsert to create or update the user record
      await _supabase.from('users').upsert({
        'id': user.id,
        'phone_number': formattedPhone,
        'email': user.email,
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully!")),
        );
        // Go to home
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error: ${e.toString()}"),
              backgroundColor: Colors.red),
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
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppTheme.accentDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phonelink_setup, size: 80, color: AppTheme.accent),
            const SizedBox(height: 24),
            const Text(
              'One last step!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please provide your phone number to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.muted, fontSize: 16),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+91 ',
                prefixStyle: const TextStyle(
                    color: AppTheme.accent, fontWeight: FontWeight.bold),
                labelStyle: const TextStyle(color: AppTheme.accent),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.accent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppTheme.accentDark, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: AppTheme.elevatedButtonStyle.copyWith(
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16)),
                ),
                onPressed: _isLoading ? null : _savePhoneNumber,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Save and Finish',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
