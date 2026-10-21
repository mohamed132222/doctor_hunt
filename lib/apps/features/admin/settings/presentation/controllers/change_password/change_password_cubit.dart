import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this._authRepo) : super(const ChangePasswordState());

  final AuthRepo _authRepo;

  Future<void> submit(String password) async {
    emit(state.copyWith(status: AppStatus.loading, saved: false));
    switch (await _authRepo.updatePassword(password: password)) {
      case Success<void>():
        emit(state.copyWith(status: AppStatus.success, saved: true));
      case Error<void>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }
}
