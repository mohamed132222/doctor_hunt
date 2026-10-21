import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDoctorsRepo implements DoctorsRepo {
  const SupabaseDoctorsRepo(this._client);

  final SupabaseClient _client;

  static const String _table = 'doctors';

  @override
  Future<Result<List<Doctor>>> fetchDoctors({
    String query = '',
    DoctorSpecialty? specialty,
    bool activeOnly = false,
    DoctorSort sort = DoctorSort.nameAsc,
    int? limit,
    int? offset,
  }) async {
    try {
      final needle = query.trim();
      var builder = _client.from(_table).select();
      if (activeOnly) builder = builder.eq('is_active', true);
      if (specialty != null) {
        builder = builder.eq('specialty', specialty.wireValue);
      }
      if (needle.isNotEmpty) builder = builder.ilike('name', '%$needle%');

      final (String column, bool ascending) = switch (sort) {
        DoctorSort.popularity => ('reviews_count', false),
        DoctorSort.rating => ('rating', false),
        DoctorSort.nameAsc => ('name', true),
      };

      var paged = builder.order(column, ascending: ascending);
      if (limit != null) {
        final from = offset ?? 0;
        paged = paged.range(from, from + limit - 1);
      }
      final rows = await paged;
      return Success<List<Doctor>>([for (final row in rows) _fromRow(row)]);
    } catch (error) {
      return Error<List<Doctor>>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<DoctorCounters>> fetchCounters() async {
    try {
      final rows = await _client.from(_table).select('is_active');
      var active = 0;
      for (final row in rows) {
        if (row['is_active'] == true) active++;
      }
      return Success<DoctorCounters>(
        DoctorCounters(total: rows.length, active: active),
      );
    } catch (error) {
      return Error<DoctorCounters>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Doctor>> doctorById(String id) async {
    try {
      final row = await _client
          .from(_table)
          .select()
          .eq('id', id)
          .maybeSingle();
      if (row == null) return _notFound();
      return Success<Doctor>(_fromRow(row));
    } catch (error) {
      return Error<Doctor>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<List<Doctor>>> doctorsByIds(List<String> ids) async {
    if (ids.isEmpty) return const Success<List<Doctor>>(<Doctor>[]);
    try {
      final rows = await _client.from(_table).select().inFilter('id', ids);
      return Success<List<Doctor>>([for (final row in rows) _fromRow(row)]);
    } catch (error) {
      return Error<List<Doctor>>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Doctor>> createDoctor({
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) async {
    try {
      final row = await _client
          .from(_table)
          .insert(<String, dynamic>{
            'name': name.trim(),
            'specialty': specialty.wireValue,
            'fee': fee,
            'photo': photo,
            'latitude': latitude,
            'longitude': longitude,
            'location_label': locationLabel,
            'rating': rating ?? 0,
            'availability': DoctorAvailability.standard.toJson(),
          })
          .select()
          .single();
      return Success<Doctor>(_fromRow(row));
    } catch (error) {
      return Error<Doctor>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<Doctor>> updateDoctor({
    required String id,
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) {
    return _update(id, <String, dynamic>{
      'name': name.trim(),
      'specialty': specialty.wireValue,
      'fee': fee,
      'photo': photo,
      'latitude': latitude,
      'longitude': longitude,
      'location_label': locationLabel,
      'rating': ?rating,
    });
  }

  @override
  Future<Result<Doctor>> setDoctorActive({
    required String id,
    required bool isActive,
  }) {
    return _update(id, <String, dynamic>{'is_active': isActive});
  }

  @override
  Future<Result<Doctor>> updateAvailability({
    required String id,
    required DoctorAvailability availability,
  }) {
    return _update(id, <String, dynamic>{
      'availability': availability.toJson(),
    });
  }

  @override
  Future<Result<void>> deleteDoctor(String id) async {
    try {
      final removed = await _client.from(_table).delete().eq('id', id).select();
      if (removed.isEmpty) return _notFound();
      return const Success<void>(null);
    } catch (error) {
      return Error<void>(ErrorHandler.handle(error));
    }
  }

  Future<Result<Doctor>> _update(String id, Map<String, dynamic> patch) async {
    try {
      final row = await _client
          .from(_table)
          .update(patch)
          .eq('id', id)
          .select()
          .maybeSingle();
      if (row == null) return _notFound();
      return Success<Doctor>(_fromRow(row));
    } catch (error) {
      return Error<Doctor>(ErrorHandler.handle(error));
    }
  }

  Error<T> _notFound<T>() => Error<T>(const ServerFailure('Doctor not found'));

  Doctor _fromRow(Map<String, dynamic> row) {
    final availability = row['availability'];
    return Doctor(
      id: row['id'] as String,
      name: row['name'] as String? ?? '',
      specialty:
          DoctorSpecialty.fromWire(row['specialty'] as String?) ??
          DoctorSpecialty.dentist,
      fee: (row['fee'] as num?)?.toDouble() ?? 0,
      photo: row['photo'] as String?,
      rating: (row['rating'] as num?)?.toDouble() ?? 0,
      reviewsCount: (row['reviews_count'] as num?)?.toInt() ?? 0,
      isActive: row['is_active'] as bool? ?? true,
      latitude: (row['latitude'] as num?)?.toDouble(),
      longitude: (row['longitude'] as num?)?.toDouble(),
      locationLabel: row['location_label'] as String?,
      availability: availability == null
          ? DoctorAvailability.standard
          : DoctorAvailability.fromJson(
              Map<String, dynamic>.from(availability as Map),
            ),
    );
  }
}
