import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/localization/app_locale_store.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/profile/presentation/controllers/current_profile/current_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/favorites/favorites_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/controllers/patient_settings/patient_settings_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/patient_setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientSettingsCubit>(
      create: (_) => getIt<PatientSettingsCubit>()..load(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: t.drawerLogoutConfirmTitle,
      message: t.drawerLogoutConfirmBody,
      confirmLabel: t.drawerLogout,
      danger: true,
    );
    if (!confirmed || !context.mounted) return;
    await getIt<AuthRepo>().logout();
    getIt<FavoritesCubit>().reset();
    getIt<CurrentProfileCubit>().reset();
    if (context.mounted) const ChooseRoleRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientIce, AppColors.gradientMint],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.s24),
          child:
              BlocSelector<
                PatientSettingsCubit,
                PatientSettingsState,
                (UserProfile?, bool)
              >(
                selector: (state) =>
                    (state.profile, state.notificationsEnabled),
                builder: (context, data) {
                  final profile = data.$1;
                  final notificationsEnabled = data.$2;
                  final name = (profile?.name.trim().isNotEmpty ?? false)
                      ? profile!.name
                      : t.patientFallbackName;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: context.s8),
                      Text(t.drawerSettings, style: context.bold28Black),
                      SizedBox(height: context.s20),
                      _ProfileCard(
                        name: name,
                        email: profile?.email ?? '',
                        photo: profile?.photo,
                        onTap: () async {
                          await const ProfileRoute().push<void>(context);
                          if (!context.mounted) return;
                          context.read<PatientSettingsCubit>().load();
                          await getIt<CurrentProfileCubit>().refresh();
                        },
                      ),
                      SizedBox(height: context.s24),
                      _SectionLabel(t.settingsAccountSection),
                      SizedBox(height: context.s8),
                      PatientSettingTile(
                        icon: Icons.lock_outline,
                        color: AppColors.danger,
                        title: t.settingsChangePassword,
                        onTap: () =>
                            const PatientChangePasswordRoute().push(context),
                      ),
                      const _RowDivider(),
                      PatientSettingTile(
                        icon: Icons.notifications_none,
                        color: AppColors.primary,
                        title: t.settingsNotifications,
                        trailing: Switch(
                          value: notificationsEnabled,
                          onChanged: context
                              .read<PatientSettingsCubit>()
                              .setNotifications,
                        ),
                      ),
                      const _RowDivider(),
                      PatientSettingTile(
                        icon: Icons.people_alt_outlined,
                        color: AppColors.warning,
                        title: t.settingsPrivacyPolicy,
                        onTap: () => const PrivacyPolicyRoute().push(context),
                      ),
                      SizedBox(height: context.s28),
                      _SectionLabel(t.settingsMoreSection),
                      SizedBox(height: context.s8),
                      _PlainRow(
                        title: t.settingsLanguages,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              context.isEnglish
                                  ? t.settingsLanguageEnglish
                                  : t.settingsLanguageArabic,
                              style: context.regular16TextSub,
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                        onTap: () => _showLanguageSheet(context),
                      ),
                      const _RowDivider(),
                      _PlainRow(
                        title: t.adminBuildVersion,
                        trailing: Text(
                          t.adminAppVersion,
                          style: context.regular16TextSub,
                        ),
                      ),
                      SizedBox(height: context.s28),
                      _LogoutButton(onTap: () => _confirmLogout(context)),
                      SizedBox(height: context.s24),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: sheetContext.s12),
            Text(t.settingsLanguageTitle, style: sheetContext.bold18Black),
            SizedBox(height: sheetContext.s8),
            ListTile(
              title: Text(t.settingsLanguageEnglish),
              trailing: sheetContext.isEnglish
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                Navigator.of(sheetContext).pop();
                AppLocaleStore.set(AppLocale.en);
              },
            ),
            ListTile(
              title: Text(t.settingsLanguageArabic),
              trailing: sheetContext.isArabic
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                Navigator.of(sheetContext).pop();
                AppLocaleStore.set(AppLocale.ar);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: context.bold18.copyWith(color: AppColors.textSub));
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: AppColors.textBorders);
  }
}

class _PlainRow extends StatelessWidget {
  const _PlainRow({required this.title, required this.trailing, this.onTap});
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: context.settingsRowHeight,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.medium18.copyWith(color: AppColors.textTitle),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.email,
    required this.onTap,
    this.photo,
  });

  final String name;
  final String email;
  final String? photo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final initials = name.trim().isEmpty ? 'U' : name.trim()[0].toUpperCase();
    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(context.r16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.s16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.r16),
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
                    Text(
                      name,
                      style: context.bold18Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.dangerLight,
      borderRadius: BorderRadius.circular(context.r12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
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
                t.drawerLogout,
                style: context.semiBold16.copyWith(color: AppColors.danger),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
