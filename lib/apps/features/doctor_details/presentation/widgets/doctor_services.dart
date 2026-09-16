import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/doctor_details_content.dart';

/// "Services" heading plus the numbered list of points.
class DoctorServices extends StatelessWidget {
  const DoctorServices({super.key, required this.points});

  final List<ServicePoint> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.servicesTitle, style: theme.textTheme.headlineSmall),
        SizedBox(height: context.w(AppSize.s12)),
        for (var i = 0; i < points.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: context.w(AppSize.s12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.numberedItem(i),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(width: context.w(AppSize.s8)),
                Expanded(
                  child: Text(
                    points[i].text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
