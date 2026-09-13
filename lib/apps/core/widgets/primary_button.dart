import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';

/// Full-width primary button.
///
/// Visual styling comes from the app theme's `FilledButtonTheme`; pass an
/// optional [style] to use a named variant.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.style,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final content = icon == null
        ? Text(label)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: context.w(AppSize.iconSmall)),
              SizedBox(width: context.w(AppSize.s8)),
              Text(label),
            ],
          );

    return FilledButton(style: style, onPressed: onPressed, child: content);
  }
}
