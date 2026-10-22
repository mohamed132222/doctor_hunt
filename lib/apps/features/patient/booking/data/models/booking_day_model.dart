import 'package:doctor_hunt/apps/core/constants/app_strings.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';

class TimeSlot {
  const TimeSlot(this.hour24, this.minute);

  factory TimeSlot.fromMinutes(int minutes) =>
      TimeSlot(minutes ~/ 60, minutes % 60);

  final int hour24;
  final int minute;

  int get minutesOfDay => hour24 * 60 + minute;

  String get label => AppStrings.slotLabel(hour24, minute);

  @override
  bool operator ==(Object other) =>
      other is TimeSlot && other.hour24 == hour24 && other.minute == minute;

  @override
  int get hashCode => Object.hash(hour24, minute);
}

class BookingDay {
  const BookingDay({
    required this.date,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });

  final DateTime date;
  final List<TimeSlot> morning;
  final List<TimeSlot> afternoon;
  final List<TimeSlot> evening;

  int get totalSlots => morning.length + afternoon.length + evening.length;

  bool get hasSlots => totalSlots > 0;
}

List<BookingDay> bookableDays(
  DoctorAvailability availability, {
  int days = 14,
  DateTime? now,
}) {
  final current = now ?? DateTime.now();
  final today = DateTime(current.year, current.month, current.day);
  final nowMinutes = current.hour * 60 + current.minute;

  final result = <BookingDay>[];
  for (var i = 0; i < days; i++) {
    final date = today.add(Duration(days: i));
    final starts = availability.slotStartsFor(date.weekday);

    final morning = <TimeSlot>[];
    final afternoon = <TimeSlot>[];
    final evening = <TimeSlot>[];
    for (final minutes in starts) {
      if (i == 0 && minutes <= nowMinutes) continue;
      final slot = TimeSlot.fromMinutes(minutes);
      if (minutes < 12 * 60) {
        morning.add(slot);
      } else if (minutes < 17 * 60) {
        afternoon.add(slot);
      } else {
        evening.add(slot);
      }
    }
    result.add(
      BookingDay(
        date: date,
        morning: morning,
        afternoon: afternoon,
        evening: evening,
      ),
    );
  }
  return result;
}
