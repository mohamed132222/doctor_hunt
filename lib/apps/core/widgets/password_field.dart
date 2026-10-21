import 'auth_text_field.dart';

class PasswordField extends AuthTextField {
  const PasswordField({
    super.key,
    required super.hint,
    super.controller,
    super.validator,
    super.textInputAction,
  });

  @override
  bool get isPasswordField => true;
}
