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
  final bool isLoading;
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
    this.isLoading = false,
    this.backgroundColor,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Disable interaction while loading or explicitly disabled to prevent
    // double submissions.
    final isEnabled = enabled && !isLoading;

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        // Keep the same color while loading/disabled so the button doesn't
        // flash to the default grey disabled color.
        disabledBackgroundColor: backgroundColor ?? AppColors.primary,
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
                isLoading
                    ? _loader()
                    : Text(label, style: textStyle ?? context.medium18White),
              ],
            )
          : isLoading
          ? _loader()
          : Text(label, style: textStyle ?? context.medium18White),
    );
  }

  /// Fixed-size loader so the button keeps its height/background while loading.
  Widget _loader() => const SizedBox(
    height: 24,
    width: 24,
    child: CircularProgressIndicator(
      strokeWidth: 2.5,
      color: AppColors.white,
    ),
  );
}
