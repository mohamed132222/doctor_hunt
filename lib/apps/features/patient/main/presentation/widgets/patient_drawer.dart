import 'drawer_header.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/confirm_dialog.dart';
import '../../../../common/auth/data/repo/auth_repo.dart';

class PatientDrawer extends StatelessWidget {
  const PatientDrawer({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _goBranch(BuildContext context, int branch) {
    navigationShell.goBranch(
      branch,
      initialLocation: branch == navigationShell.currentIndex,
    );
    ZoomDrawer.of(context)?.close();
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: t.drawerLogoutConfirmTitle,
      message: t.drawerLogoutConfirmBody,
      confirmLabel: t.drawerLogout,
      danger: true,
    );
    if (!confirmed || !context.mounted) return;
    await getIt<AuthRepo>().logout();
    if (context.mounted) const ChooseRoleRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = getIt<AuthRepo>().currentUser();
    final name = (user?.name.isNotEmpty ?? false) ? user!.name : t.rolePatient;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.s28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.s24),
              PatientDrawerHeader(name: name, email: user?.email ?? ''),
              SizedBox(height: context.s48),
              _DrawerItem(
                icon: Icons.person_outline,
                label: t.tabHome,
                onTap: () => _goBranch(context, 0),
              ),
              SizedBox(height: context.s32),
              _DrawerItem(
                icon: Icons.favorite_border,
                label: t.tabFavorites,
                onTap: () => _goBranch(context, 1),
              ),
              SizedBox(height: context.s32),
              _DrawerItem(
                icon: Icons.calendar_today_outlined,
                label: t.drawerAppointments,
                onTap: () => _goBranch(context, 2),
              ),
              SizedBox(height: context.s32),
              _DrawerItem(
                icon: Icons.settings_outlined,
                label: t.drawerSettings,
                onTap: () => _goBranch(context, 3),
              ),
              const Spacer(),
              _DrawerItem(
                icon: Icons.logout,
                label: t.drawerLogout,
                bold: true,
                showChevron: false,
                onTap: () => _logout(context),
              ),
              SizedBox(height: context.s24),
            ],
          ),
        ),
      ),
    );
  }
}

// String _initials(String name) {
//   final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
//   if (parts.isEmpty) return '';
//   if (parts.length == 1) return parts.first.characters.first.toUpperCase();
//   return (parts.first.characters.first + parts.last.characters.first)
//       .toUpperCase();
// }

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.bold = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool bold;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: AppColors.white,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
    );
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.r12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.s8),
        child: Row(
          children: [
            Icon(icon, color: AppColors.white, size: context.drawerIcon),
            SizedBox(width: context.s20),
            Expanded(
              child: Text(
                label,
                style: style,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showChevron)
              Icon(
                Icons.chevron_right,
                color: AppColors.white,
                size: context.drawerChevron,
              ),
          ],
        ),
      ),
    );
  }
}
