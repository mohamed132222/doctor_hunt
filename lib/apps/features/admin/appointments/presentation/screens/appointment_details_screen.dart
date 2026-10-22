import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_outlined_button.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/controllers/appointment_details/appointment_details_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/widgets/admin_profile_scope.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/widgets/appointment_detail_sections.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key, required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    return AdminProfileScope(
      child: BlocProvider<AppointmentDetailsCubit>(
        create: (_) => getIt<AppointmentDetailsCubit>()..load(appointmentId),
        child: _DetailsView(appointmentId: appointmentId),
      ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    final clinic = context.select<AdminProfileCubit, String>(
      (cubit) => cubit.state.profile?.clinicLocation ?? '',
    );

    return Scaffold(
      backgroundColor: AppColors.adminSurface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.adminScreenPaddingH,
          ),
          child: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
            buildWhen: (p, c) =>
                p.status != c.status || p.appointment != c.appointment,
            builder: (context, state) {
              final appointment = state.appointment;
              return Column(
                children: [
                  AppTopBar(title: t.adminAppointmentDetailsTitle),
                  if (appointment == null)
                    const Expanded(child: AppSkeletonDetails())
                  else ...[
                    Expanded(
                      child: SingleChildScrollView(
                        child: AppointmentDetailSections(
                          appointment: appointment,
                          clinicLocation: clinic,
                        ),
                      ),
                    ),
                    if (appointment.status == AppointmentStatus.upcoming)
                      _Actions(appointmentId: appointmentId),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.appointmentId});

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentDetailsCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s16),
      child: Row(
        children: [
          Expanded(
            child: AppOutlinedButton(
              label: t.adminCancelAppointment,
              color: AppColors.danger,
              onPressed: () async {
                final confirmed = await showConfirmDialog(
                  context,
                  title: t.adminCancelConfirmTitle,
                  message: t.adminCancelConfirmBody,
                  confirmLabel: t.adminCancelAppointment,
                  danger: true,
                );
                if (confirmed) cubit.cancel(appointmentId);
              },
            ),
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: SizedBox(
              height: context.bookingActionHeight,
              child: FilledButton(
                onPressed: () => cubit.markCompleted(appointmentId),
                child: Text(t.adminMarkCompleted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
