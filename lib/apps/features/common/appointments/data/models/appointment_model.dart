import 'package:doctor_hunt/apps/features/common/appointments/data/models/appointment_status.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.patientName,
    required this.patientEmail,
    required this.dateTime,
    required this.fee,
    required this.status,
    this.doctorPhoto,
    this.patientPhoto,
    this.rating,
    this.reviewComment,
  });

  final String id;
  final String doctorId;

  final String doctorName;
  final DoctorSpecialty specialty;
  final String? doctorPhoto;

  final String patientName;
  final String patientEmail;
  final String? patientPhoto;

  final DateTime dateTime;
  final double fee;
  final AppointmentStatus status;

  final double? rating;
  final String? reviewComment;

  bool get hasReview => rating != null;

  Appointment copyWith({
    AppointmentStatus? status,
    double? rating,
    String? reviewComment,
  }) {
    return Appointment(
      id: id,
      doctorId: doctorId,
      doctorName: doctorName,
      specialty: specialty,
      doctorPhoto: doctorPhoto,
      patientName: patientName,
      patientEmail: patientEmail,
      patientPhoto: patientPhoto,
      dateTime: dateTime,
      fee: fee,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      reviewComment: reviewComment ?? this.reviewComment,
    );
  }

  @override
  List<Object?> get props => [
    id,
    doctorId,
    doctorName,
    specialty,
    doctorPhoto,
    patientName,
    patientEmail,
    patientPhoto,
    dateTime,
    fee,
    status,
    rating,
    reviewComment,
  ];
}
