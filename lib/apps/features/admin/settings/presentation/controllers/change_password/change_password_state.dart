part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = AppStatus.initial,
    this.saved = false,
    this.error,
  });

  final AppStatus status;
  final bool saved;
  final String? error;

  bool get isLoading => status == AppStatus.loading;

  ChangePasswordState copyWith({
    AppStatus? status,
    bool? saved,
    String? error,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      saved: saved ?? this.saved,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, saved, error];
}
