import 'package:flutter/material.dart';

/// Responsive scaling utilities.
///
/// The design was authored on a 375×812 reference frame. Every size from
/// [AppSize] (or any design value) is scaled proportionally to the actual
/// device so screens stay pixel-perfect on phones, tablets and desktop.
class ScreenUtils {
  ScreenUtils._();

  static const double designWidth = 375;
  static const double designHeight = 812;

  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  static double width(BuildContext context) => size(context).width;

  static double height(BuildContext context) => size(context).height;

  /// Scales a design-px value by the device width relative to [designWidth].
  static double scaleW(BuildContext context, double value) =>
      value * width(context) / designWidth;

  /// Scales a design-px value by the device height relative to [designHeight].
  static double scaleH(BuildContext context, double value) =>
      value * height(context) / designHeight;

  /// Scales a radius (width-based).
  static double radius(BuildContext context, double value) =>
      scaleW(context, value);
}

/// Convenience extension so widgets can call `context.w(24)`, `context.h(48)`,
/// `context.r(16)` directly.
extension ScreenUtilsContext on BuildContext {
  double get sw => ScreenUtils.width(this);

  double get sh => ScreenUtils.height(this);

  /// Width-scaled design px.
  double w(double value) => ScreenUtils.scaleW(this, value);

  /// Height-scaled design px.
  double h(double value) => ScreenUtils.scaleH(this, value);

  /// Width-scaled radius.
  double r(double value) => ScreenUtils.radius(this, value);
}
