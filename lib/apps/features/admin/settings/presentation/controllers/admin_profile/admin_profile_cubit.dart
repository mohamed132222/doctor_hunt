import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/core/services/storage_service.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/admin_profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_profile_state.dart';

class AdminProfileCubit extends Cubit<AdminProfileState> {
  AdminProfileCubit(this._repo, this._storage)
    : super(const AdminProfileState());

  final AdminProfileRepo _repo;
  final StorageService _storage;

  Future<void> load() async {
    emit(
      state.copyWith(status: AppStatus.loading, saved: false, saving: false),
    );
    switch (await _repo.fetch()) {
      case Success<AdminProfile>(data: final profile):
        emit(state.copyWith(status: AppStatus.success, profile: profile));
      case Error<AdminProfile>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> save({
    required String name,
    required String clinicLocation,
    String? photo,
  }) async {
    emit(state.copyWith(status: AppStatus.loading, saved: false, saving: true));
    final String? photoUrl;
    try {
      photoUrl = await _storage.uploadIfLocal(photo, folder: 'avatars');
    } catch (error) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          saving: false,
          error: ErrorHandler.handle(error).message,
        ),
      );
      return;
    }
    switch (await _repo.update(
      name: name,
      clinicLocation: clinicLocation,
      photo: photoUrl,
    )) {
      case Success<AdminProfile>(data: final profile):
        emit(
          state.copyWith(
            status: AppStatus.success,
            profile: profile,
            saved: true,
            saving: false,
          ),
        );
      case Error<AdminProfile>(failure: final failure):
        emit(
          state.copyWith(
            status: AppStatus.error,
            saving: false,
            error: failure.message,
          ),
        );
    }
  }

  Future<void> updatePhoto(String path) async {
    final profile = state.profile;
    if (profile == null) return;
    emit(state.copyWith(status: AppStatus.loading, saved: false, saving: true));
    final String? url;
    try {
      url = await _storage.uploadIfLocal(path, folder: 'avatars');
    } catch (error) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          saving: false,
          error: ErrorHandler.handle(error).message,
        ),
      );
      return;
    }
    switch (await _repo.update(
      name: profile.name,
      clinicLocation: profile.clinicLocation,
      photo: url,
    )) {
      case Success<AdminProfile>(data: final updated):
        emit(
          state.copyWith(
            status: AppStatus.success,
            profile: updated,
            saving: false,
          ),
        );
      case Error<AdminProfile>(failure: final failure):
        emit(
          state.copyWith(
            status: AppStatus.error,
            saving: false,
            error: failure.message,
          ),
        );
    }
  }
}
