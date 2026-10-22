import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/core/widgets/list_more_footer.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/appointments_refresh/appointments_refresh_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/patient_appointments/patient_appointments_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/patient_appointment_card.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/rate_doctor_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PatientAppointmentsCubit>(
          create: (_) => getIt<PatientAppointmentsCubit>()..load(),
        ),
        BlocProvider<AppointmentsRefreshCubit>.value(
          value: getIt<AppointmentsRefreshCubit>(),
        ),
      ],
      child: BlocListener<AppointmentsRefreshCubit, int>(
        listenWhen: (previous, current) => previous != current,
        listener: (context, _) =>
            context.read<PatientAppointmentsCubit>().load(),
        child: const _AppointmentsView(),
      ),
    );
  }
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

  Future<void> _cancel(BuildContext context, String id) async {
    final confirmed = await showConfirmDialog(
      context,
      title: t.adminCancelConfirmTitle,
      message: t.adminCancelConfirmBody,
      confirmLabel: t.adminCancelAppointment,
      danger: true,
    );
    if (!confirmed || !context.mounted) return;
    final cubit = context.read<PatientAppointmentsCubit>();
    await cubit.cancel(id);
    if (!context.mounted) return;
    final error = cubit.state.error;
    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Future<void> _rate(BuildContext context, String id) async {
    final cubit = context.read<PatientAppointmentsCubit>();
    final result = await showRateDoctorDialog(context);
    if (result == null) return;
    final ok = await cubit.rate(id, result.rating, result.comment);
    if (!context.mounted) return;
    if (ok) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.apptReviewThanks)));
    } else {
      final error = cubit.state.error;
      if (error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  String _emptyLabel(int tabIndex) => switch (tabIndex) {
    1 => t.apptEmptyCompleted,
    2 => t.apptEmptyCancelled,
    _ => t.apptEmptyUpcoming,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientIce, AppColors.gradientMint],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.s8),
              Text(t.adminAppointmentsTitle, style: context.bold28Black),
              SizedBox(height: context.s16),
              BlocSelector<
                PatientAppointmentsCubit,
                PatientAppointmentsState,
                int
              >(
                selector: (state) => state.tabIndex,
                builder: (context, tabIndex) => _Tabs(
                  selected: tabIndex,
                  onSelect: context.read<PatientAppointmentsCubit>().selectTab,
                ),
              ),
              SizedBox(height: context.s16),
              Expanded(
                child:
                    BlocBuilder<
                      PatientAppointmentsCubit,
                      PatientAppointmentsState
                    >(
                      buildWhen: (p, c) =>
                          p.status != c.status ||
                          p.appointments != c.appointments,
                      builder: (context, state) {
                        if (state.status == AppStatus.loading) {
                          return const AppSkeletonList();
                        }
                        if (state.appointments.isEmpty) {
                          return Center(
                            child: Text(
                              _emptyLabel(state.tabIndex),
                              style: context.regular16TextSub,
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.only(
                            top: context.s4,
                            bottom: context.s16,
                          ),
                          itemCount:
                              state.appointments.length +
                              (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= state.appointments.length) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (context.mounted) {
                                  context
                                      .read<PatientAppointmentsCubit>()
                                      .loadMore();
                                }
                              });
                              return const ListMoreFooter();
                            }
                            final appointment = state.appointments[index];
                            return PatientAppointmentCard(
                              appointment: appointment,
                              onViewDetails: () =>
                                  PatientAppointmentDetailsRoute(
                                    appointmentId: appointment.id,
                                  ).push(context),
                              onCancel:
                                  appointment.status ==
                                      AppointmentStatus.upcoming
                                  ? () => _cancel(context, appointment.id)
                                  : null,
                              onRate:
                                  appointment.status ==
                                          AppointmentStatus.completed &&
                                      !appointment.hasReview
                                  ? () => _rate(context, appointment.id)
                                  : null,
                            );
                          },
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({required this.selected, required this.onSelect});

  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final labels = [
      t.adminStatusUpcoming,
      t.adminStatusCompleted,
      t.adminStatusCancelled,
    ];
    return Row(
      children: [
        for (var i = 0; i < labels.length; i++) ...[
          if (i > 0) SizedBox(width: context.s12),
          Expanded(
            child: _TabPill(
              label: labels[i],
              active: i == selected,
              onTap: () => onSelect(i),
            ),
          ),
        ],
      ],
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active
          ? AppColors.primary
          : AppColors.primary.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(context.r8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: context.segmentedTabHeight,
          alignment: Alignment.center,
          child: Text(
            label,
            style: active ? context.semiBold14White : context.semiBold14Primary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
