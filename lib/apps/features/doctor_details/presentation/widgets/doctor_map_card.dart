import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/themes/app_theme.dart';
import '../../data/models/doctor_details_content.dart';
import 'clinic_map.dart';

/// Straight-line distance to the clinic, used for the map card's caption.
const Distance _distance = Distance();

/// The clinic map presented as a rounded card, captioned with how far the
/// clinic is from the user's current location.
class DoctorMapCard extends StatelessWidget {
  const DoctorMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
      context.r(AppSize.detailsMapTopRadius),
    );
    final metres = _distance.as(
      LengthUnit.Meter,
      kUserLocation,
      kClinicLocation,
    );
    final label = metres >= 1000
        ? '${(metres / 1000).toStringAsFixed(1)} km'
        : '${metres.round()} m';

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
                horizontal: context.w(AppSize.s12),
                vertical: context.w(AppSize.s10),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.near_me_rounded,
                    size: context.w(AppSize.s16),
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(width: context.w(AppSize.s8)),
                  Expanded(
                    child: Text(
                      AppStrings.distanceAway(label),
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
            const ClinicMap(),
          ],
        ),
      ),
    );
  }
}
