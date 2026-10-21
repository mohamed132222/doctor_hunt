import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.photo,
  });

  final String id;
  final String name;
  final String email;

  final String role;

  final String? phone;

  final String? photo;

  bool get isAdmin => role == 'admin';

  factory UserProfile.fromRow(Map<String, dynamic> row) => UserProfile(
    id: row['id'] as String,
    name: row['name'] as String? ?? '',
    email: row['email'] as String? ?? '',
    role: row['role'] as String? ?? 'patient',
    phone: row['phone'] as String?,
    photo: row['photo'] as String?,
  );

  @override
  List<Object?> get props => [id, name, email, role, phone, photo];
}
