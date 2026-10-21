import 'package:doctor_hunt/generated/strings.g.dart';

abstract final class AppValidators {
  AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  static final RegExp _nameRegex = RegExp(
    r"^[A-Za-z\u0600-\u06FF][A-Za-z\u0600-\u06FF '.\-]*$",
  );
  static final RegExp _digitsRegex = RegExp(r'[^0-9]');

  static String? required(String? value, [String label = 'this field']) {
    if (value == null || value.trim().isEmpty) {
      return t.fieldRequired(label: label);
    }
    return null;
  }

  static String? personName(String? value, {int minLength = 3}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return t.fieldRequired(label: t.patientNameHint);
    if (v.length < minLength) return t.nameTooShort;
    return _nameRegex.hasMatch(v) ? null : t.nameInvalid;
  }

  static String? phone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return t.fieldRequired(label: t.contactNumberHint);
    }
    final digits = v.replaceAll(_digitsRegex, '');
    return digits.length >= 8 && digits.length <= 15 ? null : t.phoneInvalid;
  }

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return t.emailRequired;
    return _emailRegex.hasMatch(v) ? null : t.emailInvalid;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) return t.passwordRequired;
    return value.length < minLength
        ? t.passwordMinLength(minLength: minLength)
        : null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return t.reenterPasswordRequired;
    }
    return value != original ? t.passwordsDoNotMatch : null;
  }

  static String? otpCode(String? value, {int length = 4}) {
    final v = value?.trim() ?? '';
    return v.length == length ? null : t.otpRequired(length: length);
  }
}
