import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class SpecialtyFilterBar extends StatelessWidget {
  const SpecialtyFilterBar({
    super.key,
    required this.counts,
    required this.total,
    required this.selected,
    required this.onSelect,
  });

  final Map<DoctorSpecialty, int> counts;
  final int total;
  final DoctorSpecialty? selected;
  final ValueChanged<DoctorSpecialty?> onSelect;

  @override
  Widget build(BuildContext context) {
    final present = <DoctorSpecialty>[
      for (final specialty in DoctorSpecialty.values)
        if (counts.containsKey(specialty)) specialty,
    ];

    return SizedBox(
      height: context.adminChipHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _Chip(
            label: '${t.adminFilterAll} ($total)',
            selected: selected == null,
            onTap: () => onSelect(null),
          ),
          for (final specialty in present) ...[
            SizedBox(width: context.s10),
            _Chip(
              label: '${specialty.label} (${counts[specialty]})',
              selected: selected == specialty,
              onTap: () => onSelect(specialty),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: selected ? scheme.primary : scheme.surface,
      borderRadius: BorderRadius.circular(context.adminChipRadius),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: context.s16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.adminChipRadius),
            border: selected ? null : Border.all(color: scheme.outline),
          ),
          child: Text(
            label,
            style: selected
                ? context.semiBold14White
                : context.medium14.copyWith(color: scheme.onSurface),
          ),
        ),
      ),
    );
  }
}
