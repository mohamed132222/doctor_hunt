import 'package:doctor_hunt/apps/core/widgets/app_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/forget_password_email_step.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/reset_password_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/verify_code_sheet.dart';
import 'package:flutter/material.dart';

class ForgotPasswordFlow extends StatefulWidget {
  const ForgotPasswordFlow({super.key});

  @override
  State<ForgotPasswordFlow> createState() => _ForgotPasswordFlowState();
}

class _ForgotPasswordFlowState extends State<ForgotPasswordFlow> {
  int _currentStep = 0;

  String _email = '';
  String _verificationCode = '';

  void _handleEmailContinue(String email) {
    _email = email;
    _nextStep();
  }

  void _handleCodeContinue(String code) {
    _verificationCode = code;
    _nextStep();
  }

  void _handleResetSubmit(String password, String confirmPassword) {
    // Later:
    // context.read<ForgotPasswordCubit>().resetPassword(
    //   email: _email,
    //   verificationCode: _verificationCode,
    //   password: password,
    // );

    debugPrint('Email: $_email');
    debugPrint('Code: $_verificationCode');
    debugPrint('Password: $password');
    debugPrint('Confirm Password: $confirmPassword');

    _finish();
  }

  void _nextStep() {
    if (_currentStep >= 2) return;

    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep == 0) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _currentStep--;
    });
  }

  void _finish() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(child: _buildCurrentStep());
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return ForgotPasswordEmailStep(onContinue: _handleEmailContinue);

      case 1:
        return VerifyCodeStep(
          email: _email,
          onBack: _previousStep,
          onContinue: _handleCodeContinue,
        );

      case 2:
        return ResetPasswordStep(
          email: _email,
          verificationCode: _verificationCode,
          onBack: _previousStep,
          onSubmit: _handleResetSubmit,
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
