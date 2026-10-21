import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_settings_state.dart';

class PatientSettingsCubit extends Cubit<PatientSettingsState> {
  PatientSettingsCubit(this._repo) : super(const PatientSettingsState());

  final ProfileRepo _repo;

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.fetchCurrent()) {
      case Success<UserProfile?>(data: final profile):
        emit(state.copyWith(status: AppStatus.success, profile: profile));
      case Error<UserProfile?>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  void setNotifications(bool enabled) =>
      emit(state.copyWith(notificationsEnabled: enabled));
}
