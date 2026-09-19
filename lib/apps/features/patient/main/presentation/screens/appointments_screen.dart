import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../widgets/placeholder_tab.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderTab(title: t.tabAppointments, icon: Icons.calendar_month);
  }
}
