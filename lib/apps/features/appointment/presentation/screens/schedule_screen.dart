import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/ellipse_background.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import '../widgets/schedule_body.dart';

/// Appointment step 3 — pick the date, time and reminder before confirming.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctor = doctorById(doctorId);

    return Scaffold(
      body: EllipseBackground(
        child: doctor == null
            ? const _DoctorNotFound()
            : ScheduleBody(doctor: doctor),
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
            title: AppStrings.appointmentTitle,
            centerTitle: false,
          ),
        ),
        const Expanded(child: Center(child: Text(AppStrings.doctorNotFound))),
      ],
    );
  }
}
