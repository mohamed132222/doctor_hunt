part of 'register_bloc.dart';

sealed class RegisterEvent {
  const RegisterEvent();
}

final class RegisterButtonPressed extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final UserRole role;

  const RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}
