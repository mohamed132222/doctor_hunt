import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final String label;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final bool enabled;
  final bool loading;
  final Widget? icon;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
    this.radius,
    this.style,
    this.enabled = true,
    this.loading = false,
    this.backgroundColor,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        fixedSize: Size(width ?? 350, height ?? 54),
      ),
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                const SizedBox(width: 10),
                Text(label, style: textStyle ?? context.medium18White),
              ],
            )
          : Text(label, style: textStyle ?? context.medium18White),
    );
  }
}
