import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';

import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:doctor_hunt/apps/features/patient/main/data/catalog/patient_catalog.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor_model.dart';
import 'appointment_confirmed_dialog.dart';

class ScheduleBody extends StatefulWidget {
  const ScheduleBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<ScheduleBody> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  late DateTime _month;
  late DateTime _selectedDay;
  int _hour = 14;
  int _reminder = 25;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDay = DateTime(now.year, now.month, now.day);
    _month = DateTime(now.year, now.month);
  }

  void _previousMonth() =>
      setState(() => _month = DateTime(_month.year, _month.month - 1));

  void _nextMonth() =>
      setState(() => _month = DateTime(_month.year, _month.month + 1));

  void _selectDay(DateTime day) {
    setState(() {
      _selectedDay = day;
      _month = DateTime(day.year, day.month);
    });
  }

  Future<void> _confirm() async {
    final messenger = ScaffoldMessenger.of(context);

    final doctor = getIt<PatientCatalog>().byId(widget.doctor.id);
    final patient = getIt<AuthRepo>().currentUser();
    if (doctor != null && patient != null) {
      final when = DateTime(
        _selectedDay.year,
        _selectedDay.month,
        _selectedDay.day,
        _hour,
      );
      String? patientPhoto;
      final profileResult = await getIt<ProfileRepo>().fetchCurrent();
      if (profileResult is Success<UserProfile?>) {
        patientPhoto = profileResult.data?.photo;
      }
      if (!mounted) return;
      final result = await getIt<AppointmentsRepo>().createAppointment(
        Appointment(
          id: '',
          doctorId: doctor.id,
          doctorName: doctor.name,
          specialty: doctor.specialty,
          doctorPhoto: doctor.photo,
          patientName: patient.name.isNotEmpty ? patient.name : patient.email,
          patientEmail: patient.email,
          patientPhoto: patientPhoto,
          dateTime: when,
          fee: doctor.fee,
          status: AppointmentStatus.upcoming,
        ),
      );
      if (!mounted) return;
      if (result is Error<Appointment>) {
        messenger.showSnackBar(SnackBar(content: Text(result.failure.message)));
        return;
      }
    }

    if (!mounted) return;
    final done = await showAppointmentConfirmedDialog(
      context,
      doctorName: widget.doctor.name,
      date: AppStrings.monthDay(_selectedDay),
      time:
          '${AppStrings.slotTimeLabel(_hour)} '
          '${AppStrings.slotPeriodLabel(_hour)}',
    );
    if (!mounted) return;
    if (done == true) const HomeRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(title: t.appointmentTitle, centerTitle: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: gutter,
                    child: _MonthCalendar(
                      month: _month,
                      selectedDay: _selectedDay,
                      onSelect: _selectDay,
                      onPreviousMonth: _previousMonth,
                      onNextMonth: _nextMonth,
                    ),
                  ),
                  SizedBox(height: context.s20),
                  Padding(
                    padding: gutter,
                    child: Text(
                      t.availableTimeTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: context.s12),
                  Padding(
                    padding: gutter,
                    child: Wrap(
                      spacing: context.s8,
                      runSpacing: context.s8,
                      children: [
                        for (final hour in AppStrings.scheduleHours)
                          _ChoiceChipCircle(
                            label: AppStrings.slotTimeLabel(hour),
                            subLabel: AppStrings.slotPeriodLabel(hour),
                            selected: hour == _hour,
                            onTap: () => setState(() => _hour = hour),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.s20),
                  Padding(
                    padding: gutter,
                    child: Text(
                      t.reminderTitle,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: context.s12),
                  Padding(
                    padding: gutter,
                    child: Wrap(
                      spacing: context.s8,
                      runSpacing: context.s8,
                      children: [
                        for (final minutes in AppStrings.reminderOptions)
                          _ChoiceChipCircle(
                            label: t.reminderMinutes(minutes: minutes),
                            selected: minutes == _reminder,
                            onTap: () => setState(() => _reminder = minutes),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.s24),
                  Padding(
                    padding: gutter,
                    child: PrimaryButton(
                      label: t.confirmButton,
                      height: AppSize.confirmHeight,
                      radius: AppSize.bookingActionRadius,
                      onPressed: _confirm,
                    ),
                  ),
                  SizedBox(
                    height:
                        context.s24 + MediaQuery.viewPaddingOf(context).bottom,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChoiceChipCircle extends StatelessWidget {
  const _ChoiceChipCircle({
    super.key,
    required this.label,
    this.subLabel,
    required this.selected,
    this.onTap,
  });

  final String label;
  final String? subLabel;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final sub = subLabel;

    return Semantics(
      label: sub == null ? label : '$label $sub',
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          constraints: BoxConstraints(minHeight: context.choiceChipHeight),
          padding: EdgeInsets.symmetric(
            horizontal: context.s8,
            vertical: context.s8,
          ),
          decoration: BoxDecoration(
            color: selected
                ? scheme.primary
                : scheme.primary.withValues(alpha: AppSize.slotIdleAlpha),
            borderRadius: BorderRadius.circular(context.r24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: AppSize.s12,
                  fontWeight: FontWeight.w600,
                  color: selected ? scheme.onPrimary : scheme.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (sub != null)
                Text(
                  sub,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: AppSize.s10,
                    fontWeight: FontWeight.w500,
                    color: selected
                        ? scheme.onPrimary.withValues(alpha: 0.85)
                        : scheme.primary.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    super.key,
    required this.month,
    required this.selectedDay,
    required this.onSelect,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  final DateTime month;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onSelect;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(context.calendarRadius);
    final firstOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingBlanks = firstOfMonth.weekday - 1;
    final today = DateTime.now();

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: context.calendarMaxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: radius,
            boxShadow: [context.themeColors.homeCardShadow],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                height: context.calendarHeaderHeight,
                color: theme.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: context.s12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.monthYear(month),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: AppSize.s16,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _MonthArrow(
                      icon: Icons.chevron_left,
                      tooltip: t.previousMonth,
                      onTap: onPreviousMonth,
                    ),
                    _MonthArrow(
                      icon: Icons.chevron_right,
                      tooltip: t.nextMonth,
                      onTap: onNextMonth,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.s8,
                  context.s12,
                  context.s8,
                  context.s12,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (final initial in AppStrings.weekdayInitials)
                          Expanded(
                            child: Center(
                              child: Text(
                                initial,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontSize: AppSize.s12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: context.s6),
                    GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: context.s4,
                      children: [
                        for (var i = 0; i < leadingBlanks; i++)
                          const SizedBox.shrink(),
                        for (var day = 1; day <= daysInMonth; day++)
                          _DayCell(
                            date: DateTime(month.year, month.month, day),
                            selected: isSameDay(
                              DateTime(month.year, month.month, day),
                              selectedDay,
                            ),
                            isToday: isSameDay(
                              DateTime(month.year, month.month, day),
                              today,
                            ),
                            onTap: () => onSelect(
                              DateTime(month.year, month.month, day),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthArrow extends StatelessWidget {
  const _MonthArrow({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkResponse(
        onTap: onTap,
        radius: context.s20,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s4),
          child: Icon(
            icon,
            size: context.s20,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.selected,
    required this.isToday,
    required this.onTap,
  });

  final DateTime date;
  final bool selected;
  final bool isToday;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final size = context.calendarCell;

    return Semantics(
      label: '${date.day}',
      button: true,
      selected: selected,
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? scheme.primary : Colors.transparent,
              border: isToday && !selected
                  ? Border.all(color: scheme.primary, width: AppSize.borderThin)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: AppSize.s12,
                fontWeight: selected || isToday
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: selected ? scheme.onPrimary : scheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
