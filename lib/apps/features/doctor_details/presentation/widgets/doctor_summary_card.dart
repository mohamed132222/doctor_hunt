import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../main/data/models/doctor.dart';
import '../../../main/presentation/widgets/doctor_photo.dart';
import '../../../main/presentation/widgets/rating_stars.dart';

/// The doctor's summary card: photo, name, specialty, rating, price and the
/// booking CTA, plus a favourite toggle.
class DoctorSummaryCard extends StatefulWidget {
  const DoctorSummaryCard({super.key, required this.doctor, this.onBook});

  final Doctor doctor;
  final VoidCallback? onBook;

  @override
  State<DoctorSummaryCard> createState() => _DoctorSummaryCardState();
}

class _DoctorSummaryCardState extends State<DoctorSummaryCard> {
  late bool _favorite = widget.doctor.isFavorite;

  void _toggleFavorite() => setState(() => _favorite = !_favorite);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.r(AppSize.detailsCardRadius));
    final photo = context.w(AppSize.detailsPhotoSize);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(context.w(AppSize.s16)),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shared element: flies from the tapped home card.
                    Hero(
                      tag: doctor.photoHeroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.r(AppSize.detailsCardRadius),
                        ),
                        child: SizedBox(
                          width: photo,
                          height: photo,
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
                            padding: EdgeInsets.only(
                              right: context.w(AppSize.s28),
                            ),
                            child: Text(
                              doctor.name,
                              style: theme.textTheme.headlineSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: context.w(AppSize.s4)),
                          Text(
                            doctor.specialty,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.w(AppSize.s8)),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: context.w(AppSize.s2),
                            children: [
                              RatingStars(
                                rating: doctor.rating,
                                size: context.w(AppSize.s14),
                              ),
                              SizedBox(width: context.w(AppSize.s48)),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '\$ ${doctor.pricePerHour.toStringAsFixed(2)}',
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            fontSize: AppSize.s14,
                                            fontWeight: FontWeight.w600,
                                            color: colors.priceAccent,
                                          ),
                                    ),
                                    TextSpan(
                                      text: AppStrings.perHourShort,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
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
                SizedBox(height: context.w(AppSize.s16)),
                _BookNowButton(onTap: widget.onBook),
              ],
            ),
          ),
          Positioned(
            top: context.w(AppSize.s16),
            right: context.w(AppSize.s16),
            child: GestureDetector(
              onTap: _toggleFavorite,
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

class _BookNowButton extends StatelessWidget {
  const _BookNowButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
      context.r(AppSize.detailsBookButtonRadius),
    );

    return SizedBox(
      width: context.w(AppSize.detailsBookButtonWidth),
      height: context.w(AppSize.detailsBookButtonHeight),
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              AppStrings.bookNow,
              style: theme.textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
