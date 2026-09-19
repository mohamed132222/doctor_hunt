import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../data/models/role.dart';
import '../widgets/role_card.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  UserRole _selected = UserRole.patient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.s24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: context.s32),
                          Image.asset(
                            AppAssets.splashLogo,
                            width: context.chooseRoleCardWidth,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                          SizedBox(height: context.s16),
                          Text(t.appName, style: context.textStyles.wordmark),
                          SizedBox(height: context.s48),
                          Text(
                            t.chooseRoleTitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium,
                          ),
                          SizedBox(height: context.s8),
                          Text(
                            t.chooseRoleSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: context.s32),
                          ...kRoleOptions.map(
                            (option) => Padding(
                              padding: EdgeInsets.only(bottom: context.s16),
                              child: RoleCard(
                                option: option,
                                selected: _selected == option.role,
                                onTap: () =>
                                    setState(() => _selected = option.role),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.s24,
                          bottom: context.s24,
                        ),
                        child: PrimaryButton(
                          label: t.continueLabel,
                          onPressed: () => context.go(RoutePath.login),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
