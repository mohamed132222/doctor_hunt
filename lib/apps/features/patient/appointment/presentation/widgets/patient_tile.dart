import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';

/// One selectable patient in the "Who is this patient?" row.
///
/// Either the "Add" affordance (a tinted tile with a plus) or a patient photo
/// with a caption underneath.
class PatientTile extends StatelessWidget {
  const PatientTile({
    super.key,
    required this.label,
    this.image,
    this.isAdd = false,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final String? image;
  final bool isAdd;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = context.patientTileWidth;
    final height = context.patientTileHeight;

    return Semantics(
      label: label,
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Material(
                color: isAdd ? scheme.primaryContainer : scheme.surface,
                borderRadius: BorderRadius.circular(context.patientTileRadius),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        context.patientTileRadius,
                      ),
                      border: Border.all(
                        color: selected
                            ? scheme.primary
                            : scheme.outlineVariant.withValues(alpha: 0.4),
                        width: selected
                            ? AppSize.borderFocus
                            : AppSize.borderThin,
                      ),
                    ),
                    child: isAdd ? _AddContent() : _PhotoContent(image: image),
                  ),
                ),
              ),
            ),
            if (!isAdd) ...[
              SizedBox(height: context.s6),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: AppSize.s12,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AddContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.add_rounded, size: context.s32, color: scheme.primary),
        SizedBox(height: context.s2),
        Text(
          t.addPatient,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: AppSize.s12,
            fontWeight: FontWeight.w600,
            color: scheme.primary,
          ),
        ),
      ],
    );
  }
}

class _PhotoContent extends StatelessWidget {
  const _PhotoContent({this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final path = image;

    if (path == null) {
      return Center(
        child: Icon(
          Icons.person_rounded,
          size: context.s28,
          color: scheme.onSurfaceVariant,
        ),
      );
    }

    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Center(
        child: Icon(
          Icons.person_rounded,
          size: context.s28,
          color: scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
