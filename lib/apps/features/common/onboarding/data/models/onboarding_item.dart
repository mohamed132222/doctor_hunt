import '../../../../../core/constants/app_strings.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

/// A single onboarding slide.
///
/// Slides differ only by [image]; the decorative ellipse side is derived from
/// the slide index (odd → right, even → left) inside the body.
class OnboardingItem {
  const OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

const List<OnboardingItem> kOnboardingItems = [
  OnboardingItem(
    image: AppAssets.onboarding1,
    title: AppStrings.onboardingTitle1,
    subtitle: AppStrings.onboardingSubtitle,
  ),
  OnboardingItem(
    image: AppAssets.onboarding2,
    title: AppStrings.onboardingTitle2,
    subtitle: AppStrings.onboardingSubtitle,
  ),
  OnboardingItem(
    image: AppAssets.onboarding3,
    title: AppStrings.onboardingTitle3,
    subtitle: AppStrings.onboardingSubtitle,
  ),
];
