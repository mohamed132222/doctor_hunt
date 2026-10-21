import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';

abstract interface class ProfileRepo {
  Future<Result<UserProfile?>> fetchCurrent();

  Future<Result<UserProfile>> update({
    String? name,
    String? phone,
    String? photo,
  });
}
