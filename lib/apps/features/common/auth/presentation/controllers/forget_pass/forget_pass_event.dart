sealed class ForgotPasswordEvent {}

class SendPasswordResetOtp extends ForgotPasswordEvent {
  final String email;

  SendPasswordResetOtp({required this.email});
}

class VerifyPasswordResetOtp extends ForgotPasswordEvent {
  final String token;

  VerifyPasswordResetOtp({required this.token});
}

class ResetPassword extends ForgotPasswordEvent {
  final String password;

  ResetPassword({required this.password});
}

class GoBackToPreviousStep extends ForgotPasswordEvent {}

class ResendPasswordResetOtp extends ForgotPasswordEvent {}
