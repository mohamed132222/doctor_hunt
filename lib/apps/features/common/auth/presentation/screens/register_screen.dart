import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/register/register_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/register_body.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(getIt<AuthRepo>()),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == AppStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Account created successfully. Please verify your email.',
                ),
                backgroundColor: AppColors.success,
              ),
            );

            LoginRoute(role: role).go(context);
          }
          if (state.status == AppStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        child: AppBackground(
          child: SafeArea(
            minimum: const EdgeInsets.only(
              top: 100,
              bottom: 46,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(child: RegisterBody(role: role)),
          ),
        ),
      ),
    );
  }
}
