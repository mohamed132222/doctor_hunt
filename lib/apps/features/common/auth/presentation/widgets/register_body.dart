import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../../../core/widgets/auth_header.dart';
import '../../../../../core/widgets/auth_text_field.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../../core/widgets/social_auth_row.dart';

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
      ).showSnackBar(SnackBar(content: Text(t.termsRequired)));
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
          AuthHeader(title: t.registerTitle, subtitle: t.authSubtitle),
          SizedBox(height: context.s32),
          SocialAuthRow(showFacebook: true),
          SizedBox(height: context.s24),
          AuthTextField(
            hint: t.nameHint,
            controller: _nameController,
            textInputAction: TextInputAction.next,
            validator: (v) => AppValidators.required(v, t.nameFieldLabel),
          ),
          SizedBox(height: context.s16),
          AuthTextField(
            hint: t.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
          ),
          SizedBox(height: context.s16),
          PasswordField(
            hint: t.passwordHint,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            validator: AppValidators.password,
          ),
          SizedBox(height: context.s16),
          _TermsRow(
            agreed: _agreed,
            onChanged: (v) => setState(() => _agreed = v),
          ),
          SizedBox(height: context.s32),
          PrimaryButton(label: t.registerButton, onPressed: _register),
          SizedBox(height: context.s16),
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
        SizedBox(width: context.s12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!agreed),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: t.termsPrefix,
                    style: theme.textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: t.termsAction,
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
