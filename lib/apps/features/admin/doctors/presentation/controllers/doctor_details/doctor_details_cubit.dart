import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_details_state.dart';

class DoctorDetailsCubit extends Cubit<DoctorDetailsState> {
  DoctorDetailsCubit(this._repo) : super(const DoctorDetailsState());

  final DoctorsRepo _repo;

  Future<void> load(String id) async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.doctorById(id)) {
      case Success<Doctor>(data: final doctor):
        emit(state.copyWith(status: AppStatus.success, doctor: doctor));
      case Error<Doctor>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> delete(String id) async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.deleteDoctor(id)) {
      case Success<void>():
        emit(state.copyWith(status: AppStatus.success, deleted: true));
      case Error<void>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }
}
