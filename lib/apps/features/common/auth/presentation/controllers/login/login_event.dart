part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final UserRole role;

  const LoginButtonPressed({
    required this.email,
    required this.password,
    required this.role,
  });
}
