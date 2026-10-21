import 'package:equatable/equatable.dart';

class AdminProfile extends Equatable {
  const AdminProfile({
    required this.name,
    required this.email,
    required this.clinicLocation,
    this.photo,
  });

  final String name;
  final String email;
  final String clinicLocation;

  final String? photo;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '';
    final first = parts.first[0];
    final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
    return (first + last).toUpperCase();
  }

  AdminProfile copyWith({String? name, String? clinicLocation, String? photo}) {
    return AdminProfile(
      name: name ?? this.name,
      email: email,
      clinicLocation: clinicLocation ?? this.clinicLocation,
      photo: photo ?? this.photo,
    );
  }

  @override
  List<Object?> get props => [name, email, clinicLocation, photo];
}
