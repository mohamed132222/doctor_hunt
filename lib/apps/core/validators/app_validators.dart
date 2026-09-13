import '../constants/app_strings.dart';

/// Form validation helpers — single source of truth for every field rule.
abstract final class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  /// Required non-empty text.
  static String? required(String? value, [String label = 'this field']) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired(label);
    }
    return null;
  }

  /// Valid email address.
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return AppStrings.emailRequired;
    return _emailRegex.hasMatch(v) ? null : AppStrings.emailInvalid;
  }

  /// Password with minimum length.
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return AppStrings.passwordRequired;
    return value.length < minLength
        ? AppStrings.passwordMinLength(minLength)
        : null;
  }

  /// Confirmation must match the original password.
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return AppStrings.reenterPasswordRequired;
    }
    return value != original ? AppStrings.passwordsDoNotMatch : null;
  }

  /// 4-digit verification code.
  static String? otpCode(String? value, {int length = 4}) {
    final v = value?.trim() ?? '';
    return v.length == length ? null : AppStrings.otpRequired(length);
  }
}
