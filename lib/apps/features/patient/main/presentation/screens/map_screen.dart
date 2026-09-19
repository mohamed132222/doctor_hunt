import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../widgets/placeholder_tab.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderTab(title: t.tabMap, icon: Icons.map_rounded);
  }
}
