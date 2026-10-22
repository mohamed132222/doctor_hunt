import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/favorites/data/repo/favorites_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFavoritesRepo implements FavoritesRepo {
  const SupabaseFavoritesRepo(this._client);

  final SupabaseClient _client;

  static const String _table = 'favourites';

  @override
  Future<Result<Set<String>>> fetchFavoriteIds() async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) return const Success<Set<String>>(<String>{});
      final rows = await _client
          .from(_table)
          .select('doctor_id')
          .eq('patient_id', uid);
      return Success<Set<String>>({
        for (final row in rows) row['doctor_id'] as String,
      });
    } catch (error) {
      return Error<Set<String>>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<void>> add(String doctorId) async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) {
        return Error<void>(const AuthFailure('Not signed in'));
      }
      await _client.from(_table).upsert(<String, dynamic>{
        'patient_id': uid,
        'doctor_id': doctorId,
      }, onConflict: 'patient_id,doctor_id');
      return const Success<void>(null);
    } catch (error) {
      return Error<void>(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Result<void>> remove(String doctorId) async {
    try {
      final uid = _client.auth.currentUser?.id;
      if (uid == null) {
        return Error<void>(const AuthFailure('Not signed in'));
      }
      await _client
          .from(_table)
          .delete()
          .eq('patient_id', uid)
          .eq('doctor_id', doctorId);
      return const Success<void>(null);
    } catch (error) {
      return Error<void>(ErrorHandler.handle(error));
    }
  }
}
