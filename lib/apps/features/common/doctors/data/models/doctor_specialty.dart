import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

enum DoctorSpecialty {
  dentist,
  cardiologist,
  ophthalmologist,
  gastroenterologist;

  String get label => switch (this) {
    DoctorSpecialty.dentist => t.categoryDentist,
    DoctorSpecialty.cardiologist => t.categoryCardiologist,
    DoctorSpecialty.ophthalmologist => t.categoryOphthalmologist,
    DoctorSpecialty.gastroenterologist => t.categoryGastroenterologist,
  };

  String get glyph => switch (this) {
    DoctorSpecialty.dentist => AppAssets.categoryDentist,
    DoctorSpecialty.cardiologist => AppAssets.categoryCardio,
    DoctorSpecialty.ophthalmologist => AppAssets.categoryEye,
    DoctorSpecialty.gastroenterologist => AppAssets.categoryStomach,
  };

  String get wireValue => name;

  static DoctorSpecialty? fromWire(String? value) {
    if (value == null) return null;
    for (final specialty in DoctorSpecialty.values) {
      if (specialty.wireValue == value) return specialty;
    }
    return null;
  }
}
