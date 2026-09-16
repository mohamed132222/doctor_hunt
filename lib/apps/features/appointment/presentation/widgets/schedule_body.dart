import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import 'appointment_confirmed_dialog.dart';
import 'choice_chip_circle.dart';
import 'month_calendar.dart';

/// Appointment step 3: choose the day, the time and the reminder, then confirm.
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
      // Follow the grid when a day from an adjacent month is tapped.
      _month = DateTime(day.year, day.month);
    });
  }

  Future<void> _confirm() async {
    final done = await showAppointmentConfirmedDialog(
      context,
      doctorName: widget.doctor.name,
      date: AppStrings.monthDay(_selectedDay),
      time:
          '${AppStrings.slotTimeLabel(_hour)} '
          '${AppStrings.slotPeriodLabel(_hour)}',
    );
    if (!mounted) return;
    if (done == true) context.go(RoutePath.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gutter = EdgeInsets.symmetric(
      horizontal: context.w(AppSize.homeRowPaddingH),
    );

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: DoctorTopBar(
            title: AppStrings.appointmentTitle,
            centerTitle: false,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: gutter,
                  child: MonthCalendar(
                    month: _month,
                    selectedDay: _selectedDay,
                    onSelect: _selectDay,
                    onPreviousMonth: _previousMonth,
                    onNextMonth: _nextMonth,
                  ),
                ),
                SizedBox(height: context.w(AppSize.s20)),
                Padding(
                  padding: gutter,
                  child: Text(
                    AppStrings.availableTimeTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: context.w(AppSize.s12)),
                Padding(
                  padding: gutter,
                  child: Wrap(
                    spacing: context.w(AppSize.s8),
                    runSpacing: context.w(AppSize.s8),
                    children: [
                      for (final hour in AppStrings.scheduleHours)
                        ChoiceChipCircle(
                          label: AppStrings.slotTimeLabel(hour),
                          subLabel: AppStrings.slotPeriodLabel(hour),
                          selected: hour == _hour,
                          onTap: () => setState(() => _hour = hour),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: context.w(AppSize.s20)),
                Padding(
                  padding: gutter,
                  child: Text(
                    AppStrings.reminderTitle,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: context.w(AppSize.s12)),
                Padding(
                  padding: gutter,
                  child: Wrap(
                    spacing: context.w(AppSize.s8),
                    runSpacing: context.w(AppSize.s8),
                    children: [
                      for (final minutes in AppStrings.reminderOptions)
                        ChoiceChipCircle(
                          label: AppStrings.reminderMinutes(minutes),
                          selected: minutes == _reminder,
                          onTap: () => setState(() => _reminder = minutes),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: context.w(AppSize.s24)),
                Padding(
                  padding: gutter,
                  child: _ConfirmButton(onTap: _confirm),
                ),
                SizedBox(
                  // Clears the system gesture bar / home indicator: the app is
                  // edge-to-edge, so the scroll view must reserve that inset.
                  height:
                      context.w(AppSize.s24) +
                      MediaQuery.viewPaddingOf(context).bottom,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
      context.r(AppSize.bookingActionRadius),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.w(AppSize.confirmHeight)),
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.w(AppSize.s12)),
            child: Center(
              child: Text(
                AppStrings.confirmButton,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: AppSize.s16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
