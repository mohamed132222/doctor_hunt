import 'dart:async';

import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctors_list_state.dart';

class DoctorsListCubit extends Cubit<DoctorsListState> {
  DoctorsListCubit(this._repo) : super(const DoctorsListState());

  final DoctorsRepo _repo;
  List<Doctor> _all = const <Doctor>[];
  Timer? _debounce;

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading));

    final countersResult = await _repo.fetchCounters();
    final doctorsResult = await _repo.fetchDoctors(sort: DoctorSort.nameAsc);

    if (doctorsResult is Error<List<Doctor>>) {
      emit(
        state.copyWith(
          status: AppStatus.error,
          error: doctorsResult.failure.message,
        ),
      );
      return;
    }

    _all = (doctorsResult as Success<List<Doctor>>).data;
    final counters = countersResult is Success<DoctorCounters>
        ? countersResult.data
        : null;

    final counts = <DoctorSpecialty, int>{};
    for (final doctor in _all) {
      counts.update(doctor.specialty, (v) => v + 1, ifAbsent: () => 1);
    }

    emit(
      state.copyWith(
        status: AppStatus.success,
        counters: counters,
        specialtyCounts: counts,
        doctors: _applyFilters(),
      ),
    );
  }

  void search(String query) {
    _debounce?.cancel();
    emit(state.copyWith(query: query));
    _debounce = Timer(const Duration(milliseconds: 300), () {
      emit(state.copyWith(doctors: _applyFilters()));
    });
  }

  void selectSpecialty(DoctorSpecialty? specialty) {
    emit(
      state.copyWith(specialty: specialty, resetSpecialty: specialty == null),
    );
    emit(state.copyWith(doctors: _applyFilters()));
  }

  List<Doctor> _applyFilters() {
    final needle = state.query.trim().toLowerCase();
    return <Doctor>[
      for (final doctor in _all)
        if ((state.specialty == null || doctor.specialty == state.specialty) &&
            (needle.isEmpty || doctor.name.toLowerCase().contains(needle)))
          doctor,
    ];
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
