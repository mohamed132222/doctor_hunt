import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_background.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor.dart';
import '../widgets/booking_body.dart';

/// Booking page — a thin shell that resolves the doctor from the route and
/// hands it to [BookingBody].
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctor = doctorById(doctorId);

    return AppBackground(
      child: doctor == null
          ? const _BookingNotFound()
          : BookingBody(doctor: doctor),
    );
  }
}

class _BookingNotFound extends StatelessWidget {
  const _BookingNotFound();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          DoctorTopBar(
            title: AppStrings.doctorDetailsTitle,
            centerTitle: false,
          ),
          const Expanded(child: Center(child: Text(AppStrings.doctorNotFound))),
        ],
      ),
    );
  }
}
