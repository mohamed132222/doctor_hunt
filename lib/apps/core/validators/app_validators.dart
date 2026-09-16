import '../constants/app_strings.dart';

/// Form validation helpers — single source of truth for every field rule.
abstract final class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  static final RegExp _nameRegex = RegExp(
    r"^[A-Za-z\u0600-\u06FF][A-Za-z\u0600-\u06FF '.\-]*$",
  );
  static final RegExp _digitsRegex = RegExp(r'[^0-9]');

  /// Required non-empty text.
  static String? required(String? value, [String label = 'this field']) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired(label);
    }
    return null;
  }

  /// A person's name: required, at least [minLength] characters, and made of
  /// letters (Latin or Arabic) with spaces, hyphens, apostrophes or dots.
  static String? personName(String? value, {int minLength = 3}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return AppStrings.fieldRequired(AppStrings.patientNameHint);
    if (v.length < minLength) return AppStrings.nameTooShort;
    return _nameRegex.hasMatch(v) ? null : AppStrings.nameInvalid;
  }

  /// A contact number: required, and 8–15 digits once separators are ignored.
  static String? phone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return AppStrings.fieldRequired(AppStrings.contactNumberHint);
    }
    final digits = v.replaceAll(_digitsRegex, '');
    return digits.length >= 8 && digits.length <= 15
        ? null
        : AppStrings.phoneInvalid;
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
