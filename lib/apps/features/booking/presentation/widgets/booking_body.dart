import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import '../../data/models/booking_day.dart';
import 'booking_date_strip.dart';
import 'booking_doctor_card.dart';
import 'booking_empty_state.dart';
import 'booking_slot_grid.dart';

/// Booking body: a pinned "Select Time" bar over a scrolling page of the
/// doctor, the date strip, and either that day's slots or the empty state.
class BookingBody extends StatefulWidget {
  const BookingBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  late final List<BookingDay> _days = bookingDays();
  int _selectedDay = 0;
  final Set<TimeSlot> _selectedSlots = <TimeSlot>{};

  BookingDay get _day => _days[_selectedDay];

  /// Index of the next later day that still has slots, if any.
  int? get _nextDayWithSlots {
    for (var i = _selectedDay + 1; i < _days.length; i++) {
      if (_days[i].hasSlots) return i;
    }
    return null;
  }

  String _dayLabel(int index) => AppStrings.dateLabel(
    _days[index].date,
    isToday: index == 0,
    isTomorrow: index == 1,
  );

  void _selectDay(int index) {
    setState(() {
      _selectedDay = index;
      _selectedSlots.clear();
    });
  }

  /// Slots toggle, so a patient can book several in one go.
  void _toggleSlot(TimeSlot slot) {
    setState(() {
      if (!_selectedSlots.remove(slot)) _selectedSlots.add(slot);
    });
  }

  void _notify(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(
      horizontal: context.w(AppSize.homeRowPaddingH),
    );
    final day = _day;
    final next = _nextDayWithSlots;

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: DoctorTopBar(title: AppStrings.selectTimeTitle),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: gutter,
                  child: BookingDoctorCard(doctor: widget.doctor),
                ),
                SizedBox(height: context.w(AppSize.s16)),
                Padding(
                  padding: gutter,
                  child: BookingDateStrip(
                    days: _days,
                    selectedIndex: _selectedDay,
                    onSelect: _selectDay,
                  ),
                ),
                SizedBox(height: context.w(AppSize.s12)),
                Padding(
                  padding: gutter,
                  child: day.hasSlots
                      ? _slots(day)
                      : BookingEmptyState(
                          dayLabel: _dayLabel(_selectedDay),
                          nextAvailabilityLabel: next == null
                              ? null
                              : AppStrings.nextAvailabilityOn(
                                  AppStrings.dateLabel(_days[next].date),
                                ),
                          onNextAvailability: next == null
                              ? null
                              : () => _selectDay(next),
                          onContactClinic: () =>
                              _notify(AppStrings.clinicFallback),
                        ),
                ),
                SizedBox(height: context.w(AppSize.s24)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _slots(BookingDay day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _dayLabel(_selectedDay),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: context.w(AppSize.s16)),
        BookingSlotGrid(
          period: AppStrings.afternoonPeriod,
          slots: day.afternoon,
          selectedSlots: _selectedSlots,
          onSelect: _toggleSlot,
        ),
        SizedBox(height: context.w(AppSize.s16)),
        BookingSlotGrid(
          period: AppStrings.eveningPeriod,
          slots: day.evening,
          selectedSlots: _selectedSlots,
          onSelect: _toggleSlot,
        ),
        if (_selectedSlots.isNotEmpty) ...[
          SizedBox(height: context.w(AppSize.s20)),
          _ConfirmButton(
            label: AppStrings.bookNowWithCount(_selectedSlots.length),
            onTap: () => context.pushNamed(
              RouteName.appointment,
              pathParameters: {'doctorId': widget.doctor.id},
            ),
          ),
        ],
      ],
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  const _ConfirmButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
      context.r(AppSize.bookingActionRadius),
    );

    return SizedBox(
      height: context.w(AppSize.bookingActionHeight),
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
