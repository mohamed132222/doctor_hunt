import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import '../themes/app_theme.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: context.adminStatCardHeight,
      padding: EdgeInsets.symmetric(horizontal: context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminStatCardRadius),
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.regular14TextSub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.s8),
          Text(value, style: context.bold24Black, maxLines: 1),
        ],
      ),
    );
  }
}
