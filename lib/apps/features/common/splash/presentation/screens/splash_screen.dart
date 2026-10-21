import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/generated/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigation();
  }

  Future<void> _navigation() async {
    FlutterNativeSplash.remove();

    await Future<void>.delayed(Duration(seconds: 2));
    if (!mounted) return;
    const OnboardingRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.splashLogo, width: 70),
          const SizedBox(height: 16),
          Text(t.appName, style: context.bold24),
        ],
      ),
    );
  }
}
