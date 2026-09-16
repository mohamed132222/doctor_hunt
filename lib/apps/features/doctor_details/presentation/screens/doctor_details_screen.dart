import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/ellipse_background.dart';
import '../../../main/data/models/doctor.dart';
import '../widgets/doctor_details_body.dart';
import '../widgets/doctor_top_bar.dart';

/// Doctor details page — a thin shell that resolves the doctor from the route
/// and hands it to [DoctorDetailsBody].
class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctor = doctorById(doctorId);

    return Scaffold(
      body: EllipseBackground(
        child: doctor == null
            ? const _DoctorNotFound()
            : DoctorDetailsBody(doctor: doctor),
      ),
    );
  }
}

class _DoctorNotFound extends StatelessWidget {
  const _DoctorNotFound();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: DoctorTopBar(
            title: AppStrings.doctorDetailsTitle,
            onBack: () => context.pop(),
          ),
        ),
        const Expanded(child: Center(child: Text(AppStrings.doctorNotFound))),
      ],
    );
  }
}
