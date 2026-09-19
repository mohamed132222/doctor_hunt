import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_size.dart';

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

  /// Height-scaled design px. For the rare layout whose vertical rhythm must
  /// track the screen's *height* rather than its width (the onboarding page,
  /// which was authored that way).
  double heightOf(double value) => value * _heightScale;

  /// Spacing — `EdgeInsets`, `padding:`, gaps, list spacing.
  double paddingOf(double value) => value * _spacingScale;

  // ── AppSize tokens ───────────────────────────────────────────────────────
  // Call sites read `context.s16` instead of `context.s16`.
  // Each keeps the scaler its value actually needs.

  // paddingOf
  double get authBottomGap => paddingOf(AppSize.authBottomGap);

  double get authButtonLinkGap => paddingOf(AppSize.authButtonLinkGap);

  double get authFieldButtonGap => paddingOf(AppSize.authFieldButtonGap);

  double get authFieldGap => paddingOf(AppSize.authFieldGap);

  double get authSocialFieldGap => paddingOf(AppSize.authSocialFieldGap);

  double get authSubtitleSocialGap => paddingOf(AppSize.authSubtitleSocialGap);

  double get authTitleSubtitleGap => paddingOf(AppSize.authTitleSubtitleGap);

  double get authTitleTopGap => paddingOf(AppSize.authTitleTopGap);

  double get detailsStatsPadding => paddingOf(AppSize.detailsStatsPadding);

  double get dialogPadding => paddingOf(AppSize.dialogPadding);

  double get ellipseBottomOffset => paddingOf(AppSize.ellipseBottomOffset);

  double get ellipseTopOffset => paddingOf(AppSize.ellipseTopOffset);

  double get homeCardGap => paddingOf(AppSize.homeCardGap);

  double get homeCardRowPaddingV => paddingOf(AppSize.homeCardRowPaddingV);

  double get homeHeaderCardGap => paddingOf(AppSize.homeHeaderCardGap);

  double get homeHeaderPaddingH => paddingOf(AppSize.homeHeaderPaddingH);

  double get homeHeaderTitleGap => paddingOf(AppSize.homeHeaderTitleGap);

  double get homeHeaderTopGap => paddingOf(AppSize.homeHeaderTopGap);

  double get homeRowPaddingH => paddingOf(AppSize.homeRowPaddingH);

  double get homeSearchIconGap => paddingOf(AppSize.homeSearchIconGap);

  double get homeSearchPaddingH => paddingOf(AppSize.homeSearchPaddingH);

  double get homeSectionGap => paddingOf(AppSize.homeSectionGap);

  double get navPaddingH => paddingOf(AppSize.navPaddingH);

  double get onboardingBottomPadding =>
      paddingOf(AppSize.onboardingBottomPadding);

  double get onboardingButtonSkipGap =>
      paddingOf(AppSize.onboardingButtonSkipGap);

  double get onboardingCtaPaddingH => paddingOf(AppSize.onboardingCtaPaddingH);

  double get onboardingGlowOffset => paddingOf(AppSize.onboardingGlowOffset);

  double get onboardingSlideBottomGap =>
      paddingOf(AppSize.onboardingSlideBottomGap);

  double get onboardingSlideGap => paddingOf(AppSize.onboardingSlideGap);

  double get onboardingTitleSubtitleGap =>
      paddingOf(AppSize.onboardingTitleSubtitleGap);

  double get otpGap => paddingOf(AppSize.otpGap);

  double get s10 => paddingOf(AppSize.s10);

  double get s12 => paddingOf(AppSize.s12);

  double get s14 => paddingOf(AppSize.s14);

  double get s16 => paddingOf(AppSize.s16);

  double get s2 => paddingOf(AppSize.s2);

  double get s20 => paddingOf(AppSize.s20);

  double get s24 => paddingOf(AppSize.s24);

  double get s28 => paddingOf(AppSize.s28);

  double get s32 => paddingOf(AppSize.s32);

  double get s4 => paddingOf(AppSize.s4);

  double get s48 => paddingOf(AppSize.s48);

  double get s6 => paddingOf(AppSize.s6);

  double get s8 => paddingOf(AppSize.s8);

  double get servicesPaddingH => paddingOf(AppSize.servicesPaddingH);

  double get servicesPaddingTop => paddingOf(AppSize.servicesPaddingTop);

  double get sheetBottomPadding => paddingOf(AppSize.sheetBottomPadding);

  double get sheetHandleTitleGap => paddingOf(AppSize.sheetHandleTitleGap);

  double get sheetPaddingH => paddingOf(AppSize.sheetPaddingH);

  double get sheetSubtitleContentGap =>
      paddingOf(AppSize.sheetSubtitleContentGap);

  double get sheetTitleSubtitleGap => paddingOf(AppSize.sheetTitleSubtitleGap);

  double get sheetTopPadding => paddingOf(AppSize.sheetTopPadding);

  // heightOf
  double get onboardingImageTop => heightOf(AppSize.onboardingImageTop);

  // sizeOf
  double get appointmentPhotoHeight => sizeOf(AppSize.appointmentPhotoHeight);

  double get appointmentPhotoWidth => sizeOf(AppSize.appointmentPhotoWidth);

  double get authEyeIconHeight => sizeOf(AppSize.authEyeIconHeight);

  double get authEyeIconWidth => sizeOf(AppSize.authEyeIconWidth);

  double get bookingActionHeight => sizeOf(AppSize.bookingActionHeight);

  double get bookingActionRadius => sizeOf(AppSize.bookingActionRadius);

  double get bookingCardPhoto => sizeOf(AppSize.bookingCardPhoto);

  double get bookingCardRadius => sizeOf(AppSize.bookingCardRadius);

  double get bookingDateHeight => sizeOf(AppSize.bookingDateHeight);

  double get bookingDateRadius => sizeOf(AppSize.bookingDateRadius);

  double get bookingDateTextBlock => sizeOf(AppSize.bookingDateTextBlock);

  double get bookingDateWidth => sizeOf(AppSize.bookingDateWidth);

  double get bookingSlotHeight => sizeOf(AppSize.bookingSlotHeight);

  double get bookingSlotRadius => sizeOf(AppSize.bookingSlotRadius);

  double get bottomNavHeight => sizeOf(AppSize.bottomNavHeight);

  double get calendarCell => sizeOf(AppSize.calendarCell);

  double get calendarHeaderHeight => sizeOf(AppSize.calendarHeaderHeight);

  double get calendarMaxWidth => sizeOf(AppSize.calendarMaxWidth);

  double get calendarRadius => sizeOf(AppSize.calendarRadius);

  double get choiceChipHeight => sizeOf(AppSize.choiceChipHeight);

  double get chooseRoleCardWidth => sizeOf(AppSize.chooseRoleCardWidth);

  double get confirmHeight => sizeOf(AppSize.confirmHeight);

  double get detailsActionIcon => sizeOf(AppSize.detailsActionIcon);

  double get detailsActionRadius => sizeOf(AppSize.detailsActionRadius);

  double get detailsBackButton => sizeOf(AppSize.detailsBackButton);

  double get detailsBookButtonHeight => sizeOf(AppSize.detailsBookButtonHeight);

  double get detailsBookButtonRadius => sizeOf(AppSize.detailsBookButtonRadius);

  double get detailsBookButtonWidth => sizeOf(AppSize.detailsBookButtonWidth);

  double get detailsCardRadius => sizeOf(AppSize.detailsCardRadius);

  double get detailsHeartSize => sizeOf(AppSize.detailsHeartSize);

  double get detailsMapDot => sizeOf(AppSize.detailsMapDot);

  double get detailsMapHeight => sizeOf(AppSize.detailsMapHeight);

  double get detailsMapMarker => sizeOf(AppSize.detailsMapMarker);

  double get detailsMapTopRadius => sizeOf(AppSize.detailsMapTopRadius);

  double get detailsPhotoSize => sizeOf(AppSize.detailsPhotoSize);

  double get detailsStatHeight => sizeOf(AppSize.detailsStatHeight);

  double get detailsStatRadius => sizeOf(AppSize.detailsStatRadius);

  double get detailsTopBarHeight => sizeOf(AppSize.detailsTopBarHeight);

  double get dialogIconBadge => sizeOf(AppSize.dialogIconBadge);

  double get dialogIconGlyph => sizeOf(AppSize.dialogIconGlyph);

  double get dialogInset => sizeOf(AppSize.dialogInset);

  double get dialogRadius => sizeOf(AppSize.dialogRadius);

  double get doctorAvatarSize => sizeOf(AppSize.doctorAvatarSize);

  double get dotSize => sizeOf(AppSize.dotSize);

  double get featureCardHeight => sizeOf(AppSize.featureCardHeight);

  double get featureCardWidth => sizeOf(AppSize.featureCardWidth);

  double get featureIconSize => sizeOf(AppSize.featureIconSize);

  double get featureRowHeight => sizeOf(AppSize.featureRowHeight);

  double get featureTextBlockHeight => sizeOf(AppSize.featureTextBlockHeight);

  double get homeAvatarSize => sizeOf(AppSize.homeAvatarSize);

  double get homeHeaderRadius => sizeOf(AppSize.homeHeaderRadius);

  double get homeSearchHeight => sizeOf(AppSize.homeSearchHeight);

  double get homeSearchRadius => sizeOf(AppSize.homeSearchRadius);

  double get iconLarge => sizeOf(AppSize.iconLarge);

  double get iconSmall => sizeOf(AppSize.iconSmall);

  double get iconSocial => sizeOf(AppSize.iconSocial);

  double get navActiveCircle => sizeOf(AppSize.navActiveCircle);

  double get navSvgHeight => sizeOf(AppSize.navSvgHeight);

  double get navTopRadius => sizeOf(AppSize.navTopRadius);

  double get onboardingGlowWidth => sizeOf(AppSize.onboardingGlowWidth);

  double get onboardingShapeWidth => sizeOf(AppSize.onboardingShapeWidth);

  double get otpBoxSize => sizeOf(AppSize.otpBoxSize);

  double get otpRadius => sizeOf(AppSize.otpRadius);

  double get patientTileHeight => sizeOf(AppSize.patientTileHeight);

  double get patientTileRadius => sizeOf(AppSize.patientTileRadius);

  double get patientTileWidth => sizeOf(AppSize.patientTileWidth);

  double get placeholderIcon => sizeOf(AppSize.placeholderIcon);

  double get popularCardRadius => sizeOf(AppSize.popularCardRadius);

  double get popularCardWidth => sizeOf(AppSize.popularCardWidth);

  double get popularRowHeight => sizeOf(AppSize.popularRowHeight);

  double get popularStarSize => sizeOf(AppSize.popularStarSize);

  double get r12 => sizeOf(AppSize.r12);

  double get r14 => sizeOf(AppSize.r14);

  double get r16 => sizeOf(AppSize.r16);

  double get r24 => sizeOf(AppSize.r24);

  double get r8 => sizeOf(AppSize.r8);

  double get searchBookHeight => sizeOf(AppSize.searchBookHeight);

  double get searchBookWidth => sizeOf(AppSize.searchBookWidth);

  double get searchCardRadius => sizeOf(AppSize.searchCardRadius);

  double get searchPhotoSize => sizeOf(AppSize.searchPhotoSize);

  double get searchRankDot => sizeOf(AppSize.searchRankDot);

  double get sheetHandleHeight => sizeOf(AppSize.sheetHandleHeight);

  double get sheetHandleWidth => sizeOf(AppSize.sheetHandleWidth);

  double get socialButtonHeight => sizeOf(AppSize.socialButtonHeight);
}
