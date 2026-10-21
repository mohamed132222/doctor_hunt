part of 'doctor_details_cubit.dart';

class DoctorDetailsState extends Equatable {
  const DoctorDetailsState({
    this.status = AppStatus.initial,
    this.doctor,
    this.deleted = false,
    this.error,
  });

  final AppStatus status;
  final Doctor? doctor;
  final bool deleted;
  final String? error;

  DoctorDetailsState copyWith({
    AppStatus? status,
    Doctor? doctor,
    bool? deleted,
    String? error,
  }) {
    return DoctorDetailsState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      deleted: deleted ?? this.deleted,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, doctor, deleted, error];
}
