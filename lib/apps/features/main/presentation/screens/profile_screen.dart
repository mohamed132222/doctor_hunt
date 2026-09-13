import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabProfile,
      icon: Icons.person,
    );
  }
}
