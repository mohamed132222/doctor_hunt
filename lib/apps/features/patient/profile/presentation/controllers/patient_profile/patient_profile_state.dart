part of 'patient_profile_cubit.dart';

class PatientProfileState extends Equatable {
  const PatientProfileState({
    this.status = AppStatus.initial,
    this.profile,
    this.saved = false,
    this.error,
  });

  final AppStatus status;
  final UserProfile? profile;
  final bool saved;
  final String? error;

  bool get isSaving => status == AppStatus.loading && profile != null;

  PatientProfileState copyWith({
    AppStatus? status,
    UserProfile? profile,
    bool? saved,
    String? error,
  }) {
    return PatientProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      saved: saved ?? this.saved,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, profile, saved, error];
}
