import 'package:flutter/material.dart';

import '../appsize/app_size.dart';
import 'app_colors.dart';

/// Extra colors not covered by [ColorScheme] (gradient washes, brand logos).
/// Read from any screen via `context.themeColors`.
@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.gradientIce,
    required this.gradientMint,
    required this.googleBlue,
    required this.facebookBlue,
    required this.primaryLight,
    required this.splashCross,
    required this.splashWordmark,
    required this.cardShadow,
    required this.sheetHandle,
    required this.headerGradientStart,
    required this.headerGradientEnd,
    required this.starRating,
    required this.navInactive,
    required this.softShadow,
    required this.tileShadow,
    required this.homeCardShadow,
    required this.favoriteOutline,
    required this.priceAccent,
    required this.screenTint,
  });

  final Color gradientIce;
  final Color gradientMint;
  final Color googleBlue;
  final Color facebookBlue;
  final Color primaryLight;
  final Color splashCross;
  final Color splashWordmark;

  /// Soft card shadow used by the auth cards and fields.
  final BoxShadow cardShadow;

  /// Grey drag-handle bar on modal sheets.
  final Color sheetHandle;

  /// Home header gradient (teal → green).
  final Color headerGradientStart;
  final Color headerGradientEnd;

  /// Amber used for star ratings.
  final Color starRating;

  /// Inactive bottom-navigation icon colour.
  final Color navInactive;

  /// Tighter, lighter shadow used by overlaid pills (e.g. the home search).
  final BoxShadow softShadow;

  /// Soft, wider shadow that lifts the home category tiles.
  final BoxShadow tileShadow;

  /// Shadow for the home doctor cards — much lighter than [cardShadow] so it
  /// hugs each card instead of reading as a shadow across the whole row.
  final BoxShadow homeCardShadow;

  /// Outline colour of an un-favourited heart.
  final Color favoriteOutline;

  /// Accent used for the hourly price.
  final Color priceAccent;

  /// Faint page tint used behind white cards on detail screens.
  final Color screenTint;

  static const AppThemeColors light = AppThemeColors(
    gradientIce: AppColors.gradientIce,
    gradientMint: AppColors.gradientMint,
    googleBlue: AppColors.googleBlue,
    facebookBlue: AppColors.facebookBlue,
    primaryLight: AppColors.primaryLight,
    splashCross: Color(0xFF0ACB96),
    splashWordmark: Color(0xFF222222),
    cardShadow: BoxShadow(
      color: Color(0x14172B4D),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
    sheetHandle: Color(0xFFC4C4C4),
    headerGradientStart: Color(0xFF0EBE7E),
    headerGradientEnd: Color(0xFF08D7AC),
    starRating: Color(0xFFF59E0B),
    navInactive: Color(0xFF858EA9),
    softShadow: BoxShadow(
      color: Color(0x05000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    tileShadow: BoxShadow(
      color: Color(0x14000000),
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
    homeCardShadow: BoxShadow(
      color: Color(0x09000000),
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
    favoriteOutline: Color(0xFF777EA5),
    priceAccent: Color(0xFF14B8A6),
    screenTint: Color(0xFFF5F7FB),
  );

  @override
  AppThemeColors copyWith({
    Color? gradientIce,
    Color? gradientMint,
    Color? googleBlue,
    Color? facebookBlue,
    Color? primaryLight,
    Color? splashCross,
    Color? splashWordmark,
    BoxShadow? cardShadow,
    Color? sheetHandle,
    Color? headerGradientStart,
    Color? headerGradientEnd,
    Color? starRating,
    Color? navInactive,
    BoxShadow? softShadow,
    BoxShadow? tileShadow,
    BoxShadow? homeCardShadow,
    Color? favoriteOutline,
    Color? priceAccent,
    Color? screenTint,
  }) {
    return AppThemeColors(
      gradientIce: gradientIce ?? this.gradientIce,
      gradientMint: gradientMint ?? this.gradientMint,
      googleBlue: googleBlue ?? this.googleBlue,
      facebookBlue: facebookBlue ?? this.facebookBlue,
      primaryLight: primaryLight ?? this.primaryLight,
      splashCross: splashCross ?? this.splashCross,
      splashWordmark: splashWordmark ?? this.splashWordmark,
      cardShadow: cardShadow ?? this.cardShadow,
      sheetHandle: sheetHandle ?? this.sheetHandle,
      headerGradientStart: headerGradientStart ?? this.headerGradientStart,
      headerGradientEnd: headerGradientEnd ?? this.headerGradientEnd,
      starRating: starRating ?? this.starRating,
      navInactive: navInactive ?? this.navInactive,
      softShadow: softShadow ?? this.softShadow,
      tileShadow: tileShadow ?? this.tileShadow,
      homeCardShadow: homeCardShadow ?? this.homeCardShadow,
      favoriteOutline: favoriteOutline ?? this.favoriteOutline,
      priceAccent: priceAccent ?? this.priceAccent,
      screenTint: screenTint ?? this.screenTint,
    );
  }

  @override
  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other == null) return this;
    return AppThemeColors(
      gradientIce: Color.lerp(gradientIce, other.gradientIce, t)!,
      gradientMint: Color.lerp(gradientMint, other.gradientMint, t)!,
      googleBlue: Color.lerp(googleBlue, other.googleBlue, t)!,
      facebookBlue: Color.lerp(facebookBlue, other.facebookBlue, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      splashCross: Color.lerp(splashCross, other.splashCross, t)!,
      splashWordmark: Color.lerp(splashWordmark, other.splashWordmark, t)!,
      cardShadow: BoxShadow.lerp(cardShadow, other.cardShadow, t)!,
      sheetHandle: Color.lerp(sheetHandle, other.sheetHandle, t)!,
      headerGradientStart: Color.lerp(
        headerGradientStart,
        other.headerGradientStart,
        t,
      )!,
      headerGradientEnd: Color.lerp(
        headerGradientEnd,
        other.headerGradientEnd,
        t,
      )!,
      starRating: Color.lerp(starRating, other.starRating, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      softShadow: BoxShadow.lerp(softShadow, other.softShadow, t)!,
      tileShadow: BoxShadow.lerp(tileShadow, other.tileShadow, t)!,
      homeCardShadow: BoxShadow.lerp(homeCardShadow, other.homeCardShadow, t)!,
      favoriteOutline: Color.lerp(favoriteOutline, other.favoriteOutline, t)!,
      priceAccent: Color.lerp(priceAccent, other.priceAccent, t)!,
      screenTint: Color.lerp(screenTint, other.screenTint, t)!,
    );
  }
}

/// Reads the custom theme colors from any [BuildContext].
extension AppThemeColorsX on BuildContext {
  AppThemeColors get themeColors =>
      Theme.of(this).extension<AppThemeColors>() ?? AppThemeColors.light;
}

/// Shorthand for `Theme.of(context).colorScheme`.
extension ColorSchemeX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

/// Named button styles that differ from the global component themes.
@immutable
class AppButtonStyles extends ThemeExtension<AppButtonStyles> {
  const AppButtonStyles({required this.onboardingCta});

  /// Onboarding CTA: 54 high, radius 10, Rubik 18/500.
  final ButtonStyle onboardingCta;

  static final AppButtonStyles light = AppButtonStyles(
    onboardingCta: FilledButton.styleFrom(
      minimumSize: const Size.fromHeight(AppSize.onboardingButtonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.onboardingButtonRadius),
      ),
      textStyle: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: 0,
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
  );

  @override
  AppButtonStyles copyWith({ButtonStyle? onboardingCta}) =>
      AppButtonStyles(onboardingCta: onboardingCta ?? this.onboardingCta);

  @override
  AppButtonStyles lerp(AppButtonStyles? other, double t) {
    if (other == null) return this;
    return AppButtonStyles(
      onboardingCta: ButtonStyle.lerp(onboardingCta, other.onboardingCta, t)!,
    );
  }
}

/// Reads the named button styles from any [BuildContext].
extension AppButtonStylesX on BuildContext {
  AppButtonStyles get buttonStyles =>
      Theme.of(this).extension<AppButtonStyles>() ?? AppButtonStyles.light;
}

/// Light theme - the single source of truth for colors, typography and
/// component styles. Screens must read from this, never hardcode.
abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Rubik',
    );

    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.secondary,
          onSecondary: AppColors.white,
          error: AppColors.danger,
          onError: AppColors.white,
          surface: AppColors.white,
          onSurface: AppColors.textMain,
          onSurfaceVariant: AppColors.textSub,
          outline: AppColors.textBorders,
          outlineVariant: AppColors.textPlaceholder,
        );

    // Rubik via Google Fonts - explicit sizes/weights/colors so screens never
    // hardcode them. Falls back to the bundled Rubik / default sans.
    final textTheme = base.textTheme.copyWith(
      headlineLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textMain,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textMain,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSub,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Rubik',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textMain,
      ),
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: textTheme,
      extensions: [AppThemeColors.light, AppButtonStyles.light],
      inputDecorationTheme: _inputTheme(colorScheme),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      textButtonTheme: _textButtonTheme(colorScheme),
      checkboxTheme: _checkboxTheme(colorScheme),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.onSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.surface,
        ),
      ),
    );
  }

  static InputDecorationTheme _inputTheme(ColorScheme scheme) {
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      hintStyle: TextStyle(color: scheme.outlineVariant, fontSize: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      enabledBorder: border(scheme.outline, 1),
      focusedBorder: border(scheme.primary, 1.5),
      errorBorder: border(scheme.error, 1),
      focusedErrorBorder: border(scheme.error, 1.5),
    );
  }

  static FilledButtonThemeData _filledButtonTheme(ColorScheme scheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.primary.withValues(alpha: 0.5),
        minimumSize: Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
        minimumSize: Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(ColorScheme scheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: scheme.primary),
    );
  }

  static CheckboxThemeData _checkboxTheme(ColorScheme scheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? scheme.primary : null,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}
