import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
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
      title: AppStrings.resetPasswordTitle,
      subtitle: AppStrings.resetPasswordSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PasswordField(
              hint: AppStrings.newPasswordHint,
              controller: _passwordController,
              validator: AppValidators.password,
            ),
            SizedBox(height: context.paddingOf(AppSize.s16)),
            PasswordField(
              hint: AppStrings.reenterPasswordHint,
              controller: _confirmController,
              validator: (v) =>
                  AppValidators.confirmPassword(v, _passwordController.text),
            ),
            SizedBox(height: context.paddingOf(AppSize.s24)),
            PrimaryButton(
              label: AppStrings.updatePasswordButton,
              onPressed: _update,
            ),
          ],
        ),
      ),
    );
  }
}
