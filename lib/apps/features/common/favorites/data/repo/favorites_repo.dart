import 'package:doctor_hunt/apps/core/result/result.dart';

abstract interface class FavoritesRepo {
  Future<Result<Set<String>>> fetchFavoriteIds();

  Future<Result<void>> add(String doctorId);

  Future<Result<void>> remove(String doctorId);
}
