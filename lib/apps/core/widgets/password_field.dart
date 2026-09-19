import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../appsize/media_query_extension.dart';
import 'auth_text_field.dart';

/// Password input with a visibility toggle.
///
/// Uses the design's `obscure` SVG when hidden and a Material eye when shown.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.hint,
    this.controller,
    this.validator,
    this.textInputAction,
  });

  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final iconWidth = context.authEyeIconWidth;
    final iconHeight = context.authEyeIconHeight;

    return AuthTextField(
      hint: widget.hint,
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      obscureText: _obscure,
      suffixIcon: IconButton(
        icon: _obscure
            ? SvgPicture.asset(
                AppAssets.passwordObscureIcon,
                width: iconWidth,
                height: iconHeight,
              )
            : Icon(Icons.visibility_outlined, size: iconWidth),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}
