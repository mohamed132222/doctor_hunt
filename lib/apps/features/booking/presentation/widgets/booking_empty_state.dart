import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';

/// Shown for a day with no free slots: the status, a shortcut to the next day
/// that has slots, and a way to reach the clinic instead.
class BookingEmptyState extends StatelessWidget {
  const BookingEmptyState({
    super.key,
    required this.dayLabel,
    required this.nextAvailabilityLabel,
    this.onNextAvailability,
    this.onContactClinic,
  });

  final String dayLabel;
  final String? nextAvailabilityLabel;
  final VoidCallback? onNextAvailability;
  final VoidCallback? onContactClinic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          dayLabel,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: context.w(AppSize.s4)),
        Text(
          AppStrings.noSlotsAvailable,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (nextAvailabilityLabel != null) ...[
          SizedBox(height: context.w(AppSize.s20)),
          _BookingActionButton(
            label: nextAvailabilityLabel!,
            filled: true,
            onTap: onNextAvailability,
          ),
        ],
        SizedBox(height: context.w(AppSize.s12)),
        Text(
          AppStrings.orLabel,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.w(AppSize.s12)),
        _BookingActionButton(
          label: AppStrings.contactClinic,
          filled: false,
          onTap: onContactClinic,
        ),
      ],
    );
  }
}

class _BookingActionButton extends StatelessWidget {
  const _BookingActionButton({
    required this.label,
    required this.filled,
    this.onTap,
  });

  final String label;
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(
      context.r(AppSize.bookingActionRadius),
    );
    final shape = RoundedRectangleBorder(
      borderRadius: radius,
      side: filled
          ? BorderSide.none
          : BorderSide(color: scheme.primary, width: AppSize.borderThin),
    );

    return SizedBox(
      height: context.w(AppSize.bookingActionHeight),
      child: Material(
        color: filled ? scheme.primary : scheme.surface,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: AppSize.s16,
                color: filled ? scheme.onPrimary : scheme.primary,
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
