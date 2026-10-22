import 'actions.dart';
import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class PatientAppointmentCard extends StatelessWidget {
  const PatientAppointmentCard({
    super.key,
    required this.appointment,
    required this.onViewDetails,
    this.onCancel,
    this.onRate,
  });

  final Appointment appointment;
  final VoidCallback onViewDetails;
  final VoidCallback? onCancel;
  final VoidCallback? onRate;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final status = appointment.status;

    return Container(
      margin: EdgeInsets.only(bottom: context.s16),
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.r16),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhotoAvatar(
                size: context.adminDoctorCardPhoto,
                imagePath: appointment.doctorPhoto,
                initials: appointment.doctorName.isEmpty
                    ? '?'
                    : appointment.doctorName[0],
                shape: AvatarShape.rounded,
              ),
              SizedBox(width: context.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: context.bold18Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s2),
                    Text(
                      appointment.specialty.label,
                      style: context.medium14Primary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.s8),
              _StatusChip(status: status),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.s12),
            child: Divider(height: 1, color: scheme.outline),
          ),
          Row(
            children: [
              Expanded(
                child: _InfoCell(
                  icon: Icons.calendar_today,
                  label: t.apptDateLabel,
                  value: AppStrings.fullDate(appointment.dateTime),
                ),
              ),
              Expanded(
                child: _InfoCell(
                  icon: Icons.access_time,
                  label: t.apptTimeLabel,
                  value: AppStrings.clockTime(appointment.dateTime),
                ),
              ),
            ],
          ),
          SizedBox(height: context.s12),
          _InfoCell(
            icon: Icons.attach_money,
            label: t.apptFeeLabel,
            value: '\$${appointment.fee.toStringAsFixed(2)}',
          ),
          if (status == AppointmentStatus.completed) ...[
            SizedBox(height: context.s12),
            _RateStrip(rating: appointment.rating, onRate: onRate),
          ],
          SizedBox(height: context.s16),
          AppointmentActions(
            status: status,
            hasReview: appointment.hasReview,
            onViewDetails: onViewDetails,
            onCancel: onCancel,
            onRate: onRate,
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  const _InfoCell({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.infoTileIconBox;
    return Row(
      children: [
        Container(
          width: box,
          height: box,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(context.infoTileRadius),
          ),
          child: Icon(icon, color: scheme.primary, size: context.iconSmall),
        ),
        SizedBox(width: context.s8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: context.regular12TextSub,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.s2),
              Text(
                value,
                style: context.semiBold14Black,
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

class _RateStrip extends StatelessWidget {
  const _RateStrip({required this.rating, this.onRate});

  final double? rating;
  final VoidCallback? onRate;

  @override
  Widget build(BuildContext context) {
    final filled = (rating ?? 0).round();
    return Material(
      color: AppColors.primary.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(context.r8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: rating == null ? onRate : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.s12,
            vertical: context.s8,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(t.apptTapToRate, style: context.regular14TextSub),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 1; i <= 5; i++)
                    Icon(
                      i <= filled
                          ? Icons.star_rounded
                          : Icons.star_border_rounded,
                      size: context.iconSmall,
                      color: context.themeColors.starRating,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final AppointmentStatus status;

  @override
  Widget build(BuildContext context) {
    final cancelled = status == AppointmentStatus.cancelled;
    final color = cancelled ? AppColors.danger : AppColors.primary;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.s12,
        vertical: context.s4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(context.statusPillRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: context.statusDotSize,
            height: context.statusDotSize,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: context.s6),
          Text(status.label, style: context.semiBold12.copyWith(color: color)),
        ],
      ),
    );
  }
}
