import 'package:flutter/material.dart';

import '../appsize/media_query_extension.dart';

/// Full-width primary button.
///
/// Visual styling comes from the app theme's `FilledButtonTheme`. Pass [height],
/// [radius] or [fontSize] (design px) for the few places that need a specific
/// box; anything left null inherits from the theme.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.style,
    this.height,
    this.radius,
    this.fontSize,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonStyle? style;

  /// Design-px button height. Null inherits the theme's.
  final double? height;

  /// Design-px corner radius. Null inherits the theme's.
  final double? radius;

  /// Design-px label size. Null inherits the theme's.
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final content = icon == null
        ? Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: context.iconSmall),
              SizedBox(width: context.s8),
              Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          );

    final h = height;
    final r = radius;
    final f = fontSize;

    // Merge onto whatever style was passed (or the theme default) so callers
    // only state what they override.
    final resolved = (style ?? ButtonStyle()).merge(
      ButtonStyle(
        minimumSize: h == null
            ? null
            : WidgetStatePropertyAll(Size.fromHeight(context.sizeOf(h))),
        shape: r == null
            ? null
            : WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.sizeOf(r)),
                ),
              ),
        textStyle: f == null
            ? null
            : WidgetStatePropertyAll(
                Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: f),
              ),
      ),
    );

    return FilledButton(style: resolved, onPressed: onPressed, child: content);
  }
}
