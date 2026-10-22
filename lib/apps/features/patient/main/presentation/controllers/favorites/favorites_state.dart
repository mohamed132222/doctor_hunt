part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.status = AppStatus.initial,
    this.ids = const <String>{},
    this.error,
  });

  final AppStatus status;
  final Set<String> ids;
  final String? error;

  bool get isLoading => status == AppStatus.loading;

  FavoritesState copyWith({
    AppStatus? status,
    Set<String>? ids,
    String? error,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      ids: ids ?? this.ids,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, ids, error];
}
