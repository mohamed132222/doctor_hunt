import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/admin_profile_repo.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';

class PatientCatalog {
  PatientCatalog(this._doctors, this._adminProfile);

  final DoctorsRepo _doctors;
  final AdminProfileRepo _adminProfile;

  List<Doctor> _active = const <Doctor>[];
  String _clinicLocation = '';
  bool _loaded = false;

  bool get isLoaded => _loaded;
  List<Doctor> get all => _active;
  String get clinicLocation => _clinicLocation;

  Future<void> ensureLoaded({bool force = false}) async {
    if (_loaded && !force) return;

    try {
      final doctors = await _doctors
          .fetchDoctors(activeOnly: true, sort: DoctorSort.nameAsc)
          .timeout(const Duration(seconds: 15));
      if (doctors is Success<List<Doctor>>) _active = doctors.data;
    } catch (_) {}

    try {
      final profile = await _adminProfile.fetch().timeout(
        const Duration(seconds: 15),
      );
      if (profile is Success<AdminProfile>) {
        _clinicLocation = profile.data.clinicLocation;
      }
    } catch (_) {
    } finally {
      _loaded = true;
    }
  }

  Doctor? byId(String id) {
    for (final doctor in _active) {
      if (doctor.id == id) return doctor;
    }
    return null;
  }

  List<Doctor> popular() =>
      [..._active]..sort((a, b) => b.reviewsCount.compareTo(a.reviewsCount));

  List<Doctor> topRated() =>
      [..._active]..sort((a, b) => b.rating.compareTo(a.rating));

  List<Doctor> search(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return all;
    return <Doctor>[
      for (final doctor in _active)
        if (doctor.name.toLowerCase().contains(needle) ||
            doctor.specialty.label.toLowerCase().contains(needle))
          doctor,
    ];
  }
}
