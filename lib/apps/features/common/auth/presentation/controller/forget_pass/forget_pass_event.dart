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

/// Moves the flow one step back (resetPassword -> verifyOtp -> email).
class GoBackToPreviousStep extends ForgotPasswordEvent {}

/// Re-sends the OTP to the email already stored in the state (verify step).
class ResendPasswordResetOtp extends ForgotPasswordEvent {}
