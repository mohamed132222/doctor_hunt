import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.adminSettingsIconBox;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.s12),
        child: Row(
          children: [
            Container(
              width: box,
              height: box,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(context.infoTileRadius),
              ),
              child: Icon(icon, color: scheme.primary, size: context.iconSmall),
            ),
            SizedBox(width: context.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.bold16Black),
                  if (subtitle != null) ...[
                    SizedBox(height: context.s2),
                    Text(
                      subtitle!,
                      style: context.regular12TextSub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            trailing ??
                (onTap != null
                    ? Icon(Icons.chevron_right, color: scheme.onSurfaceVariant)
                    : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
