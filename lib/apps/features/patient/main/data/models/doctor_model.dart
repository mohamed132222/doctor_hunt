import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart'
    as catalog;
import 'package:doctor_hunt/apps/features/patient/main/data/catalog/patient_catalog.dart';

class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.pricePerHour,
    this.image,
    this.isFavorite = false,
    this.experienceYears = 0,
    this.satisfaction = 0,
    this.patientStories = 0,
    this.nextAvailable = '',
    this.latitude,
    this.longitude,
    this.locationLabel,
  });

  factory Doctor.fromCatalog(catalog.Doctor d) => Doctor(
    id: d.id,
    name: d.name,
    specialty: d.specialty.label,
    rating: d.rating,
    pricePerHour: d.fee,
    image: d.photo,
    satisfaction: (d.rating * 20).round(),
    patientStories: d.reviewsCount,
    latitude: d.latitude,
    longitude: d.longitude,
    locationLabel: d.locationLabel,
  );

  final String id;

  final String name;
  final String specialty;
  final double rating;
  final double pricePerHour;

  final String? image;

  final bool isFavorite;

  final int experienceYears;
  final int satisfaction;
  final int patientStories;

  final String nextAvailable;

  final double? latitude;
  final double? longitude;

  final String? locationLabel;

  bool get hasLocation => latitude != null && longitude != null;

  String get photoHeroTag => 'doctor-photo-$id';
}

PatientCatalog get _catalog => getIt<PatientCatalog>();

List<Doctor> get kPopularDoctors =>
    _catalog.popular().map(Doctor.fromCatalog).toList();

List<Doctor> get kFeatureDoctors =>
    _catalog.topRated().map(Doctor.fromCatalog).toList();

List<Doctor> get kSearchDoctors =>
    _catalog.all.map(Doctor.fromCatalog).toList();

List<Doctor> get kAllDoctors => kSearchDoctors;

List<Doctor> searchDoctors(String query) =>
    _catalog.search(query).map(Doctor.fromCatalog).toList();

Doctor? doctorById(String id) {
  final doctor = _catalog.byId(id);
  return doctor == null ? null : Doctor.fromCatalog(doctor);
}
