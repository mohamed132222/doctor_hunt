import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/validators/app_validators.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/password_field.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/change_password/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => getIt<ChangePasswordCubit>(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<ChangePasswordCubit>().submit(_passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (p, c) => p.saved != c.saved || p.status != c.status,
      listener: (context, state) {
        if (state.saved) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.adminPasswordUpdated)));
        } else if (state.status == AppStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.adminSurface,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.adminScreenPaddingH,
            ),
            child: Column(
              children: [
                AppTopBar(title: t.adminChangePasswordTitle),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: context.s24),
                          PasswordField(
                            hint: t.newPasswordHint,
                            controller: _passwordController,
                            textInputAction: TextInputAction.next,
                            validator: (v) =>
                                AppValidators.password(v, minLength: 6),
                          ),
                          SizedBox(height: context.s20),
                          PasswordField(
                            hint: t.reenterPasswordHint,
                            controller: _confirmController,
                            textInputAction: TextInputAction.done,
                            validator: (v) => AppValidators.confirmPassword(
                              v,
                              _passwordController.text,
                            ),
                          ),
                          SizedBox(height: context.s32),
                          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                            buildWhen: (p, c) =>
                                p.status != c.status || p.saved != c.saved,
                            builder: (context, state) => PrimaryButton(
                              label: t.updatePasswordButton,
                              width: double.infinity,
                              isLoading: state.isLoading,
                              onPressed: _submit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
