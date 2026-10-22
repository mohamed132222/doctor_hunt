part of 'appointment_details_cubit.dart';

class AppointmentDetailsState extends Equatable {
  const AppointmentDetailsState({
    this.status = AppStatus.initial,
    this.appointment,
    this.error,
  });

  final AppStatus status;
  final Appointment? appointment;
  final String? error;

  AppointmentDetailsState copyWith({
    AppStatus? status,
    Appointment? appointment,
    String? error,
  }) {
    return AppointmentDetailsState(
      status: status ?? this.status,
      appointment: appointment ?? this.appointment,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, appointment, error];
}
