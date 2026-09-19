import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';

/// A pill-shaped choice used for the schedule's time and reminder rows.
/// Selected chips fill with the accent; the rest stay tinted.
///
/// [subLabel] renders a second line — the schedule's time chips read
/// "02:00" over "PM".
class ChoiceChipCircle extends StatelessWidget {
  const ChoiceChipCircle({
    super.key,
    required this.label,
    this.subLabel,
    required this.selected,
    this.onTap,
  });

  final String label;
  final String? subLabel;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sub = subLabel;

    return Semantics(
      label: sub == null ? label : '$label $sub',
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          // Minimum, not fixed: two scaled text lines must be able to grow.
          constraints: BoxConstraints(
            minHeight: context.sizeOf(AppSize.choiceChipHeight),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingOf(AppSize.s8),
            vertical: context.paddingOf(AppSize.s8),
          ),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary
                : scheme.primary.withValues(alpha: AppSize.slotIdleAlpha),
            borderRadius: BorderRadius.circular(context.sizeOf(AppSize.r24)),
          ),
          // No `alignment`: that would make the box greedy and take a whole
          // row in the Wrap. The Column below centres the content instead.
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: AppSize.s12,
                  fontWeight: FontWeight.w600,
                  color: selected ? scheme.onPrimary : scheme.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (sub != null)
                Text(
                  sub,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: AppSize.s10,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? scheme.onPrimary.withValues(alpha: 0.85)
                        : scheme.primary.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
