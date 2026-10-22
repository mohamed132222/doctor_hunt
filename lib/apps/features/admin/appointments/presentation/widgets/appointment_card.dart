import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/app_outlined_button.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/status_pill.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/app_svg_icon.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

StatusVariant appointmentVariant(AppointmentStatus status) => switch (status) {
  AppointmentStatus.upcoming => StatusVariant.success,
  AppointmentStatus.completed => StatusVariant.success,
  AppointmentStatus.cancelled => StatusVariant.danger,
};

String patientInitials(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return '';
  final first = parts.first[0];
  final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
  return (first + last).toUpperCase();
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onViewDetails,
    this.onCancel,
    this.onComplete,
  });

  final Appointment appointment;
  final VoidCallback? onViewDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final a = appointment;

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.homeCardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              PhotoAvatar(
                size: context.adminDoctorCardPhoto,
                imagePath: a.patientPhoto,
                initials: patientInitials(a.patientName),
                shape: AvatarShape.rounded,
                radius: context.adminDoctorCardPhotoRadius,
              ),
              SizedBox(width: context.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.patientName,
                      style: context.bold16Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s2),
                    Text(
                      a.doctorName,
                      style: context.semiBold14Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      a.specialty.label,
                      style: context.regular12TextSub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.s8),
              StatusPill(
                label: a.status.label,
                variant: appointmentVariant(a.status),
              ),
            ],
          ),
          Divider(height: context.s24, color: scheme.outline),
          _StatsRow(appointment: a),
          if (a.status == AppointmentStatus.upcoming) ...[
            SizedBox(height: context.s16),
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    label: t.adminCancelAppointment,
                    color: AppColors.danger,
                    onPressed: onCancel,
                  ),
                ),
                SizedBox(width: context.s12),
                Expanded(
                  child: SizedBox(
                    height: context.bookingActionHeight,
                    child: FilledButton(
                      onPressed: onComplete,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(t.adminMarkCompleted, maxLines: 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            if (a.status == AppointmentStatus.completed && a.hasReview) ...[
              SizedBox(height: context.s12),
              _ReviewNote(rating: a.rating!, comment: a.reviewComment ?? ''),
            ],
            SizedBox(height: context.s16),
            AppOutlinedButton(
              label: t.adminViewDetails,
              onPressed: onViewDetails,
            ),
          ],
        ],
      ),
    );
  }
}

class _ReviewNote extends StatelessWidget {
  const _ReviewNote({required this.rating, required this.comment});

  final double rating;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s12,
        vertical: context.s10,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningLight,
        borderRadius: BorderRadius.circular(context.r8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star_rounded,
            color: context.themeColors.starRating,
            size: context.popularStarSize,
          ),
          SizedBox(width: context.s6),
          Expanded(
            child: Text(
              '${rating.toStringAsFixed(1)} · "$comment"',
              style: context.regular14TextMain,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.value,
  }) : assert(
         icon != null || iconWidget != null,
         'Stat needs either icon or iconWidget',
       );

  final IconData? icon;
  final Widget? iconWidget;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.adminDayIconBox;

    return Row(
      children: [
        Container(
          width: box,
          height: box,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(context.infoTileRadius),
          ),
          child:
              iconWidget ??
              Icon(icon, color: scheme.primary, size: context.iconSmall),
        ),
        SizedBox(width: context.s6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.regular11TextSub, maxLines: 1),
              Text(
                value,
                style: context.bold14Black,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Stat(
            iconWidget: AppSvgIcon(
              AppAssets.calendarDaysIcon,
              size: context.iconSmall,
            ),
            label: t.adminDateLabel,
            value: AppStrings.fullDate(appointment.dateTime),
          ),
        ),
        Expanded(
          child: _Stat(
            icon: Icons.schedule,
            label: t.adminTimeLabel,
            value: AppStrings.clockTime(appointment.dateTime),
          ),
        ),
        Expanded(
          child: _Stat(
            iconWidget: AppSvgIcon(
              AppAssets.consultationFeeIcon,
              size: context.iconSmall,
            ),
            label: t.adminFeeLabel,
            value: '\$${appointment.fee.toStringAsFixed(2)}',
          ),
        ),
      ],
    );
  }
}
