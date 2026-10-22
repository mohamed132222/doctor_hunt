import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfileRepo implements ProfileRepo {
  const SupabaseProfileRepo(this._client);

  final SupabaseClient _client;

  static const String _table = 'users';

  @override
  Future<Result<UserProfile?>> fetchCurrent() async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) return const Success<UserProfile?>(null);
      final row = await _client
          .from(_table)
          .select()
          .eq('id', uid)
          .maybeSingle();
      return Success<UserProfile?>(
        row == null ? null : UserProfile.fromRow(row),
      );
    } catch (error) {
      return Error<UserProfile?>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<UserProfile>> update({
    String? name,
    String? phone,
    String? photo,
  }) async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) {
        return Error<UserProfile>(const AuthFailure('Not signed in'));
      }
      final patch = <String, dynamic>{
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };
      if (name != null) patch['name'] = name.trim();
      if (phone != null) patch['phone'] = phone.trim();
      if (photo != null) patch['photo'] = photo;
      final row = await _client
          .from(_table)
          .update(patch)
          .eq('id', uid)
          .select()
          .single();
      return Success<UserProfile>(UserProfile.fromRow(row));
    } catch (error) {
      return Error<UserProfile>(ErrorHandler.handle(error));
    }
  }
}
