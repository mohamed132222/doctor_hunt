import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';

/// Section title with an optional "See all ›" action on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingOf(AppSize.homeRowPaddingH),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.seeAll),
                Icon(
                  Icons.chevron_right,
                  size: context.sizeOf(AppSize.iconSmall),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
