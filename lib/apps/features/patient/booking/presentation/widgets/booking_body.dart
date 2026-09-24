import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/primary_button.dart';
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
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);
    final day = _day;
    final next = _nextDayWithSlots;

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(title: t.doctorDetailsTitle, centerTitle: false),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: gutter,
                    child: BookingDoctorCard(doctor: widget.doctor),
                  ),
                  SizedBox(height: context.s16),
                  Padding(
                    padding: gutter,
                    child: BookingDateStrip(
                      days: _days,
                      selectedIndex: _selectedDay,
                      onSelect: _selectDay,
                    ),
                  ),
                  SizedBox(height: context.s12),
                  Padding(
                    padding: gutter,
                    child: day.hasSlots
                        ? _slots(day)
                        : BookingEmptyState(
                            dayLabel: _dayLabel(_selectedDay),
                            nextAvailabilityLabel: next == null
                                ? null
                                : t.nextAvailabilityOn(
                                    day: AppStrings.dateLabel(_days[next].date),
                                  ),
                            onNextAvailability: next == null
                                ? null
                                : () => _selectDay(next),
                            onContactClinic: () => _notify(t.clinicFallback),
                          ),
                  ),
                  SizedBox(height: context.s24),
                ],
              ),
            ),
          ),
        ],
      ),
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
        SizedBox(height: context.s16),
        BookingSlotGrid(
          period: t.afternoonPeriod,
          slots: day.afternoon,
          selectedSlots: _selectedSlots,
          onSelect: _toggleSlot,
        ),
        SizedBox(height: context.s16),
        BookingSlotGrid(
          period: t.eveningPeriod,
          slots: day.evening,
          selectedSlots: _selectedSlots,
          onSelect: _toggleSlot,
        ),
        if (_selectedSlots.isNotEmpty) ...[
          SizedBox(height: context.s20),
          PrimaryButton(
            label: AppStrings.bookNowWithCount(_selectedSlots.length),
            height: AppSize.bookingActionHeight,
            radius: AppSize.bookingActionRadius,
            onPressed: () =>
                AppointmentRoute(doctorId: widget.doctor.id).push(context),
          ),
        ],
      ],
    );
  }
}
