import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
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
    final radius = BorderRadius.circular(context.popularCardRadius);

    return SizedBox(
      width: context.popularCardWidth,
      height: context.popularCardWidth * AppSize.popularCardAspect,
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
                          iconSize: context.doctorAvatarSize,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      context.s12,
                      context.s12,
                      context.s12,
                      context.s8,
                    ),
                    child: Column(
                      children: [
                        Text(
                          doctor.name,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.s2),
                        Text(
                          doctor.specialty,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: AppSize.s12,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.s4),
                        RatingStars(
                          rating: doctor.rating,
                          size: context.popularStarSize,
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
