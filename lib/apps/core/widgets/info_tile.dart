import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    this.icon,
    this.iconWidget,
    required this.label,
    required this.value,
    this.valueMaxLines = 2,
  }) : assert(
         icon != null || iconWidget != null,
         'InfoTile needs either icon or iconWidget',
       );

  final IconData? icon;

  final Widget? iconWidget;
  final String label;
  final String value;
  final int valueMaxLines;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.infoTileIconBox;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: box,
          height: box,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(context.infoTileRadius),
          ),
          child:
              iconWidget ??
              Icon(icon, color: scheme.primary, size: context.iconSmall),
        ),
        SizedBox(width: context.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label.toUpperCase(),
                style: context.regular12TextSub.copyWith(letterSpacing: 0.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.s2),
              Text(
                value,
                style: context.semiBold16Black,
                maxLines: valueMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
