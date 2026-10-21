import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class PatientSettingTile extends StatelessWidget {
  const PatientSettingTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final circle = context.settingsIconCircle;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: context.settingsRowHeight,
        child: Row(
          children: [
            Container(
              width: circle,
              height: circle,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(
                icon,
                color: AppColors.white,
                size: context.iconSmall,
              ),
            ),
            SizedBox(width: context.s16),
            Expanded(
              child: Text(
                title,
                style: context.medium18.copyWith(color: AppColors.textTitle),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing ??
                (onTap != null
                    ? Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
