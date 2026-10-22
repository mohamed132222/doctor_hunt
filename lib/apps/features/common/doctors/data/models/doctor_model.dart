import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.fee,
    this.photo,
    this.rating = 0,
    this.reviewsCount = 0,
    this.isActive = true,
    this.availability = DoctorAvailability.standard,
    this.latitude,
    this.longitude,
    this.locationLabel,
  });

  final String id;
  final String name;
  final DoctorSpecialty specialty;

  final double fee;

  final String? photo;

  final double rating;

  final int reviewsCount;

  final bool isActive;

  final DoctorAvailability availability;

  final double? latitude;
  final double? longitude;

  final String? locationLabel;

  bool get hasLocation => latitude != null && longitude != null;

  bool get isBookable => isActive && availability.isBookable;

  String get photoHeroTag => 'doctor-photo-$id';

  Doctor copyWith({
    String? name,
    DoctorSpecialty? specialty,
    double? fee,
    String? photo,
    double? rating,
    int? reviewsCount,
    bool? isActive,
    DoctorAvailability? availability,
    double? latitude,
    double? longitude,
    String? locationLabel,
  }) {
    return Doctor(
      id: id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      fee: fee ?? this.fee,
      photo: photo ?? this.photo,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isActive: isActive ?? this.isActive,
      availability: availability ?? this.availability,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationLabel: locationLabel ?? this.locationLabel,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    specialty,
    fee,
    photo,
    rating,
    reviewsCount,
    isActive,
    availability,
    latitude,
    longitude,
    locationLabel,
  ];
}
