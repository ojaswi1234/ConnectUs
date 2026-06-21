// lib/utils/new_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAppTheme {
  // Core Palette
  static const Color background = Color(0xFF0A0A0F);
  static const Color surface = Color(0xFF12121A);
  static const Color surfaceLight = Color(0xFF1A1A25);
  static const Color cardGlass = Color(0x18FFFFFF);
  static const Color accent = Color(0xFF00F0FF);
  static const Color accentSecondary = Color(0xFF7000FF);
  static const Color textPrimary = Color(0xFFF0F0F5);
  static const Color textSecondary = Color(0xFF8A8A9A);
  static const Color online = Color(0xFF00E676);
  static const Color offline = Color(0xFF78909C);
  static const Color sentBubble = Color(0xFF1E3A8A);
  static const Color receivedBubble = Color(0xFF2A2A3A);

  static SystemUiOverlayStyle get systemOverlay => const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: background,
        systemNavigationBarIconBrightness: Brightness.light,
      );

  static BoxDecoration get glassCard => BoxDecoration(
        color: cardGlass,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.08), width: 1),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: -5,
          ),
        ],
      );

  static BoxDecoration get gradientMesh => BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.5, -0.5),
          radius: 1.2,
          colors: [
            accent.withValues(alpha: 0.15),
            accentSecondary.withValues(alpha: 0.08),
            background,
          ],
        ),
      );

  static BoxDecoration get messageSent => BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0066FF), Color(0xFF00C6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0066FF).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get messageReceived => BoxDecoration(
        color: surfaceLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(18),
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      );
}
