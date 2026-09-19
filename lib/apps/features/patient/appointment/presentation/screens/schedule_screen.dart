import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_background.dart';
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

    return AppBackground(
      child: doctor == null ? _DoctorNotFound() : ScheduleBody(doctor: doctor),
    );
  }
}

class _DoctorNotFound extends StatelessWidget {
  const _DoctorNotFound();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(title: t.appointmentTitle, centerTitle: false),
          Expanded(child: Center(child: Text(t.doctorNotFound))),
        ],
      ),
    );
  }
}
