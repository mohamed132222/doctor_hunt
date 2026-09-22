import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:doctor_hunt/apps/core/widgets/auth_text_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailStep extends StatefulWidget {
  const ForgotPasswordEmailStep({super.key, required this.onContinue});

  /// Called only after the email passes validation.
  ///
  /// Later this callback can be connected directly to Cubit/API logic.
  final ValueChanged<String> onContinue;

  @override
  State<ForgotPasswordEmailStep> createState() =>
      _ForgotPasswordEmailStepState();
}

class _ForgotPasswordEmailStepState extends State<ForgotPasswordEmailStep> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    final email = _emailController.text.trim();

    widget.onContinue(email);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.forgotPasswordTitle, style: context.bold24),

          const SizedBox(height: 12),

          Text(t.forgotPasswordSubtitle, style: context.regular14),

          const SizedBox(height: 36),

          AuthTextField(
            hint: t.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: AppValidators.email,
          ),

          const SizedBox(height: 30),

          PrimaryButton(label: t.continueLabel, onPressed: _handleContinue),
        ],
      ),
    );
  }
}
