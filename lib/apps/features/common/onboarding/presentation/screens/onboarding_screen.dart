import 'package:doctor_hunt/apps/features/common/onboarding/data/models/onboarding_item.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

/// Onboarding screen — thin StatelessWidget; all state lives in
/// [OnboardingBody].
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnboardingBody(items: kOnboardingItems));
  }
}
