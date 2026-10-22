import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_appointment_details_state.dart';

class PatientAppointmentDetailsCubit
    extends Cubit<PatientAppointmentDetailsState> {
  PatientAppointmentDetailsCubit(this._repo)
    : super(const PatientAppointmentDetailsState());

  final AppointmentsRepo _repo;
  String? _id;

  Future<void> load(String id) async {
    _id = id;
    emit(state.copyWith(status: AppStatus.loading, clearError: true));

    final result = await _repo.appointmentById(id);
    if (isClosed) return;

    switch (result) {
      case Success<Appointment>(data: final appointment):
        emit(
          state.copyWith(status: AppStatus.success, appointment: appointment),
        );
      case Error<Appointment>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<bool> cancel() async {
    final id = _id;
    if (id == null) return false;

    emit(state.copyWith(busy: true, clearError: true));
    final result = await _repo.cancel(id);
    if (isClosed) return false;

    if (result is Success<Appointment>) {
      emit(state.copyWith(busy: false, appointment: result.data));
      return true;
    }
    emit(
      state.copyWith(
        busy: false,
        error: (result as Error<Appointment>).failure.message,
      ),
    );
    return false;
  }

  Future<bool> rate(double rating, String? comment) async {
    final id = _id;
    if (id == null) return false;

    emit(state.copyWith(busy: true, clearError: true));
    final result = await _repo.submitReview(
      appointmentId: id,
      rating: rating,
      comment: comment,
    );
    if (isClosed) return false;

    if (result is Error<void>) {
      emit(state.copyWith(busy: false, error: result.failure.message));
      return false;
    }

    await load(id);
    if (isClosed) return false;
    emit(state.copyWith(busy: false));
    return true;
  }
}
