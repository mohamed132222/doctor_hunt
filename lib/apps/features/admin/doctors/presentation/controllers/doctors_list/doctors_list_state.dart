part of 'doctors_list_cubit.dart';

class DoctorsListState extends Equatable {
  const DoctorsListState({
    this.status = AppStatus.initial,
    this.doctors = const <Doctor>[],
    this.counters,
    this.query = '',
    this.specialty,
    this.specialtyCounts = const <DoctorSpecialty, int>{},
    this.error,
  });

  final AppStatus status;
  final List<Doctor> doctors;
  final DoctorCounters? counters;
  final String query;
  final DoctorSpecialty? specialty;
  final Map<DoctorSpecialty, int> specialtyCounts;
  final String? error;

  bool get isLoading => status == AppStatus.loading;

  DoctorsListState copyWith({
    AppStatus? status,
    List<Doctor>? doctors,
    DoctorCounters? counters,
    String? query,
    DoctorSpecialty? specialty,
    bool resetSpecialty = false,
    Map<DoctorSpecialty, int>? specialtyCounts,
    String? error,
  }) {
    return DoctorsListState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      counters: counters ?? this.counters,
      query: query ?? this.query,
      specialty: resetSpecialty ? null : (specialty ?? this.specialty),
      specialtyCounts: specialtyCounts ?? this.specialtyCounts,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    doctors,
    counters,
    query,
    specialty,
    specialtyCounts,
    error,
  ];
}
