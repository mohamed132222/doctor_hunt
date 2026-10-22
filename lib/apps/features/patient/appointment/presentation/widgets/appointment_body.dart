import 'package:doctor_hunt/apps/core/themes/app_theme.dart';
import 'package:doctor_hunt/apps/features/patient/main/presentation/widgets/doctor_photo.dart';
import 'package:doctor_hunt/apps/core/widgets/rating_stars.dart';
import 'package:doctor_hunt/apps/features/patient/appointment/presentation/widgets/photo_content.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'add_content.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/extensions/media_query_extension.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/validators/app_validators.dart';
import '../../../../../core/widgets/auth_text_field.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor_model.dart';

class _Patient {
  _Patient(this.label, {this.image});

  final String label;
  final String? image;
}

List<_Patient> _patients = [
  _Patient(t.mySelf, image: AppAssets.featureDoctorImage),
  _Patient(t.childGirl),
];

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

  int _selectedPatient = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    ScheduleRoute(doctorId: widget.doctor.id).push(context);
  }

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(horizontal: context.homeRowPaddingH);
    final theme = Theme.of(context);

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(title: t.appointmentTitle, centerTitle: false),
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
                      child: _AppointmentDoctorCard(doctor: widget.doctor),
                    ),
                    SizedBox(height: context.s20),
                    Padding(
                      padding: gutter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            t.appointmentForTitle,
                            style: theme.textTheme.titleMedium,
                          ),
                          SizedBox(height: context.s12),
                          AuthTextField(
                            hint: t.patientNameHint,
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            validator: AppValidators.personName,
                          ),
                          SizedBox(height: context.s14),
                          AuthTextField(
                            hint: t.contactNumberHint,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            validator: AppValidators.phone,
                          ),
                          SizedBox(height: context.s24),
                          Text(
                            t.whoIsPatientTitle,
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.s12),
                    SizedBox(
                      height:
                          context.patientTileHeight +
                          context.s6 +
                          AppSize.patientLabelLine *
                              MediaQuery.textScalerOf(context).scale(1) +
                          context.s4,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: gutter,
                        itemCount: _patients.length + 1,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: context.s12),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _PatientTile(
                              label: t.addPatient,
                              isAdd: true,
                              onTap: _addPatient,
                            );
                          }
                          final patient = _patients[index - 1];
                          return _PatientTile(
                            label: patient.label,
                            image: patient.image,
                            selected: index - 1 == _selectedPatient,
                            onTap: () =>
                                setState(() => _selectedPatient = index - 1),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: context.s24),
                    Padding(
                      padding: gutter,
                      child: PrimaryButton(
                        label: t.next,
                        height: AppSize.appointmentNextHeight,
                        radius: AppSize.bookingActionRadius,

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
    );
  }

  void _addPatient() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(t.addPatient)));
  }
}

class _AppointmentDoctorCard extends StatefulWidget {
  const _AppointmentDoctorCard({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<_AppointmentDoctorCard> createState() => _AppointmentDoctorCardState();
}

class _AppointmentDoctorCardState extends State<_AppointmentDoctorCard> {
  late bool _favorite = widget.doctor.isFavorite;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final colors = context.themeColors;
    final doctor = widget.doctor;
    final radius = BorderRadius.circular(context.bookingCardRadius);

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: radius,
        boxShadow: [colors.homeCardShadow],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(context.s12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: doctor.photoHeroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(context.r8),
                    child: SizedBox(
                      width: context.appointmentPhotoWidth,
                      height: context.appointmentPhotoHeight,
                      child: DoctorPhoto(doctor: doctor, iconSize: context.s24),
                    ),
                  ),
                ),
                SizedBox(width: context.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: context.s28),
                        child: Text(
                          doctor.name,
                          style: theme.textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: context.s2),
                      Text(
                        doctor.specialty,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: AppSize.s12,
                          color: scheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: context.s8),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: context.s4,
                        children: [
                          RatingStars(rating: doctor.rating, size: context.s14),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '\$ ${doctor.pricePerHour.toStringAsFixed(2)}',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeight.w700,
                                    color: colors.priceAccent,
                                  ),
                                ),
                                TextSpan(
                                  text: t.perHourShort,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontSize: AppSize.s12,
                                    color: colors.priceAccent,
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: context.s12,
            right: context.s12,
            child: GestureDetector(
              onTap: () => setState(() => _favorite = !_favorite),
              behavior: HitTestBehavior.opaque,
              child: Icon(
                _favorite ? Icons.favorite : Icons.favorite_border,
                size: context.detailsHeartSize,
                color: _favorite ? scheme.error : colors.favoriteOutline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientTile extends StatelessWidget {
  const _PatientTile({
    super.key,
    required this.label,
    this.image,
    this.isAdd = false,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final String? image;
  final bool isAdd;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final width = context.patientTileWidth;
    final height = context.patientTileHeight;

    return Semantics(
      label: label,
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Material(
                color: isAdd ? scheme.primaryContainer : scheme.surface,
                borderRadius: BorderRadius.circular(context.patientTileRadius),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: onTap,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        context.patientTileRadius,
                      ),
                      border: Border.all(
                        color: selected
                            ? scheme.primary
                            : scheme.outlineVariant.withValues(alpha: 0.4),
                        width: selected
                            ? AppSize.borderFocus
                            : AppSize.borderThin,
                      ),
                    ),
                    child: isAdd ? AddContent() : PhotoContent(image: image),
                  ),
                ),
              ),
            ),
            if (!isAdd) ...[
              SizedBox(height: context.s6),
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: AppSize.s12,
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
