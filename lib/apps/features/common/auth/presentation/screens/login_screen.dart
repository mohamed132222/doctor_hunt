import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';

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
        minimum: const EdgeInsets.only(
          top: 100,
          bottom: 46,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(child: LoginBody()),
      ),
    );
  }
}
