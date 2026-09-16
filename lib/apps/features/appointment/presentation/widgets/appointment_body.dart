import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/appsize/app_size.dart';
import '../../../../core/appsize/screen_utils.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../core/widgets/auth_text_field.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import 'appointment_doctor_card.dart';
import 'patient_tile.dart';

/// A patient the appointment can be booked for.
class _Patient {
  const _Patient(this.label, {this.image});

  final String label;
  final String? image;
}

const List<_Patient> _patients = [
  _Patient(AppStrings.mySelf, image: 'assets/images/home/mock2.png'),
  _Patient(AppStrings.childGirl),
];

/// Booking step 2: who the appointment is for, plus the patient's details.
class AppointmentBody extends StatefulWidget {
  const AppointmentBody({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<AppointmentBody> createState() => _AppointmentBodyState();
}

class _AppointmentBodyState extends State<AppointmentBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  /// Index into [_patients]; "My Self" is preselected.
  int _selectedPatient = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    // The date, time and reminder are chosen on the next step, which owns
    // the confirmation popup.
    context.pushNamed(
      RouteName.schedule,
      pathParameters: {'doctorId': widget.doctor.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(
      horizontal: context.w(AppSize.homeRowPaddingH),
    );
    final theme = Theme.of(context);

    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: DoctorTopBar(
            title: AppStrings.appointmentTitle,
            centerTitle: false,
          ),
        ),
        Expanded(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: gutter,
                    child: AppointmentDoctorCard(doctor: widget.doctor),
                  ),
                  SizedBox(height: context.w(AppSize.s20)),
                  Padding(
                    padding: gutter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.appointmentForTitle,
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: context.w(AppSize.s12)),
                        AuthTextField(
                          hint: AppStrings.patientNameHint,
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          validator: AppValidators.personName,
                        ),
                        SizedBox(height: context.w(AppSize.s14)),
                        AuthTextField(
                          hint: AppStrings.contactNumberHint,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: AppValidators.phone,
                        ),
                        SizedBox(height: context.w(AppSize.s24)),
                        Text(
                          AppStrings.whoIsPatientTitle,
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.w(AppSize.s12)),
                  SizedBox(
                    height:
                        context.w(AppSize.patientTileHeight) +
                        context.w(AppSize.s6) +
                        AppSize.patientLabelLine *
                            MediaQuery.textScalerOf(context).scale(1) +
                        context.w(AppSize.s4),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: gutter,
                      itemCount: _patients.length + 1,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: context.w(AppSize.s12)),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return PatientTile(
                            label: AppStrings.addPatient,
                            isAdd: true,
                            onTap: _addPatient,
                          );
                        }
                        final patient = _patients[index - 1];
                        return PatientTile(
                          label: patient.label,
                          image: patient.image,
                          selected: index - 1 == _selectedPatient,
                          onTap: () =>
                              setState(() => _selectedPatient = index - 1),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: context.w(AppSize.s24)),
                  Padding(
                    padding: gutter,
                    child: _NextButton(onTap: _submit),
                  ),
                  SizedBox(height: context.w(AppSize.s24)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _addPatient() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(AppStrings.addPatient)));
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(
      context.r(AppSize.bookingActionRadius),
    );

    return SizedBox(
      height: context.w(AppSize.appointmentNextHeight),
      child: Material(
        color: theme.colorScheme.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(
              AppStrings.next,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: AppSize.s16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
