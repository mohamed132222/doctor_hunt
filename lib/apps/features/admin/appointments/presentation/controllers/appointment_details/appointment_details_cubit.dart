import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appointment_details_state.dart';

class AppointmentDetailsCubit extends Cubit<AppointmentDetailsState> {
  AppointmentDetailsCubit(this._repo) : super(const AppointmentDetailsState());

  final AppointmentsRepo _repo;

  Future<void> load(String id) async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _repo.appointmentById(id)) {
      case Success<Appointment>(data: final appointment):
        emit(
          state.copyWith(status: AppStatus.success, appointment: appointment),
        );
      case Error<Appointment>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> markCompleted(String id) async {
    switch (await _repo.markCompleted(id)) {
      case Success<Appointment>(data: final appointment):
        emit(state.copyWith(appointment: appointment));
      case Error<Appointment>():
        break;
    }
  }

  Future<void> cancel(String id) async {
    switch (await _repo.cancel(id)) {
      case Success<Appointment>(data: final appointment):
        emit(state.copyWith(appointment: appointment));
      case Error<Appointment>():
        break;
    }
  }
}
