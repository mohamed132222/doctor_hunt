import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:equatable/equatable.dart';

enum ForgotPasswordStep { email, verifyOtp, resetPassword, completed }

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    required this.status,
    required this.step,
    required this.email,
    required this.errorMessage,
  });

  final AppStatus status;
  final ForgotPasswordStep step;
  final String? email;
  final String? errorMessage;

  factory ForgotPasswordState.initial() {
    return const ForgotPasswordState(
      status: AppStatus.initial,
      step: ForgotPasswordStep.email,
      email: null,
      errorMessage: null,
    );
  }

  bool get isLoading => status == AppStatus.loading;

  ForgotPasswordState copyWith({
    AppStatus? status,
    ForgotPasswordStep? step,
    String? email,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      step: step ?? this.step,
      email: email ?? this.email,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, step, email, errorMessage];
}
