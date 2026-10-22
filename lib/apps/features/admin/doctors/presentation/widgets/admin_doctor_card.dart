import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/avatar.dart';
import '../../../../../core/widgets/rating_stars.dart';
import '../../../../../core/widgets/status_pill.dart';
import '../../../../common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AdminDoctorCard extends StatelessWidget {
  const AdminDoctorCard({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.adminDoctorCardRadius);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(context.s12),
            child: Row(
              children: [
                PhotoAvatar(
                  size: context.adminDoctorCardPhoto,
                  imagePath: doctor.photo,
                  shape: AvatarShape.rounded,
                  radius: context.adminDoctorCardPhotoRadius,
                ),
                SizedBox(width: context.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: context.bold16Black,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.s2),
                      Text(
                        doctor.specialty.label,
                        style: context.medium12.copyWith(color: scheme.primary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.s6),
                      Row(
                        children: [
                          RatingStars(
                            rating: doctor.rating,
                            size: context.popularStarSize,
                          ),
                          SizedBox(width: context.s6),
                          Flexible(
                            child: Text(
                              '${doctor.rating.toStringAsFixed(1)} · '
                              '${t.adminReviewsCount(count: doctor.reviewsCount)}',
                              style: context.regular12TextSub,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.s8),
                StatusPill(
                  label: doctor.isActive
                      ? t.adminStatusActive
                      : t.adminStatusInactive,
                  variant: doctor.isActive
                      ? StatusVariant.success
                      : StatusVariant.danger,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
