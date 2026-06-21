// lib/components/animated_background.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math' show pi, sin, cos;
import 'package:ConnectUs/utils/new_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Orb> _orbs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Fewer orbs on web for better performance
    final orbCount = kIsWeb ? 2 : 5;
    _orbs = List.generate(orbCount, (i) {
      return Orb(
        x: 0.1 + (i * 0.18),
        y: 0.15 + (i * 0.12),
        size: kIsWeb ? (120.0 + i * 30) : (150.0 + i * 40),
        color: i.isEven
            ? NewAppTheme.accent.withValues(alpha: 0.15)
            : NewAppTheme.accentSecondary.withValues(alpha: 0.12),
        speed: 0.3 + (i * 0.1),
        phase: i * 1.2,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NewAppTheme.background,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Base gradient mesh
              Container(decoration: NewAppTheme.gradientMesh),

              // Floating orbs
              ..._orbs.map((orb) {
                final t = _controller.value * 2 * pi * orb.speed + orb.phase;
                final dx = sin(t) * 30;
                final dy = cos(t * 0.7) * 20;
                return Positioned(
                  left: orb.x * MediaQuery.of(context).size.width + dx,
                  top: orb.y * MediaQuery.of(context).size.height + dy,
                  child: Container(
                    width: orb.size,
                    height: orb.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [orb.color, orb.color.withValues(alpha: 0)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: orb.color.withValues(alpha: 0.3),
                          blurRadius: kIsWeb ? 40 : 60,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Page content
              widget.child,
            ],
          );
        },
      ),
    );
  }
}

class Orb {
  final double x, y, size, speed, phase;
  final Color color;

  const Orb({
    required this.x,
    required this.y,
    required this.size,
    required this.color,
    required this.speed,
    required this.phase,
  });
}
