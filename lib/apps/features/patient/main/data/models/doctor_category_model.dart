import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';

import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';

class DoctorCategory {
  DoctorCategory({
    required this.specialty,
    required this.label,
    required this.image,
    required this.colors,
  });

  final DoctorSpecialty specialty;
  final String label;
  final String image;
  final List<Color> colors;
}

List<DoctorCategory> get kDoctorCategories => [
  DoctorCategory(
    specialty: DoctorSpecialty.dentist,
    label: t.categoryDentist,
    image: AppAssets.categoryDentist,
    colors: [Color(0xFF4F5FE6), Color(0xFF7C6BF2)],
  ),
  DoctorCategory(
    specialty: DoctorSpecialty.cardiologist,
    label: t.categoryCardiologist,
    image: AppAssets.categoryCardio,
    colors: [Color(0xFF12C89A), Color(0xFF2ED9A6)],
  ),
  DoctorCategory(
    specialty: DoctorSpecialty.ophthalmologist,
    label: t.categoryOphthalmologist,
    image: AppAssets.categoryEye,
    colors: [Color(0xFFF97316), Color(0xFFFBC02D)],
  ),
  DoctorCategory(
    specialty: DoctorSpecialty.gastroenterologist,
    label: t.categoryGastroenterologist,
    image: AppAssets.categoryStomach,
    colors: [Color(0xFFF04A3E), Color(0xFFFA7A6E)],
  ),
];
