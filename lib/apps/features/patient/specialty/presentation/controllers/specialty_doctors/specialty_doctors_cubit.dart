import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'specialty_doctors_state.dart';

class SpecialtyDoctorsCubit extends Cubit<SpecialtyDoctorsState> {
  SpecialtyDoctorsCubit(this._repo, this.specialty)
    : super(const SpecialtyDoctorsState());

  static const int pageSize = 12;

  final DoctorsRepo _repo;
  final DoctorSpecialty specialty;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: AppStatus.loading,
        doctors: const <Doctor>[],
        hasMore: true,
        clearError: true,
      ),
    );

    final result = await _repo.fetchDoctors(
      specialty: specialty,
      activeOnly: true,
      sort: DoctorSort.popularity,
      limit: pageSize,
      offset: 0,
    );
    if (isClosed) return;

    switch (result) {
      case Success<List<Doctor>>(data: final doctors):
        emit(
          state.copyWith(
            status: AppStatus.success,
            doctors: doctors,
            hasMore: doctors.length == pageSize,
          ),
        );
      case Error<List<Doctor>>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));

    final result = await _repo.fetchDoctors(
      specialty: specialty,
      activeOnly: true,
      sort: DoctorSort.popularity,
      limit: pageSize,
      offset: state.doctors.length,
    );
    if (isClosed) return;

    switch (result) {
      case Success<List<Doctor>>(data: final doctors):
        emit(
          state.copyWith(
            doctors: [...state.doctors, ...doctors],
            isLoadingMore: false,
            hasMore: doctors.length == pageSize,
          ),
        );
      case Error<List<Doctor>>(failure: final failure):
        emit(state.copyWith(isLoadingMore: false, error: failure.message));
    }
  }
}
