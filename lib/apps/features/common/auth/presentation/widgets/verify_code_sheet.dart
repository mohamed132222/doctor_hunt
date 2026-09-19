import 'package:flutter/material.dart';
import '../../../../../core/appsize/app_size.dart';

import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_sheet.dart';
import '../../../../../core/widgets/otp_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import 'reset_password_sheet.dart';

/// Step 2: enter the 4-digit code sent to [email].
class VerifyCodeSheet extends StatefulWidget {
  const VerifyCodeSheet({super.key, required this.email});

  final String email;

  @override
  State<VerifyCodeSheet> createState() => _VerifyCodeSheetState();
}

class _VerifyCodeSheetState extends State<VerifyCodeSheet> {
  String _code = '';

  Future<void> _continue() async {
    if (_code.length != 4) return;
    Navigator.of(context).pop();
    await showAppSheet<void>(context, (_) => const ResetPasswordSheet());
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: AppStrings.verifyCodeTitle,
      subtitle: AppStrings.verifyCodeSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OtpField(onCompleted: (code) => setState(() => _code = code)),
          SizedBox(height: context.paddingOf(AppSize.s24)),
          PrimaryButton(label: AppStrings.continueLabel, onPressed: _continue),
        ],
      ),
    );
  }
}
