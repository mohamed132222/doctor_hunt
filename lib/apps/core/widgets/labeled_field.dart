import 'package:flutter/material.dart';
import 'auth_text_field.dart';
import 'package:flutter/services.dart';

import '../extensions/media_query_extension.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.enabled = true,
    this.onChanged,
    this.prefixIcon,
    this.inputFormatters,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: context.semiBold12TextMain.copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: context.s10),
        AuthTextField(
          hint: hint,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          enabled: enabled,
          onChanged: onChanged,
          prefixIcon: prefixIcon,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}
