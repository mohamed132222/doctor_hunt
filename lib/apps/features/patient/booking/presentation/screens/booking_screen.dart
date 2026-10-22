import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/features/patient/booking/presentation/controllers/booking/booking_cubit.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/app_background.dart';
import '../../../doctor_details/presentation/widgets/doctor_top_bar.dart';
import '../../../main/data/models/doctor_model.dart';
import '../widgets/booking_body.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key, required this.doctorId});

  final String doctorId;

  @override
  Widget build(BuildContext context) {
    final doctor = doctorById(doctorId);

    return AppBackground(
      child: doctor == null
          ? _BookingNotFound()
          : BlocProvider<BookingCubit>(
              create: (_) => getIt<BookingCubit>()..load(doctorId),
              child: BookingBody(doctor: doctor),
            ),
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
          DoctorTopBar(title: t.doctorDetailsTitle, centerTitle: false),
          Expanded(child: Center(child: Text(t.doctorNotFound))),
        ],
      ),
    );
  }
}
