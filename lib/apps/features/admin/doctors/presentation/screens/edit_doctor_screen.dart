import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/core/enums/app_status.dart';
import 'package:doctor_hunt/apps/core/extensions/media_query_extension.dart';
import 'package:doctor_hunt/apps/core/themes/app_colors.dart';
import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/core/widgets/app_outlined_button.dart';
import 'package:doctor_hunt/apps/core/widgets/app_top_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/confirm_dialog.dart';
import 'package:doctor_hunt/apps/core/widgets/labeled_field.dart';
import 'package:doctor_hunt/apps/core/widgets/photo_picker.dart';
import 'package:doctor_hunt/apps/core/widgets/primary_button.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_details/doctor_details_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/controllers/doctor_form/doctor_form_cubit.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_form_fields.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/doctor_photo_picker.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/location_picker_field.dart';
import 'package:doctor_hunt/apps/features/admin/doctors/presentation/widgets/rating_input.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_specialty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/apps/core/widgets/skeleton.dart';

class EditDoctorScreen extends StatelessWidget {
  const EditDoctorScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorDetailsCubit>(
          create: (_) => getIt<DoctorDetailsCubit>()..load(doctorId),
        ),
        BlocProvider<DoctorFormCubit>(create: (_) => getIt<DoctorFormCubit>()),
      ],
      child: _EditDoctorView(doctorId: doctorId),
    );
  }
}

class _EditDoctorView extends StatefulWidget {
  const _EditDoctorView({required this.doctorId});

  final String doctorId;

  @override
  State<_EditDoctorView> createState() => _EditDoctorViewState();
}

class _EditDoctorViewState extends State<_EditDoctorView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _feeController = TextEditingController();
  final _locationNameController = TextEditingController();
  DoctorSpecialty? _specialty;
  String? _photoPath;
  LatLng? _location;
  double _rating = 0;
  bool _isActive = true;
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _feeController.dispose();
    _locationNameController.dispose();
    super.dispose();
  }

  void _hydrate(Doctor doctor) {
    _nameController.text = doctor.name;
    _feeController.text = doctor.fee.toStringAsFixed(0);
    _specialty = doctor.specialty;
    _photoPath = doctor.photo;
    _isActive = doctor.isActive;
    _location = doctor.hasLocation
        ? LatLng(doctor.latitude!, doctor.longitude!)
        : null;
    _locationNameController.text = doctor.locationLabel ?? '';
    _rating = doctor.rating;
    _initialized = true;
  }

  Future<void> _pickPhoto() async {
    final path = await pickPhoto(context);
    if (path != null) setState(() => _photoPath = path);
  }

  void _save() {
    if (!_formKey.currentState!.validate() || _specialty == null) return;
    final locationName = _locationNameController.text.trim();
    context.read<DoctorFormCubit>().update(
      id: widget.doctorId,
      name: _nameController.text,
      specialty: _specialty!,
      fee: parseFee(_feeController.text),
      isActive: _isActive,
      photo: _photoPath,
      latitude: _location?.latitude,
      longitude: _location?.longitude,
      locationLabel: locationName.isEmpty ? null : locationName,
      rating: _rating,
    );
  }

  Future<void> _delete() async {
    final confirmed = await showConfirmDialog(
      context,
      title: t.adminDeleteDoctorConfirmTitle,
      message: t.adminDeleteDoctorConfirmBody(name: _nameController.text),
      confirmLabel: t.commonDelete,
      danger: true,
    );
    if (confirmed && mounted) {
      context.read<DoctorFormCubit>().delete(widget.doctorId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorFormCubit, DoctorFormState>(
      listenWhen: (p, c) => p.status != c.status || p.deleted != c.deleted,
      listener: _onForm,
      child: Scaffold(
        backgroundColor: AppColors.adminSurface,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.adminScreenPaddingH,
            ),
            child: Column(
              children: [
                AppTopBar(title: t.adminEditDoctorTitle),
                Expanded(
                  child: BlocBuilder<DoctorDetailsCubit, DoctorDetailsState>(
                    buildWhen: (p, c) =>
                        p.status != c.status || p.doctor != c.doctor,
                    builder: (context, state) {
                      if (state.doctor == null) {
                        return const AppSkeletonDetails();
                      }
                      if (!_initialized) _hydrate(state.doctor!);
                      return _buildForm(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onForm(BuildContext context, DoctorFormState state) {
    if (state.status == AppStatus.success) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.deleted ? t.adminDoctorDeleted : t.adminDoctorUpdated,
          ),
        ),
      );
    } else if (state.status == AppStatus.error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.error ?? '')));
    }
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: context.s24),
            DoctorPhotoPicker(photoPath: _photoPath, onTap: _pickPhoto),
            SizedBox(height: context.s32),
            LabeledField(
              label: t.adminDoctorNameLabel,
              hint: t.adminDoctorNameHint,
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline),
              validator: requiredField(t.adminDoctorNameLabel),
            ),
            SizedBox(height: context.s20),
            SpecialtyField(
              value: _specialty,
              onChanged: (value) => setState(() => _specialty = value),
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
              onChanged: (value) => setState(() => _rating = value),
            ),
            SizedBox(height: context.s20),
            LocationPickerField(
              value: _location,
              onChanged: (point) => setState(() => _location = point),
            ),
            SizedBox(height: context.s20),
            LabeledField(
              label: t.adminLocationName,
              hint: t.adminLocationNameHint,
              controller: _locationNameController,
              prefixIcon: const Icon(Icons.place_outlined),
            ),
            SizedBox(height: context.s20),
            _StatusCard(
              active: _isActive,
              onChanged: (value) => setState(() => _isActive = value),
            ),
            SizedBox(height: context.s32),
            BlocBuilder<DoctorFormCubit, DoctorFormState>(
              buildWhen: (p, c) => p.status != c.status || p.error != c.error,
              builder: (context, state) => PrimaryButton(
                label: t.adminSaveChanges,
                width: double.infinity,
                isLoading: state.isLoading,
                onPressed: _save,
              ),
            ),
            SizedBox(height: context.s12),
            AppOutlinedButton(
              label: t.adminDeleteDoctor,
              color: AppColors.danger,
              onPressed: _delete,
            ),
            SizedBox(height: context.s24),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.active, required this.onChanged});

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final box = context.infoTileIconBox;

    return Container(
      padding: EdgeInsets.all(context.s16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(context.adminCardRadius),
        boxShadow: [context.themeColors.cardShadow],
      ),
      child: Row(
        children: [
          Container(
            width: box,
            height: box,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(context.infoTileRadius),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: scheme.primary,
              size: context.iconSmall,
            ),
          ),
          SizedBox(width: context.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.adminDoctorStatus, style: context.bold16Black),
                SizedBox(height: context.s2),
                Text(t.adminActiveAvailable, style: context.regular14TextSub),
              ],
            ),
          ),
          Switch(value: active, onChanged: onChanged),
        ],
      ),
    );
  }
}
