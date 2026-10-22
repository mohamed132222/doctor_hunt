import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/repo/admin_profile_repo.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class InMemoryAdminProfileRepo implements AdminProfileRepo {
  AdminProfile _profile = AdminProfile(
    name: t.seedAdminName,
    email: t.seedAdminEmail,
    clinicLocation: t.seedClinicLocation,
  );

  @override
  Future<Result<AdminProfile>> fetch() async => Success<AdminProfile>(_profile);

  @override
  Future<Result<AdminProfile>> update({
    required String name,
    required String clinicLocation,
    String? photo,
  }) async {
    _profile = _profile.copyWith(
      name: name.trim(),
      clinicLocation: clinicLocation.trim(),
      photo: photo,
    );
    return Success<AdminProfile>(_profile);
  }
}
