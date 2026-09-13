import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../../generated/style_atoms.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.tabHome, style: context.semiBold20.textMain),
      ),
      body: Center(
        child: Text(AppStrings.appName, style: context.bold24.primary),
      ),
    );
  }
}
