import 'package:flutter/material.dart';

import '../../../../../core/themes/app_theme.dart';
import '../../data/models/onboarding_item.dart';
import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';

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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.sizeOf(AppSize.onboardingSlideGap),
      ),
      child: Column(
        children: [
          Center(
            child: ClipOval(child: Image.asset(item.image, fit: BoxFit.cover)),
          ),
          SizedBox(height: context.sizeOf(AppSize.onboardingSlideBottomGap)),
          Column(
            children: [
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: context.textStyles.onboardingTitle,
              ),
              SizedBox(
                height: context.sizeOf(AppSize.onboardingTitleSubtitleGap),
              ),
              Text(
                item.subtitle,
                textAlign: TextAlign.center,
                style: context.textStyles.onboardingSubtitle,
              ),
            ],
          ),
          SizedBox(height: context.sizeOf(AppSize.onboardingSlideBottomGap)),
        ],
      ),
    );
  }
}
