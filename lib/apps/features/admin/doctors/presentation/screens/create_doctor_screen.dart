import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/labeled_field.dart';
import 'package:doctor_hunt/apps/core/widgets/photo_picker.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_form/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_photo_picker.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/location_picker_field.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/rating_input.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

class CreateDoctorScreen extends StatelessWidget {
  const CreateDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorFormCubit>(
      create: (_) => getIt<DoctorFormCubit>(),
      child: const _CreateDoctorView(),
    );
  }
}

class _CreateDoctorView extends StatefulWidget {
  const _CreateDoctorView();

  @override
  State<_CreateDoctorView> createState() => _CreateDoctorViewState();
}

class _CreateDoctorViewState extends State<_CreateDoctorView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _feeController = TextEditingController();
  final _locationNameController = TextEditingController();
  DoctorSpecialty? _specialty;
  String? _photoPath;
  LatLng? _location;
  double _rating = 0;
  bool _specialtyError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _feeController.dispose();
    _locationNameController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final path = await pickPhoto(context);
    if (path != null) setState(() => _photoPath = path);
  }

  void _submit() {
    final validForm = _formKey.currentState!.validate();
    final hasSpecialty = _specialty != null;
    setState(() => _specialtyError = !hasSpecialty);
    if (!validForm || !hasSpecialty) return;

    final locationName = _locationNameController.text.trim();
    context.read<DoctorFormCubit>().create(
      name: _nameController.text,
      specialty: _specialty!,
      fee: parseFee(_feeController.text),
      photo: _photoPath,
      latitude: _location?.latitude,
      longitude: _location?.longitude,
      locationLabel: locationName.isEmpty ? null : locationName,
      rating: _rating,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorFormCubit, DoctorFormState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == AppStatus.success) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(t.adminDoctorCreated)));
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
                AppTopBar(title: t.adminCreateDoctorTitle),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: context.s24),
                          DoctorPhotoPicker(
                            photoPath: _photoPath,
                            onTap: _pickPhoto,
                          ),
                          SizedBox(height: context.s32),
                          LabeledField(
                            label: t.adminDoctorNameLabel,
                            hint: t.adminDoctorNameHint,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            validator: requiredField(t.adminDoctorNameLabel),
                          ),
                          SizedBox(height: context.s20),
                          SpecialtyField(
                            value: _specialty,
                            showError: _specialtyError,
                            onChanged: (value) => setState(() {
                              _specialty = value;
                              _specialtyError = false;
                            }),
                          ),
                          SizedBox(height: context.s20),
                          LabeledField(
                            label: t.adminConsultationFee,
                            hint: t.adminFeeHint,
                            controller: _feeController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: feeInputFormatters,
                            validator: requiredField(t.adminConsultationFee),
                          ),
                          SizedBox(height: context.s20),
                          RatingInput(
                            value: _rating,
                            onChanged: (value) =>
                                setState(() => _rating = value),
                          ),
                          SizedBox(height: context.s20),
                          LocationPickerField(
                            value: _location,
                            onChanged: (point) =>
                                setState(() => _location = point),
                          ),
                          SizedBox(height: context.s20),
                          LabeledField(
                            label: t.adminLocationName,
                            hint: t.adminLocationNameHint,
                            controller: _locationNameController,
                            textInputAction: TextInputAction.done,
                            prefixIcon: const Icon(Icons.place_outlined),
                          ),
                          SizedBox(height: context.s32),
                          BlocBuilder<DoctorFormCubit, DoctorFormState>(
                            buildWhen: (p, c) =>
                                p.status != c.status || p.error != c.error,
                            builder: (context, state) => PrimaryButton(
                              label: t.adminCreateDoctorButton,
                              width: double.infinity,
                              isLoading: state.isLoading,
                              onPressed: _submit,
                            ),
                          ),
                          SizedBox(height: context.s24),
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
