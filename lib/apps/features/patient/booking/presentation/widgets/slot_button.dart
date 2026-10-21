import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../data/models/booking_day_model.dart';

class SlotButton extends StatelessWidget {
  const SlotButton({
    super.key,
    required this.slot,
    required this.selected,
    this.onTap,
  });

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
