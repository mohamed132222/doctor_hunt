part of 'patient_appointment_details_cubit.dart';

class PatientAppointmentDetailsState extends Equatable {
  const PatientAppointmentDetailsState({
    this.status = AppStatus.initial,
    this.appointment,
    this.error,
    this.busy = false,
  });

  final AppStatus status;
  final Appointment? appointment;
  final String? error;

  final bool busy;

  PatientAppointmentDetailsState copyWith({
    AppStatus? status,
    Appointment? appointment,
    String? error,
    bool? busy,
    bool clearError = false,
  }) {
    return PatientAppointmentDetailsState(
      status: status ?? this.status,
      appointment: appointment ?? this.appointment,
      error: clearError ? null : (error ?? this.error),
      busy: busy ?? this.busy,
    );
  }

  @override
  List<Object?> get props => [status, appointment, error, busy];
}
