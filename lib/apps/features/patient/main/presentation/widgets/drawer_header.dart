import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import 'avatar.dart';
import 'package:flutter/material.dart';

class PatientDrawerHeader extends StatelessWidget {
  const PatientDrawerHeader({
    super.key,
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final faint = AppColors.white.withValues(alpha: 0.85);
    return Row(
      children: [
        Avatar(name: name),
        SizedBox(width: context.s16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (email.isNotEmpty) ...[
                SizedBox(height: context.s6),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      size: context.iconSmall,
                      color: faint,
                    ),
                    SizedBox(width: context.s6),
                    Expanded(
                      child: Text(
                        email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: faint,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
