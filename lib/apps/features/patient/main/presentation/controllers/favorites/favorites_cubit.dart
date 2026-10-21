import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/favorites/data/repo/favorites_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._favorites) : super(const FavoritesState());

  final FavoritesRepo _favorites;
  bool _loaded = false;

  bool isFavorite(String doctorId) => state.ids.contains(doctorId);

  Future<void> ensureLoaded() async {
    if (_loaded) return;
    await load();
  }

  Future<void> load() async {
    emit(state.copyWith(status: AppStatus.loading));
    switch (await _favorites.fetchFavoriteIds()) {
      case Success<Set<String>>(data: final ids):
        _loaded = true;
        emit(state.copyWith(status: AppStatus.success, ids: ids));
      case Error<Set<String>>(failure: final failure):
        emit(state.copyWith(status: AppStatus.error, error: failure.message));
    }
  }

  Future<void> toggle(String doctorId) async {
    final wasFavorite = state.ids.contains(doctorId);
    final previous = state.ids;

    final next = Set<String>.from(previous);
    if (wasFavorite) {
      next.remove(doctorId);
    } else {
      next.add(doctorId);
    }
    emit(state.copyWith(ids: next));

    final result = wasFavorite
        ? await _favorites.remove(doctorId)
        : await _favorites.add(doctorId);
    if (result is Error<void>) {
      emit(state.copyWith(ids: previous, error: result.failure.message));
    }
  }

  void reset() {
    _loaded = false;
    emit(const FavoritesState());
  }
}
