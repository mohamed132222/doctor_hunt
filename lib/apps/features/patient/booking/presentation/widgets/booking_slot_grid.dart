import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../data/models/booking_day.dart';

/// A period heading ("Afternoon 7 slots") with its slots laid out four to a
/// row. Any number of slots can be chosen at once.
class BookingSlotGrid extends StatelessWidget {
  const BookingSlotGrid({
    super.key,
    required this.period,
    required this.slots,
    this.selectedSlots = const {},
    this.onSelect,
  });

  final String period;
  final List<TimeSlot> slots;
  final Set<TimeSlot> selectedSlots;
  final ValueChanged<TimeSlot>? onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (slots.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.periodSlots(period, slots.length),
          style: theme.textTheme.titleSmall?.copyWith(fontSize: AppSize.s14),
        ),
        SizedBox(height: context.s8),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = context.s8;
            final columnWidth = (constraints.maxWidth - gap * 3) / 4;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final slot in slots)
                  SizedBox(
                    width: columnWidth,
                    child: _SlotButton(
                      slot: slot,
                      selected: selectedSlots.contains(slot),
                      onTap: () => onSelect?.call(slot),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _SlotButton extends StatelessWidget {
  const _SlotButton({required this.slot, required this.selected, this.onTap});

  final TimeSlot slot;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.bookingSlotRadius);

    return Container(
      constraints: BoxConstraints(minHeight: context.bookingSlotHeight),
      child: Material(
        // Selected: the accent solid; unselected: the same accent at 8%.
        color: selected
            ? scheme.primary
            : scheme.primary.withValues(alpha: AppSize.slotIdleAlpha),
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              slot.label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: AppSize.s12,
                fontWeight: FontWeight.w600,
                color: selected ? scheme.onPrimary : scheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
