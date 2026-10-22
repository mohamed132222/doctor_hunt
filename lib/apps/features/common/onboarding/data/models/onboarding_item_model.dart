import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

class OnboardingItemModel {
  OnboardingItemModel({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

List<OnboardingItemModel> get kOnboardingItemModels => [
  OnboardingItemModel(
    image: AppAssets.onboarding1,
    title: t.onboardingTitle1,
    subtitle: t.onboardingSubtitle,
  ),
  OnboardingItemModel(
    image: AppAssets.onboarding2,
    title: t.onboardingTitle2,
    subtitle: t.onboardingSubtitle,
  ),
  OnboardingItemModel(
    image: AppAssets.onboarding3,
    title: t.onboardingTitle3,
    subtitle: t.onboardingSubtitle,
  ),
];
