import 'package:doctor_hunt/apps/core/appsize/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_header.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_switch_link.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_text_field.dart';
import 'package:doctor_hunt/apps/core/widgets/password_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/core/widgets/social_auth_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

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
    const HomeRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthHeader(title: t.registerTitle, subtitle: t.authSubtitle),
          const SizedBox(height: 66),
          SocialButton(
            label: "Google",
            icon: "assets/icons/google_icon.svg",
            textStyle: context.light16TextSub,
          ),
          const SizedBox(height: 34),
          AuthTextField(
            hint: t.nameHint,
            controller: _nameController,
            textInputAction: TextInputAction.next,
            validator: (v) => AppValidators.required(v, t.nameFieldLabel),
          ),
          const SizedBox(height: 18),
          AuthTextField(
            hint: t.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.email,
          ),
          const SizedBox(height: 18),
          PasswordField(
            hint: t.passwordHint,
            controller: _passwordController,
            textInputAction: TextInputAction.done,
            validator: AppValidators.password,
          ),
          const SizedBox(height: 14),
          _TermsRow(
            agreed: _agreed,
            onChanged: (v) => setState(() => _agreed = v),
          ),
          const SizedBox(height: 54),
          PrimaryButton(
            label: t.registerButton,
            onPressed: _register,
            width: context.sizeOf(295),
          ),
          const SizedBox(height: 16),
          AuthSwitchLink(
            prefix: t.registerSwitchPrefix,
            action: t.registerSwitchAction,
            onTap: () => const LoginRoute().go(context),
          ),
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
    return Row(
      children: [
        Checkbox(value: agreed, onChanged: (v) => onChanged(v ?? false)),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!agreed),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: t.termsPrefix,
                    style: context.regular14TextSub,
                  ),
                  TextSpan(text: t.termsAction, style: context.medium14TextSub),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
