part of 'doctor_form_cubit.dart';

class DoctorFormState extends Equatable {
  const DoctorFormState({
    this.status = AppStatus.initial,
    this.deleted = false,
    this.error,
  });

  final AppStatus status;
  final bool deleted;
  final String? error;

  bool get isLoading => status == AppStatus.loading;

  DoctorFormState copyWith({AppStatus? status, bool? deleted, String? error}) {
    return DoctorFormState(
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, deleted, error];
}
