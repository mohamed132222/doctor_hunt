import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/app_user_model.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/service/supabase_service.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role_model.dart';

class AuthRepo {
  final SupabaseService _supabaseService;

  const AuthRepo(this._supabaseService);

  Future<Result<AppUserModel>> login({
    required String email,
    required String password,
  }) {
    return _supabaseService.login(email: email, password: password);
  }

  Future<Result<AppUserModel>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) {
    return _supabaseService.register(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }

  Future<Result<void>> sendPasswordResetOtp({required String email}) {
    return _supabaseService.sendPasswordResetOtp(email: email);
  }

  Future<Result<void>> verifyPasswordResetOtp({
    required String email,
    required String token,
  }) {
    return _supabaseService.verifyPasswordResetOtp(email: email, token: token);
  }

  Future<Result<void>> updatePassword({required String password}) {
    return _supabaseService.updatePassword(password: password);
  }

  Future<Result<void>> logout() {
    return _supabaseService.signOut();
  }

  AppUserModel? currentUser() => _supabaseService.currentUser();
}
