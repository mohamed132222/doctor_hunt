import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../data/models/booking_day.dart';

/// Horizontally scrollable date picker: each card shows the date and how many
/// slots that day has, with the selected card filled in the accent colour.
class BookingDateStrip extends StatelessWidget {
  const BookingDateStrip({
    super.key,
    required this.days,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<BookingDay> days;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final textExtra =
        (textScale - 1).clamp(0.0, 1.0) *
        context.w(AppSize.bookingDateTextBlock);

    return SizedBox(
      height:
          context.w(AppSize.bookingDateHeight) +
          context.w(AppSize.s16) +
          textExtra,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: context.w(AppSize.s8)),
        itemCount: days.length,
        separatorBuilder: (context, index) =>
            SizedBox(width: context.w(AppSize.s12)),
        itemBuilder: (context, index) => _DateCard(
          day: days[index],
          label: AppStrings.dateLabel(
            days[index].date,
            isToday: index == 0,
            isTomorrow: index == 1,
          ),
          selected: index == selectedIndex,
          onTap: () => onSelect(index),
        ),
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
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
    final radius = BorderRadius.circular(context.r(AppSize.bookingDateRadius));

    return Container(
      constraints: BoxConstraints(
        minHeight: context.w(AppSize.bookingDateHeight),
      ),
      width: context.w(AppSize.bookingDateWidth),
      child: Material(
        color: selected ? scheme.primary : scheme.surface,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.w(AppSize.s12)),
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
                SizedBox(height: context.w(AppSize.s2)),
                Text(
                  day.hasSlots
                      ? (day.totalSlots == 1
                            ? AppStrings.oneSlotAvailable
                            : AppStrings.slotsAvailable(day.totalSlots))
                      : AppStrings.noSlotsAvailable,
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
