import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';

import '../../data/models/onboarding_item.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 42),
      child: Column(
        children: [
          Center(
            child: ClipOval(child: Image.asset(item.image, fit: BoxFit.cover)),
          ),
          SizedBox(height: context.paddingOf(60)),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: context.medium28.textTitle,
          ),
          const SizedBox(height: 14),
          Text(
            item.subtitle,
            textAlign: TextAlign.center,
            style: context.regular14.textSub,
          ),
        ],
      ),
    );
  }
}
