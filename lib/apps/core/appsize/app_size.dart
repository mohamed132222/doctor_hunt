/// Pixel-perfect design tokens (logical px at the 375×812 reference frame).
///
/// Use [ScreenUtils] to scale these to the actual device size.
/// Keep all hardcoded dimensions here — never inline numbers in widgets.
abstract final class AppSize {
  AppSize._();

  // ── Spacing ───────────────────────────────────────────────────────────────
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s42 = 42;
  static const double s48 = 48;

  // ── Corner radius ─────────────────────────────────────────────────────────
  static const double r4 = 4;
  static const double r6 = 6;
  static const double r14 = 14;
  static const double r16 = 16;
  static const double r24 = 24;

  // ── Control heights / sizes ───────────────────────────────────────────────
  static const double buttonHeight = 56;
  static const double socialButtonHeight = 52;
  static const double otpBoxSize = 52;
  static const double otpGap = 15;
  static const double otpRadius = 10;

  // ── Input field ───────────────────────────────────────────────────────────
  static const double fieldHPadding = 20;
  static const double fieldVPadding = 18;

  // ── Icons ─────────────────────────────────────────────────────────────────
  static const double iconSmall = 20;
  static const double iconSocial = 22;
  static const double iconLarge = 96;

  // ── Illustration ──────────────────────────────────────────────────────────
  static const double illustrationCircle = 240;

  // ── Borders ───────────────────────────────────────────────────────────────
  static const double borderThin = 1;
  static const double borderThick = 1.5;
  static const double borderFocus = 2;

  // ── Page indicator / sheet ────────────────────────────────────────────────
  static const double dragHandleWidth = 40;
  static const double dragHandleHeight = 4;

  // Page-indicator dots (used by [PageDots]).
  static const double dotSize = 8;
  static const double dotActiveWidth = 28;

  // ── Splash ────────────────────────────────────────────────────────────────
  static const double splashLogoFraction = 0.2;

  // ── Onboarding ────────────────────────────────────────────────────────────
  static const double onboardingImage = 336;
  static const double onboardingImageTop = 91;
  static const double onboardingImageTitleGap = 86;
  static const double onboardingTitleSubtitleGap = 14;

  /// Gap below the subtitle (keeps the CTA at y=679 on the reference frame).
  static const double onboardingSlideBottomGap = 54;

  /// Horizontal padding of the text column → 291px column, 3-line subtitle.
  static const double onboardingTextPaddingH = 42;
  static const double onboardingShapeWidth = 238;
  static const double onboardingGlowWidth = 300;
  static const double onboardingButtonLeft = 49;
  static const double onboardingButtonRight = 31;
  static const double onboardingButtonHeight = 54;
  static const double onboardingButtonRadius = 10;
  static const double onboardingButtonSkipGap = 14;
  static const double onboardingBottomPadding = 42;

  // ── Auth (login / register) ───────────────────────────────────────────────
  static const double authTitleTopGap = 84;
  static const double authTitleSubtitleGap = 8;
  static const double authSubtitleSocialGap = 72;
  static const double authSocialFieldGap = 40;
  static const double authFieldGap = 20;
  static const double authFieldButtonGap = 32;
  static const double authButtonLinkGap = 20;
  static const double authBottomGap = 28;
  static const double authCheckIconWidth = 15;
  static const double authEyeIconWidth = 17;
  static const double authEyeIconHeight = 14;

  // ── Modal sheets ──────────────────────────────────────────────────────────
  static const double sheetPaddingH = 20;
  static const double sheetTopPadding = 14;
  static const double sheetHandleWidth = 130;
  static const double sheetHandleHeight = 5;
  static const double sheetHandleTitleGap = 59;
  static const double sheetTitleSubtitleGap = 12;
  static const double sheetSubtitleContentGap = 28;
  static const double sheetBottomPadding = 34;
}
