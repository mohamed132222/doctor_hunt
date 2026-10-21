part of 'booking_cubit.dart';

class BookingState extends Equatable {
  const BookingState({
    this.status = AppStatus.initial,
    this.doctor,
    this.days = const <BookingDay>[],
    this.selectedDay = 0,
    this.selectedSlot,
    this.isConfirming = false,
    this.booked,
    this.error,
  });

  final AppStatus status;
  final Doctor? doctor;
  final List<BookingDay> days;
  final int selectedDay;
  final TimeSlot? selectedSlot;
  final bool isConfirming;

  final Appointment? booked;
  final String? error;

  BookingDay? get day =>
      days.isEmpty ? null : days[selectedDay.clamp(0, days.length - 1)];

  BookingState copyWith({
    AppStatus? status,
    Doctor? doctor,
    List<BookingDay>? days,
    int? selectedDay,
    TimeSlot? selectedSlot,
    bool clearSlot = false,
    bool? isConfirming,
    Appointment? booked,
    String? error,
  }) {
    return BookingState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      days: days ?? this.days,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedSlot: clearSlot ? null : (selectedSlot ?? this.selectedSlot),
      isConfirming: isConfirming ?? this.isConfirming,
      booked: booked,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    doctor,
    days,
    selectedDay,
    selectedSlot,
    isConfirming,
    booked,
    error,
  ];
}
