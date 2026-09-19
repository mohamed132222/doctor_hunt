import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The frame every design value was authored in.
const double _designWidth = 375;
const double _designHeight = 812;

/// Spacing never collapses to nothing on a short screen, nor balloons on a
/// large one. The floor must stay below the landscape phone's smaller-axis
/// scale (~0.46 at 800×375) so screens that already fitted there still fit.
const double _minSpacingScale = 0.4;
const double _maxSpacingScale = 1.35;

/// Everything a screen needs from its BuildContext: screen metrics, layout
/// flags, route extras, and the two responsive scalers.
///
/// Screen metrics come from Flutter's own MediaQuery context extension
/// (`mediaQuerySize`, `mediaQueryPadding`, `mediaQueryOrientation`).
///
/// * [sizeOf] — anything that sizes a box or a glyph: **width, height**,
///   radius, icon size, font size.
/// * [paddingOf] — **spacing**: `EdgeInsets`, `padding:`, gaps between boxes,
///   list spacing, anything sized by a spacing token.
extension AppSizeExtension on BuildContext {
  // ── Screen ───────────────────────────────────────────────────────────────
  // Reads Flutter's MediaQuery directly — the single source of truth for
  // device metrics — so screens never call it themselves.
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get topPadding => MediaQuery.of(this).padding.top;

  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  bool get isEnglish => Localizations.localeOf(this).languageCode == 'en';

  /// Route arguments: `context.extra<MyArgs>()`.
  T extra<T>() => GoRouterState.of(this).extra as T;

  // ── Responsive scaling ───────────────────────────────────────────────────
  /// Device width relative to the design frame.
  double get _widthScale => screenWidth / _designWidth;

  /// Device height relative to the design frame.
  double get _heightScale => screenHeight / _designHeight;

  /// The spacing scale: smaller axis, clamped. Exactly 1.0 on the design frame.
  double get _spacingScale {
    final sx = _widthScale;
    final sy = _heightScale;
    return (sx < sy ? sx : sy).clamp(_minSpacingScale, _maxSpacingScale);
  }

  /// A dimension — width, height, radius, icon size, font size.
  double sizeOf(double value) => value * _widthScale;

  /// Spacing — `EdgeInsets`, `padding:`, gaps, list spacing.
  double paddingOf(double value) => value * _spacingScale;
}
