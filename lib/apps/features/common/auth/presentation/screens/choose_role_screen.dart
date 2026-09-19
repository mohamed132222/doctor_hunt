import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
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
                  padding: EdgeInsets.symmetric(
                    horizontal: context.paddingOf(AppSize.s24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: context.paddingOf(AppSize.s32)),
                          Image.asset(
                            AppAssets.splashLogo,
                            width: context.sizeOf(AppSize.chooseRoleCardWidth),
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s16)),
                          Text(
                            AppStrings.appName,
                            style: context.textStyles.wordmark,
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s48)),
                          Text(
                            AppStrings.chooseRoleTitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium,
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s8)),
                          Text(
                            AppStrings.chooseRoleSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: context.paddingOf(AppSize.s32)),
                          ...kRoleOptions.map(
                            (option) => Padding(
                              padding: EdgeInsets.only(
                                bottom: context.paddingOf(AppSize.s16),
                              ),
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
                          top: context.paddingOf(AppSize.s24),
                          bottom: context.paddingOf(AppSize.s24),
                        ),
                        child: PrimaryButton(
                          label: AppStrings.continueLabel,
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
