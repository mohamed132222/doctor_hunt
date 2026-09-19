import 'package:doctor_hunt/apps/features/patient/main/data/models/doctor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Each home row renders a Hero per card, tagged by the doctor's id. Two cards
  // with the same id in one row crash the hero system on navigation, so the ids
  // have to be unique — guard that here rather than discovering it at runtime.
  group('doctor data', () {
    test('ids are unique within each home row', () {
      for (final row in [kPopularDoctors, kFeatureDoctors]) {
        final ids = row.map((doctor) => doctor.id).toList();
        expect(
          ids.toSet().length,
          ids.length,
          reason: 'duplicate doctor id in a row would break Hero tags: $ids',
        );
      }
    });

    test('hero tags are unique across everything rendered at once', () {
      final tags = kAllDoctors.map((doctor) => doctor.photoHeroTag).toList();
      expect(tags.toSet().length, tags.length);
    });

    test('every doctor id resolves back to its doctor', () {
      for (final doctor in kAllDoctors) {
        expect(doctorById(doctor.id)?.name, doctor.name);
      }
      expect(doctorById('does-not-exist'), isNull);
    });
  });
}
