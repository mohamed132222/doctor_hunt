import 'package:doctor_hunt/apps/features/common/onboarding/data/models/onboarding_item_model.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/presentation/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnboardingBody(items: kOnboardingItems));
  }
}
