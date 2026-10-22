import 'package:doctor_hunt/generated/strings.g.dart';

enum AppointmentStatus {
  upcoming,
  completed,
  cancelled;

  String get label => switch (this) {
    AppointmentStatus.upcoming => t.adminStatusUpcoming,
    AppointmentStatus.completed => t.adminStatusCompleted,
    AppointmentStatus.cancelled => t.adminStatusCancelled,
  };

  String get wireValue => name;

  static AppointmentStatus fromWire(String? value) {
    for (final status in AppointmentStatus.values) {
      if (status.wireValue == value) return status;
    }
    return AppointmentStatus.upcoming;
  }
}
