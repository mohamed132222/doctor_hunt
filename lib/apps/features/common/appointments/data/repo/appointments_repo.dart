import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/doctor_review_model.dart';

abstract interface class AppointmentsRepo {
  Future<Result<List<Appointment>>> fetchAppointments({
    AppointmentStatus? status,
    int? limit,
    int? offset,
  });

  Future<Result<Appointment>> appointmentById(String id);

  Future<Result<Set<DateTime>>> fetchBookedSlots({
    required String doctorId,
    required DateTime from,
    required DateTime to,
  });

  Future<Result<Appointment>> createAppointment(Appointment appointment);

  Future<Result<Appointment>> markCompleted(String id);

  Future<Result<Appointment>> cancel(String id);

  Future<Result<void>> submitReview({
    required String appointmentId,
    required double rating,
    String? comment,
  });

  Future<Result<List<DoctorReview>>> fetchDoctorReviews(String doctorId);
}
