import 'package:flutter/material.dart';
import '../appsize/app_size.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:doctor_hunt/generated/image_assets.dart';
import '../appsize/media_query_extension.dart';
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
    final radius = BorderRadius.circular(context.sizeOf(AppSize.r14));

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
              height: context.sizeOf(AppSize.socialButtonHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    icon,
                    width: context.sizeOf(AppSize.iconSocial),
                    height: context.sizeOf(AppSize.iconSocial),
                  ),
                  SizedBox(width: context.paddingOf(AppSize.s8)),
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

/// Row of the social login buttons.
///
/// Shows Google alone (full width) by default; pass [showFacebook] to add the
/// Facebook button beside it.
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    this.onGoogle,
    this.onFacebook,
    this.showFacebook = false,
  });

  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;

  /// When false the Google button spans the full width.
  final bool showFacebook;

  @override
  Widget build(BuildContext context) {
    final google = SocialButton(
      label: AppStrings.socialGoogle,
      icon: AppAssets.googleIcon,
      onPressed: onGoogle,
    );

    if (!showFacebook) {
      // Still needs a Flex parent: [SocialButton] is an [Expanded].
      return Row(children: [google]);
    }

    return Row(
      children: [
        google,
        SizedBox(width: context.paddingOf(AppSize.s16)),
        SocialButton(
          label: AppStrings.socialFacebook,
          icon: AppAssets.facebookIcon,
          onPressed: onFacebook,
        ),
      ],
    );
  }
}
