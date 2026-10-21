import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:latlong2/latlong.dart';

import '../../../main/data/models/doctor_model.dart';

class DoctorStat {
  DoctorStat({required this.value, required this.label});

  final String value;
  final String label;
}

class ServicePoint {
  ServicePoint({required this.text});

  final String text;
}

List<DoctorStat> doctorStats(Doctor doctor) => [
  DoctorStat(value: doctor.rating.toStringAsFixed(1), label: t.statRating),
  DoctorStat(value: '${doctor.patientStories}', label: t.statReviews),
  DoctorStat(
    value: t.satisfactionPercent(percent: doctor.satisfaction),
    label: t.statSatisfaction,
  ),
];

List<ServicePoint> get kServicePoints => [
  ServicePoint(text: t.servicePoint1),
  ServicePoint(text: t.servicePoint2),
  ServicePoint(text: t.servicePoint3),
];

const LatLng kClinicLocation = LatLng(-1.3013, 36.8073);
const LatLng kUserLocation = LatLng(-1.2670, 36.8030);
