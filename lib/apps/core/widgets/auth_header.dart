import 'package:flutter/material.dart';

import 'package:doctor_hunt/generated/style_atoms.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, textAlign: TextAlign.center, style: context.medium24Black),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: context.regular14TextSub,
        ),
      ],
    );
  }
}
