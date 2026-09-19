import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/auth_switch_link.dart';
import '../../../../../core/widgets/app_background.dart';
import '../widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          SizedBox(
                            height: context.paddingOf(AppSize.authTitleTopGap),
                          ),
                          const RegisterBody(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.paddingOf(AppSize.s24),
                          bottom: context.paddingOf(AppSize.authBottomGap),
                        ),
                        child: AuthSwitchLink(
                          prefix: AppStrings.registerSwitchPrefix,
                          action: AppStrings.registerSwitchAction,
                          onTap: () => context.go(RoutePath.login),
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
