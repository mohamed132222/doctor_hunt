import 'dart:io';

import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Failure handle(Object error) {
    if (error is AuthException) {
      return AuthFailure(_mapAuthError(error));
    }

    if (error is PostgrestException) {
      return ServerFailure(error.message);
    }

    if (error is SocketException) {
      return const NetworkFailure(
        'No internet connection. Please check your connection.',
      );
    }

    if (error is FormatException) {
      return ValidationFailure(error.message);
    }

    return const UnknownFailure('Something went wrong. Please try again.');
  }

  static String _mapAuthError(AuthException error) {
    switch (error.code) {
      case 'invalid_credentials':
        return 'Email or password is incorrect.';

      case 'email_not_confirmed':
        return 'Please verify your email first.';

      case 'user_already_exists':
        return 'An account with this email already exists.';

      case 'user_banned':
        return 'This account has been disabled.';

      case 'weak_password':
        return 'Password is too weak.';

      case 'signup_disabled':
        return 'Registration is currently disabled.';

      case 'email_provider_disabled':
        return 'Email registration is currently disabled.';

      case 'invalid_email':
        return 'Please enter a valid email address.';

      case 'user_not_found':
        return 'User not found.';

      case 'over_email_send_rate_limit':
        return 'Too many email requests. Please try again later.';

      case 'over_request_rate_limit':
        return 'Too many requests. Please try again later.';

      case 'otp_expired':
      case 'otp_disabled':
        return 'The code is incorrect or has expired. Please try again.';

      default:
        return error.message;
    }
  }
}
