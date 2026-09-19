import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:latlong2/latlong.dart';

/// A single figure in the doctor's stats row.
class DoctorStat {
  DoctorStat({required this.value, required this.label});

  final String value;
  final String label;
}

/// One numbered entry in the doctor's services list.
class ServicePoint {
  ServicePoint({required this.text});

  final String text;
}

/// Stats shown under the doctor's summary card.
List<DoctorStat> kDoctorStats = [
  DoctorStat(value: t.statRunningValue, label: t.statRunning),
  DoctorStat(value: t.statOngoingValue, label: t.statOngoing),
  DoctorStat(value: t.statPatientValue, label: t.statPatient),
];

/// Numbered points rendered in the Services section.
List<ServicePoint> kServicePoints = [
  ServicePoint(text: t.servicePoint1),
  ServicePoint(text: t.servicePoint2),
  ServicePoint(text: t.servicePoint3),
];

/// Where these doctors practise (Kenyatta National Hospital, Nairobi) and a
/// demo "you are here" point — the details map fits its camera to both.
const LatLng kClinicLocation = LatLng(-1.3013, 36.8073);
const LatLng kUserLocation = LatLng(-1.2670, 36.8030);
