import 'package:doctor_hunt/generated/image_assets.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
  });

  final Widget child;

  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Stack(
        fit: StackFit.expand,
        children: [
          ///todo enhance without mediaquery
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(AppAssets.ellipseTeal),
          ),

          ///todo enhance without mediaquery
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(AppAssets.ellipseGreen),
          ),
          child,
        ],
      ),
    );
  }
}
