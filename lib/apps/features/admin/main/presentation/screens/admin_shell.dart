import 'package:doctor_hunt/apps/features/admin/settings/presentation/widgets/admin_profile_scope.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/themes/app_colors.dart';
import '../widgets/admin_bottom_nav.dart';

class AdminShell extends StatelessWidget {
  const AdminShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return AdminProfileScope(
      child: Scaffold(
        backgroundColor: AppColors.adminSurface,
        body: navigationShell,
        bottomNavigationBar: AdminBottomNav(
          currentIndex: navigationShell.currentIndex,
          onSelect: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
        ),
      ),
    );
  }
}
