import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Centered title + subtitle header used at the top of auth screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textStyles.authTitle,
        ),
        SizedBox(height: context.h(AppSize.authTitleSubtitleGap)),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: context.textStyles.authSubtitle,
        ),
      ],
    );
  }
}
