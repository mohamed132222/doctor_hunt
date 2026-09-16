import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../widgets/placeholder_tab.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderTab(
      title: AppStrings.tabMap,
      icon: Icons.map_rounded,
    );
  }
}
