import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';

/// Details top bar: a back button, the screen title and a trailing action.
///
/// Geometry is width-scaled so the row keeps its proportions on any viewport.
class DoctorTopBar extends StatelessWidget {
  const DoctorTopBar({
    super.key,
    required this.title,
    this.onBack,
    this.onAction,
    this.actionIcon = Icons.search_rounded,
    this.actionTooltip,
    this.centerTitle = true,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onAction;
  final IconData actionIcon;
  final String? actionTooltip;

  /// The details page centres its title; search screens left-align it.
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = context.sizeOf(AppSize.detailsBackButton);
    final action = onAction;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingOf(AppSize.homeRowPaddingH),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: context.sizeOf(AppSize.detailsTopBarHeight),
        ),
        child: Row(
          children: [
            _SquareButton(
              size: size,
              icon: Icons.chevron_left,
              color: context.themeColors.navInactive,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
            ),
            if (!centerTitle) SizedBox(width: context.paddingOf(AppSize.s12)),

            Expanded(
              child: Text(
                title,
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: theme.textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (action != null)
              _SquareButton(
                size: size,
                icon: actionIcon,
                tooltip: actionTooltip,
                onTap: action,
              )
            else
              SizedBox(width: size),
          ],
        ),
      ),
    );
  }
}

/// A rounded-square white button used for the bar's icon actions.
class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.size,
    required this.icon,
    required this.onTap,
    this.color,
    this.tooltip,
  });

  final double size;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        context.sizeOf(AppSize.detailsActionRadius),
      ),
    );
    final button = SizedBox(
      width: size,
      height: size,
      child: Material(
        color: theme.colorScheme.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: context.sizeOf(AppSize.detailsActionIcon),
            color: color ?? theme.colorScheme.onSurface,
          ),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
