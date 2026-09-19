import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/media_query_extension.dart';
import '../themes/app_theme.dart';

/// The app's standard page shell: it owns the [Scaffold] so screens don't
/// each build one.
///
/// Paints the two brand ellipses — teal glow top-left, green glow
/// bottom-right (the splash decoration) — over the surface colour, then
/// lays the screen's content on top.
///
/// ```dart
/// return AppBackground(child: MyBody());
/// ```
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
  });

  final Widget child;

  /// Forwarded to the internal [Scaffold].
  final Color? backgroundColor;

  /// Forwarded to the internal [Scaffold].
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth;

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ColoredBox(color: context.colorScheme.surface),
          ),
          Positioned(
            top: -context.paddingOf(AppSize.ellipseTopOffset),
            left: -width * 0.25,
            child: Image.asset(
              AppAssets.ellipseTeal,
              width: width * 0.9,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
          Positioned(
            bottom: -context.paddingOf(AppSize.ellipseBottomOffset),
            right: -width * 0.2,
            child: Image.asset(
              AppAssets.ellipseGreen,
              width: width * 0.7,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
