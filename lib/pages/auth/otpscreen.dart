import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class OtpScreen extends StatefulWidget {
  final String
      verificationId; // This is the phone number passed from the previous screen
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;

  /// Verifies the OTP and updates the public users table
  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 6) return;

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // 1. Verify the OTP session
      await supabase.auth.verifyOTP(
        phone: widget.verificationId,
        token: otp,
        type: OtpType.sms,
      );

      // 2. IMPORTANT: Update your public 'users' table with the verified number
      final userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        await supabase.from('users').update({
          'phone_number': widget.verificationId,
        }).eq('id', userId);
      }

      if (mounted) {
        // Verification complete -> Navigate home and clear history
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification failed: ${e.toString()}'),
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
        title: const Text('Enter Code'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppTheme.accentDark,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Check your messages',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'We sent a 6-digit code to ${widget.verificationId}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.muted, fontSize: 16),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppTheme.accentDark, fontSize: 24, letterSpacing: 8),
              decoration: InputDecoration(
                counterText: "",
                filled: true,
                fillColor: AppTheme.surface,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppTheme.muted),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: AppTheme.elevatedButtonStyle.copyWith(
                  padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16)),
                ),
                onPressed: _isLoading ? null : _verifyOtp,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text('Verify & Finish',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Wrong number? Go back',
                  style: TextStyle(color: AppTheme.accent)),
            )
          ],
        ),
      ),
    );
  }
}
