import 'package:flutter/material.dart';

import '../../../generated/image_assets.dart';
import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Fullscreen background with the two brand ellipses — teal glow top-left and
/// green glow bottom-right (the splash decoration), on the surface color.
class EllipseBackground extends StatelessWidget {
  const EllipseBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = context.sw;

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(child: ColoredBox(color: context.colorScheme.surface)),
        Positioned(
          top: -context.h(80),
          left: -width * 0.25,
          child: Image.asset(
            AppAssets.ellipseTeal,
            width: width * 0.9,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        ),
        Positioned(
          bottom: -context.h(50),
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
    );
  }
}
