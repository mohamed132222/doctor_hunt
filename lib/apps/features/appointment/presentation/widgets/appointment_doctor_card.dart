import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../main/data/models/doctor.dart';
import '../../../main/presentation/widgets/doctor_photo.dart';
import '../../../main/presentation/widgets/rating_stars.dart';

/// The doctor being booked: portrait photo, name, specialty, rating, price and
/// a favourite toggle.
class AppointmentDoctorCard extends StatefulWidget {
  const AppointmentDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<AppointmentDoctorCard> createState() => _AppointmentDoctorCardState();
}

class _AppointmentDoctorCardState extends State<AppointmentDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.r(AppSize.bookingCardRadius));

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(context.w(AppSize.s12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: doctor.photoHeroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.r(AppSize.r8)),
                    child: SizedBox(
                      width: context.w(AppSize.appointmentPhotoWidth),
                      height: context.w(AppSize.appointmentPhotoHeight),
                      child: DoctorPhoto(
                        doctor: doctor,
                        iconSize: context.w(AppSize.s24),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.w(AppSize.s12)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: context.w(AppSize.s28)),
                        child: Text(
                          doctor.name,
                          style: theme.textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: context.w(AppSize.s2)),
                      Text(
                        doctor.specialty,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: AppSize.s12,
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.w(AppSize.s8)),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: context.w(AppSize.s4),
                        children: [
                          RatingStars(
                            rating: doctor.rating,
                            size: context.w(AppSize.s14),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '\$ ${doctor.pricePerHour.toStringAsFixed(2)}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeight.w700,
                                    color: colors.priceAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.perHourShort,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: AppSize.s12,
                                    color: colors.priceAccent,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: context.w(AppSize.s12),
            right: context.w(AppSize.s12),
            child: GestureDetector(
              onTap: () => setState(() => _favorite = !_favorite),
              behavior: HitTestBehavior.opaque,
              child: Icon(
                _favorite ? Icons.favorite : Icons.favorite_border,
                size: context.w(AppSize.detailsHeartSize),
                color: _favorite ? scheme.error : colors.favoriteOutline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
