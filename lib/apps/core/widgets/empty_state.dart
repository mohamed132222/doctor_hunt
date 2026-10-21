import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.svgAsset,
    this.showAddBadge = false,
    this.action,
  });

  final String title;
  final String message;
  final IconData icon;
  final String? svgAsset;
  final bool showAddBadge;
  final Widget? action;

  static const double _logoMinHeight = 150;

  static const double _fullHeight = 260;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final circle = context.emptyStateCircle;
    final badge = context.emptyStateBadge;

    Widget illustration(double size) {
      if (svgAsset != null) {
        return SvgPicture.asset(svgAsset!, width: size, height: size);
      }
      return SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.primary.withValues(alpha: 0.10),
              ),
              child: Center(
                child: Icon(icon, size: size * 0.55, color: scheme.primary),
              ),
            ),
            if (showAddBadge)
              Positioned(
                right: 0,
                bottom: context.s8,
                child: Container(
                  width: badge,
                  height: badge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.primary,
                  ),
                  child: Icon(
                    Icons.add,
                    size: context.iconSmall,
                    color: scheme.onPrimary,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    Widget body({
      required bool showLogo,
      required double logoSize,
      required double logoGap,
    }) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[illustration(logoSize), SizedBox(height: logoGap)],
          Text(title, style: context.bold20Black, textAlign: TextAlign.center),
          SizedBox(height: context.s8),
          Text(
            message,
            style: context.regular14TextSub,
            textAlign: TextAlign.center,
          ),
          if (action != null) ...[SizedBox(height: context.s24), action!],
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final pad = context.s24;

        if (!constraints.hasBoundedHeight) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(pad),
              child: body(
                showLogo: true,
                logoSize: circle,
                logoGap: context.s24,
              ),
            ),
          );
        }

        final height = constraints.maxHeight;
        final showLogo = height >= _logoMinHeight;
        final logoSize = height >= _fullHeight ? circle : circle * 0.55;
        final logoGap = height >= _fullHeight ? context.s24 : context.s12;
        final available = height - pad * 2;

        return SingleChildScrollView(
          padding: EdgeInsets.all(pad),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: available > 0 ? available : 0,
            ),
            child: Center(
              child: body(
                showLogo: showLogo,
                logoSize: logoSize,
                logoGap: logoGap,
              ),
            ),
          ),
        );
      },
    );
  }
}
