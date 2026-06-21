// lib/components/responsive_scaffold.dart
import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/new_theme.dart';

/// On screens wider than 900 px (web/desktop), renders a fixed 320 px sidebar
/// on the left and the main body on the right.
/// On narrow screens (mobile), renders only the body.
class ResponsiveScaffold extends StatelessWidget {
  final Widget sidebar;
  final Widget body;
  final bool showSidebar;

  const ResponsiveScaffold({
    super.key,
    required this.sidebar,
    required this.body,
    this.showSidebar = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Scaffold(
      backgroundColor: NewAppTheme.background,
      body: Row(
        children: [
          if (isWide && showSidebar)
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: NewAppTheme.surface.withValues(alpha: 0.5),
                border: Border(
                  right: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
              child: sidebar,
            ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
