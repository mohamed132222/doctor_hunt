import 'package:flutter/material.dart';
import '../../../../../core/extensions/media_query_extension.dart';

class PhotoContent extends StatelessWidget {
  const PhotoContent({super.key, this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final path = image;

    if (path == null) {
      return Center(
        child: Icon(
          Icons.person_rounded,
          size: context.s28,
          color: scheme.onSurfaceVariant,
        ),
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Center(
        child: Icon(
          Icons.person_rounded,
          size: context.s28,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
