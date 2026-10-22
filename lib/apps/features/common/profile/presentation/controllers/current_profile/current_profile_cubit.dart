import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/repo/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentProfileCubit extends Cubit<UserProfile?> {
  CurrentProfileCubit(this._repo) : super(null);

  final ProfileRepo _repo;

  Future<void> load() async {
    final result = await _repo.fetchCurrent();
    if (isClosed) return;
    if (result case Success<UserProfile?>(data: final profile)) {
      emit(profile);
    }
  }

  Future<void> refresh() => load();

  void reset() => emit(null);
}
