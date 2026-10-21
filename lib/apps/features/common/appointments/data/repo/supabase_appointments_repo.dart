import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/models/doctor_review_model.dart';
import 'package:doctor_hunt/apps/features/common/appointments/data/repo/appointments_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAppointmentsRepo implements AppointmentsRepo {
  const SupabaseAppointmentsRepo(this._client);

  final SupabaseClient _client;

  static const String _table = 'appointments';

  @override
  Future<Result<List<Appointment>>> fetchAppointments({
    AppointmentStatus? status,
    int? limit,
    int? offset,
  }) async {
    try {
      var builder = _client.from(_table).select();
      if (status != null) builder = builder.eq('status', status.wireValue);
      var query = builder.order('date_time', ascending: false);
      if (limit != null) {
        final from = offset ?? 0;
        query = query.range(from, from + limit - 1);
      }
      final rows = await query;
      return Success<List<Appointment>>([
        for (final row in rows) _fromRow(row),
      ]);
    } catch (error) {
      return Error<List<Appointment>>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Appointment>> appointmentById(String id) async {
    try {
      final row = await _client
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (row == null) return _notFound();
      return Success<Appointment>(_fromRow(row));
    } catch (error) {
      return Error<Appointment>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Appointment>> markCompleted(String id) =>
      _setStatus(id, AppointmentStatus.completed);

  @override
  Future<Result<Appointment>> cancel(String id) async {
    try {
      await _client.rpc('cancel_appointment', params: {'p_appointment_id': id});
      return appointmentById(id);
    } catch (error) {
      return Error<Appointment>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Set<DateTime>>> fetchBookedSlots({
    required String doctorId,
    required DateTime from,
    required DateTime to,
  }) async {
    try {
      final rows = await _client
          .from(_table)
          .select('date_time')
          .eq('doctor_id', doctorId)
          .neq('status', 'cancelled')
          .gte('date_time', from.toIso8601String())
          .lt('date_time', to.toIso8601String());

      final taken = <DateTime>{};
      for (final row in rows) {
        final raw = row['date_time'] as String?;
        if (raw == null) continue;
        final parsed = DateTime.parse(raw).toUtc();
        taken.add(
          DateTime(
            parsed.year,
            parsed.month,
            parsed.day,
            parsed.hour,
            parsed.minute,
          ),
        );
      }
      return Success<Set<DateTime>>(taken);
    } catch (error) {
      return Error<Set<DateTime>>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Appointment>> createAppointment(Appointment appointment) async {
    try {
      final row = await _client
          .from(_table)
          .insert(<String, dynamic>{
            'doctor_id': appointment.doctorId.isEmpty
                ? null
                : appointment.doctorId,
            'doctor_name': appointment.doctorName,
            'specialty': appointment.specialty.wireValue,
            'doctor_photo': appointment.doctorPhoto,
            'patient_name': appointment.patientName,
            'patient_email': appointment.patientEmail,
            'patient_photo': appointment.patientPhoto,
            'patient_id': _client.auth.currentUser?.id,
            'date_time': appointment.dateTime.toIso8601String(),
            'fee': appointment.fee,
            'status': appointment.status.wireValue,
          })
          .select()
          .single();
      return Success<Appointment>(_fromRow(row));
    } catch (error) {
      return Error<Appointment>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<void>> submitReview({
    required String appointmentId,
    required double rating,
    String? comment,
  }) async {
    try {
      await _client.rpc(
        'submit_review',
        params: {
          'p_appointment_id': appointmentId,
          'p_rating': rating,
          'p_comment': comment,
        },
      );
      return const Success<void>(null);
    } catch (error) {
      return Error<void>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<List<DoctorReview>>> fetchDoctorReviews(String doctorId) async {
    try {
      final data =
          await _client.rpc('doctor_reviews', params: {'p_doctor_id': doctorId})
              as List<dynamic>;
      return Success<List<DoctorReview>>([
        for (final row in data)
          DoctorReview.fromRow(Map<String, dynamic>.from(row as Map)),
      ]);
    } catch (error) {
      return Error<List<DoctorReview>>(ErrorHandler.handle(error));
    }
  }

  Future<Result<Appointment>> _setStatus(
    String id,
    AppointmentStatus status,
  ) async {
    try {
      final row = await _client
          .from(_table)
          .update(<String, dynamic>{'status': status.wireValue})
          .eq('id', id)
          .select()
          .maybeSingle();
      if (row == null) return _notFound();
      return Success<Appointment>(_fromRow(row));
    } catch (error) {
      return Error<Appointment>(ErrorHandler.handle(error));
    }
  }

  Error<Appointment> _notFound() =>
      Error<Appointment>(const ServerFailure('Appointment not found'));

  Appointment _fromRow(Map<String, dynamic> row) {
    return Appointment(
      id: row['id'] as String,
      doctorId: row['doctor_id'] as String? ?? '',
      doctorName: row['doctor_name'] as String? ?? '',
      specialty:
          DoctorSpecialty.fromWire(row['specialty'] as String?) ??
          DoctorSpecialty.dentist,
      doctorPhoto: row['doctor_photo'] as String?,
      patientName: row['patient_name'] as String? ?? '',
      patientEmail: row['patient_email'] as String? ?? '',
      patientPhoto: row['patient_photo'] as String?,
      dateTime: DateTime.parse(row['date_time'] as String),
      fee: (row['fee'] as num?)?.toDouble() ?? 0,
      status: AppointmentStatus.fromWire(row['status'] as String?),
      rating: (row['rating'] as num?)?.toDouble(),
      reviewComment: row['review_comment'] as String?,
    );
  }
}
