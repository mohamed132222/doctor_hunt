import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../data/models/doctor.dart';
import 'doctor_photo.dart';

/// "Feature Doctor" card — 109 x 150 in the design.
///
/// Top row is the favourite toggle (outline indigo / filled red) and the star
/// rating; then the photo avatar, the name and the hourly price.
class FeatureDoctorCard extends StatefulWidget {
  const FeatureDoctorCard({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  State<FeatureDoctorCard> createState() => _FeatureDoctorCardState();
}

class _FeatureDoctorCardState extends State<FeatureDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  void _toggleFavorite() => setState(() => _favorite = !_favorite);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.r12);
    final labelStyle = theme.textTheme.labelSmall;

    // Grow the card with the system font size so accessible text is never
    // cropped by the design's fixed aspect.
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final textExtra =
        (textScale - 1).clamp(0.0, 1.0) * context.featureTextBlockHeight;

    return SizedBox(
      width: context.featureCardWidth,
      height: context.featureCardHeight + textExtra,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: radius,
          boxShadow: [colors.homeCardShadow],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              child: Padding(
                padding: EdgeInsets.all(context.s6),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _toggleFavorite,
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            _favorite ? Icons.favorite : Icons.favorite_border,
                            size: context.featureIconSize,
                            color: _favorite
                                ? scheme.error
                                : colors.favoriteOutline,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.star_rounded,
                          size: context.featureIconSize,
                          color: colors.starRating,
                        ),
                        SizedBox(width: context.s2),
                        Text(
                          doctor.rating.toStringAsFixed(1),
                          style: labelStyle?.copyWith(
                            fontSize: AppSize.s12,
                            color: scheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.s6),
                    // Flexible + scaleDown: when a large system font needs more
                    // vertical room, the avatar gives it up instead of
                    // overflowing the card.
                    Flexible(
                      child: Hero(
                        tag: doctor.photoHeroTag,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: ClipOval(
                            child: SizedBox(
                              width: context.doctorAvatarSize,
                              height: context.doctorAvatarSize,
                              child: DoctorPhoto(
                                doctor: doctor,
                                iconSize: context.s24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: context.s6),
                    Text(
                      doctor.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: AppSize.featureNameSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s2),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '\$ ${doctor.pricePerHour.toStringAsFixed(2)}',
                            style: labelStyle?.copyWith(
                              fontSize: AppSize.featurePriceSize,
                              color: colors.priceAccent,
                            ),
                          ),
                          TextSpan(
                            text: t.perHourSuffix,
                            style: labelStyle?.copyWith(
                              fontSize: AppSize.featurePriceSize,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
