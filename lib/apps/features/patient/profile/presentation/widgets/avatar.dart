import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.photo,
    required this.initials,
    required this.onPickPhoto,
  });

  final String? photo;
  final String initials;
  final VoidCallback onPickPhoto;

  @override
  Widget build(BuildContext context) {
    final size = context.profileAvatar;
    final border = context.profileAvatarBorder;
    final badge = context.profileCameraBadge;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: border),
              boxShadow: [context.themeColors.cardShadow],
            ),
            child: PhotoAvatar(
              size: size,
              imagePath: photo,
              initials: initials,
            ),
          ),
          Positioned(
            right: 0,
            bottom: context.s4,
            child: GestureDetector(
              onTap: onPickPhoto,
              child: Container(
                width: badge,
                height: badge,
                decoration: BoxDecoration(
                  color: AppColors.textSub,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: Icon(
                  Icons.photo_camera,
                  size: context.profileCameraIcon,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
