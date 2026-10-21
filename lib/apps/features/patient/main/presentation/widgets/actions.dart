import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_outlined_button.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';

class AppointmentActions extends StatelessWidget {
  const AppointmentActions({
    super.key,
    required this.status,
    required this.hasReview,
    required this.onViewDetails,
    this.onCancel,
    this.onRate,
  });

  final AppointmentStatus status;
  final bool hasReview;
  final VoidCallback onViewDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onRate;

  @override
  Widget build(BuildContext context) {
    final viewDetails = AppOutlinedButton(
      label: t.adminViewDetails,
      onPressed: onViewDetails,
    );

    switch (status) {
      case AppointmentStatus.upcoming:
        return Row(
          children: [
            Expanded(child: viewDetails),
            SizedBox(width: context.s12),
            Expanded(
              child: AppOutlinedButton(
                label: t.adminCancelAppointment,
                color: AppColors.danger,
                onPressed: onCancel,
              ),
            ),
          ],
        );
      case AppointmentStatus.completed:
        return Row(
          children: [
            Expanded(child: viewDetails),
            SizedBox(width: context.s12),
            Expanded(
              child: PrimaryButton(
                label: t.apptRateDoctor,
                width: double.infinity,
                height: context.bookingActionHeight,
                radius: context.r12,
                enabled: !hasReview && onRate != null,
                onPressed: onRate ?? () {},
              ),
            ),
          ],
        );
      case AppointmentStatus.cancelled:
        return viewDetails;
    }
  }
}
