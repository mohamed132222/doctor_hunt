import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import '../themes/app_colors.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.icon,
    this.height,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final IconData? icon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;

    return SizedBox(
      height: height ?? context.bookingActionHeight,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: c,
          side: BorderSide(color: c),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.r12),
          ),
          textStyle: context.semiBold16,
        ),
        child: icon == null
            ? FittedBox(fit: BoxFit.scaleDown, child: Text(label, maxLines: 1))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: context.iconSmall, color: c),
                  SizedBox(width: context.s8),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(label, maxLines: 1),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
