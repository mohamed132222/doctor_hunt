import 'package:flutter/material.dart';

import '../../../../../generated/image_assets.dart';
import '../../../../core/constants/app_strings.dart';

/// A medical category tile on the home screen.
///
/// [image] is the white glyph asset; [colors] is the tile's brand gradient
/// (content palette, not a theme token).
class DoctorCategory {
  const DoctorCategory({
    required this.label,
    required this.image,
    required this.colors,
  });

  final String label;
  final String image;
  final List<Color> colors;
}

const List<DoctorCategory> kDoctorCategories = [
  DoctorCategory(
    label: AppStrings.categoryDentist,
    image: AppAssets.categoryDentist,
    colors: [Color(0xFF4F5FE6), Color(0xFF7C6BF2)],
  ),
  DoctorCategory(
    label: AppStrings.categoryCardiologist,
    image: AppAssets.categoryCardio,
    colors: [Color(0xFF12C89A), Color(0xFF2ED9A6)],
  ),
  DoctorCategory(
    label: AppStrings.categoryOphthalmologist,
    image: AppAssets.categoryEye,
    colors: [Color(0xFFF97316), Color(0xFFFBC02D)],
  ),
  DoctorCategory(
    label: AppStrings.categoryGastroenterologist,
    image: AppAssets.categoryStomach,
    colors: [Color(0xFFF04A3E), Color(0xFFFA7A6E)],
  ),
];
