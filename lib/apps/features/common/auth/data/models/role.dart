import '../../../../../core/constants/app_strings.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

/// The account roles the app supports.
enum UserRole { patient, admin }

/// Presentational data for a role card.
class RoleOption {
  const RoleOption({
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

const List<RoleOption> kRoleOptions = [
  RoleOption(
    role: UserRole.patient,
    icon: AppAssets.patientIcon,
    title: AppStrings.rolePatient,
    description: AppStrings.rolePatientDescription,
  ),
  RoleOption(
    role: UserRole.admin,
    icon: AppAssets.adminIcon,
    title: AppStrings.roleAdmin,
    description: AppStrings.roleAdminDescription,
  ),
];
