import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../../core/widgets/password_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/social_auth_row.dart';

/// Sign-up form body (stateful: owns the form + controllers).
class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreed) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.termsRequired)));
      return;
    }
    context.go(RoutePath.home);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: AppStrings.registerTitle,
            subtitle: AppStrings.authSubtitle,
          ),
          SizedBox(height: context.w(AppSize.s32)),
          const SocialAuthRow(),
          SizedBox(height: context.w(AppSize.s24)),
          AuthTextField(
            hint: AppStrings.nameHint,
            controller: _nameController,
            textInputAction: TextInputAction.next,
            validator: (v) =>
                AppValidators.required(v, AppStrings.nameFieldLabel),
          ),
          SizedBox(height: context.w(AppSize.s16)),
          AuthTextField(
            hint: AppStrings.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
          ),
          SizedBox(height: context.w(AppSize.s16)),
          PasswordField(
            hint: AppStrings.passwordHint,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            validator: AppValidators.password,
          ),
          SizedBox(height: context.w(AppSize.s16)),
          _TermsRow(
            agreed: _agreed,
            onChanged: (v) => setState(() => _agreed = v),
          ),
          SizedBox(height: context.w(AppSize.s32)),
          PrimaryButton(label: AppStrings.registerButton, onPressed: _register),
          SizedBox(height: context.w(AppSize.s16)),
        ],
      ),
    );
  }
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({required this.agreed, required this.onChanged});

  final bool agreed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Checkbox(value: agreed, onChanged: (v) => onChanged(v ?? false)),
        SizedBox(width: context.w(AppSize.s12)),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!agreed),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.termsPrefix,
                    style: theme.textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: AppStrings.termsAction,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
