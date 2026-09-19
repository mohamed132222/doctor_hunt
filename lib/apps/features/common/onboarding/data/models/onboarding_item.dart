import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

/// A single onboarding slide.
///
/// Slides differ only by [image]; the decorative ellipse side is derived from
/// the slide index (odd → right, even → left) inside the body.
class OnboardingItem {
  OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

List<OnboardingItem> kOnboardingItems = [
  OnboardingItem(
    image: AppAssets.onboarding1,
    title: t.onboardingTitle1,
    subtitle: t.onboardingSubtitle,
  ),
  OnboardingItem(
    image: AppAssets.onboarding2,
    title: t.onboardingTitle2,
    subtitle: t.onboardingSubtitle,
  ),
  OnboardingItem(
    image: AppAssets.onboarding3,
    title: t.onboardingTitle3,
    subtitle: t.onboardingSubtitle,
  ),
];
