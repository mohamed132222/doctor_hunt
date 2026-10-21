import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:doctor_hunt/apps/features/patient/doctor_details/data/models/doctor_details_content_model.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/doctor_photo.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_stars.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/favorites/favorites_cubit.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'doctor_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../main/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _distance = Distance();

class DoctorDetailsBody extends StatelessWidget {
  const DoctorDetailsBody({super.key, required this.doctor});

  final Doctor doctor;

  void _onBook(BuildContext context) {
    BookingRoute(doctorId: doctor.id).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(
            title: t.doctorDetailsTitle,
            onBack: () => context.pop(),
            actionTooltip: t.searchDoctors,
            onAction: () => const HomeRoute().go(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: gutter,
                    child: _DoctorSummaryCard(
                      doctor: doctor,
                      onBook: () => _onBook(context),
                    ),
                  ),
                  SizedBox(height: context.s16),
                  Padding(
                    padding: gutter,
                    child: _DoctorStatsCard(stats: doctorStats(doctor)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: context.servicesPaddingH,
                      top: context.servicesPaddingTop,
                      right: context.servicesPaddingH,
                    ),
                    child: _DoctorServices(points: kServicePoints),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSize.s20,
                      AppSize.s20,
                      AppSize.s20,
                      AppSize.s42,
                    ),
                    child: _DoctorMapCard(doctor: doctor),
                  ),
                  SizedBox(height: context.s16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DoctorMapCard extends StatelessWidget {
  const _DoctorMapCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(context.detailsMapTopRadius);
    final clinic = doctor.hasLocation
        ? LatLng(doctor.latitude!, doctor.longitude!)
        : kClinicLocation;
    final metres = _distance.as(LengthUnit.Meter, kUserLocation, clinic);
    final distance = metres >= 1000
        ? '${(metres / 1000).toStringAsFixed(1)} km'
        : '${metres.round()} m';
    final label = (doctor.locationLabel?.isNotEmpty ?? false)
        ? doctor.locationLabel!
        : t.distanceAway(distance: distance);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: radius,
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.s12,
                vertical: context.s10,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_rounded,
                    size: context.s16,
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: context.s8),
                  Expanded(
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
              ),
            ),
            _ClinicMap(clinic: clinic),
          ],
        ),
      ),
    );
  }
}

class _ClinicMap extends StatelessWidget {
  const _ClinicMap({super.key, required this.clinic});

  final LatLng clinic;

  static const String _tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String _userAgent = 'doctor_hunt';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markerSize = context.detailsMapMarker;
    final dotSize = context.detailsMapDot;

    return SizedBox(
      height: context.detailsMapHeight,
      width: double.infinity,
      child: FlutterMap(
        options: MapOptions(
          initialCameraFit: CameraFit.bounds(
            bounds: LatLngBounds(kUserLocation, clinic),
            padding: EdgeInsets.all(context.s24),
          ),
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: _tileUrl,
            userAgentPackageName: _userAgent,
            tileProvider: NetworkTileProvider(
              cachingProvider: DisabledMapCachingProvider(),
            ),
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [kUserLocation, kClinicLocation],
                color: theme.colorScheme.primary,
                strokeWidth: context.s4,
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: clinic,
                width: markerSize,
                height: markerSize,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: markerSize * 0.4,
                    height: markerSize * 0.4,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Marker(
                point: kUserLocation,
                width: dotSize,
                height: dotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.tertiary,
                    border: Border.all(
                      color: theme.colorScheme.surface,
                      width: context.s2,
                    ),
                  ),
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            showFlutterMapAttribution: false,
            attributions: [TextSourceAttribution(t.mapAttribution)],
          ),
        ],
      ),
    );
  }
}

class _DoctorServices extends StatelessWidget {
  const _DoctorServices({super.key, required this.points});

  final List<ServicePoint> points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.servicesTitle, style: theme.textTheme.headlineSmall),
        SizedBox(height: context.s12),
        for (var i = 0; i < points.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: context.s12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.numberedItem(i),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(width: context.s8),
                Expanded(
                  child: Text(
                    points[i].text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DoctorStatsCard extends StatelessWidget {
  const _DoctorStatsCard({super.key, required this.stats});

  final List<DoctorStat> stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(context.detailsStatRadius),
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      padding: EdgeInsets.all(context.detailsStatsPadding),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0) SizedBox(width: context.s10),
              Expanded(child: _DoctorStatTile(stat: stats[i])),
            ],
          ],
        ),
      ),
    );
  }
}

class _DoctorStatTile extends StatelessWidget {
  const _DoctorStatTile({super.key, required this.stat});

  final DoctorStat stat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(minHeight: context.detailsStatHeight),
      padding: EdgeInsets.symmetric(horizontal: context.s8),
      decoration: BoxDecoration(
        color: context.themeColors.screenTint,
        borderRadius: BorderRadius.circular(context.detailsStatRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat.value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontSize: AppSize.s24,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: context.s2),
          Text(
            stat.label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: AppSize.s12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _DoctorSummaryCard extends StatelessWidget {
  const _DoctorSummaryCard({super.key, required this.doctor, this.onBook});

  final Doctor doctor;
  final VoidCallback? onBook;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final radius = BorderRadius.circular(context.detailsCardRadius);
    final photo = context.detailsPhotoSize;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(context.s16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: doctor.photoHeroTag,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          context.detailsCardRadius,
                        ),
                        child: SizedBox(
                          width: photo,
                          height: photo,
                          child: DoctorPhoto(
                            doctor: doctor,
                            iconSize: context.s24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.s12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: context.s28),
                            child: Text(
                              doctor.name,
                              style: theme.textTheme.headlineSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: context.s4),
                          Text(
                            doctor.specialty,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.s8),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: context.s2,
                            children: [
                              RatingStars(
                                rating: doctor.rating,
                                size: context.s14,
                              ),
                              SizedBox(width: context.s48),
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
                                      text: t.perHourShort,
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
                SizedBox(height: context.s16),
                _BookNowButton(onTap: onBook),
              ],
            ),
          ),
          Positioned(
            top: context.s16,
            right: context.s16,
            child: BlocSelector<FavoritesCubit, FavoritesState, bool>(
              selector: (state) => state.ids.contains(doctor.id),
              builder: (context, favorite) {
                return GestureDetector(
                  onTap: () => context.read<FavoritesCubit>().toggle(doctor.id),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(
                    favorite ? Icons.favorite : Icons.favorite_border,
                    size: context.detailsHeartSize,
                    color: favorite ? scheme.error : colors.favoriteOutline,
                  ),
                );
              },
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
    final radius = BorderRadius.circular(context.detailsBookButtonRadius);

    return SizedBox(
      width: context.detailsBookButtonWidth,
      height: context.detailsBookButtonHeight,
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              t.bookNow,
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
