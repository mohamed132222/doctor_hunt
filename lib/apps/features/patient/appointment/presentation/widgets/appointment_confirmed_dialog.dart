import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';

/// Success dialog shown after confirming an appointment.
///
/// Resolves to `true` when the user chooses Done (the caller then returns
/// home) and to `false`/`null` when they choose to edit instead.
Future<bool?> showAppointmentConfirmedDialog(
  BuildContext context, {
  required String doctorName,
  required String date,
  String time = '',
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _AppointmentConfirmedDialog(
      doctorName: doctorName,
      date: date,
      time: time,
    ),
  );
}

class _AppointmentConfirmedDialog extends StatelessWidget {
  const _AppointmentConfirmedDialog({
    required this.doctorName,
    required this.date,
    this.time = '',
  });

  final String doctorName;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.dialogRadius);

    return Dialog(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(borderRadius: radius),
      insetPadding: EdgeInsets.symmetric(
        horizontal: context.dialogInset,
        vertical: context.s24,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.dialogPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.dialogIconBadge,
              height: context.dialogIconBadge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.primaryContainer,
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.thumb_up_rounded,
                size: context.dialogIconGlyph,
                color: scheme.primary,
              ),
            ),
            SizedBox(height: context.s20),
            Text(
              t.thankYou,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: AppSize.dialogTitleSize,
              ),
            ),
            SizedBox(height: context.s8),
            Text(
              t.appointmentSuccessful,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: AppSize.s14,
                color: scheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.s16),
            Text(
              AppStrings.bookedWith(doctor: doctorName, date: date, time: time),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: context.s24),
            SizedBox(
              height: context.confirmHeight,
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  t.doneButton,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: AppSize.s16,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.s12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                t.editAppointment,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
