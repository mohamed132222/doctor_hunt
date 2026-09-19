import 'package:latlong2/latlong.dart';

import '../../../../../core/constants/app_strings.dart';

/// A single figure in the doctor's stats row.
class DoctorStat {
  const DoctorStat({required this.value, required this.label});

  final String value;
  final String label;
}

/// One numbered entry in the doctor's services list.
class ServicePoint {
  const ServicePoint({required this.text});

  final String text;
}

/// Stats shown under the doctor's summary card.
const List<DoctorStat> kDoctorStats = [
  DoctorStat(value: AppStrings.statRunningValue, label: AppStrings.statRunning),
  DoctorStat(value: AppStrings.statOngoingValue, label: AppStrings.statOngoing),
  DoctorStat(value: AppStrings.statPatientValue, label: AppStrings.statPatient),
];

/// Numbered points rendered in the Services section.
const List<ServicePoint> kServicePoints = [
  ServicePoint(text: AppStrings.servicePoint1),
  ServicePoint(text: AppStrings.servicePoint2),
  ServicePoint(text: AppStrings.servicePoint3),
];

/// Where these doctors practise (Kenyatta National Hospital, Nairobi) and a
/// demo "you are here" point — the details map fits its camera to both.
const LatLng kClinicLocation = LatLng(-1.3013, 36.8073);
const LatLng kUserLocation = LatLng(-1.2670, 36.8030);
