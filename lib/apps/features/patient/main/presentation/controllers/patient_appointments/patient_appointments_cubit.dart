import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_appointments_state.dart';

class PatientAppointmentsCubit extends Cubit<PatientAppointmentsState> {
  PatientAppointmentsCubit(this._repo)
    : super(const PatientAppointmentsState());

  final AppointmentsRepo _repo;

  static const List<AppointmentStatus> filters = <AppointmentStatus>[
    AppointmentStatus.upcoming,
    AppointmentStatus.completed,
    AppointmentStatus.cancelled,
  ];

  static const int pageSize = 12;

  Future<void> load() async {
    emit(
      state.copyWith(
        status: AppStatus.loading,
        appointments: const <Appointment>[],
        hasMore: true,
      ),
    );
    switch (await _repo.fetchAppointments(
      status: filters[state.tabIndex],
      limit: pageSize,
      offset: 0,
    )) {
      case Success<List<Appointment>>(data: final list):
        emit(
          state.copyWith(
            status: AppStatus.success,
            appointments: list,
            hasMore: list.length == pageSize,
          ),
        );
      case Error<List<Appointment>>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    switch (await _repo.fetchAppointments(
      status: filters[state.tabIndex],
      limit: pageSize,
      offset: state.appointments.length,
    )) {
      case Success<List<Appointment>>(data: final list):
        emit(
          state.copyWith(
            appointments: [...state.appointments, ...list],
            isLoadingMore: false,
            hasMore: list.length == pageSize,
          ),
        );
      case Error<List<Appointment>>(failure: final failure):
        emit(state.copyWith(isLoadingMore: false, error: failure.message));
    }
  }

  void selectTab(int index) {
    if (index == state.tabIndex) return;
    emit(state.copyWith(tabIndex: index, appointments: const <Appointment>[]));
    load();
  }

  Future<void> cancel(String id) async {
    switch (await _repo.cancel(id)) {
      case Success<Appointment>():
        await load();
      case Error<Appointment>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<bool> rate(String id, double rating, String? comment) async {
    switch (await _repo.submitReview(
      appointmentId: id,
      rating: rating,
      comment: comment,
    )) {
      case Success<void>():
        await load();
        return true;
      case Error<void>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
        return false;
    }
  }
}
