import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/core/widgets/empty_state.dart';
import 'package:doctor_hunt/apps/core/widgets/segmented_tabs.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/controllers/appointments_list/appointments_list_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/appointments/presentation/widgets/appointment_card.dart';
import 'package:doctor_hunt/apps/features/admin/main/presentation/widgets/admin_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class AdminAppointmentsScreen extends StatelessWidget {
  const AdminAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppointmentsListCubit>(
      create: (_) => getIt<AppointmentsListCubit>()..load(),
      child: const _AppointmentsView(),
    );
  }
}

class _AppointmentsView extends StatelessWidget {
  const _AppointmentsView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppointmentsListCubit>();

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.adminScreenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: context.s8),
            AdminHeader(title: t.adminAppointmentsTitle),
            SizedBox(height: context.s20),
            BlocBuilder<AppointmentsListCubit, AppointmentsListState>(
              buildWhen: (a, b) => a.tabIndex != b.tabIndex,
              builder: (context, state) => SegmentedTabs(
                labels: [
                  t.adminFilterAll,
                  t.adminStatusUpcoming,
                  t.adminStatusCompleted,
                  t.adminStatusCancelled,
                ],
                selectedIndex: state.tabIndex,
                onSelect: cubit.selectTab,
              ),
            ),
            SizedBox(height: context.s16),
            Expanded(
              child: BlocBuilder<AppointmentsListCubit, AppointmentsListState>(
                buildWhen: (p, c) =>
                    p.status != c.status ||
                    p.appointments != c.appointments ||
                    p.tabIndex != c.tabIndex,
                builder: (context, state) => _content(context, cubit, state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    AppointmentsListCubit cubit,
    AppointmentsListState state,
  ) {
    if (state.status == AppStatus.loading && state.appointments.isEmpty) {
      return const AppSkeletonList();
    }
    if (state.appointments.isEmpty) {
      return EmptyState(
        icon: Icons.event_busy_outlined,
        title: t.adminNoAppointmentsTitle,
        message: t.adminNoAppointmentsBody,
      );
    }
    return ListView.separated(
      padding: EdgeInsets.only(top: context.s4, bottom: context.s24),
      itemCount: state.appointments.length,
      separatorBuilder: (_, _) => SizedBox(height: context.s16),
      itemBuilder: (context, index) {
        final appointment = state.appointments[index];
        return AppointmentCard(
          appointment: appointment,
          onViewDetails: () async {
            await AdminAppointmentDetailsRoute(
              appointmentId: appointment.id,
            ).push<void>(context);
            if (context.mounted) cubit.load();
          },
          onComplete: () => cubit.markCompleted(appointment.id),
          onCancel: () async {
            final confirmed = await showConfirmDialog(
              context,
              title: t.adminCancelConfirmTitle,
              message: t.adminCancelConfirmBody,
              confirmLabel: t.adminCancelAppointment,
              danger: true,
            );
            if (confirmed) cubit.cancel(appointment.id);
          },
        );
      },
    );
  }
}
