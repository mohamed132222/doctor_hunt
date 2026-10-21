import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/widgets/avatar.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class DoctorPhotoPicker extends StatelessWidget {
  const DoctorPhotoPicker({
    super.key,
    required this.onTap,
    this.photoPath,
    this.initials,
  });

  final VoidCallback onTap;
  final String? photoPath;
  final String? initials;

  bool get _hasPhoto => photoPath != null && photoPath!.isNotEmpty;
  bool get _hasInitials => initials != null && initials!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = context.adminFormPhoto;
    final showBadge = _hasPhoto || _hasInitials;

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(child: _circle(context, scheme, size)),
                if (showBadge)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _badge(context, scheme),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: context.s12),
        Text(
          _hasPhoto || _hasInitials ? t.adminTapPhotoToChange : t.adminAddPhoto,
          style: context.semiBold14Primary,
        ),
      ],
    );
  }

  Widget _circle(BuildContext context, ColorScheme scheme, double size) {
    if (_hasPhoto) {
      return PhotoAvatar(size: size, imagePath: photoPath, initials: initials);
    }
    if (_hasInitials) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheme.primary.withValues(alpha: 0.12),
        ),
        child: Text(
          initials!,
          style: context.bold24Black.copyWith(color: scheme.primary),
        ),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: scheme.outlineVariant, width: 1.5),
      ),
      child: Icon(
        Icons.photo_camera_outlined,
        size: context.iconSocial,
        color: scheme.onSurfaceVariant,
      ),
    );
  }

  Widget _badge(BuildContext context, ColorScheme scheme) {
    final badge = context.adminFormPhotoBadge;
    return Container(
      width: badge,
      height: badge,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: scheme.primary,
        border: Border.all(color: scheme.surface, width: 2),
      ),
      child: Icon(
        Icons.photo_camera_rounded,
        size: context.iconSmall,
        color: scheme.onPrimary,
      ),
    );
  }
}
