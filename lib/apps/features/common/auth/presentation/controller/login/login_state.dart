part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final AppUser? user;
  final bool isLoggedIn;
  final AppStatus status;

  const LoginState({
    required this.isLoading,
    required this.errorMessage,
    required this.user,
    required this.isLoggedIn,
    required this.status,
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      errorMessage: null,
      user: null,
      isLoggedIn: false,
      status: AppStatus.initial,
    );
  }

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    AppUser? user,
    bool? isLoggedIn,
    AppStatus? status,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    user,
    isLoggedIn,
    status,
  ];
}