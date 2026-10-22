import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/core/services/storage_service.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_form_state.dart';

class DoctorFormCubit extends Cubit<DoctorFormState> {
  DoctorFormCubit(this._repo, this._storage) : super(const DoctorFormState());

  final DoctorsRepo _repo;
  final StorageService _storage;

  Future<void> create({
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) async {
    emit(state.copyWith(status: AppStatus.loading));
    final String? photoUrl;
    try {
      photoUrl = await _storage.uploadIfLocal(photo, folder: 'doctors');
    } catch (error) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          error: ErrorHandler.handle(error).message,
        ),
      );
      return;
    }
    _handle(
      await _repo.createDoctor(
        name: name,
        specialty: specialty,
        fee: fee,
        photo: photoUrl,
        latitude: latitude,
        longitude: longitude,
        locationLabel: locationLabel,
        rating: rating,
      ),
    );
  }

  Future<void> update({
    required String id,
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    required bool isActive,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) async {
    emit(state.copyWith(status: AppStatus.loading));

    final String? photoUrl;
    try {
      photoUrl = await _storage.uploadIfLocal(photo, folder: 'doctors');
    } catch (error) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          error: ErrorHandler.handle(error).message,
        ),
      );
      return;
    }

    final result = await _repo.updateDoctor(
      id: id,
      name: name,
      specialty: specialty,
      fee: fee,
      photo: photoUrl,
      latitude: latitude,
      longitude: longitude,
      locationLabel: locationLabel,
      rating: rating,
    );
    if (result is Error<Doctor>) {
      emit(
        state.copyWith(status: AppStatus.error, error: result.failure.message),
      );
      return;
    }
    _handle(await _repo.setDoctorActive(id: id, isActive: isActive));
  }

  Future<void> delete(String id) async {
    emit(state.copyWith(status: AppStatus.loading));
    final result = await _repo.deleteDoctor(id);
    switch (result) {
      case Success<void>():
        emit(state.copyWith(status: AppStatus.success, deleted: true));
      case Error<void>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  void _handle(Result<Doctor> result) {
    switch (result) {
      case Success<Doctor>():
        emit(state.copyWith(status: AppStatus.success));
      case Error<Doctor>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }
}
