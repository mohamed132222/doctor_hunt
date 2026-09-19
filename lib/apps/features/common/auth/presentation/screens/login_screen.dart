import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../../../../core/widgets/auth_switch_link.dart';
import '../widgets/login_body.dart';

/// Login screen — thin StatelessWidget; form state lives in [LoginBody].
///
/// Background mirrors the splash / choose-role (teal ellipse top-left, green
/// ellipse bottom-right). The "Don't have an account? Join us" button routes
/// to sign-up.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  padding: EdgeInsets.symmetric(horizontal: context.s24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: context.authTitleTopGap),
                          LoginBody(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: context.s24,
                          bottom: context.authBottomGap,
                        ),
                        child: AuthSwitchLink(
                          prefix: t.loginSwitchPrefix,
                          action: t.loginSwitchAction,
                          onTap: () => context.go(RoutePath.register),
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
