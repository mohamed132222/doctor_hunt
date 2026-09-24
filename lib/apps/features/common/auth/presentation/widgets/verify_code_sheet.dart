import 'dart:async';

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
    required this.onResend,
    this.codeLength = 6,
    this.isLoading = false,
    this.resendCooldownSeconds = 60,
    this.errorMessage,
  });

  /// Email received from the previous step.
  final String email;

  /// UI navigation only.
  final VoidCallback onBack;

  /// Requests a new OTP for the same email.
  final VoidCallback onResend;

  /// Number of OTP digits. Supabase recovery codes are 6 digits by default.
  final int codeLength;

  /// Shows a loading indicator on the action button while verifying.
  final bool isLoading;

  /// Seconds the user must wait before requesting a new code (rate-limit safe).
  final int resendCooldownSeconds;

  /// Error text shown under the OTP field (e.g. wrong or expired code).
  final String? errorMessage;

  /// Called only when the user has entered a complete code.
  final ValueChanged<String> onContinue;

  @override
  State<VerifyCodeStep> createState() => _VerifyCodeStepState();
}

class _VerifyCodeStepState extends State<VerifyCodeStep> {
  String _code = '';

  Timer? _timer;
  int _secondsLeft = 0;

  bool get _isCodeComplete => _code.length == widget.codeLength;
  bool get _canResend => _secondsLeft == 0;

  @override
  void initState() {
    super.initState();
    // A code was just sent when this step opened, so start the cooldown.
    _startCooldown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _secondsLeft = widget.resendCooldownSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _handleResend() {
    if (!_canResend) return;

    widget.onResend();
    _startCooldown();
  }

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
        OtpField(length: widget.codeLength, onCompleted: _handleCodeCompleted),

        // Inline error message (wrong / expired code).
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.errorMessage!,
            textAlign: TextAlign.center,
            style: context.regular14.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Continue
        PrimaryButton(
          label: t.continueLabel,
          onPressed: _handleContinue,
          isLoading: widget.isLoading,
        ),

        const SizedBox(height: 8),

        // Resend code with cooldown.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(t.resendCodeQuestion, style: context.regular14),
            TextButton(
              onPressed: _canResend ? _handleResend : null,
              child: Text(
                _canResend
                    ? t.resendCodeButton
                    : t.resendCodeCountdown(seconds: _secondsLeft),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
