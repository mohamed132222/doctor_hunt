part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final AppUser? user;
  final bool isRegistered;
  final AppStatus status;

  const RegisterState({
    required this.isLoading,
    required this.errorMessage,
    required this.user,
    required this.isRegistered,
    required this.status,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isLoading: false,
      errorMessage: null,
      user: null,
      isRegistered: false,
      status: AppStatus.initial,
    );
  }

  RegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
    AppUser? user,
    bool? isRegistered,
    AppStatus? status,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
      isRegistered: isRegistered ?? this.isRegistered,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    user,
    isRegistered,
    status,
  ];
}
