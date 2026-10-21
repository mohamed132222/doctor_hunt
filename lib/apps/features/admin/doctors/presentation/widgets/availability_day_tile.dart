import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/widgets/app_svg_icon.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AvailabilityDayTile extends StatelessWidget {
  const AvailabilityDayTile({
    super.key,
    required this.label,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.adminDayIconBox;

    return SizedBox(
      height: context.adminToggleTileHeight,
      child: Row(
        children: [
          Container(
            width: box,
            height: box,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(context.infoTileRadius),
            ),
            child: AppSvgIcon(
              AppAssets.calendarDaysIcon,
              size: context.iconSmall,
            ),
          ),
          SizedBox(width: context.s12),
          Expanded(child: Text(label, style: context.medium16Black)),
          Switch(value: enabled, onChanged: onChanged),
        ],
      ),
    );
  }
}
