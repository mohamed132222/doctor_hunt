import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: context.segmentedTabHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: labels.length,
        separatorBuilder: (_, _) => SizedBox(width: context.s10),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return Material(
            color: selected
                ? scheme.primary
                : scheme.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(context.segmentedTabRadius),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => onSelect(index),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.s20),
                child: Center(
                  child: Text(
                    labels[index],
                    style: selected
                        ? context.semiBold14White
                        : context.semiBold14Primary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
