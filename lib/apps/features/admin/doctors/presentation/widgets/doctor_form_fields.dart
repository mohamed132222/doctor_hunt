import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

FormFieldValidator<String> requiredField(String label) {
  return (value) => (value == null || value.trim().isEmpty)
      ? t.fieldRequired(label: label)
      : null;
}

final List<TextInputFormatter> feeInputFormatters = <TextInputFormatter>[
  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
];

double parseFee(String raw) =>
    double.tryParse(raw.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

class SpecialtyField extends StatelessWidget {
  const SpecialtyField({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  final DoctorSpecialty? value;
  final ValueChanged<DoctorSpecialty?> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.adminSpecialtyLabel.toUpperCase(),
          style: context.semiBold12TextMain.copyWith(letterSpacing: 0.8),
        ),
        SizedBox(height: context.s10),
        _SpecialtyDropdown(value: value, onChanged: onChanged),
        if (showError)
          Padding(
            padding: EdgeInsets.only(top: context.s6, left: context.s12),
            child: Text(
              t.fieldRequired(label: t.adminSpecialtyLabel),
              style: context.regular12Danger,
            ),
          ),
      ],
    );
  }
}

class _SpecialtyDropdown extends StatelessWidget {
  const _SpecialtyDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DoctorSpecialty? value;
  final ValueChanged<DoctorSpecialty?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: context.adminDropdownHeight,
      padding: EdgeInsets.symmetric(horizontal: context.s20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.r14),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DoctorSpecialty>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(context.r14),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: scheme.onSurfaceVariant,
          ),
          hint: Text(
            t.adminSelectSpecialty,
            style: context.regular16.copyWith(color: scheme.outlineVariant),
          ),
          style: context.regular16Black,
          items: [
            for (final specialty in DoctorSpecialty.values)
              DropdownMenuItem<DoctorSpecialty>(
                value: specialty,
                child: Text(specialty.label, style: context.regular16Black),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
