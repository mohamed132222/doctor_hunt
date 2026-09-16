import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/themes/app_theme.dart';
import '../../data/models/doctor.dart';
import 'doctor_photo.dart';
import 'rating_stars.dart';

/// "Popular Doctor" card — 140 x 195 in the design.
///
/// The photo fills the card edge to edge across the top (~2/3 of the height,
/// no inset), with name, specialty and stars centred underneath.
class PopularDoctorCard extends StatelessWidget {
  const PopularDoctorCard({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(context.r(AppSize.popularCardRadius));

    return SizedBox(
      width: context.w(AppSize.popularCardWidth),
      height: context.w(AppSize.popularCardWidth) * AppSize.popularCardAspect,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: radius,
          boxShadow: [context.themeColors.homeCardShadow],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: doctor.photoHeroTag,
                      child: SizedBox(
                        width: double.infinity,
                        child: DoctorPhoto(
                          doctor: doctor,
                          iconSize: context.w(AppSize.doctorAvatarSize),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.w(AppSize.s12),
                      context.h(AppSize.s12),
                      context.w(AppSize.s12),
                      context.h(AppSize.s8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          doctor.name,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.h(AppSize.s2)),
                        Text(
                          doctor.specialty,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: AppSize.s12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.h(AppSize.s4)),
                        RatingStars(
                          rating: doctor.rating,
                          size: context.w(AppSize.popularStarSize),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
