import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import '../widgets/appointment_body.dart';

/// Appointment step — a thin shell that resolves the doctor from the route and
/// hands it to [AppointmentBody].
class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctor = doctorById(doctorId);

    return AppBackground(
      child: doctor == null
          ? const _AppointmentNotFound()
          : AppointmentBody(doctor: doctor),
    );
  }
}

class _AppointmentNotFound extends StatelessWidget {
  const _AppointmentNotFound();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(title: AppStrings.appointmentTitle, centerTitle: false),
          const Expanded(child: Center(child: Text(AppStrings.doctorNotFound))),
        ],
      ),
    );
  }
}
