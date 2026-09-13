import 'package:flutter/material.dart';

import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Shared scaffold background: ice-blue → white → mint-green vertical gradient
/// with optional decorative corner blobs.
///
/// [blob] controls where a soft green decorative circle sits (or `null` for
/// a plain gradient).
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.blob = BlobPosition.none,
  });

  final Widget child;
  final BlobPosition blob;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.gradientIce,
            context.colorScheme.surface,
            colors.gradientMint,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          if (blob == BlobPosition.topLeft)
            Positioned(
              top: -context.h(80),
              left: -context.w(80),
              child: _Blob(size: context.w(220), color: colors.primaryLight),
            )
          else if (blob == BlobPosition.topRight)
            Positioned(
              top: -context.h(80),
              right: -context.w(80),
              child: _Blob(size: context.w(220), color: colors.primaryLight),
            ),
          if (blob != BlobPosition.none)
            Positioned(
              bottom: -context.h(100),
              left: -context.w(60),
              child: _Blob(
                size: context.w(260),
                color: colors.primaryLight,
                opacity: 0.35,
              ),
            ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

enum BlobPosition { none, topLeft, topRight }

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color, this.opacity = 0.5});

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}
