import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/features/common/onboarding/data/models/onboarding_item_model.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.item});

  final OnboardingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                    child: Image.asset(item.image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.s24),
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
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.s24),
        ],
      ),
    );
  }
}
