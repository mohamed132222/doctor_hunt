import '../../../../core/constants/app_strings.dart';

/// A bookable time on a given day.
class TimeSlot {
  const TimeSlot(this.hour24, this.minute);

  final int hour24;
  final int minute;

  String get label => AppStrings.slotLabel(hour24, minute);

  // Value equality matters: the slots are rebuilt on every frame, so without
  // this the grid could never tell which one is selected.
  @override
  bool operator ==(Object other) =>
      other is TimeSlot && other.hour24 == hour24 && other.minute == minute;

  @override
  int get hashCode => Object.hash(hour24, minute);
}

/// One day in the booking date strip, with how many slots it has left.
class BookingDay {
  const BookingDay({
    required this.date,
    required this.afternoonSlots,
    required this.eveningSlots,
  });

  final DateTime date;
  final int afternoonSlots;
  final int eveningSlots;

  int get totalSlots => afternoonSlots + eveningSlots;

  bool get hasSlots => totalSlots > 0;

  /// Afternoon runs 1:00 PM on the half hour; evening runs 5:00 PM.
  List<TimeSlot> get afternoon => _slotsFrom(13, afternoonSlots);

  List<TimeSlot> get evening => _slotsFrom(17, eveningSlots);

  static List<TimeSlot> _slotsFrom(int startHour, int count) => [
    for (var i = 0; i < count; i++)
      TimeSlot(startHour + (i ~/ 2), (i % 2) * 30),
  ];
}

/// Today plus the next two days, seeded from the current date so the strip is
/// always accurate. Today is deliberately full (the design's "no slots" state)
/// so both booking states are reachable.
List<BookingDay> bookingDays({DateTime? now}) {
  final today = DateTime.now();
  final base = DateTime(
    now?.year ?? today.year,
    now?.month ?? today.month,
    now?.day ?? today.day,
  );

  return [
    BookingDay(date: base, afternoonSlots: 0, eveningSlots: 0),
    BookingDay(
      date: base.add(const Duration(days: 1)),
      afternoonSlots: 7,
      eveningSlots: 5,
    ),
    BookingDay(
      date: base.add(const Duration(days: 2)),
      afternoonSlots: 6,
      eveningSlots: 4,
    ),
  ];
}
