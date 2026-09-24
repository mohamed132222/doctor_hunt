import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/app_theme.dart';

/// A month grid: green month header with prev/next arrows, weekday initials,
/// and day cells where the selected day is filled and today is ringed.
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.month,
    required this.selectedDay,
    required this.onSelect,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final DateTime month;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onSelect;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(context.calendarRadius);
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    // Dart weekday is Mon = 1 … Sun = 7, so Monday-start grids need no shift.
    final leadingBlanks = firstOfMonth.weekday - 1;
    final today = DateTime.now();

    return Center(
      child: ConstrainedBox(
        // Keeps day cells phone-sized on tablets and in landscape instead of
        // stretching the grid across the full width.
        constraints: BoxConstraints(maxWidth: context.calendarMaxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: radius,
            boxShadow: [context.themeColors.homeCardShadow],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: context.calendarHeaderHeight,
                color: theme.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: context.s12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.monthYear(month),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _MonthArrow(
                      icon: Icons.chevron_left,
                      tooltip: t.previousMonth,
                      onTap: onPreviousMonth,
                    ),
                    _MonthArrow(
                      icon: Icons.chevron_right,
                      tooltip: t.nextMonth,
                      onTap: onNextMonth,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.s8,
                  context.s12,
                  context.s8,
                  context.s12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (final initial in AppStrings.weekdayInitials)
                          Expanded(
                            child: Center(
                              child: Text(
                                initial,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: AppSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: context.s6),
                    GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: context.s4,
                      children: [
                        for (var i = 0; i < leadingBlanks; i++)
                          const SizedBox.shrink(),
                        for (var day = 1; day <= daysInMonth; day++)
                          _DayCell(
                            date: DateTime(month.year, month.month, day),
                            selected: isSameDay(
                              DateTime(month.year, month.month, day),
                              selectedDay,
                            ),
                            isToday: isSameDay(
                              DateTime(month.year, month.month, day),
                              today,
                            ),
                            onTap: () => onSelect(
                              DateTime(month.year, month.month, day),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthArrow extends StatelessWidget {
  const _MonthArrow({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkResponse(
        onTap: onTap,
        radius: context.s20,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s4),
          child: Icon(
            icon,
            size: context.s20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.selected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime date;
  final bool selected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final size = context.calendarCell;

    return Semantics(
      label: '${date.day}',
      button: true,
      selected: selected,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? scheme.primary : Colors.transparent,
              border: isToday && !selected
                  ? Border.all(color: scheme.primary, width: AppSize.borderThin)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: AppSize.s12,
                fontWeight: selected || isToday
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: selected ? scheme.onPrimary : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
