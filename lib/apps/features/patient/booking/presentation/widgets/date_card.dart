import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../data/models/booking_day_model.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.day,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final BookingDay day;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.bookingDateRadius);

    return Container(
      constraints: BoxConstraints(minHeight: context.bookingDateHeight),
      width: context.bookingDateWidth,
      child: Material(
        color: selected ? scheme.primary : scheme.surface,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.s12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: AppSize.s14,
                    color: selected ? scheme.onPrimary : scheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s2),
                Text(
                  day.hasSlots
                      ? (day.totalSlots == 1
                            ? AppStrings.oneSlotAvailable
                            : AppStrings.slotsAvailable(day.totalSlots))
                      : t.noSlotsAvailable,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: AppSize.s12,
                    color: selected
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
