import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final size = context.drawerAvatar;
    final initials = _initials(name);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.2),
      ),
      child: initials.isEmpty
          ? Icon(Icons.person, color: AppColors.white, size: size * 0.5)
          : Text(
              initials,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: AppColors.white),
            ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '';
  final first = parts.first[0];
  final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
  return (first + last).toUpperCase();
}
