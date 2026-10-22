import 'package:doctor_hunt/apps/core/error/error_handler.dart';
import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/models/app_user_model.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client;

  const SupabaseService(this._client);

  Future<Result<AppUserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return const Error(AuthFailure('Login failed.'));
      }

      return _mapUser(user, fallbackEmail: email.trim());
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<bool>> emailExists({required String email}) async {
    try {
      final result = await _client.rpc(
        'email_exists',
        params: {'p_email': email.trim()},
      );

      return Success(result == true);
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<AppUserModel>> register({
    required String name,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final emailCheck = await emailExists(email: email);

    switch (emailCheck) {
      case Success<bool>(data: final exists):
        if (exists) {
          return const Error(AuthFailure('Email already exists.'));
        }

      case Error<bool>(failure: final failure):
        return Error(failure);
    }

    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {'name': name.trim(), 'role': role.name},
      );

      final user = response.user;

      if (user == null) {
        return const Error(AuthFailure('Unable to create account.'));
      }

      return Success(
        AppUserModel(
          id: user.id,
          name: name.trim(),
          email: user.email ?? email.trim(),
          role: role.name,
        ),
      );
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<void>> sendPasswordResetOtp({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email.trim());

      return const Success(null);
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<void>> verifyPasswordResetOtp({
    required String email,
    required String token,
  }) async {
    try {
      await _client.auth.verifyOTP(
        email: email.trim(),
        token: token.trim(),
        type: OtpType.recovery,
      );

      return const Success(null);
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<void>> updatePassword({required String password}) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: password));

      return const Success(null);
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  Future<Result<void>> signOut() async {
    try {
      await _client.auth.signOut();

      return const Success(null);
    } catch (error) {
      return Error(ErrorHandler.handle(error));
    }
  }

  AppUserModel? currentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final metadata = user.userMetadata;
    return AppUserModel(
      id: user.id,
      name: metadata?['name'] as String? ?? '',
      email: user.email ?? '',
      role: metadata?['role'] as String? ?? '',
    );
  }

  Result<AppUserModel> _mapUser(User user, {required String fallbackEmail}) {
    final metadata = user.userMetadata;

    final name = metadata?['name'] as String? ?? '';
    final role = metadata?['role'] as String?;

    if (role == null || role.isEmpty) {
      return const Error(AuthFailure('User role not found.'));
    }

    return Success(
      AppUserModel(
        id: user.id,
        name: name,
        email: user.email ?? fallbackEmail,
        role: role,
      ),
    );
  }
}
