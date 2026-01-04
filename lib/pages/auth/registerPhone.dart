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

  /// Triggers Supabase Phone OTP
  Future<void> _sendOtp() async {
    final phoneInput = _phoneController.text.trim();

    if (phoneInput.isEmpty || phoneInput.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enter a valid 10-digit phone number")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Assuming +91 as per your UI requirement
      final formattedPhone = '+91$phoneInput';

      await Supabase.instance.client.auth.signInWithOtp(
        phone: formattedPhone,
      );

      if (mounted) {
        // Navigate to OTP screen and pass the phone number as an argument
        Navigator.pushNamed(context, '/otpVerify', arguments: formattedPhone);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: AppTheme.danger,
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
      appBar: AppBar(
        title: const Text('Complete Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.accentDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.phonelink_setup, size: 80, color: AppTheme.accent),
            const SizedBox(height: 32),
            const Text(
              'One last step!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Verify your phone number to connect with your contacts.',
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
                onPressed: _isLoading ? null : _sendOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Send Verification Code',
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
