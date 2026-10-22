import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_background.dart';
import 'package:doctor_hunt/apps/core/widgets/photo_picker.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/common/profile/data/models/user_profile_model.dart';
import 'package:doctor_hunt/apps/features/common/profile/presentation/controllers/current_profile/current_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/profile/presentation/controllers/patient_profile/patient_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/patient/profile/presentation/widgets/profile_field_card.dart';
import 'package:doctor_hunt/apps/features/patient/profile/presentation/widgets/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientProfileCubit>(
      create: (_) => getIt<PatientProfileCubit>()..load(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _photoPath;
  String _initials = '';
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _hydrate(UserProfile profile) {
    _nameController.text = profile.name;
    _phoneController.text = profile.phone ?? '';
    _photoPath = profile.photo;
    _initials = profile.name.trim().isEmpty
        ? 'U'
        : profile.name.trim()[0].toUpperCase();
    _initialized = true;
  }

  Future<void> _pickPhoto() async {
    final path = await pickPhoto(context);
    if (path != null) setState(() => _photoPath = path);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<PatientProfileCubit>().save(
      name: _nameController.text,
      phone: _phoneController.text,
      photo: _photoPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      backgroundColor: AppColors.white,
      child: BlocConsumer<PatientProfileCubit, PatientProfileState>(
        listenWhen: (p, c) => p.saved != c.saved || p.status != c.status,
        buildWhen: (p, c) => p.status != c.status || p.profile != c.profile,
        listener: (context, state) {
          if (state.saved) {
            getIt<CurrentProfileCubit>().refresh();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(t.profileUpdated)));
            context.pop();
          } else if (state.status == AppStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
          }
        },
        builder: (context, state) {
          if (!_initialized && state.profile != null) {
            _hydrate(state.profile!);
          }
          return Column(
            children: [
              ProfileHeader(
                photo: _photoPath,
                initials: _initials,
                onPickPhoto: _pickPhoto,
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.s24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: context.s20),
                              Text(
                                t.personalInformation,
                                style: context.bold20Black,
                              ),
                              SizedBox(height: context.s16),
                              ProfileFieldCard(
                                label: t.nameHint,
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                    ? t.fieldRequired(label: t.nameHint)
                                    : null,
                              ),
                              SizedBox(height: context.s16),
                              ProfileFieldCard(
                                label: t.contactNumberHint,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9+\s-]'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            context.s24,
                            context.s12,
                            context.s24,
                            context.s24,
                          ),
                          child: PrimaryButton(
                            label: t.continueLabel,
                            width: double.infinity,
                            radius: context.r12,
                            isLoading: state.isSaving,
                            onPressed: _save,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
