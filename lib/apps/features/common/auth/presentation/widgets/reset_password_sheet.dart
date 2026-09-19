import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../../../core/widgets/app_sheet.dart';
import '../../../../../core/widgets/password_field.dart';
import '../../../../../core/widgets/primary_button.dart';

/// Step 3: set a new password and confirm it.
class ResetPasswordSheet extends StatefulWidget {
  const ResetPasswordSheet({super.key});

  @override
  State<ResetPasswordSheet> createState() => _ResetPasswordSheetState();
}

class _ResetPasswordSheetState extends State<ResetPasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _update() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: t.resetPasswordTitle,
      subtitle: t.resetPasswordSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PasswordField(
              hint: t.newPasswordHint,
              controller: _passwordController,
              validator: AppValidators.password,
            ),
            SizedBox(height: context.s16),
            PasswordField(
              hint: t.reenterPasswordHint,
              controller: _confirmController,
              validator: (v) =>
                  AppValidators.confirmPassword(v, _passwordController.text),
            ),
            SizedBox(height: context.s24),
            PrimaryButton(label: t.updatePasswordButton, onPressed: _update),
          ],
        ),
      ),
    );
  }
}
