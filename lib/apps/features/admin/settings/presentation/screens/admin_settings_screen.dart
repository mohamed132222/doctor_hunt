import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/widgets/settings_tile.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/widgets/admin_profile_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminProfileScope(child: const _SettingsView());
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: context.adminScreenPaddingH),
        child:
            BlocSelector<AdminProfileCubit, AdminProfileState, AdminProfile?>(
              selector: (state) => state.profile,
              builder: (context, profile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: context.s8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            t.adminSettingsTitle,
                            style: context.bold28Black,
                          ),
                        ),
                        PhotoAvatar(
                          size: context.adminHeaderAvatar,
                          imagePath: profile?.photo,
                          initials: profile?.initials ?? 'A',
                        ),
                      ],
                    ),
                    SizedBox(height: context.s20),
                    _ProfileCard(
                      email: profile?.email ?? '',
                      photo: profile?.photo,
                      initials: profile?.initials ?? 'A',
                    ),
                    SizedBox(height: context.s20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: context.s16),
                      decoration: BoxDecoration(
                        color: scheme.surface,
                        borderRadius: BorderRadius.circular(
                          context.adminCardRadius,
                        ),
                        boxShadow: [context.themeColors.cardShadow],
                      ),
                      child: Column(
                        children: [
                          SettingsTile(
                            icon: Icons.manage_accounts_outlined,
                            title: t.adminProfileTitle,
                            subtitle: t.adminProfileSubtitle,
                            onTap: () async {
                              await const AdminProfileEditRoute().push<void>(
                                context,
                              );
                              if (context.mounted) {
                                context.read<AdminProfileCubit>().load();
                              }
                            },
                          ),
                          Divider(height: 1, color: scheme.outline),
                          SettingsTile(
                            icon: Icons.lock_reset_outlined,
                            title: t.adminChangePassword,
                            subtitle: t.adminChangePasswordSubtitle,
                            onTap: () => const AdminChangePasswordRoute()
                                .push<void>(context),
                          ),
                          Divider(height: 1, color: scheme.outline),
                          SettingsTile(
                            icon: Icons.info_outline,
                            title: t.adminAppInfo,
                            subtitle: t.adminBuildVersion,
                            trailing: Text(
                              t.adminAppVersion,
                              style: context.regular14TextSub,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.s24),
                    const _LogoutButton(),
                    SizedBox(height: context.s24),
                  ],
                );
              },
            ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.email, required this.initials, this.photo});

  final String email;
  final String initials;
  final String? photo;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Row(
        children: [
          PhotoAvatar(
            size: context.homeAvatarSize,
            imagePath: photo,
            initials: initials,
          ),
          SizedBox(width: context.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.adminAdministrator, style: context.bold18Black),
                SizedBox(height: context.s2),
                Text(
                  email,
                  style: context.regular14TextSub,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.dangerLight,
      borderRadius: BorderRadius.circular(context.r12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final confirmed = await showConfirmDialog(
            context,
            title: t.adminLogoutConfirmTitle,
            message: t.adminLogoutConfirmBody,
            confirmLabel: t.adminLogout,
            danger: true,
          );
          if (!confirmed || !context.mounted) return;
          await getIt<AuthRepo>().logout();
          if (context.mounted) const ChooseRoleRoute().go(context);
        },
        child: Container(
          height: context.confirmHeight,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.logout,
                color: AppColors.danger,
                size: context.iconSmall,
              ),
              SizedBox(width: context.s8),
              Text(
                t.adminLogout,
                style: context.semiBold16.copyWith(color: AppColors.danger),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
