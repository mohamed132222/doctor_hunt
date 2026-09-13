import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/app_sheet.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../../core/widgets/password_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/social_auth_row.dart';
import '../widgets/forgot_password_sheet.dart';

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

  void _onEmailChanged(String value) {
    final valid = AppValidators.email(value) == null;
    if (valid != _emailValid) setState(() => _emailValid = valid);
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    context.go(RoutePath.home);
  }

  Future<void> _forgotPassword() async {
    await showAppSheet<void>(context, (_) => const ForgotPasswordSheet());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: AppStrings.loginTitle,
            subtitle: AppStrings.authSubtitle,
          ),
          SizedBox(height: context.h(AppSize.authSubtitleSocialGap)),
          const SocialAuthRow(),
          SizedBox(height: context.h(AppSize.authSocialFieldGap)),
          AuthTextField(
            hint: AppStrings.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: _onEmailChanged,
            suffixIcon: _emailValid ? Icon(Icons.check) : null,
            validator: AppValidators.email,
          ),
          SizedBox(height: context.h(AppSize.authFieldGap)),
          PasswordField(
            hint: AppStrings.passwordHint,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            validator: (v) => AppValidators.password(v, minLength: 1),
          ),
          SizedBox(height: context.h(AppSize.authFieldButtonGap)),
          PrimaryButton(label: AppStrings.loginButton, onPressed: _login),
          SizedBox(height: context.h(AppSize.authButtonLinkGap)),
          Center(
            child: TextButton(
              onPressed: _forgotPassword,
              child: const Text(AppStrings.forgotPassword),
            ),
          ),
        ],
      ),
    );
  }
}
