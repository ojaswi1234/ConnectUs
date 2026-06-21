import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({super.key});
  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLoading = false;
  final _supabase = Supabase.instance.client;

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw Exception("User not authenticated");

      final usernameInput = _usernameController.text.trim();
      final phoneInput = _phoneController.text.trim();
      final formattedPhone = '+91$phoneInput';

      await _supabase.from('users').upsert({
        'id': user.id,
        'usrname': usernameInput,
        'phone_number': formattedPhone,
        'email': user.email,
        'updated_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile completed!"), backgroundColor: AppTheme.logoTeal),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(AppTheme.lightOverlay);
    return Scaffold(
      backgroundColor: AppTheme.bgWarm,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppTheme.textDark),
                  ),
                ),
                const SizedBox(height: 40),
                const Text('One last\nstep!', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppTheme.textDark, height: 1.2)),
                const SizedBox(height: 12),
                Text('Please provide a username and phone number to continue.', style: TextStyle(fontSize: 16, color: AppTheme.textMuted.withOpacity(0.8))),
                const SizedBox(height: 48),
                _GlassInput(
                  hint: 'Username',
                  icon: Icons.person_outline,
                  controller: _usernameController,
                  validator: (v) => v == null || v.trim().isEmpty ? 'Username is required' : null,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: AppTheme.cardShadow,
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: AppTheme.textDark),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Phone number is required';
                      if (v.trim().length != 10) return 'Enter a valid 10-digit number';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      prefixText: '+91 ',
                      prefixStyle: const TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w600, fontSize: 16),
                      hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.5)),
                      prefixIcon: const Icon(Icons.phone_outlined, color: AppTheme.textMuted),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _isLoading ? null : _saveProfile,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppTheme.coralGradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: AppTheme.coral.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Save and Finish', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const _GlassInput({required this.hint, required this.icon, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardShadow,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppTheme.textDark),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppTheme.textMuted.withOpacity(0.5)),
          prefixIcon: Icon(icon, color: AppTheme.textMuted, size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
