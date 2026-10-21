import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';

class RatingInput extends StatelessWidget {
  const RatingInput({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final starColor = context.themeColors.starRating;
    final size = context.adminRatingStar;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.adminRating.toUpperCase(),
          style: context.semiBold12TextMain.copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: context.s10),
        Row(
          children: [
            for (var i = 0; i < 5; i++)
              GestureDetector(
                onTap: () => onChanged((i + 1).toDouble()),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.only(right: context.s8),
                  child: Icon(
                    value >= i + 1
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: starColor,
                    size: size,
                  ),
                ),
              ),
            SizedBox(width: context.s8),
            Text(value.toStringAsFixed(1), style: context.regular14TextSub),
          ],
        ),
      ],
    );
  }
}
