import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../../../core/widgets/app_sheet.dart';
import '../../../../../core/widgets/auth_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
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
      title: t.forgotPasswordTitle,
      subtitle: t.forgotPasswordSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthTextField(
              hint: t.emailHint,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: AppValidators.email,
            ),
            SizedBox(height: context.s24),
            PrimaryButton(label: t.continueLabel, onPressed: _continue),
          ],
        ),
      ),
    );
  }
}
