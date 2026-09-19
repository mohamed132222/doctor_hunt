import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../data/models/role.dart';

/// Selectable role card: icon chip + title + description.
///
/// Selected → primary green border + green icon + check badge.
/// Unselected → outline border + muted icon. All colors from the theme.
class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final RoleOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final iconColor = selected ? scheme.primary : scheme.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.all(context.paddingOf(AppSize.s20)),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(context.sizeOf(AppSize.r16)),
              border: Border.all(
                color: selected ? scheme.primary : scheme.outline,
                width: selected ? AppSize.borderFocus : AppSize.borderThin,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: context.paddingOf(AppSize.s48),
                  height: context.paddingOf(AppSize.s48),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected
                        ? scheme.primary.withValues(alpha: 0.12)
                        : scheme.surfaceContainerHighest,
                  ),
                  child: SvgPicture.asset(
                    option.icon,
                    width: context.paddingOf(AppSize.s24),
                    height: context.paddingOf(AppSize.s24),
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: context.paddingOf(AppSize.s16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(option.title, style: theme.textTheme.titleLarge),
                      SizedBox(height: context.paddingOf(AppSize.s4)),
                      Text(
                        option.description,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            Positioned(
              top: context.paddingOf(AppSize.s16),
              right: context.paddingOf(AppSize.s16),
              child: Container(
                width: context.paddingOf(AppSize.s28),
                height: context.paddingOf(AppSize.s28),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.primary,
                ),
                child: Icon(
                  Icons.check,
                  size: context.paddingOf(AppSize.s16),
                  color: scheme.onPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
