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

/// Named text styles that don't belong to the base [TextTheme].
@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.wordmark,
    required this.onboardingTitle,
    required this.onboardingSubtitle,
    required this.onboardingSkip,
    required this.authTitle,
    required this.authSubtitle,
  });

  /// Splash wordmark: Rubik Bold 25, letter-spacing -0.3.
  final TextStyle wordmark;

  /// Onboarding title: Rubik 500 / 28 / 100% / -0.3.
  final TextStyle onboardingTitle;

  /// Onboarding subtitle: Rubik 400 / 14 / 166% / -0.3.
  final TextStyle onboardingSubtitle;

  /// Onboarding skip label: Rubik 400 / 14 / 166% / -0.3.
  final TextStyle onboardingSkip;

  /// Auth screen title: Rubik 500 / 24 / 100% / -0.3.
  final TextStyle authTitle;

  /// Auth screen subtitle: Rubik 400 / 14 / 166% / -0.3.
  final TextStyle authSubtitle;

  static final AppTextStyles light = AppTextStyles(
    wordmark: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 25,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.3,
      color: AppThemeColors.light.splashWordmark,
    ),
    onboardingTitle: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 28,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: -0.3,
      color: AppColors.textMain,
    ),
    onboardingSubtitle: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.66,
      letterSpacing: -0.3,
      color: AppColors.textSub,
    ),
    onboardingSkip: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.66,
      letterSpacing: -0.3,
      color: AppColors.textSub,
    ),
    authTitle: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: -0.3,
      color: AppColors.textMain,
    ),
    authSubtitle: TextStyle(
      fontFamily: 'Rubik',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.66,
      letterSpacing: -0.3,
      color: AppColors.textSub,
    ),
  );

  @override
  AppTextStyles copyWith({
    TextStyle? wordmark,
    TextStyle? onboardingTitle,
    TextStyle? onboardingSubtitle,
    TextStyle? onboardingSkip,
    TextStyle? authTitle,
    TextStyle? authSubtitle,
  }) {
    return AppTextStyles(
      wordmark: wordmark ?? this.wordmark,
      onboardingTitle: onboardingTitle ?? this.onboardingTitle,
      onboardingSubtitle: onboardingSubtitle ?? this.onboardingSubtitle,
      onboardingSkip: onboardingSkip ?? this.onboardingSkip,
      authTitle: authTitle ?? this.authTitle,
      authSubtitle: authSubtitle ?? this.authSubtitle,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other == null) return this;
    return AppTextStyles(
      wordmark: TextStyle.lerp(wordmark, other.wordmark, t)!,
      onboardingTitle: TextStyle.lerp(
        onboardingTitle,
        other.onboardingTitle,
        t,
      )!,
      onboardingSubtitle: TextStyle.lerp(
        onboardingSubtitle,
        other.onboardingSubtitle,
        t,
      )!,
      onboardingSkip: TextStyle.lerp(onboardingSkip, other.onboardingSkip, t)!,
      authTitle: TextStyle.lerp(authTitle, other.authTitle, t)!,
      authSubtitle: TextStyle.lerp(authSubtitle, other.authSubtitle, t)!,
    );
  }
}

/// Reads the custom text styles from any [BuildContext].
extension AppTextStylesX on BuildContext {
  AppTextStyles get textStyles =>
      Theme.of(this).extension<AppTextStyles>() ?? AppTextStyles.light;
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
      extensions: [
        AppThemeColors.light,
        AppTextStyles.light,
        AppButtonStyles.light,
      ],
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
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme scheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        side: BorderSide(color: scheme.outline),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
