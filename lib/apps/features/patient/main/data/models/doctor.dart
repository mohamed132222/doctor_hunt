import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

/// A doctor shown on the home screen.
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
  });

  /// Stable slug used for routing (e.g. `/doctor/crick`).
  final String id;

  final String name;
  final String specialty;
  final double rating;
  final double pricePerHour;

  /// Optional photo asset; falls back to an avatar placeholder when null.
  final String? image;

  /// Initial favourite state (the design shows one filled heart).
  final bool isFavorite;

  /// Search-result details. Defaults keep the home cards unchanged.
  final int experienceYears;
  final int satisfaction;
  final int patientStories;

  /// Human label for the soonest free slot, e.g. `"10:00 AM tomorrow"`.
  final String nextAvailable;

  /// Hero tag shared by the home cards and the details page, so the doctor's
  /// photo flies between them.
  String get photoHeroTag => 'doctor-photo-$id';
}

List<Doctor> kPopularDoctors = [
  Doctor(
    id: 'fillerup',
    name: t.doctorFillerup,
    specialty: t.specialistFallback,
    rating: 4.8,
    pricePerHour: 30,
    image: AppAssets.popularDoctorImage,
  ),
  Doctor(
    id: 'addison',
    name: t.doctorAddison,
    specialty: t.specialistFallback,
    rating: 4.6,
    pricePerHour: 28,
    image: AppAssets.popularDoctorImage,
  ),
  Doctor(
    id: 'bennett',
    name: t.doctorBennett,
    specialty: t.specialistFallback,
    rating: 4.5,
    pricePerHour: 26,
    image: AppAssets.popularDoctorImage,
  ),
];

List<Doctor> kFeatureDoctors = [
  Doctor(
    id: 'crick',
    name: t.doctorCrick,
    specialty: t.specialistFallback,
    rating: 3.7,
    pricePerHour: 25,
    image: AppAssets.featureDoctorImage,
    nextAvailable: '10:00 AM tomorrow',
  ),
  Doctor(
    id: 'strain',
    name: t.doctorStrain,
    specialty: t.specialistFallback,
    rating: 3.0,
    pricePerHour: 22,
    image: AppAssets.featureDoctorImage,
    isFavorite: true,
  ),
  Doctor(
    id: 'lachinet',
    name: t.doctorLachinet,
    specialty: t.specialistFallback,
    rating: 2.9,
    pricePerHour: 29,
    image: AppAssets.featureDoctorImage,
  ),
  Doctor(
    id: 'lachinet-2',
    name: t.doctorLachinet,
    specialty: t.specialistFallback,
    rating: 2.9,
    pricePerHour: 29,
    image: AppAssets.featureDoctorImage,
  ),
  Doctor(
    id: 'lachinet-3',
    name: t.doctorLachinet,
    specialty: t.specialistFallback,
    rating: 2.9,
    pricePerHour: 29,
    image: AppAssets.featureDoctorImage,
  ),
];

/// Extra doctors surfaced by search. Mock data until the REST API exists —
/// swap this list for a repository call and nothing else changes.
List<Doctor> kSearchDoctors = [
  Doctor(
    id: 'shruti',
    name: t.doctorShruti,
    specialty: t.specialtyDentist,
    rating: 4.9,
    pricePerHour: 24,
    image: AppAssets.popularDoctorImage,
    isFavorite: true,
    experienceYears: 7,
    satisfaction: 87,
    patientStories: 69,
    nextAvailable: '10:00 AM tomorrow',
  ),
  Doctor(
    id: 'watamaniuk',
    name: t.doctorWatamaniuk,
    specialty: t.specialtyDentist,
    rating: 4.6,
    pricePerHour: 21,
    image: AppAssets.featureDoctorImage,
    experienceYears: 9,
    satisfaction: 74,
    patientStories: 78,
    nextAvailable: '12:00 AM tomorrow',
  ),
  Doctor(
    id: 'crownover',
    name: t.doctorCrownover,
    specialty: t.specialtyDentist,
    rating: 4.4,
    pricePerHour: 19,
    image: AppAssets.featureDoctorImage,
    isFavorite: true,
    experienceYears: 5,
    satisfaction: 59,
    patientStories: 86,
    nextAvailable: '11:00 AM tomorrow',
  ),
  Doctor(
    id: 'balestra',
    name: t.doctorBalestra,
    specialty: t.specialtyDentist,
    rating: 4.2,
    pricePerHour: 23,
    image: AppAssets.popularDoctorImage,
    experienceYears: 6,
    satisfaction: 71,
    patientStories: 16,
    nextAvailable: '9:30 AM tomorrow',
  ),
];

/// All doctors in one place, so routes can resolve an id and search can filter.
List<Doctor> kAllDoctors = [
  ...kPopularDoctors,
  ...kFeatureDoctors,
  ...kSearchDoctors,
];

/// Case-insensitive match on the doctor's name or specialty.
///
/// Mock implementation — the REST-backed repository will replace this and the
/// screen won't need to change.
List<Doctor> searchDoctors(String query) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) return kAllDoctors;
  return [
    for (final doctor in kAllDoctors)
      if (doctor.name.toLowerCase().contains(needle) ||
          doctor.specialty.toLowerCase().contains(needle))
        doctor,
  ];
}

/// Resolves a doctor by [id], or null when the slug is unknown.
Doctor? doctorById(String id) {
  for (final doctor in kAllDoctors) {
    if (doctor.id == id) return doctor;
  }
  return null;
}
