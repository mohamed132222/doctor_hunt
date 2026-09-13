import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabAppointments,
      icon: Icons.calendar_month,
    );
  }
}
