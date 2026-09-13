import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Row of page-indicator dots for carousels / onboarding.
class PageDots extends StatelessWidget {
  const PageDots({super.key, required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: context.w(AppSize.s4)),
          width: context.w(active ? AppSize.dotActiveWidth : AppSize.dotSize),
          height: context.w(AppSize.dotSize),
          decoration: BoxDecoration(
            color: active
                ? context.colorScheme.primary
                : context.colorScheme.outline,
            borderRadius: BorderRadius.circular(AppSize.r4),
          ),
        );
      }),
    );
  }
}
