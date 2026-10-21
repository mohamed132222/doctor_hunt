import '../extensions/media_query_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.isPassword = false,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  final bool isPassword;

  bool get isPasswordField => isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  Widget _passwordToggle(BuildContext context) {
    final iconWidth = context.authEyeIconWidth;

    return IconButton(
      icon: _obscure
          ? SvgPicture.asset(
              AppAssets.passwordObscureIcon,
              width: iconWidth,
              height: context.authEyeIconHeight,
            )
          : Icon(Icons.visibility_outlined, size: iconWidth),
      onPressed: () => setState(() => _obscure = !_obscure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.r14),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPasswordField && _obscure,
        enabled: widget.enabled,
        validator: widget.validator,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPasswordField
              ? _passwordToggle(context)
              : widget.suffixIcon,
        ),
      ),
    );
  }
}
