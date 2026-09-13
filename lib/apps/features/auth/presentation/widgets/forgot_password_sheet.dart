import 'package:flutter/material.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/app_sheet.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import 'verify_code_sheet.dart';

/// Step 1: enter the email to receive a verification code.
class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    Navigator.of(context).pop();
    await showAppSheet<void>(context, (_) => VerifyCodeSheet(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: AppStrings.forgotPasswordTitle,
      subtitle: AppStrings.forgotPasswordSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              hint: AppStrings.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: AppValidators.email,
            ),
            SizedBox(height: context.w(AppSize.s24)),
            PrimaryButton(
              label: AppStrings.continueLabel,
              onPressed: _continue,
            ),
          ],
        ),
      ),
    );
  }
}
