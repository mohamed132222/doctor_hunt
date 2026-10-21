import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/core/services/storage_service.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_profile_state.dart';

class PatientProfileCubit extends Cubit<PatientProfileState> {
  PatientProfileCubit(this._repo, this._storage)
    : super(const PatientProfileState());

  final ProfileRepo _repo;
  final StorageService _storage;

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.fetchCurrent()) {
      case Success<UserProfile?>(data: final profile):
        emit(state.copyWith(status: AppStatus.success, profile: profile));
      case Error<UserProfile?>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> save({
    required String name,
    required String phone,
    String? photo,
  }) async {
    emit(state.copyWith(status: AppStatus.loading, saved: false));
    final String? photoUrl;
    try {
      photoUrl = await _storage.uploadIfLocal(photo, folder: 'avatars');
    } catch (error) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          error: ErrorHandler.handle(error).message,
        ),
      );
      return;
    }
    switch (await _repo.update(name: name, phone: phone, photo: photoUrl)) {
      case Success<UserProfile>(data: final profile):
        emit(
          state.copyWith(
            status: AppStatus.success,
            profile: profile,
            saved: true,
          ),
        );
      case Error<UserProfile>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }
}
