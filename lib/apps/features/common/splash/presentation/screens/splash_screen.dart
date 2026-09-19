import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/appsize/app_size.dart';
import '../../../../../core/appsize/media_query_extension.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/router/app_router.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/app_background.dart';
import 'package:doctor_hunt/generated/image_assets.dart';

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
    _naviagtion();
  }

  Future<void> _naviagtion() async {
    // Native splash has served its purpose — drop it once Flutter renders.
    FlutterNativeSplash.remove();

    // TODO: replace with real init — restore session, check auth, load config.
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.go(RoutePath.onboarding);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final width = context.screenWidth;

    return AppBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.splashLogo,
            width: width * AppSize.splashLogoFraction,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.local_hospital,
              size: width * AppSize.splashLogoFraction,
              color: colors.splashCross,
            ),
          ),
          SizedBox(height: context.paddingOf(AppSize.s24)),
          Text(AppStrings.appName, style: context.textStyles.wordmark),
        ],
      ),
    );
  }
}
