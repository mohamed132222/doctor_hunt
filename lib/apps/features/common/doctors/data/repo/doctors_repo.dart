import 'package:doctor_hunt/apps/core/result/result.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_availability_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:equatable/equatable.dart';

enum DoctorSort { nameAsc, popularity, rating }

class DoctorCounters extends Equatable {
  const DoctorCounters({required this.total, required this.active});

  final int total;
  final int active;

  int get inactive => total - active;

  @override
  List<Object?> get props => [total, active];
}

abstract interface class DoctorsRepo {
  Future<Result<List<Doctor>>> fetchDoctors({
    String query,
    DoctorSpecialty? specialty,
    bool activeOnly,
    DoctorSort sort,
    int? limit,
    int? offset,
  });

  Future<Result<DoctorCounters>> fetchCounters();

  Future<Result<Doctor>> doctorById(String id);

  Future<Result<List<Doctor>>> doctorsByIds(List<String> ids);

  Future<Result<Doctor>> createDoctor({
    required String name,
    required DoctorSpecialty specialty,
    required double fee,
    String? photo,
    double? latitude,
    double? longitude,
    String? locationLabel,
    double? rating,
  });

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
  });

  Future<Result<Doctor>> setDoctorActive({
    required String id,
    required bool isActive,
  });

  Future<Result<Doctor>> updateAvailability({
    required String id,
    required DoctorAvailability availability,
  });

  Future<Result<void>> deleteDoctor(String id);
}
