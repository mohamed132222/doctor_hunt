import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/router/app_router.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/login/login_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/login_body.dart';
import 'package:doctor_hunt/apps/features/common/choose_role/data/models/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(getIt<AuthRepo>()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == AppStatus.success) {
            const HomeRoute().go(context);
          }

          if (state.status == AppStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
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
            child: SingleChildScrollView(child: LoginBody(role: role)),
          ),
        ),
      ),
    );
  }
}
