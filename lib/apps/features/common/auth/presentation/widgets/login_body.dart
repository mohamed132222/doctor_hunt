import 'package:doctor_hunt/apps/core/appsize/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:doctor_hunt/apps/core/widgets/app_sheet.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_header.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_switch_link.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_text_field.dart';
import 'package:doctor_hunt/apps/core/widgets/password_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/widgets/social_auth_button.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/forget_password_flow.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../widgets/forget_password_email_step.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailValid = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    const HomeRoute().go(context);
  }

  void _openForgotPassword() {
    showAppSheet<void>(context, (_) => const ForgotPasswordFlow());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthHeader(title: t.loginTitle, subtitle: t.authSubtitle),
          SizedBox(height: context.paddingOf(80)),
          SocialButton(
            label: "Google",
            icon: "assets/icons/google_icon.svg",
            textStyle: context.light16Black,
            onPressed: () {},
          ),
          const SizedBox(height: 36),
          AuthTextField(
            hint: t.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            suffixIcon: _emailValid ? Icon(Icons.check) : null,
            validator: AppValidators.email,
          ),
          const SizedBox(height: 18),
          PasswordField(
            hint: t.passwordHint,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            validator: (v) => AppValidators.password(v, minLength: 1),
          ),
          const SizedBox(height: 32),
          PrimaryButton(label: t.loginButton, onPressed: _login),
          const SizedBox(height: 18),
          Center(
            child: TextButton(
              onPressed: _openForgotPassword,
              child: Text(t.forgotPassword),
            ),
          ),
          SizedBox(height: context.paddingOf(124)),
          AuthSwitchLink(
            prefix: t.loginSwitchPrefix,
            action: t.loginSwitchAction,
            onTap: () => const RegisterRoute().go(context),
          ),
        ],
      ),
    );
  }
}
