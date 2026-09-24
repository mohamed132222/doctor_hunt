import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo _authRepo;

  RegisterBloc(this._authRepo) : super(RegisterState.initial()) {
    on<RegisterButtonPressed>(
      _onRegisterButtonPressed,
      transformer: droppable(),
    );
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        status: AppStatus.loading,
      ),
    );

    final result = await _authRepo.register(
      name: event.name.trim(),
      email: event.email.trim(),
      password: event.password,
      role: event.role,
    );

    switch (result) {
      case Success<AppUser>(data: final user):
        emit(
          state.copyWith(
            isLoading: false,
            user: user,
            isRegistered: true,
            status: AppStatus.success,
            errorMessage: null,
          ),
        );

      case Error<AppUser>(failure: final failure):
        emit(
          state.copyWith(
            isLoading: false,
            isRegistered: false,
            status: AppStatus.error,
            errorMessage: failure.message,
          ),
        );
    }
  }
}
