import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/auth_switch_link.dart';
import '../../../../core/widgets/ellipse_background.dart';
import '../widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EllipseBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(AppSize.s24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: context.h(AppSize.authTitleTopGap),
                            ),
                            const RegisterBody(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: context.h(AppSize.s24),
                            bottom: context.h(AppSize.authBottomGap),
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
      ),
    );
  }
}
