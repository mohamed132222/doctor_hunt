import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class FavoriteDoctorCard extends StatelessWidget {
  const FavoriteDoctorCard({
    super.key,
    required this.doctor,
    required this.isFavorite,
    required this.onToggle,
    this.onTap,
  });

  final Doctor doctor;
  final bool isFavorite;
  final VoidCallback onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.themeColors;
    final radius = BorderRadius.circular(context.favoriteCardRadius);
    final initials = doctor.name.trim().isEmpty
        ? '?'
        : doctor.name.trim()[0].toUpperCase();

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(context.s12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onToggle,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: context.favoriteHeart,
                      color: isFavorite ? scheme.error : colors.favoriteOutline,
                    ),
                  ),
                ),
                PhotoAvatar(
                  size: context.favoritePhoto,
                  imagePath: doctor.image,
                  initials: initials,
                ),
                SizedBox(height: context.s12),
                Text(
                  doctor.name,
                  style: context.bold16Black,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s4),
                Text(
                  doctor.specialty,
                  style: context.medium14Primary,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
