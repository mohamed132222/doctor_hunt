import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../generated/image_assets.dart';
import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';
import '../constants/app_strings.dart';
import '../themes/app_theme.dart';

/// A single social-auth button rendered as a soft white card with a shadow.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
  });

  final String label;

  /// SVG asset path (e.g. [AppAssets.googleIcon]).
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(context.r(AppSize.r14));

    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: radius,
          boxShadow: [context.themeColors.cardShadow],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: radius,
            child: SizedBox(
              height: context.h(AppSize.socialButtonHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: context.w(AppSize.iconSocial),
                    height: context.w(AppSize.iconSocial),
                  ),
                  SizedBox(width: context.w(AppSize.s8)),
                  Flexible(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of the two social login buttons (Google + Facebook).
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({super.key, this.onGoogle, this.onFacebook});

  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SocialButton(
          label: AppStrings.socialGoogle,
          icon: AppAssets.googleIcon,
          onPressed: onGoogle,
        ),
        SizedBox(width: context.w(AppSize.s16)),
        SocialButton(
          label: AppStrings.socialFacebook,
          icon: AppAssets.facebookIcon,
          onPressed: onFacebook,
        ),
      ],
    );
  }
}
