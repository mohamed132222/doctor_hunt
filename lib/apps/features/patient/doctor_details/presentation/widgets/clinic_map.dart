import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../data/models/doctor_details_content.dart';

/// A real OpenStreetMap view of the clinic.
///
/// No API key is required. The camera is fitted to both the clinic and the
/// user's location, so neither marker can be cropped out.
///
/// All map gestures are disabled: this map sits inside a scroll view, and an
/// interactive map swallows the page's vertical drag. Pinch-zooming would make
/// the page unscrollable past the map.
class ClinicMap extends StatelessWidget {
  const ClinicMap({super.key});

  static const String _tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String _userAgent = 'doctor_hunt';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markerSize = context.sizeOf(AppSize.detailsMapMarker);
    final dotSize = context.sizeOf(AppSize.detailsMapDot);

    return SizedBox(
      height: context.sizeOf(AppSize.detailsMapHeight),
      width: double.infinity,
      child: FlutterMap(
        options: MapOptions(
          initialCameraFit: CameraFit.bounds(
            bounds: LatLngBounds(kUserLocation, kClinicLocation),
            padding: EdgeInsets.all(context.paddingOf(AppSize.s24)),
          ),
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.none,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: _tileUrl,
            userAgentPackageName: _userAgent,
            // The default disk cache depends on path_provider, which has no
            // implementation in widget tests. Disabling the cache keeps the
            // map renderable in tests and still works at runtime.
            tileProvider: NetworkTileProvider(
              cachingProvider: const DisabledMapCachingProvider(),
            ),
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [kUserLocation, kClinicLocation],
                color: theme.colorScheme.primary,
                strokeWidth: context.paddingOf(AppSize.s4),
              ),
            ],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: kClinicLocation,
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
                      width: context.paddingOf(AppSize.s2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          RichAttributionWidget(
            showFlutterMapAttribution: false,
            attributions: [TextSourceAttribution(AppStrings.mapAttribution)],
          ),
        ],
      ),
    );
  }
}
