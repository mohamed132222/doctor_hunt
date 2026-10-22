import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../extensions/media_query_extension.dart';

class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest.withValues(alpha: 0.55);
    final highlight = scheme.surface.withValues(alpha: 0.9);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final dx = bounds.width * (_controller.value * 2 - 1);
            return LinearGradient(
              colors: [base, highlight, base],
              stops: const [0.35, 0.5, 0.65],
              begin: Alignment(-1 + dx / bounds.width * 2, -0.3),
              end: Alignment(1 + dx / bounds.width * 2, 0.3),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.radius,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double height;
  final double? radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(radius ?? AppSize.r8),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(context.r16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(
            width: context.bookingCardPhoto,
            height: context.bookingCardPhoto,
            shape: BoxShape.circle,
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(
                  width: 140,
                  height: context.s16,
                  radius: context.r8,
                ),
                SizedBox(height: context.s8),
                SkeletonBox(width: 90, height: context.s12, radius: context.r8),
                SizedBox(height: context.s16),
                SkeletonBox(height: context.s12, radius: context.r8),
                SizedBox(height: context.s8),
                SkeletonBox(
                  width: 180,
                  height: context.s12,
                  radius: context.r8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppSkeletonList extends StatelessWidget {
  const AppSkeletonList({super.key, this.itemCount = 5, this.padding});

  final int itemCount;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: context.homeRowPaddingH,
              vertical: context.s16,
            ),
        itemCount: itemCount,
        separatorBuilder: (_, _) => SizedBox(height: context.s12),
        itemBuilder: (_, _) => const SkeletonCard(),
      ),
    );
  }
}

class AppSkeletonDetails extends StatelessWidget {
  const AppSkeletonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(context.homeRowPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonCard(),
            SizedBox(height: context.s24),
            SkeletonBox(height: context.s16, radius: context.r8),
            SizedBox(height: context.s12),
            SkeletonBox(height: 120, radius: context.r16),
            SizedBox(height: context.s24),
            SkeletonBox(height: context.s16, radius: context.r8),
            SizedBox(height: context.s12),
            SkeletonBox(height: 88, radius: context.r16),
          ],
        ),
      ),
    );
  }
}
