import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../data/models/doctor_details_content.dart';
import 'doctor_stat_tile.dart';

/// The doctor's stats: one white card (with the card shadow) holding the
/// [DoctorStatTile]s, matching the design.
class DoctorStatsCard extends StatelessWidget {
  const DoctorStatsCard({super.key, required this.stats});

  final List<DoctorStat> stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.detailsStatRadius),
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      padding: EdgeInsets.all(context.detailsStatsPadding),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0) SizedBox(width: context.s10),
              Expanded(child: DoctorStatTile(stat: stats[i])),
            ],
          ],
        ),
      ),
    );
  }
}
