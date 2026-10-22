import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import '../themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

enum StatusVariant { success, danger, neutral }

class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.variant = StatusVariant.success,
    this.showDot = true,
  });

  final String label;
  final StatusVariant variant;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    final (Color fg, Color bg) = switch (variant) {
      StatusVariant.success => (AppColors.success, AppColors.successLight),
      StatusVariant.danger => (AppColors.danger, AppColors.dangerLight),
      StatusVariant.neutral => (AppColors.textSub, AppColors.textBorders),
    };

    return Container(
      height: context.statusPillHeight,
      padding: EdgeInsets.symmetric(horizontal: context.s12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(context.statusPillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: context.statusDotSize,
              height: context.statusDotSize,
              decoration: BoxDecoration(shape: BoxShape.circle, color: fg),
            ),
            SizedBox(width: context.s6),
          ],
          Text(label, style: context.semiBold12.copyWith(color: fg)),
        ],
      ),
    );
  }
}
