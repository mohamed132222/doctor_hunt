import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

enum AvatarShape { circle, rounded }

class PhotoAvatar extends StatelessWidget {
  const PhotoAvatar({
    super.key,
    required this.size,
    this.imagePath,
    this.initials,
    this.shape = AvatarShape.circle,
    this.radius,
  });

  final double size;
  final String? imagePath;
  final String? initials;
  final AvatarShape shape;

  final double? radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final borderRadius = BorderRadius.circular(
      shape == AvatarShape.circle ? size : (radius ?? size * 0.22),
    );
    final fallback = _fallback(context, scheme);
    final path = imagePath;

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: size,
        height: size,
        child: path == null || path.isEmpty ? fallback : _image(path, fallback),
      ),
    );
  }

  Widget _image(String path, Widget fallback) {
    final cache = (size * 3).round();
    Widget onError(BuildContext _, Object _, StackTrace? _) => fallback;

    if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        fit: BoxFit.cover,
        placeholder: (_, _) => fallback,
        errorWidget: (_, _, _) => fallback,
      );
    }
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        cacheWidth: cache,
        errorBuilder: onError,
      );
    }
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      cacheWidth: cache,
      errorBuilder: onError,
    );
  }

  Widget _fallback(BuildContext context, ColorScheme scheme) {
    final hasInitials = initials != null && initials!.isNotEmpty;
    return ColoredBox(
      color: scheme.primary.withValues(alpha: 0.12),
      child: Center(
        child: hasInitials
            ? Text(
                initials!,
                style: context.semiBold16.copyWith(color: scheme.primary),
              )
            : Icon(Icons.person, color: scheme.primary, size: size * 0.5),
      ),
    );
  }
}
