import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import '../themes/app_theme.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.max = 5, this.size});

  final double rating;
  final int max;

  final double? size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final starSize = size ?? context.s12;
    final color = context.themeColors.starRating;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < max; i++)
          Padding(
            padding: EdgeInsets.only(right: context.s2),
            child: Icon(
              _iconFor(i),
              size: starSize,
              color: rating >= i + 0.5 ? color : scheme.outlineVariant,
            ),
          ),
      ],
    );
  }

  IconData _iconFor(int index) {
    if (rating >= index + 1) return Icons.star_rounded;
    if (rating >= index + 0.5) return Icons.star_half_rounded;
    return Icons.star_outline_rounded;
  }
}
