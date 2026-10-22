import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/themes/app_colors.dart';

const LatLng _defaultCenter = LatLng(-1.3013, 36.8073);

class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final LatLng? value;
  final ValueChanged<LatLng> onChanged;

  static const String _tileUrl =
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const String _userAgent = 'doctor_hunt';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markerSize = context.detailsMapMarker;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.adminClinicLocation.toUpperCase(),
          style: context.semiBold12TextMain.copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: context.s10),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.adminCardRadius),
          child: SizedBox(
            height: context.locationPickerHeight,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: value ?? _defaultCenter,
                    initialZoom: 13,
                    onTap: (_, point) => onChanged(point),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: _tileUrl,
                      userAgentPackageName: _userAgent,
                      tileProvider: NetworkTileProvider(
                        cachingProvider: DisabledMapCachingProvider(),
                      ),
                    ),
                    if (value != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: value!,
                            width: markerSize,
                            height: markerSize,
                            alignment: Alignment.topCenter,
                            child: Icon(
                              Icons.location_on,
                              color: theme.colorScheme.primary,
                              size: markerSize,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  left: context.s8,
                  bottom: context.s8,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.s8,
                      vertical: context.s4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(context.r8),
                    ),
                    child: Text(
                      t.adminTapMapHint,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
