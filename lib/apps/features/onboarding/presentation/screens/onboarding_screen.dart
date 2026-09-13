import 'package:flutter/material.dart';

import '../../data/models/onboarding_item.dart';
import '../widgets/onboarding_body.dart';

/// Onboarding screen — thin StatelessWidget; all state lives in
/// [OnboardingBody].
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OnboardingBody(items: kOnboardingItems));
  }
}
