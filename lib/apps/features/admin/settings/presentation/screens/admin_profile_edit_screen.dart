import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/labeled_field.dart';
import 'package:doctor_hunt/apps/core/widgets/photo_picker.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_photo_picker.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:doctor_hunt/apps/features/common/admin_profile/data/models/admin_profile_model.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/widgets/admin_profile_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class AdminProfileEditScreen extends StatelessWidget {
  const AdminProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminProfileScope(child: const _EditProfileView());
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _clinicController = TextEditingController();
  final _emailController = TextEditingController();
  String _email = '';
  String? _photoPath;
  String _initials = '';
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _clinicController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _hydrate(AdminProfile profile) {
    _nameController.text = profile.name;
    _clinicController.text = profile.clinicLocation;
    _emailController.text = profile.email;
    _email = profile.email;
    _photoPath = profile.photo;
    _initials = profile.initials;
    _initialized = true;
  }

  Future<void> _pickPhoto() async {
    final path = await pickPhoto(context);
    if (path != null) setState(() => _photoPath = path);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AdminProfileCubit>().save(
      name: _nameController.text,
      clinicLocation: _clinicController.text,
      photo: _photoPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.adminSurface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.adminScreenPaddingH,
          ),
          child: BlocConsumer<AdminProfileCubit, AdminProfileState>(
            listenWhen: (previous, current) =>
                previous.saved != current.saved ||
                previous.error != current.error,
            buildWhen: (p, c) => p.profile != c.profile,
            listener: (context, state) {
              if (state.saved) {
                final messenger = ScaffoldMessenger.of(context);
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                messenger.showSnackBar(
                  SnackBar(content: Text(t.adminProfileSaved)),
                );
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
                  AppTopBar(title: t.adminEditProfileTitle),
                  Expanded(
                    child: state.profile == null
                        ? const AppSkeletonDetails()
                        : _form(context, state.saving),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context, bool isSaving) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: context.s24),
            DoctorPhotoPicker(
              photoPath: _photoPath,
              initials: _initials,
              onTap: _pickPhoto,
            ),
            SizedBox(height: context.s32),
            LabeledField(
              label: t.adminFullName,
              hint: t.adminFullName,
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline),
              validator: requiredField(t.adminFullName),
            ),
            SizedBox(height: context.s20),
            LabeledField(
              label: t.adminEmailAddress,
              hint: _email,
              controller: _emailController,
              enabled: false,
              prefixIcon: const Icon(Icons.mail_outline),
            ),
            SizedBox(height: context.s20),
            LabeledField(
              label: t.adminClinicLocation,
              hint: t.adminClinicLocation,
              controller: _clinicController,
              prefixIcon: const Icon(Icons.location_on_outlined),
              validator: requiredField(t.adminClinicLocation),
            ),
            SizedBox(height: context.s32),
            PrimaryButton(
              label: t.adminSaveChanges,
              width: double.infinity,
              isLoading: isSaving,
              onPressed: _save,
            ),
            SizedBox(height: context.s24),
          ],
        ),
      ),
    );
  }
}
