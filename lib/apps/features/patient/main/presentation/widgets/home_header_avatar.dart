import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:flutter/material.dart';

class HomeHeaderAvatar extends StatelessWidget {
  const HomeHeaderAvatar({super.key, required this.size, this.photo});

  final double size;
  final String? photo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasPhoto = photo != null && photo!.trim().isNotEmpty;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.onPrimary.withValues(alpha: 0.22),
        border: Border.all(
          color: scheme.onPrimary.withValues(alpha: 0.6),
          width: 2,
        ),
      ),
      child: hasPhoto
          ? ClipOval(
              child: PhotoAvatar(size: size, imagePath: photo),
            )
          : Icon(Icons.person, color: scheme.onPrimary, size: size * 0.55),
    );
  }
}
