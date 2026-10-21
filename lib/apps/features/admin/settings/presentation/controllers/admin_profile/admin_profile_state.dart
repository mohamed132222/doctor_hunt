part of 'admin_profile_cubit.dart';

class AdminProfileState extends Equatable {
  const AdminProfileState({
    this.status = AppStatus.initial,
    this.profile,
    this.saved = false,
    this.saving = false,
    this.error,
  });

  final AppStatus status;
  final AdminProfile? profile;
  final bool saved;
  final bool saving;
  final String? error;

  AdminProfileState copyWith({
    AppStatus? status,
    AdminProfile? profile,
    bool? saved,
    bool? saving,
    String? error,
  }) {
    return AdminProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      saved: saved ?? this.saved,
      saving: saving ?? this.saving,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, profile, saved, saving, error];
}
