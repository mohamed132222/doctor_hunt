import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/widgets/app_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/forget_pass/forget_pass_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/forget_pass/forget_pass_event.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/forget_pass/forget_pass_state.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/forget_password_email_step.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/reset_password_sheet.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/verify_code_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordFlow extends StatelessWidget {
  const ForgotPasswordFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listenWhen: (previous, current) =>
          previous.status != current.status || previous.step != current.step,
      listener: (context, state) {
        if (state.status == AppStatus.error) {
          // The verifyOtp step shows its error inline, so skip the SnackBar
          // there to avoid a duplicate message.
          if (state.step == ForgotPasswordStep.verifyOtp) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
          return;
        }

        if (state.status == AppStatus.success &&
            state.step == ForgotPasswordStep.completed) {
          Navigator.of(context).pop();
        }
      },
      child: AppSheet(
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          buildWhen: (previous, current) =>
              previous.step != current.step ||
              previous.email != current.email ||
              previous.status != current.status,
          builder: (context, state) {
            final isLoading = state.isLoading;
            switch (state.step) {
              case ForgotPasswordStep.email:
                return ForgotPasswordEmailStep(
                  isLoading: isLoading,
                  onContinue: (email) {
                    context.read<ForgotPasswordBloc>().add(
                      SendPasswordResetOtp(email: email),
                    );
                  },
                );

              case ForgotPasswordStep.verifyOtp:
                return VerifyCodeStep(
                  email: state.email ?? '',
                  isLoading: isLoading,
                  errorMessage: state.status == AppStatus.error
                      ? state.errorMessage
                      : null,
                  onBack: () {
                    context.read<ForgotPasswordBloc>().add(
                      GoBackToPreviousStep(),
                    );
                  },
                  onResend: () {
                    context.read<ForgotPasswordBloc>().add(
                      ResendPasswordResetOtp(),
                    );
                  },
                  onContinue: (code) {
                    context.read<ForgotPasswordBloc>().add(
                      VerifyPasswordResetOtp(token: code),
                    );
                  },
                );

              case ForgotPasswordStep.resetPassword:
                return ResetPasswordStep(
                  email: state.email ?? '',
                  verificationCode: '',
                  isLoading: isLoading,
                  onBack: () {
                    context.read<ForgotPasswordBloc>().add(
                      GoBackToPreviousStep(),
                    );
                  },
                  onSubmit: (password, confirmPassword) {
                    context.read<ForgotPasswordBloc>().add(
                      ResetPassword(password: password),
                    );
                  },
                );

              case ForgotPasswordStep.completed:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
