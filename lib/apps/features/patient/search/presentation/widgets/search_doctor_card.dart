import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../main/data/models/doctor.dart';
import '../../../main/presentation/widgets/doctor_photo.dart';

/// A search result: photo, name, specialty, experience, satisfaction metrics,
/// next availability and a booking shortcut.
class SearchDoctorCard extends StatefulWidget {
  const SearchDoctorCard({
    super.key,
    required this.doctor,
    this.onTap,
    this.onBook,
  });

  final Doctor doctor;
  final VoidCallback? onTap;
  final VoidCallback? onBook;

  @override
  State<SearchDoctorCard> createState() => _SearchDoctorCardState();
}

class _SearchDoctorCardState extends State<SearchDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(
      context.sizeOf(AppSize.searchCardRadius),
    );

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
          onTap: widget.onTap,
          borderRadius: radius,
          child: Padding(
            padding: EdgeInsets.all(context.paddingOf(AppSize.s12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: doctor.photoHeroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.sizeOf(AppSize.r12),
                        ),
                        child: SizedBox(
                          width: context.sizeOf(AppSize.searchPhotoSize),
                          height: context.sizeOf(AppSize.searchPhotoSize),
                          child: DoctorPhoto(
                            doctor: doctor,
                            iconSize: context.paddingOf(AppSize.s24),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.paddingOf(AppSize.s12)),
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
                          SizedBox(height: context.paddingOf(AppSize.s2)),
                          Text(
                            doctor.specialty,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: AppSize.s12,
                              fontWeight: FontWeight.w600,
                              color: scheme.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s4)),
                          Text(
                            AppStrings.experienceYears(doctor.experienceYears),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: AppSize.s12,
                              color: scheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s8)),
                          Row(
                            children: [
                              _Metric(
                                label: AppStrings.satisfactionPercent(
                                  doctor.satisfaction,
                                ),
                              ),
                              SizedBox(width: context.paddingOf(AppSize.s12)),
                              Expanded(
                                child: _Metric(
                                  label: AppStrings.patientStories(
                                    doctor.patientStories,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.paddingOf(AppSize.s8)),
                    GestureDetector(
                      onTap: () => setState(() => _favorite = !_favorite),
                      behavior: HitTestBehavior.opaque,
                      child: Icon(
                        _favorite ? Icons.favorite : Icons.favorite_border,
                        size: context.sizeOf(AppSize.detailsHeartSize),
                        color: _favorite
                            ? scheme.error
                            : colors.favoriteOutline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.paddingOf(AppSize.s12)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.nextAvailableLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: AppSize.s12,
                              fontWeight: FontWeight.w600,
                              color: scheme.primary,
                            ),
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s2)),
                          Text(
                            doctor.nextAvailable,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: AppSize.s12,
                              color: scheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.paddingOf(AppSize.s8)),
                    SizedBox(
                      width: context.sizeOf(AppSize.searchBookWidth),
                      height: context.sizeOf(AppSize.searchBookHeight),
                      child: Material(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(
                          context.sizeOf(AppSize.r8),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: widget.onBook,
                          child: Center(
                            child: Text(
                              AppStrings.bookNow,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontSize: AppSize.s12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A dotted metric pair, e.g. "• 87%".
class _Metric extends StatelessWidget {
  const _Metric({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.sizeOf(AppSize.searchRankDot),
          height: context.sizeOf(AppSize.searchRankDot),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(width: context.paddingOf(AppSize.s6)),
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: AppSize.s12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
