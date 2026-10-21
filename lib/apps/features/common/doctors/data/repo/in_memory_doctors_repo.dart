import 'package:doctor_hunt/apps/core/error/failure.dart';
import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/repo/doctors_repo.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class InMemoryDoctorsRepo implements DoctorsRepo {
  InMemoryDoctorsRepo() {
    for (final doctor in _seed()) {
      _doctors[doctor.id] = doctor;
    }
  }

  final Map<String, Doctor> _doctors = <String, Doctor>{};

  int _nextId = 0;

  @override
  Future<Result<List<Doctor>>> fetchDoctors({
    String query = '',
    DoctorSpecialty? specialty,
    bool activeOnly = false,
    DoctorSort sort = DoctorSort.nameAsc,
    int? limit,
    int? offset,
  }) async {
    final needle = query.trim().toLowerCase();

    final matches = <Doctor>[
      for (final doctor in _doctors.values)
        if ((!activeOnly || doctor.isActive) &&
            (specialty == null || doctor.specialty == specialty) &&
            (needle.isEmpty || doctor.name.toLowerCase().contains(needle)))
          doctor,
    ];

    matches.sort(_comparatorFor(sort));
    return Success<List<Doctor>>(matches);
  }

  @override
  Future<Result<DoctorCounters>> fetchCounters() async {
    var active = 0;
    for (final doctor in _doctors.values) {
      if (doctor.isActive) active++;
    }
    return Success<DoctorCounters>(
      DoctorCounters(total: _doctors.length, active: active),
    );
  }

  @override
  Future<Result<Doctor>> doctorById(String id) async {
    final doctor = _doctors[id];
    if (doctor == null) return _notFound();
    return Success<Doctor>(doctor);
  }

  @override
  Future<Result<List<Doctor>>> doctorsByIds(List<String> ids) async {
    final wanted = ids.toSet();
    return Success<List<Doctor>>(<Doctor>[
      for (final doctor in _doctors.values)
        if (wanted.contains(doctor.id)) doctor,
    ]);
  }

  @override
  Future<Result<Doctor>> createDoctor({
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) async {
    final id = 'doctor-${_nextId++}';
    final doctor = Doctor(
      id: id,
      name: name.trim(),
      specialty: specialty,
      fee: fee,
      photo: photo,
      latitude: latitude,
      longitude: longitude,
      locationLabel: locationLabel,
      rating: rating ?? 0,
    );
    _doctors[id] = doctor;
    return Success<Doctor>(doctor);
  }

  @override
  Future<Result<Doctor>> updateDoctor({
    required String id,
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  }) {
    return _mutate(
      id,
      (doctor) => doctor.copyWith(
        name: name.trim(),
        specialty: specialty,
        fee: fee,
        photo: photo,
        latitude: latitude,
        longitude: longitude,
        locationLabel: locationLabel,
        rating: rating,
      ),
    );
  }

  @override
  Future<Result<Doctor>> setDoctorActive({
    required String id,
    required bool isActive,
  }) {
    return _mutate(id, (doctor) => doctor.copyWith(isActive: isActive));
  }

  @override
  Future<Result<Doctor>> updateAvailability({
    required String id,
    required DoctorAvailability availability,
  }) {
    return _mutate(id, (doctor) => doctor.copyWith(availability: availability));
  }

  @override
  Future<Result<void>> deleteDoctor(String id) async {
    if (_doctors.remove(id) == null) {
      return Error<void>(ServerFailure(t.doctorNotFound));
    }
    return const Success<void>(null);
  }

  Future<Result<Doctor>> _mutate(
    String id,
    Doctor Function(Doctor current) change,
  ) async {
    final current = _doctors[id];
    if (current == null) return _notFound();

    final updated = change(current);
    _doctors[id] = updated;
    return Success<Doctor>(updated);
  }

  Error<Doctor> _notFound() => Error<Doctor>(ServerFailure(t.doctorNotFound));

  static Comparator<Doctor> _comparatorFor(DoctorSort sort) {
    return switch (sort) {
      DoctorSort.popularity => (a, b) => b.reviewsCount.compareTo(
        a.reviewsCount,
      ),
      DoctorSort.rating => (a, b) => b.rating.compareTo(a.rating),
      DoctorSort.nameAsc => (a, b) => a.name.toLowerCase().compareTo(
        b.name.toLowerCase(),
      ),
    };
  }

  List<Doctor> _seed() {
    final seeds = <Doctor>[
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorFillerup,
        specialty: DoctorSpecialty.dentist,
        fee: 30,
        photo: AppAssets.popularDoctorImage,
        rating: 4.8,
        reviewsCount: 124,
      ),
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorAddison,
        specialty: DoctorSpecialty.cardiologist,
        fee: 28,
        photo: AppAssets.popularDoctorImage,
        rating: 4.6,
        reviewsCount: 98,
      ),
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorBennett,
        specialty: DoctorSpecialty.ophthalmologist,
        fee: 26,
        photo: AppAssets.featureDoctorImage,
        rating: 4.5,
        reviewsCount: 76,
      ),
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorShruti,
        specialty: DoctorSpecialty.dentist,
        fee: 24,
        photo: AppAssets.popularDoctorImage,
        rating: 4.9,
        reviewsCount: 143,
      ),
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorCrownover,
        specialty: DoctorSpecialty.gastroenterologist,
        fee: 19,
        photo: AppAssets.featureDoctorImage,
        rating: 4.4,
        reviewsCount: 52,
      ),
      Doctor(
        id: 'doctor-${_nextId++}',
        name: t.doctorWatamaniuk,
        specialty: DoctorSpecialty.cardiologist,
        fee: 21,
        photo: AppAssets.featureDoctorImage,
        rating: 4.2,
        reviewsCount: 31,
        isActive: false,
      ),
    ];

    return seeds;
  }
}
