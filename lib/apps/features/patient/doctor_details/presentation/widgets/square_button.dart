import 'package:flutter/material.dart';
import '../../../../../core/extensions/media_query_extension.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.size,
    required this.icon,
    required this.onTap,
    this.color,
    this.tooltip,
  });

  final double size;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.detailsActionRadius),
    );
    final button = SizedBox(
      width: size,
      height: size,
      child: Material(
        color: theme.colorScheme.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            size: context.detailsActionIcon,
            color: color ?? theme.colorScheme.onSurface,
          ),
        ),
      ),
    );

    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}
