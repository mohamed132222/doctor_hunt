part of 'availability_cubit.dart';

class AvailabilityState extends Equatable {
  const AvailabilityState({
    this.status = AppStatus.initial,
    this.doctor,
    this.availability,
    this.saved = false,
    this.error,
  });

  final AppStatus status;
  final Doctor? doctor;
  final DoctorAvailability? availability;
  final bool saved;
  final String? error;

  bool get isSaving => status == AppStatus.loading && doctor != null;

  AvailabilityState copyWith({
    AppStatus? status,
    Doctor? doctor,
    DoctorAvailability? availability,
    bool? saved,
    String? error,
  }) {
    return AvailabilityState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      availability: availability ?? this.availability,
      saved: saved ?? this.saved,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, doctor, availability, saved, error];
}
