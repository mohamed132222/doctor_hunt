import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

/// The account roles the app supports.
enum UserRole { patient, admin }

/// Presentational data for a role card.
class RoleOption {
  RoleOption({
    required this.role,
    required this.icon,
    required this.title,
    required this.description,
  });

  final UserRole role;

  /// SVG asset path (e.g. [AppAssets.patientIcon]).
  final String icon;
  final String title;
  final String description;
}

List<RoleOption> kRoleOptions = [
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
