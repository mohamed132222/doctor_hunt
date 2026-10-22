import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'availability_state.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  AvailabilityCubit(this._repo) : super(const AvailabilityState());

  final DoctorsRepo _repo;

  Future<void> load(String id) async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.doctorById(id)) {
      case Success<Doctor>(data: final doctor):
        emit(
          state.copyWith(
            status: AppStatus.success,
            doctor: doctor,
            availability: doctor.availability,
          ),
        );
      case Error<Doctor>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  void toggleDay(int weekday) {
    final current = state.availability;
    if (current == null) return;
    emit(state.copyWith(availability: current.toggleDay(weekday)));
  }

  void setStart(int minute) => _patch(startMinute: minute);
  void setEnd(int minute) => _patch(endMinute: minute);
  void setSlot(int minutes) => _patch(slotMinutes: minutes);

  void _patch({int? startMinute, int? endMinute, int? slotMinutes}) {
    final current = state.availability;
    if (current == null) return;
    emit(
      state.copyWith(
        availability: current.copyWith(
          startMinute: startMinute,
          endMinute: endMinute,
          slotMinutes: slotMinutes,
        ),
      ),
    );
  }

  Future<void> save() async {
    final doctor = state.doctor;
    final availability = state.availability;
    if (doctor == null || availability == null) return;

    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.updateAvailability(
      id: doctor.id,
      availability: availability,
    )) {
      case Success<Doctor>():
        emit(state.copyWith(status: AppStatus.success, saved: true));
      case Error<Doctor>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }
}
