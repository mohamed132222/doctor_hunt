import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/datasources/supabase_data_source.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/app_user.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';

class AuthRepo {
  final SupabaseDataSource _supabaseDataSource;

  const AuthRepo(this._supabaseDataSource);

  Future<Result<AppUser>> login({
    required String email,
    required String password,
  }) {
    return _supabaseDataSource.login(email: email, password: password);
  }

  Future<Result<AppUser>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return _supabaseDataSource.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }

  Future<Result<void>> sendPasswordResetOtp({required String email}) {
    return _supabaseDataSource.sendPasswordResetOtp(email: email);
  }

  Future<Result<void>> verifyPasswordResetOtp({
    required String email,
    required String token,
  }) {
    return _supabaseDataSource.verifyPasswordResetOtp(
      email: email,
      token: token,
    );
  }

  Future<Result<void>> updatePassword({required String password}) {
    return _supabaseDataSource.updatePassword(password: password);
  }
}
