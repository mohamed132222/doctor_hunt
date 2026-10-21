import 'avatar.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
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
    final colors = context.themeColors;
    final headerHeight = context.profileHeaderHeight;
    final avatar = context.profileAvatar;

    return SizedBox(
      height: headerHeight + avatar / 2,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: headerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [colors.headerGradientStart, colors.headerGradientEnd],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(context.profileHeaderRadius),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.s20),
                child: Row(
                  children: [
                    _BackButton(onTap: () => context.pop()),
                    SizedBox(width: context.s16),
                    Text(t.tabProfile, style: context.bold20White),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Avatar(
              photo: photo,
              initials: initials,
              onPickPhoto: onPickPhoto,
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = context.adminBackButton;
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(context.r12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: context.profileEditIcon,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
