import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:doctor_hunt/apps/features/patient/booking/data/models/booking_day_model.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this._doctors, this._appointments, this._auth, this._profile)
    : super(const BookingState());

  final DoctorsRepo _doctors;
  final AppointmentsRepo _appointments;
  final AuthRepo _auth;
  final ProfileRepo _profile;

  Future<void> load(String doctorId) async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _doctors.doctorById(doctorId)) {
      case Success<Doctor>(data: final doctor):
        final booked = await _appointments.fetchBookedSlots(
          doctorId: doctorId,
          from: DateTime.now().subtract(const Duration(days: 1)),
          to: DateTime.now().add(const Duration(days: 15)),
        );
        final taken = switch (booked) {
          Success<Set<DateTime>>(data: final slots) => {
            for (final slot in slots) _slotKey(slot),
          },
          Error<Set<DateTime>>() => <String>{},
        };

        final days = <BookingDay>[
          for (final day in bookableDays(doctor.availability))
            _withoutTaken(day, taken),
        ];
        final firstWithSlots = days.indexWhere((d) => d.hasSlots);
        emit(
          state.copyWith(
            status: AppStatus.success,
            doctor: doctor,
            days: days,
            selectedDay: firstWithSlots < 0 ? 0 : firstWithSlots,
          ),
        );
      case Error<Doctor>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  void selectDay(int index) =>
      emit(state.copyWith(selectedDay: index, clearSlot: true));

  void selectSlot(TimeSlot slot) => emit(state.copyWith(selectedSlot: slot));

  Future<void> confirm() async {
    final doctor = state.doctor;
    final slot = state.selectedSlot;
    if (doctor == null || slot == null) return;

    final patient = _auth.currentUser();
    if (patient == null || patient.email.isEmpty) {
      emit(
        state.copyWith(
          error: const AuthFailure('Please sign in to book').message,
        ),
      );
      return;
    }

    emit(state.copyWith(isConfirming: true));

    String? patientPhoto;
    if (await _profile.fetchCurrent() case Success<UserProfile?>(
      data: final p,
    )) {
      patientPhoto = p?.photo;
    }

    final day = state.days[state.selectedDay].date;
    final when = DateTime(
      day.year,
      day.month,
      day.day,
      slot.hour24,
      slot.minute,
    );

    final result = await _appointments.createAppointment(
      Appointment(
        id: '',
        doctorId: doctor.id,
        doctorName: doctor.name,
        specialty: doctor.specialty,
        doctorPhoto: doctor.photo,
        patientName: patient.name.isNotEmpty ? patient.name : patient.email,
        patientEmail: patient.email,
        patientPhoto: patientPhoto,
        dateTime: when,
        fee: doctor.fee,
        status: AppointmentStatus.upcoming,
      ),
    );
    switch (result) {
      case Success<Appointment>(data: final appointment):
        emit(state.copyWith(isConfirming: false, booked: appointment));
      case Error<Appointment>(failure: final failure):
        final conflict = _isSlotTaken(failure.message);
        emit(
          state.copyWith(
            isConfirming: false,
            error: conflict ? t.apptSlotTaken : failure.message,
          ),
        );
        if (conflict) await load(doctor.id);
    }
  }
}

String _slotKey(DateTime at) =>
    '${at.year}-${at.month}-${at.day}-${at.hour}-${at.minute}';

BookingDay _withoutTaken(BookingDay day, Set<String> taken) {
  bool free(TimeSlot slot) => !taken.contains(
    _slotKey(
      DateTime(
        day.date.year,
        day.date.month,
        day.date.day,
        slot.hour24,
        slot.minute,
      ),
    ),
  );

  return BookingDay(
    date: day.date,
    morning: day.morning.where(free).toList(growable: false),
    afternoon: day.afternoon.where(free).toList(growable: false),
    evening: day.evening.where(free).toList(growable: false),
  );
}

bool _isSlotTaken(String message) {
  final lower = message.toLowerCase();
  return lower.contains('duplicate key') || lower.contains('unique');
}
