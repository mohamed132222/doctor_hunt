import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/admin_profile_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAdminProfileRepo implements AdminProfileRepo {
  const SupabaseAdminProfileRepo(this._client);

  final SupabaseClient _client;

  static const String _table = 'admin_profile';

  @override
  Future<Result<AdminProfile>> fetch() async {
    try {
      final row = await _client.from(_table).select().limit(1).maybeSingle();
      if (row == null) return _notFound();
      return Success<AdminProfile>(_fromRow(row));
    } catch (error) {
      return Error<AdminProfile>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<AdminProfile>> update({
    required String name,
    required String clinicLocation,
    String? photo,
  }) async {
    try {
      final existing = await _client
          .from(_table)
          .select('id')
          .limit(1)
          .maybeSingle();
      if (existing == null) return _notFound();

      final row = await _client
          .from(_table)
          .update(<String, dynamic>{
            'name': name.trim(),
            'clinic_location': clinicLocation.trim(),
            'photo': photo,
          })
          .eq('id', existing['id'] as Object)
          .select()
          .single();
      return Success<AdminProfile>(_fromRow(row));
    } catch (error) {
      return Error<AdminProfile>(ErrorHandler.handle(error));
    }
  }

  Error<AdminProfile> _notFound() =>
      Error<AdminProfile>(const ServerFailure('Admin profile not found'));

  AdminProfile _fromRow(Map<String, dynamic> row) => AdminProfile(
    name: row['name'] as String? ?? '',
    email: row['email'] as String? ?? '',
    clinicLocation: row['clinic_location'] as String? ?? '',
    photo: row['photo'] as String?,
  );
}
