import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import '../appsize/screen_utils.dart';
import '../themes/app_theme.dart';

/// Reusable text input shown as a soft white card (shadow from the theme).
/// All field styling (fill, border, radius, hint color) comes from the app
/// theme's `InputDecorationTheme`.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.r(AppSize.r14)),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: obscureText,
        enabled: enabled,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(hintText: hint, suffixIcon: suffixIcon),
      ),
    );
  }
}
