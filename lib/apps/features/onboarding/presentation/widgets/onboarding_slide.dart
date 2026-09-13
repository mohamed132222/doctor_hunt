import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/themes/app_theme.dart';
import '../../data/models/onboarding_item.dart';

/// A single onboarding slide: illustration + title + subtitle.
///
/// The illustration fills the space above the text (square, capped by width)
/// so the slide always fills its page; then an 86px gap, the title, a 14px gap
/// and the subtitle in a 42px-padded column (→ the design's 3-line wrap).
/// All styles come from the theme.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = math.min(
                constraints.maxHeight,
                constraints.maxWidth,
              );
              return Center(
                child: ClipOval(
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Image.asset(item.image, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: context.h(AppSize.onboardingImageTitleGap)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(AppSize.onboardingTextPaddingH),
          ),
          child: Column(
            children: [
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: context.textStyles.onboardingTitle,
              ),
              SizedBox(height: context.h(AppSize.onboardingTitleSubtitleGap)),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: context.textStyles.onboardingSubtitle,
              ),
            ],
          ),
        ),
        SizedBox(height: context.h(AppSize.onboardingSlideBottomGap)),
      ],
    );
  }
}
