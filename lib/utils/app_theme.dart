import 'package:flutter/material.dart';

class AppTheme {
  // Core palette (kept from existing app)
  static const Color background = Color.fromARGB(255, 0, 32, 31);
  static const Color accent = Color.fromARGB(255, 44, 227, 252);
  static const Color accentDark = Color.fromARGB(255, 7, 226, 255);
  static const Color hint = Color(0xFFFFCA28);
  // Extended semantic palette
  static const Color success = Color(0xFF4CAF50);
  static const Color danger = Color(0xFFE53935);
  static const Color surface = Color(0xFF2A2A2A);
  static const Color muted = Color(0xFF9E9E9E);
  static const Color highlight = Color(0xFFFFE082);

  // Text styles
  static const TextStyle titleStyle = TextStyle(
    color: accent,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle subtitleStyle = TextStyle(
    color: hint,
    fontSize: 14,
  );

  // Card decoration (not const because of withOpacity calls)
  static final BoxDecoration cardDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color(0xFFA67B00).withOpacity(0.08), accentDark.withOpacity(0.04)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );

  static BoxDecoration avatarDecoration() => BoxDecoration(
        color: accentDark,
        shape: BoxShape.circle,
      );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: accentDark,
    foregroundColor: Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}
