part of 'appointments_list_cubit.dart';

class AppointmentsListState extends Equatable {
  const AppointmentsListState({
    this.status = AppStatus.initial,
    this.appointments = const <Appointment>[],
    this.tabIndex = 0,
    this.error,
  });

  final AppStatus status;
  final List<Appointment> appointments;
  final int tabIndex;
  final String? error;

  bool get isLoading => status == AppStatus.loading;

  AppointmentsListState copyWith({
    AppStatus? status,
    List<Appointment>? appointments,
    int? tabIndex,
    String? error,
  }) {
    return AppointmentsListState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      tabIndex: tabIndex ?? this.tabIndex,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, appointments, tabIndex, error];
}
