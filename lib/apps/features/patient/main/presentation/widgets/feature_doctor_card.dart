import 'package:doctor_hunt/generated/strings.g.dart';
import 'doctor_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../data/models/doctor_model.dart';
import '../controllers/favorites/favorites_cubit.dart';

class FeatureDoctorCard extends StatelessWidget {
  const FeatureDoctorCard({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final radius = BorderRadius.circular(context.r12);
    final labelStyle = theme.textTheme.labelSmall;

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
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.all(context.s6),
                child: Column(
                  children: [
                    Row(
                      children: [
                        BlocSelector<FavoritesCubit, FavoritesState, bool>(
                          selector: (state) => state.ids.contains(doctor.id),
                          builder: (context, favorite) {
                            return GestureDetector(
                              onTap: () => context
                                  .read<FavoritesCubit>()
                                  .toggle(doctor.id),
                              behavior: HitTestBehavior.opaque,
                              child: Icon(
                                favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: context.featureIconSize,
                                color: favorite
                                    ? scheme.error
                                    : colors.favoriteOutline,
                              ),
                            );
                          },
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
                    Flexible(
                      child: Hero(
                        tag: 'feature-${doctor.id}',
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
