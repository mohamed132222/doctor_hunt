import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';

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
      return t.fieldRequired(label: label);
    }
    return null;
  }

  /// A person's name: required, at least [minLength] characters, and made of
  /// letters (Latin or Arabic) with spaces, hyphens, apostrophes or dots.
  static String? personName(String? value, {int minLength = 3}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return t.fieldRequired(label: t.patientNameHint);
    if (v.length < minLength) return t.nameTooShort;
    return _nameRegex.hasMatch(v) ? null : t.nameInvalid;
  }

  /// A contact number: required, and 8–15 digits once separators are ignored.
  static String? phone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return t.fieldRequired(label: t.contactNumberHint);
    }
    final digits = v.replaceAll(_digitsRegex, '');
    return digits.length >= 8 && digits.length <= 15 ? null : t.phoneInvalid;
  }

  /// Valid email address.
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return t.emailRequired;
    return _emailRegex.hasMatch(v) ? null : t.emailInvalid;
  }

  /// Password with minimum length.
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return t.passwordRequired;
    return value.length < minLength
        ? t.passwordMinLength(minLength: minLength)
        : null;
  }

  /// Confirmation must match the original password.
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return t.reenterPasswordRequired;
    }
    return value != original ? t.passwordsDoNotMatch : null;
  }

  /// 4-digit verification code.
  static String? otpCode(String? value, {int length = 4}) {
    final v = value?.trim() ?? '';
    return v.length == length ? null : t.otpRequired(length: length);
  }
}
