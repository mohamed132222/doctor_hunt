import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/widgets/status_pill.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/availability/availability_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/availability_day_tile.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class DoctorAvailabilityScreen extends StatelessWidget {
  const DoctorAvailabilityScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AvailabilityCubit>(
      create: (_) => getIt<AvailabilityCubit>()..load(doctorId),
      child: const _AvailabilityView(),
    );
  }
}

const List<int> _weekOrder = <int>[
  DateTime.monday,
  DateTime.tuesday,
  DateTime.wednesday,
  DateTime.thursday,
  DateTime.friday,
  DateTime.saturday,
  DateTime.sunday,
];

String _dayLabel(int weekday) => switch (weekday) {
  DateTime.monday => t.dayMonday,
  DateTime.tuesday => t.dayTuesday,
  DateTime.wednesday => t.dayWednesday,
  DateTime.thursday => t.dayThursday,
  DateTime.friday => t.dayFriday,
  DateTime.saturday => t.daySaturday,
  _ => t.daySunday,
};

class _AvailabilityView extends StatelessWidget {
  const _AvailabilityView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminSurface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.adminScreenPaddingH,
          ),
          child: BlocConsumer<AvailabilityCubit, AvailabilityState>(
            buildWhen: (p, c) =>
                p.status != c.status ||
                p.doctor != c.doctor ||
                p.availability != c.availability,
            listenWhen: (p, c) => p.saved != c.saved || p.status != c.status,
            listener: (context, state) {
              if (state.saved) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.adminAvailabilitySaved)),
                );
              } else if (state.status == AppStatus.error) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
              }
            },
            builder: (context, state) {
              final doctor = state.doctor;
              final availability = state.availability;
              return Column(
                children: [
                  AppTopBar(title: t.adminAvailabilityTitle),
                  Expanded(
                    child: doctor == null || availability == null
                        ? const AppSkeletonDetails()
                        : _body(context, doctor, availability, state.isSaving),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    Doctor doctor,
    DoctorAvailability a,
    bool isSaving,
  ) {
    final cubit = context.read<AvailabilityCubit>();
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: context.s16),
          _DoctorHeaderCard(doctor: doctor),
          SizedBox(height: context.s24),
          Row(
            children: [
              Expanded(
                child: Text(t.adminWorkingDays, style: context.bold18Black),
              ),
              Text(
                t.adminDaysEnabled(count: a.workingDays.length),
                style: context.regular14TextSub,
              ),
            ],
          ),
          SizedBox(height: context.s12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: context.s16),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(context.adminCardRadius),
              boxShadow: [context.themeColors.cardShadow],
            ),
            child: Column(
              children: [
                for (var i = 0; i < _weekOrder.length; i++) ...[
                  if (i > 0) Divider(height: 1, color: scheme.outline),
                  AvailabilityDayTile(
                    label: _dayLabel(_weekOrder[i]),
                    enabled: a.worksOn(_weekOrder[i]),
                    onChanged: (_) => cubit.toggleDay(_weekOrder[i]),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: context.s24),
          Text(t.adminWorkingHours, style: context.bold18Black),
          SizedBox(height: context.s12),
          _hoursCard(context, cubit, a),
          SizedBox(height: context.s24),
          PrimaryButton(
            label: t.adminSaveAvailability,
            width: double.infinity,
            isLoading: isSaving,
            icon: Icon(
              Icons.check,
              color: scheme.onPrimary,
              size: context.iconSmall,
            ),
            onPressed: cubit.save,
          ),
          SizedBox(height: context.s24),
        ],
      ),
    );
  }

  Widget _hoursCard(
    BuildContext context,
    AvailabilityCubit cubit,
    DoctorAvailability a,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final times = <int>[for (int m = 0; m <= 23 * 60 + 30; m += 30) m];
    const slots = <int>[15, 30, 45, 60];

    Widget field(String label, Widget child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: context.semiBold12TextMain.copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: context.s10),
        child,
      ],
    );

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: field(
                  t.adminStartTime,
                  _StyledDropdown<int>(
                    value: a.startMinute,
                    items: times,
                    labeler: _timeLabel,
                    icon: Icons.schedule,
                    onChanged: cubit.setStart,
                  ),
                ),
              ),
              SizedBox(width: context.s12),
              Expanded(
                child: field(
                  t.adminEndTime,
                  _StyledDropdown<int>(
                    value: a.endMinute,
                    items: times,
                    labeler: _timeLabel,
                    icon: Icons.schedule,
                    onChanged: cubit.setEnd,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.s16),
          field(
            t.adminSlotDuration,
            _StyledDropdown<int>(
              value: a.slotMinutes,
              items: slots,
              labeler: (m) => t.adminMinutesOption(count: m),
              icon: Icons.timer_outlined,
              onChanged: cubit.setSlot,
            ),
          ),
        ],
      ),
    );
  }
}

String _timeLabel(int minutes) {
  final hour = minutes ~/ 60;
  final minute = minutes % 60;
  final period = hour >= 12 ? 'PM' : 'AM';
  final hour12 = hour % 12 == 0 ? 12 : hour % 12;
  return '${hour12.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')} $period';
}

class _DoctorHeaderCard extends StatelessWidget {
  const _DoctorHeaderCard({required this.doctor});

  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.s12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Row(
        children: [
          PhotoAvatar(
            size: context.adminDoctorCardPhoto,
            imagePath: doctor.photo,
            shape: AvatarShape.rounded,
            radius: context.adminDoctorCardPhotoRadius,
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: context.bold16Black,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.s2),
                Text(
                  doctor.specialty.label,
                  style: context.regular14TextSub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: context.s8),
          StatusPill(
            label: doctor.isActive
                ? t.adminStatusActive
                : t.adminStatusInactive,
            variant: doctor.isActive
                ? StatusVariant.success
                : StatusVariant.danger,
          ),
        ],
      ),
    );
  }
}

class _StyledDropdown<T> extends StatelessWidget {
  const _StyledDropdown({
    required this.value,
    required this.items,
    required this.labeler,
    required this.onChanged,
    this.icon,
  });

  final T value;
  final List<T> items;
  final String Function(T) labeler;
  final ValueChanged<T> onChanged;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: context.adminDropdownHeight,
      padding: EdgeInsets.symmetric(horizontal: context.s12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.r14),
        border: Border.all(color: scheme.outline),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: scheme.primary, size: context.iconSmall),
            SizedBox(width: context.s8),
          ],
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                borderRadius: BorderRadius.circular(context.r14),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: scheme.onSurfaceVariant,
                ),
                style: context.semiBold16Black,
                items: [
                  for (final item in items)
                    DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        labeler(item),
                        style: context.semiBold16Black,
                      ),
                    ),
                ],
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
