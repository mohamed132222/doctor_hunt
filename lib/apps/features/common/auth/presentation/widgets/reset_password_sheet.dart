import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:doctor_hunt/apps/core/widgets/password_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class ResetPasswordStep extends StatefulWidget {
  const ResetPasswordStep({
    super.key,
    required this.email,
    required this.verificationCode,
    required this.onBack,
    required this.onSubmit,
    this.isLoading = false,
  });

  /// Email from the first step.
  final String email;

  /// Verified code from the second step.
  ///
  /// It is kept here so this step is ready for the API integration later.
  final String verificationCode;

  /// UI navigation only.
  final VoidCallback onBack;

  /// Called only after local validation succeeds.
  ///
  /// Later this callback can be connected directly to Cubit/API logic.
  final void Function(String password, String confirmPassword) onSubmit;

  /// Shows a loading indicator on the action button while updating.
  final bool isLoading;

  @override
  State<ResetPasswordStep> createState() => _ResetPasswordStepState();
}

class _ResetPasswordStepState extends State<ResetPasswordStep> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    widget.onSubmit(password, confirmPassword);
  }

  String? _validateConfirmPassword(String? value) {
    return AppValidators.confirmPassword(value, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ),

          const SizedBox(height: 12),

          Text(t.resetPasswordTitle, style: context.bold24),

          const SizedBox(height: 12),

          Text(t.resetPasswordSubtitle, style: context.regular14),

          const SizedBox(height: 36),

          PasswordField(
            hint: t.newPasswordHint,
            controller: _passwordController,
            validator: AppValidators.password,
          ),

          const SizedBox(height: 16),

          PasswordField(
            hint: t.reenterPasswordHint,
            controller: _confirmPasswordController,
            validator: _validateConfirmPassword,
          ),

          const SizedBox(height: 24),

          PrimaryButton(
            label: t.updatePasswordButton,
            onPressed: _handleSubmit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
