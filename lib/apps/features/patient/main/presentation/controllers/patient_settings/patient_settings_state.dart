part of 'patient_settings_cubit.dart';

class PatientSettingsState extends Equatable {
  const PatientSettingsState({
    this.status = AppStatus.initial,
    this.profile,
    this.notificationsEnabled = true,
    this.error,
  });

  final AppStatus status;
  final UserProfile? profile;
  final bool notificationsEnabled;
  final String? error;

  PatientSettingsState copyWith({
    AppStatus? status,
    UserProfile? profile,
    bool? notificationsEnabled,
    String? error,
  }) {
    return PatientSettingsState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, profile, notificationsEnabled, error];
}
