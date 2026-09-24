import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    this.textStyle,
    this.onPressed,
  });

  final String label;
  final TextStyle? textStyle;
  final String icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: label,
      icon: SvgPicture.asset(icon),
      backgroundColor: AppColors.white,
      textStyle: textStyle,

      onPressed: onPressed ?? () {},
    );
  }
}
