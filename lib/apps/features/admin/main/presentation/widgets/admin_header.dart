import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/avatar.dart';
import '../../../../../core/widgets/photo_picker.dart';
import '../../../settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({
    super.key,
    required this.title,
    this.avatarInitials = 'A',
    this.showBell = true,
    this.enableAvatarUpload = false,
  });

  final String title;
  final String avatarInitials;
  final bool showBell;
  final bool enableAvatarUpload;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: context.bold28Black,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showBell) ...[
          _Bell(color: scheme.onSurface, size: context.adminBellSize),
          SizedBox(width: context.s16),
        ],
        _HeaderAvatar(
          size: context.adminHeaderAvatar,
          fallbackInitials: avatarInitials,
          enableUpload: enableAvatarUpload,
        ),
      ],
    );
  }
}

class _Bell extends StatelessWidget {
  const _Bell({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Icon(Icons.notifications_none_rounded, size: size, color: color),
          Positioned(
            right: 0,
            top: context.s2,
            child: Container(
              width: context.s8,
              height: context.s8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  const _HeaderAvatar({
    required this.size,
    required this.fallbackInitials,
    required this.enableUpload,
  });

  final double size;
  final String fallbackInitials;
  final bool enableUpload;

  Future<void> _pick(BuildContext context) async {
    final cubit = context.read<AdminProfileCubit>();
    final path = await pickPhoto(context);
    if (path != null) cubit.updatePhoto(path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AdminProfileCubit, AdminProfileState, AdminProfile?>(
      selector: (state) => state.profile,
      builder: (context, profile) {
        final initials = (profile != null && profile.initials.isNotEmpty)
            ? profile.initials
            : fallbackInitials;
        final avatar = PhotoAvatar(
          size: size,
          imagePath: profile?.photo,
          initials: initials,
        );
        if (!enableUpload) return avatar;

        final badge = size * 0.36;
        return GestureDetector(
          onTap: () => _pick(context),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,
              Positioned(
                right: -badge * 0.15,
                bottom: -badge * 0.15,
                child: Container(
                  width: badge,
                  height: badge,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                  child: Icon(
                    Icons.photo_camera,
                    size: badge * 0.55,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
