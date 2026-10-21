import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

enum UserRole { patient, admin }

class RoleOption {
  RoleOption({
    required this.role,
    required this.icon,
    required this.title,
    required this.description,
  });

  final UserRole role;

  final String icon;
  final String title;
  final String description;
}

List<RoleOption> get kRoleOptions => [
  RoleOption(
    role: UserRole.patient,
    icon: AppAssets.patientIcon,
    title: t.rolePatient,
    description: t.rolePatientDescription,
  ),
  RoleOption(
    role: UserRole.admin,
    icon: AppAssets.adminIcon,
    title: t.roleAdmin,
    description: t.roleAdminDescription,
  ),
];
