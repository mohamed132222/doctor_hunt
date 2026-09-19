import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../main/data/models/doctor.dart';
import '../../../main/presentation/widgets/doctor_photo.dart';
import '../../../main/presentation/widgets/rating_stars.dart';

/// Compact doctor card shown at the top of the booking screen: photo, name,
/// clinic, rating and a favourite toggle.
class BookingDoctorCard extends StatefulWidget {
  const BookingDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<BookingDoctorCard> createState() => _BookingDoctorCardState();
}

class _BookingDoctorCardState extends State<BookingDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.bookingCardRadius);
    final photo = context.bookingCardPhoto;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      padding: EdgeInsets.all(context.s12),
      child: Row(
        children: [
          Hero(
            tag: doctor.photoHeroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.bookingDateRadius),
              child: SizedBox(
                width: photo,
                height: photo,
                child: DoctorPhoto(doctor: doctor, iconSize: context.s24),
              ),
            ),
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s2),
                Text(
                  t.clinicFallback,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: AppSize.s12,
                    color: scheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s6),
                RatingStars(rating: doctor.rating, size: context.s12),
              ],
            ),
          ),
          SizedBox(width: context.s8),
          GestureDetector(
            onTap: () => setState(() => _favorite = !_favorite),
            behavior: HitTestBehavior.opaque,
            child: Icon(
              _favorite ? Icons.favorite : Icons.favorite_border,
              size: context.detailsHeartSize,
              color: _favorite ? scheme.error : colors.favoriteOutline,
            ),
          ),
        ],
      ),
    );
  }
}
