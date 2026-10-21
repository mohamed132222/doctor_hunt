import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/widgets/square_button.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';

import '../../../../../core/extensions/media_query_extension.dart';

import 'package:flutter/material.dart';

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

  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = context.detailsBackButton;
    final action = onAction;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.homeRowPaddingH),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: context.detailsTopBarHeight),
        child: Row(
          children: [
            SquareButton(
              size: size,
              icon: Icons.chevron_left,
              color: context.themeColors.navInactive,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onTap: onBack ?? () => Navigator.of(context).maybePop(),
            ),
            if (!centerTitle) SizedBox(width: context.s12),

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
              SquareButton(
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
