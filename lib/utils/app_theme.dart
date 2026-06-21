import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Brand
  static const Color logoCyan = Color(0xFF00D4FF);
  static const Color logoTeal = Color(0xFF4ECDC4);

  // Warm Primary
  static const Color coral = Color(0xFFFF6B6B);
  static const Color coralLight = Color(0xFFFF8E53);
  static const Color peach = Color(0xFFFFE5D9);

  // Backgrounds
  static const Color bgWarm = Color(0xFFFFFBF7);
  static const Color bgCool = Color(0xFFF0F4F8);
  static const Color surface = Colors.white;
  static const Color headerDark = Color(0xFF1A1A2E);

  // Text
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color textLight = Color(0xFFB0B0B5);

  // Functional
  static const Color online = Color(0xFF4ECDC4);
  static const Color offline = Color(0xFF8E8E93);
  static const Color sentBubbleStart = Color(0xFFFF6B6B);
  static const Color sentBubbleEnd = Color(0xFFFF8E53);
  static const Color receivedBubble = Color(0xFFFFFFFF);
  static const Color receivedBubbleBorder = Color(0xFFE8E8E8);

  // Backward compatibility aliases (old code uses these)
  static const Color accentDark = headerDark;
  static const Color accent = coral;
  static const Color background = bgWarm;
  static const Color highlight = logoCyan;

  static ButtonStyle get elevatedButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: coral,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  );

  // Gradients
  static const LinearGradient coralGradient = LinearGradient(
    colors: [sentBubbleStart, sentBubbleEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanRingGradient = LinearGradient(
    colors: [logoCyan, logoTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration get cardShadow => BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: coral.withOpacity(0.08),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration get pillDark => BoxDecoration(
    color: headerDark,
    borderRadius: BorderRadius.circular(40),
    boxShadow: [
      BoxShadow(
        color: headerDark.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static SystemUiOverlayStyle get lightOverlay => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: bgWarm,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static SystemUiOverlayStyle get darkOverlay => const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: headerDark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
