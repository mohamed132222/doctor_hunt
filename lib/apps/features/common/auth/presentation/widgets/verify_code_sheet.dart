import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/apps/core/widgets/otp_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class VerifyCodeStep extends StatefulWidget {
  const VerifyCodeStep({
    super.key,
    required this.email,
    required this.onBack,
    required this.onContinue,
  });

  /// Email received from the previous step.
  final String email;

  /// UI navigation only.
  final VoidCallback onBack;

  /// Called only when the user has entered a valid 4-digit code.
  ///
  /// Later this callback can be connected directly to Cubit/API logic.
  final ValueChanged<String> onContinue;

  @override
  State<VerifyCodeStep> createState() => _VerifyCodeStepState();
}

class _VerifyCodeStepState extends State<VerifyCodeStep> {
  String _code = '';

  bool get _isCodeComplete => _code.length == 4;

  void _handleCodeCompleted(String code) {
    // This rebuild happens only once when the OTP is completed.
    if (_code == code) return;

    setState(() {
      _code = code;
    });
  }

  void _handleContinue() {
    if (!_isCodeComplete) return;

    widget.onContinue(_code);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Back button
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

        // Title
        Text(t.verifyCodeTitle, style: context.bold24),

        const SizedBox(height: 12),

        // Subtitle
        Text(t.verifyCodeSubtitle, style: context.regular14),

        const SizedBox(height: 36),

        // OTP
        OtpField(onCompleted: _handleCodeCompleted),

        const SizedBox(height: 24),

        // Continue
        PrimaryButton(label: t.continueLabel, onPressed: _handleContinue),
      ],
    );
  }
}
