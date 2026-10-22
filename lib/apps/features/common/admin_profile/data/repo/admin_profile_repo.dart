import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';

abstract interface class AdminProfileRepo {
  Future<Result<AdminProfile>> fetch();

  Future<Result<AdminProfile>> update({
    required String name,
    required String clinicLocation,
    String? photo,
  });
}
