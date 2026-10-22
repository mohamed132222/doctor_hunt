import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/doctor_review_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class InMemoryAppointmentsRepo implements AppointmentsRepo {
  InMemoryAppointmentsRepo() {
    for (final appointment in _seed()) {
      _appointments[appointment.id] = appointment;
    }
  }

  final Map<String, Appointment> _appointments = <String, Appointment>{};
  int _nextId = 0;

  @override
  Future<Result<List<Appointment>>> fetchAppointments({
    AppointmentStatus? status,
    int? limit,
    int? offset,
  }) async {
    final list = <Appointment>[
      for (final appointment in _appointments.values)
        if (status == null || appointment.status == status) appointment,
    ];
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    final start = offset ?? 0;
    final page = limit == null
        ? list
        : list.skip(start).take(limit).toList(growable: false);
    return Success<List<Appointment>>(page);
  }

  @override
  Future<Result<Appointment>> appointmentById(String id) async {
    final appointment = _appointments[id];
    if (appointment == null) return _notFound();
    return Success<Appointment>(appointment);
  }

  @override
  Future<Result<Appointment>> markCompleted(String id) =>
      _transition(id, AppointmentStatus.completed);

  @override
  Future<Result<Appointment>> cancel(String id) =>
      _transition(id, AppointmentStatus.cancelled);

  @override
  Future<Result<Set<DateTime>>> fetchBookedSlots({
    required String doctorId,
    required DateTime from,
    required DateTime to,
  }) async {
    final taken = <DateTime>{
      for (final a in _appointments.values)
        if (a.doctorId == doctorId &&
            a.status != AppointmentStatus.cancelled &&
            !a.dateTime.isBefore(from) &&
            a.dateTime.isBefore(to))
          DateTime(
            a.dateTime.year,
            a.dateTime.month,
            a.dateTime.day,
            a.dateTime.hour,
            a.dateTime.minute,
          ),
    };
    return Success<Set<DateTime>>(taken);
  }

  @override
  Future<Result<Appointment>> createAppointment(Appointment appointment) async {
    final id = 'appointment-${_nextId++}';
    final created = Appointment(
      id: id,
      doctorId: appointment.doctorId,
      doctorName: appointment.doctorName,
      specialty: appointment.specialty,
      doctorPhoto: appointment.doctorPhoto,
      patientName: appointment.patientName,
      patientEmail: appointment.patientEmail,
      patientPhoto: appointment.patientPhoto,
      dateTime: appointment.dateTime,
      fee: appointment.fee,
      status: appointment.status,
      rating: appointment.rating,
      reviewComment: appointment.reviewComment,
    );
    _appointments[id] = created;
    return Success<Appointment>(created);
  }

  Future<Result<Appointment>> _transition(
    String id,
    AppointmentStatus status,
  ) async {
    final current = _appointments[id];
    if (current == null) return _notFound();
    final updated = current.copyWith(status: status);
    _appointments[id] = updated;
    return Success<Appointment>(updated);
  }

  @override
  Future<Result<void>> submitReview({
    required String appointmentId,
    required double rating,
    String? comment,
  }) async {
    final current = _appointments[appointmentId];
    if (current == null || current.status != AppointmentStatus.completed) {
      return Error<void>(const ServerFailure('Appointment not reviewable'));
    }
    _appointments[appointmentId] = current.copyWith(
      rating: rating,
      reviewComment: comment,
    );
    return const Success<void>(null);
  }

  @override
  Future<Result<List<DoctorReview>>> fetchDoctorReviews(String doctorId) async {
    final reviews = <DoctorReview>[
      for (final a in _appointments.values)
        if (a.doctorId == doctorId && a.rating != null)
          DoctorReview(
            patientName: a.patientName,
            rating: a.rating!,
            comment: a.reviewComment,
            date: a.dateTime,
          ),
    ];
    reviews.sort((x, y) => y.date.compareTo(x.date));
    return Success<List<DoctorReview>>(reviews);
  }

  Error<Appointment> _notFound() =>
      Error<Appointment>(ServerFailure(t.doctorNotFound));

  String _email(String name) =>
      '${name.toLowerCase().replaceAll(' ', '.')}@example.com';

  List<Appointment> _seed() {
    Appointment make({
      required String patient,
      required String doctorName,
      required DoctorSpecialty specialty,
      required String doctorPhoto,
      required DateTime dateTime,
      required double fee,
      required AppointmentStatus status,
      double? rating,
      String? review,
    }) {
      return Appointment(
        id: 'appointment-${_nextId++}',
        doctorId: 'doctor-0',
        doctorName: doctorName,
        specialty: specialty,
        doctorPhoto: doctorPhoto,
        patientName: patient,
        patientEmail: _email(patient),
        dateTime: dateTime,
        fee: fee,
        status: status,
        rating: rating,
        reviewComment: review,
      );
    }

    return <Appointment>[
      make(
        patient: t.seedPatientMayaPatel,
        doctorName: t.doctorAddison,
        specialty: DoctorSpecialty.cardiologist,
        doctorPhoto: AppAssets.popularDoctorImage,
        dateTime: DateTime(2026, 10, 2, 10, 30),
        fee: 28,
        status: AppointmentStatus.upcoming,
      ),
      make(
        patient: t.seedPatientJamesWilson,
        doctorName: t.doctorShruti,
        specialty: DoctorSpecialty.dentist,
        doctorPhoto: AppAssets.featureDoctorImage,
        dateTime: DateTime(2026, 10, 8, 14, 0),
        fee: 32,
        status: AppointmentStatus.upcoming,
      ),
      make(
        patient: t.seedPatientOliviaMartin,
        doctorName: t.doctorFillerup,
        specialty: DoctorSpecialty.dentist,
        doctorPhoto: AppAssets.popularDoctorImage,
        dateTime: DateTime(2026, 9, 21, 9, 0),
        fee: 30,
        status: AppointmentStatus.completed,
        rating: 4.8,
        review: t.seedReviewKind,
      ),
      make(
        patient: t.seedPatientDanielKim,
        doctorName: t.doctorBennett,
        specialty: DoctorSpecialty.ophthalmologist,
        doctorPhoto: AppAssets.featureDoctorImage,
        dateTime: DateTime(2026, 9, 12, 16, 30),
        fee: 24,
        status: AppointmentStatus.completed,
        rating: 5.0,
        review: t.seedReviewReassuring,
      ),
      make(
        patient: t.seedPatientSophiaClark,
        doctorName: t.doctorAddison,
        specialty: DoctorSpecialty.cardiologist,
        doctorPhoto: AppAssets.popularDoctorImage,
        dateTime: DateTime(2026, 8, 30, 11, 0),
        fee: 35,
        status: AppointmentStatus.cancelled,
      ),
      make(
        patient: t.seedPatientEthanBrooks,
        doctorName: t.doctorCrownover,
        specialty: DoctorSpecialty.gastroenterologist,
        doctorPhoto: AppAssets.featureDoctorImage,
        dateTime: DateTime(2026, 8, 18, 15, 30),
        fee: 26,
        status: AppointmentStatus.cancelled,
      ),
    ];
  }
}
