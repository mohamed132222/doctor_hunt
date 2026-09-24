import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../data/models/doctor_details_content.dart';

/// One figure inside [DoctorStatsCard]: a tinted rounded tile with the value
/// above its label.
class DoctorStatTile extends StatelessWidget {
  const DoctorStatTile({super.key, required this.stat});

  final DoctorStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(minHeight: context.detailsStatHeight),
      padding: EdgeInsets.symmetric(horizontal: context.s8),
      decoration: BoxDecoration(
        color: context.themeColors.screenTint,
        borderRadius: BorderRadius.circular(context.detailsStatRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat.value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: AppSize.s24,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: context.s2),
          Text(
            stat.label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: AppSize.s12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
