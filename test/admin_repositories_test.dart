import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/in_memory_appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/in_memory_doctors_repo.dart';
import 'package:flutter_test/flutter_test.dart';

List<T> _data<T>(Result<List<T>> result) => (result as Success<List<T>>).data;

void main() {
  group('InMemoryAppointmentsRepo', () {
    test('fetchAppointments filters by status', () async {
      final repo = InMemoryAppointmentsRepo();

      final all = _data(await repo.fetchAppointments());
      final upcoming = _data(
        await repo.fetchAppointments(status: AppointmentStatus.upcoming),
      );

      expect(all, isNotEmpty);
      expect(upcoming, isNotEmpty);
      expect(upcoming.length, lessThan(all.length));
      expect(
        upcoming.every((a) => a.status == AppointmentStatus.upcoming),
        isTrue,
      );
    });

    test('markCompleted and cancel transition an upcoming appointment',
        () async {
      final repo = InMemoryAppointmentsRepo();
      final upcoming = _data(
        await repo.fetchAppointments(status: AppointmentStatus.upcoming),
      );

      final completed = await repo.markCompleted(upcoming.first.id);
      expect(
        (completed as Success<Appointment>).data.status,
        AppointmentStatus.completed,
      );

      final cancelled = await repo.cancel(upcoming.last.id);
      expect(
        (cancelled as Success<Appointment>).data.status,
        AppointmentStatus.cancelled,
      );
    });

    test('createAppointment persists a patient booking as upcoming', () async {
      final repo = InMemoryAppointmentsRepo();
      final before = _data(await repo.fetchAppointments());

      final created = await repo.createAppointment(
        Appointment(
          id: '',
          doctorId: 'doctor-0',
          doctorName: 'Dr. Test',
          specialty: DoctorSpecialty.dentist,
          patientName: 'Pat Ient',
          patientEmail: 'pat@example.com',
          dateTime: DateTime(2026, 11, 1, 9, 0),
          fee: 40,
          status: AppointmentStatus.upcoming,
        ),
      );

      final appointment = (created as Success<Appointment>).data;
      expect(appointment.id, isNotEmpty);

      final after = _data(await repo.fetchAppointments());
      expect(after.length, before.length + 1);

      final upcoming = _data(
        await repo.fetchAppointments(status: AppointmentStatus.upcoming),
      );
      expect(upcoming.any((a) => a.id == appointment.id), isTrue);
    });
  });

  group('InMemoryDoctorsRepo.deleteDoctor', () {
    test('removes the doctor from the catalog', () async {
      final repo = InMemoryDoctorsRepo();
      final before = _data<Doctor>(await repo.fetchDoctors());
      final id = before.first.id;

      final result = await repo.deleteDoctor(id);
      expect(result, isA<Success<void>>());

      final after = _data<Doctor>(await repo.fetchDoctors());
      expect(after.length, before.length - 1);
      expect(after.any((d) => d.id == id), isFalse);
    });

    test('deleting an unknown id returns an error', () async {
      final repo = InMemoryDoctorsRepo();
      final result = await repo.deleteDoctor('missing-id');
      expect(result, isA<Error<void>>());
    });
  });
}
