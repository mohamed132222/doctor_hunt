import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../../../core/router/app_router.dart';
import '../../../../../core/widgets/app_background.dart';
import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:doctor_hunt/apps/core/i18n/strings.g.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';

/// First Flutter screen shown after the native splash.
///
/// Mirrors the splash design (white background + teal/green ellipses +
/// green cross + "Doctor Hunt" wordmark in Rubik Bold).
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
    // Native splash has served its purpose — drop it once Flutter renders.
    FlutterNativeSplash.remove();

    // TODO: replace with real init — restore session, check auth, load config.
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
