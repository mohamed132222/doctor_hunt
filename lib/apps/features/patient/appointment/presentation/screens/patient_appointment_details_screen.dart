import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/core/widgets/app_svg_icon.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/info_tile.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_stars.dart';
import 'package:doctor_hunt/apps/core/widgets/status_pill.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/controllers/patient_appointment_details/patient_appointment_details_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/doctor_details/presentation/widgets/doctor_top_bar.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/appointments_refresh/appointments_refresh_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/rate_doctor_dialog.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class PatientAppointmentDetailsScreen extends StatelessWidget {
  const PatientAppointmentDetailsScreen({
    super.key,
    required this.appointmentId,
  });

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DoctorTopBar(
              title: t.adminAppointmentDetailsTitle,
              centerTitle: false,
              onBack: () => context.pop(),
            ),
            Expanded(
              child:
                  BlocBuilder<
                    PatientAppointmentDetailsCubit,
                    PatientAppointmentDetailsState
                  >(
                    buildWhen: (p, c) =>
                        p.status != c.status ||
                        p.appointment != c.appointment ||
                        p.busy != c.busy,
                    builder: (context, state) {
                      switch (state.status) {
                        case AppStatus.initial:
                        case AppStatus.loading:
                          return const AppSkeletonDetails();
                        case AppStatus.error:
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.s24,
                              ),
                              child: Text(
                                state.error ?? '',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        case AppStatus.success:
                          final appointment = state.appointment;
                          if (appointment == null) {
                            return const SizedBox.shrink();
                          }
                          return _Body(
                            appointment: appointment,
                            busy: state.busy,
                          );
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.appointment, required this.busy});

  final Appointment appointment;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final appointment = this.appointment;

    return ListView(
      padding: EdgeInsets.fromLTRB(
        context.homeRowPaddingH,
        context.s16,
        context.homeRowPaddingH,
        context.s24,
      ),
      children: [
        _DoctorCard(appointment: appointment),
        SizedBox(height: context.s16),
        Row(
          children: [
            Text(t.adminAppointment, style: context.bold18Black),
            const Spacer(),
            StatusPill(
              label: appointment.status.label,
              variant: switch (appointment.status) {
                AppointmentStatus.cancelled => StatusVariant.danger,
                _ => StatusVariant.success,
              },
            ),
          ],
        ),
        SizedBox(height: context.s12),
        Container(
          padding: EdgeInsets.all(context.s16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(context.adminCardRadius),
            boxShadow: [context.themeColors.cardShadow],
          ),
          child: Column(
            children: [
              InfoTile(
                iconWidget: AppSvgIcon(
                  AppAssets.calendarDaysIcon,
                  size: context.iconSmall,
                ),
                label: t.apptDateLabel,
                value: AppStrings.fullDate(appointment.dateTime),
              ),
              SizedBox(height: context.s16),
              InfoTile(
                icon: Icons.schedule,
                label: t.apptTimeLabel,
                value: AppStrings.clockTime(appointment.dateTime),
              ),
              SizedBox(height: context.s16),
              InfoTile(
                iconWidget: AppSvgIcon(
                  AppAssets.consultationFeeIcon,
                  size: context.iconSmall,
                ),
                label: t.apptFeeLabel,
                value: '\$${appointment.fee.toStringAsFixed(2)}',
              ),
            ],
          ),
        ),
        if (appointment.rating != null) ...[
          SizedBox(height: context.s16),
          _ReviewCard(appointment: appointment),
        ],
        SizedBox(height: context.s24),
        _Actions(appointment: appointment, busy: busy),
      ],
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(context.adminCardRadius);

    return Material(
      color: scheme.surface,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: appointment.doctorId.isEmpty
            ? null
            : () => DoctorDetailsRoute(
                doctorId: appointment.doctorId,
              ).push(context),
        child: Padding(
          padding: EdgeInsets.all(context.s12),
          child: Row(
            children: [
              PhotoAvatar(
                size: context.bookingCardPhoto,
                imagePath: appointment.doctorPhoto,
                shape: AvatarShape.rounded,
                radius: context.adminDoctorCardPhotoRadius,
              ),
              SizedBox(width: context.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.doctorName,
                      style: context.bold16Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s2),
                    Text(
                      appointment.specialty.label,
                      style: context.regular14TextSub,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s6),
                    Text(
                      t.doctorDetailsTitle,
                      style: context.semiBold12Primary,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final comment = appointment.reviewComment;

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(context.adminCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingStars(rating: appointment.rating ?? 0),
          if (comment != null && comment.trim().isNotEmpty) ...[
            SizedBox(height: context.s8),
            Text(comment, style: context.regular14TextSub),
          ],
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.appointment, required this.busy});

  final Appointment appointment;
  final bool busy;

  Future<void> _rate(BuildContext context) async {
    final result = await showRateDoctorDialog(context);
    if (result == null || !context.mounted) return;

    final cubit = context.read<PatientAppointmentDetailsCubit>();
    final ok = await cubit.rate(result.rating, result.comment);
    if (!context.mounted) return;
    if (ok) {
      getIt<AppointmentsRefreshCubit>().ping();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.apptReviewThanks)));
    }
  }

  Future<void> _cancel(BuildContext context) async {
    final ok = await context.read<PatientAppointmentDetailsCubit>().cancel();
    if (ok) getIt<AppointmentsRefreshCubit>().ping();
  }

  @override
  Widget build(BuildContext context) {
    final canCancel = appointment.status == AppointmentStatus.upcoming;
    final canRate =
        appointment.status == AppointmentStatus.completed &&
        appointment.rating == null;

    if (!canCancel && !canRate) return const SizedBox.shrink();

    return Row(
      children: [
        if (canCancel)
          Expanded(
            child: OutlinedButton(
              onPressed: busy ? null : () => _cancel(context),
              child: Text(t.adminCancelAppointment),
            ),
          ),
        if (canCancel && canRate) SizedBox(width: context.s12),
        if (canRate)
          Expanded(
            child: FilledButton(
              onPressed: busy ? null : () => _rate(context),
              child: Text(t.apptRateDoctor),
            ),
          ),
      ],
    );
  }
}
