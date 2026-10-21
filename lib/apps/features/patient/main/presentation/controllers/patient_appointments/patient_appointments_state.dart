part of 'patient_appointments_cubit.dart';

class PatientAppointmentsState extends Equatable {
  const PatientAppointmentsState({
    this.status = AppStatus.initial,
    this.appointments = const <Appointment>[],
    this.tabIndex = 0,
    this.error,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final AppStatus status;
  final List<Appointment> appointments;
  final int tabIndex;
  final String? error;
  final bool hasMore;
  final bool isLoadingMore;

  bool get isLoading => status == AppStatus.loading;

  PatientAppointmentsState copyWith({
    AppStatus? status,
    List<Appointment>? appointments,
    int? tabIndex,
    String? error,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return PatientAppointmentsState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      tabIndex: tabIndex ?? this.tabIndex,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    appointments,
    tabIndex,
    error,
    hasMore,
    isLoadingMore,
  ];
}
