import 'package:flutter/material.dart';

import '../extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key, required this.title, this.onBack, this.trailing});

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final slot = context.adminBackButton;

    return SizedBox(
      height: context.adminTopBarHeight,
      child: Row(
        children: [
          _CircleIcon(
            icon: Icons.arrow_back,
            onTap: onBack ?? () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.bold20Black,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: slot,
            child: trailing == null
                ? null
                : Align(alignment: Alignment.centerRight, child: trailing),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = context.adminBackButton;
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon, size: context.iconSmall),
        ),
      ),
    );
  }
}
