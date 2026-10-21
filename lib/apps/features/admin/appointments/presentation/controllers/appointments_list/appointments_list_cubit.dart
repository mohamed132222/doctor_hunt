import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointments_list_state.dart';

class AppointmentsListCubit extends Cubit<AppointmentsListState> {
  AppointmentsListCubit(this._repo) : super(const AppointmentsListState());

  final AppointmentsRepo _repo;

  static const List<AppointmentStatus?> filters = <AppointmentStatus?>[
    null,
    AppointmentStatus.upcoming,
    AppointmentStatus.completed,
    AppointmentStatus.cancelled,
  ];

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.fetchAppointments(status: filters[state.tabIndex])) {
      case Success<List<Appointment>>(data: final list):
        emit(state.copyWith(status: AppStatus.success, appointments: list));
      case Error<List<Appointment>>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  void selectTab(int index) {
    if (index == state.tabIndex) return;
    emit(state.copyWith(tabIndex: index));
    load();
  }

  Future<void> markCompleted(String id) async {
    await _repo.markCompleted(id);
    await load();
  }

  Future<void> cancel(String id) async {
    await _repo.cancel(id);
    await load();
  }
}
