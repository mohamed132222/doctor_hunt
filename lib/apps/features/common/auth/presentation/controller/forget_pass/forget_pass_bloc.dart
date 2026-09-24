import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_pass_event.dart';
import 'forget_pass_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this._authRepo) : super(ForgotPasswordState.initial()) {
    on<SendPasswordResetOtp>(_onSendPasswordResetOtp, transformer: droppable());

    on<VerifyPasswordResetOtp>(
      _onVerifyPasswordResetOtp,
      transformer: droppable(),
    );

    on<ResetPassword>(_onResetPassword, transformer: droppable());

    on<ResendPasswordResetOtp>(
      _onResendPasswordResetOtp,
      transformer: droppable(),
    );

    on<GoBackToPreviousStep>(_onGoBackToPreviousStep);
  }

  final AuthRepo _authRepo;

  Future<void> _onSendPasswordResetOtp(
    SendPasswordResetOtp event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AppStatus.loading,
        email: event.email.trim(),
        clearError: true,
      ),
    );

    final result = await _authRepo.sendPasswordResetOtp(
      email: event.email.trim(),
    );

    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            status: AppStatus.success,
            step: ForgotPasswordStep.verifyOtp,
            email: event.email.trim(),
            clearError: true,
          ),
        );

      case Error<void>(failure: final failure):
        emit(
          state.copyWith(
            status: AppStatus.error,
            errorMessage: failure.message,
          ),
        );
    }
  }

  Future<void> _onVerifyPasswordResetOtp(
    VerifyPasswordResetOtp event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = state.email;

    if (email == null || email.isEmpty) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          errorMessage: 'Email is missing.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AppStatus.loading, clearError: true));

    final result = await _authRepo.verifyPasswordResetOtp(
      email: email,
      token: event.token,
    );

    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            status: AppStatus.success,
            step: ForgotPasswordStep.resetPassword,
            clearError: true,
          ),
        );

      case Error<void>(failure: final failure):
        emit(
          state.copyWith(
            status: AppStatus.error,
            errorMessage: failure.message,
          ),
        );
    }
  }

  Future<void> _onResetPassword(
    ResetPassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading, clearError: true));

    final result = await _authRepo.updatePassword(password: event.password);

    switch (result) {
      case Success<void>():
        emit(
          state.copyWith(
            status: AppStatus.success,
            step: ForgotPasswordStep.completed,
            clearError: true,
          ),
        );

      case Error<void>(failure: final failure):
        emit(
          state.copyWith(
            status: AppStatus.error,
            errorMessage: failure.message,
          ),
        );
    }
  }

  Future<void> _onResendPasswordResetOtp(
    ResendPasswordResetOtp event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    final email = state.email;

    if (email == null || email.isEmpty) {
      emit(
        state.copyWith(status: AppStatus.error, errorMessage: 'Email is missing.'),
      );
      return;
    }

    emit(state.copyWith(status: AppStatus.loading, clearError: true));

    final result = await _authRepo.sendPasswordResetOtp(email: email);

    switch (result) {
      case Success<void>():
        // Stay on the verify step; just refresh the sent code.
        emit(state.copyWith(status: AppStatus.success, clearError: true));

      case Error<void>(failure: final failure):
        emit(
          state.copyWith(status: AppStatus.error, errorMessage: failure.message),
        );
    }
  }

  void _onGoBackToPreviousStep(
    GoBackToPreviousStep event,
    Emitter<ForgotPasswordState> emit,
  ) {
    final previousStep = switch (state.step) {
      ForgotPasswordStep.resetPassword => ForgotPasswordStep.verifyOtp,
      ForgotPasswordStep.verifyOtp => ForgotPasswordStep.email,
      _ => state.step,
    };

    emit(
      state.copyWith(
        step: previousStep,
        status: AppStatus.initial,
        clearError: true,
      ),
    );
  }
}
