part of 'specialty_doctors_cubit.dart';

class SpecialtyDoctorsState extends Equatable {
  const SpecialtyDoctorsState({
    this.status = AppStatus.initial,
    this.doctors = const <Doctor>[],
    this.error,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final AppStatus status;
  final List<Doctor> doctors;
  final String? error;
  final bool hasMore;
  final bool isLoadingMore;

  SpecialtyDoctorsState copyWith({
    AppStatus? status,
    List<Doctor>? doctors,
    String? error,
    bool? hasMore,
    bool? isLoadingMore,
    bool clearError = false,
  }) {
    return SpecialtyDoctorsState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      error: clearError ? null : (error ?? this.error),
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [status, doctors, error, hasMore, isLoadingMore];
}
