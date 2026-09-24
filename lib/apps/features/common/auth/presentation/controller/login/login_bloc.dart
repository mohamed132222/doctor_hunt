import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc(this._authRepo) : super(LoginState.initial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed, transformer: droppable());
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        status: AppStatus.loading,
      ),
    );

    final result = await _authRepo.login(
      email: event.email.trim(),
      password: event.password,
    );

    switch (result) {
      case Success<AppUser>(data: final user):
        debugPrint('SELECTED ROLE: ${event.role.name}');
        debugPrint('USER ROLE: ${user.role}');

        final hasCorrectRole = user.role == event.role.name;

        debugPrint('ROLE MATCH: $hasCorrectRole');

        if (!hasCorrectRole) {
          emit(
            state.copyWith(
              isLoading: false,
              isLoggedIn: false,
              status: AppStatus.error,
              errorMessage: _roleErrorMessage(event.role),
            ),
          );

          return;
        }

        emit(
          state.copyWith(
            isLoading: false,
            user: user,
            isLoggedIn: true,
            status: AppStatus.success,
            errorMessage: null,
          ),
        );

      case Error<AppUser>(failure: final failure):
        emit(
          state.copyWith(
            isLoading: false,
            isLoggedIn: false,
            status: AppStatus.error,
            errorMessage: failure.message,
          ),
        );
    }
  }
}

String _roleErrorMessage(UserRole role) {
  switch (role) {
    case UserRole.patient:
      return 'This account is not a patient account.';

    case UserRole.admin:
      return 'This account is not an admin account.';
  }
}
