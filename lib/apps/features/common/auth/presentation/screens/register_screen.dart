import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../../../../core/widgets/auth_switch_link.dart';
import '../widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        minimum: const EdgeInsets.only(
          top: 125,
          bottom: 46,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(child: RegisterBody()),
      ),
    );
  }
}
