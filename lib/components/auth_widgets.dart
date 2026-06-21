// lib/components/auth_widgets.dart
// Shared glass input/button widgets used across auth pages.
import 'package:ConnectUs/utils/new_theme.dart';
import 'package:flutter/material.dart';

class GlassInput extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  const GlassInput({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.initialValue,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: NewAppTheme.glassCard,
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        obscureText: obscure,
        keyboardType: keyboardType,
        style: const TextStyle(color: NewAppTheme.textPrimary, fontSize: 15),
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: NewAppTheme.textSecondary.withValues(alpha: 0.5), fontSize: 14),
          prefixIcon:
              Icon(icon, color: NewAppTheme.textSecondary, size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onTap;

  const GradientButton({
    super.key,
    required this.label,
    required this.isLoading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: disabled
                ? [Colors.grey.shade700, Colors.grey.shade600]
                : [NewAppTheme.accent, NewAppTheme.accentSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: disabled
              ? []
              : [
                  BoxShadow(
                    color: NewAppTheme.accent.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                ),
              )
            : Center(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const GlassButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: NewAppTheme.glassCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: NewAppTheme.accent, size: 26),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: NewAppTheme.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
