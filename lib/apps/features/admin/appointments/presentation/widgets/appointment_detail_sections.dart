import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/info_tile.dart';
import 'package:doctor_hunt/apps/core/widgets/status_pill.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/widgets/appointment_card.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:doctor_hunt/apps/core/widgets/app_svg_icon.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AppointmentDetailSections extends StatelessWidget {
  const AppointmentDetailSections({
    super.key,
    required this.appointment,
    required this.clinicLocation,
  });

  final Appointment appointment;
  final String clinicLocation;

  @override
  Widget build(BuildContext context) {
    final a = appointment;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: context.s16),
        Text(t.adminPatient, style: context.bold18Black),
        SizedBox(height: context.s12),
        _PersonCard(
          name: a.patientName,
          subtitle: a.patientEmail,
          subtitleIcon: Icons.mail_outline,
          photo: a.patientPhoto,
          initials: patientInitials(a.patientName),
        ),
        SizedBox(height: context.s24),
        Text(t.adminDoctor, style: context.bold18Black),
        SizedBox(height: context.s12),
        _PersonCard(
          name: a.doctorName,
          subtitle: a.specialty.label,
          photo: a.doctorPhoto,
          rounded: true,
          verified: true,
        ),
        SizedBox(height: context.s24),
        Row(
          children: [
            Expanded(
              child: Text(t.adminAppointment, style: context.bold18Black),
            ),
            StatusPill(
              label: a.status.label,
              variant: appointmentVariant(a.status),
            ),
          ],
        ),
        SizedBox(height: context.s12),
        _InfoGrid(appointment: a, clinicLocation: clinicLocation),
        SizedBox(height: context.s24),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.value,
  }) : assert(
         icon != null || iconWidget != null,
         'InfoBox needs either icon or iconWidget',
       );

  final IconData? icon;
  final Widget? iconWidget;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.s12),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(context.infoTileRadius),
      ),
      child: InfoTile(
        icon: icon,
        iconWidget: iconWidget,
        label: label,
        value: value,
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.appointment, required this.clinicLocation});

  final Appointment appointment;
  final String clinicLocation;

  @override
  Widget build(BuildContext context) {
    final a = appointment;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _InfoBox(
                iconWidget: AppSvgIcon(
                  AppAssets.calendarDaysIcon,
                  size: context.iconSmall,
                ),
                label: t.adminDateLabel,
                value: AppStrings.fullDate(a.dateTime),
              ),
            ),
            SizedBox(width: context.s12),
            Expanded(
              child: _InfoBox(
                icon: Icons.schedule,
                label: t.adminTimeLabel,
                value: AppStrings.clockTime(a.dateTime),
              ),
            ),
          ],
        ),
        SizedBox(height: context.s12),
        _InfoBox(
          iconWidget: AppSvgIcon(
            AppAssets.consultationFeeIcon,
            size: context.iconSmall,
          ),
          label: t.adminConsultationFee,
          value: '\$${a.fee.toStringAsFixed(2)}',
        ),
        SizedBox(height: context.s12),
        _InfoBox(
          icon: Icons.location_on_outlined,
          label: t.adminClinicLocation,
          value: clinicLocation,
        ),
      ],
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    super.key,
    required this.name,
    required this.subtitle,
    this.subtitleIcon,
    this.photo,
    this.initials,
    this.rounded = false,
    this.verified = false,
  });

  final String name;
  final String subtitle;
  final IconData? subtitleIcon;
  final String? photo;
  final String? initials;
  final bool rounded;
  final bool verified;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Row(
        children: [
          PhotoAvatar(
            size: context.bookingCardPhoto,
            imagePath: photo,
            initials: initials,
            shape: rounded ? AvatarShape.rounded : AvatarShape.circle,
            radius: context.adminDoctorCardPhotoRadius,
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.bold18Black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s4),
                Row(
                  children: [
                    if (subtitleIcon != null) ...[
                      Icon(
                        subtitleIcon,
                        size: context.iconSmall,
                        color: scheme.onSurfaceVariant,
                      ),
                      SizedBox(width: context.s6),
                    ],
                    Flexible(
                      child: Text(
                        subtitle,
                        style: context.regular14TextSub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (verified) ...[
            SizedBox(width: context.s8),
            Container(
              width: context.adminVerifiedBadge,
              height: context.adminVerifiedBadge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.primary.withValues(alpha: 0.12),
              ),
              child: Icon(
                Icons.verified_rounded,
                color: scheme.primary,
                size: context.iconSmall,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
