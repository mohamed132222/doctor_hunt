import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/themes/app_theme.dart';
import '../../data/models/doctor_category.dart';

/// The row of medical-category tiles (equal-width squares).
class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, this.onSelect});

  final ValueChanged<DoctorCategory>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(AppSize.s16)),
      child: Row(
        children: [
          for (var i = 0; i < kDoctorCategories.length; i++) ...[
            if (i > 0) SizedBox(width: context.w(AppSize.s8)),
            Expanded(
              child: _CategoryTile(
                category: kDoctorCategories[i],
                onTap: () => onSelect?.call(kDoctorCategories[i]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, this.onTap});

  final DoctorCategory category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(context.r(AppSize.r16));

    return Semantics(
      label: category.label,
      button: true,
      child: AspectRatio(
        aspectRatio: .8,
        // The shadow must live outside the Material: an Ink decoration is
        // clipped to the Material's bounds, so a boxShadow there never shows.
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [context.themeColors.tileShadow],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: radius,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: radius,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: category.colors,
                  ),
                ),
                child: Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.46,
                    heightFactor: 0.46,
                    child: Image.asset(
                      category.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
