/// Pixel-perfect design tokens (logical px at the 375×812 reference frame).
///
/// Use the `context.sizeOf(...)` / `context.paddingOf(...)` extensions
/// (in `media_query_extension.dart`) to scale these to the actual device size.
/// Keep all hardcoded dimensions here — never inline numbers in widgets.
abstract final class AppSize {
  AppSize._();

  // ── Spacing ───────────────────────────────────────────────────────────────
  static const double s2 = 2;
  static const double s4 = 4;
  static const double s6 = 6;
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s30 = 30;
  static const double s32 = 32;
  static const double s42 = 42;
  static const double s48 = 48;

  // ── Corner radius ─────────────────────────────────────────────────────────
  static const double r4 = 4;
  static const double r6 = 6;
  static const double r8 = 8;
  static const double r12 = 12;
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

  // ── Misc surfaces ────────────────────────────────────────────────────────
  static const double chooseRoleCardWidth = 56;
  static const double placeholderIcon = 64;
  static const double onboardingGlowOffset = 60;
  static const double onboardingCtaPaddingH = 42;
  static const double ellipseTopOffset = 80;
  static const double ellipseBottomOffset = 50;

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
  static const double onboardingSlideGap = 20;

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

  // ── Home ──────────────────────────────────────────────────────────────────
  /// Header gradient height = safe top + [homeHeaderTopGap] +
  /// [homeAvatarSize] + [homeHeaderTitleGap] + half of [homeSearchHeight], so
  /// the search bar straddles the gradient's bottom edge.
  static const double homeHeaderRadius = 24;
  static const double homeHeaderTopGap = 6;
  static const double homeHeaderTitleGap = 20;
  static const double homeHeaderPaddingH = 20;
  static const double homeSearchHeight = 54;
  static const double homeSearchRadius = 6;
  static const double homeSearchPaddingH = 20;
  static const double homeSearchIconGap = 8;
  static const double homeAvatarSize = 56;
  static const double homeRowPaddingH = 16;
  static const double homeCardGap = 12;

  /// Vertical headroom inside the card rows so their shadows are not clipped.
  static const double homeCardRowPaddingV = 12;
  static const double homeSectionGap = 20;
  static const double homeHeaderCardGap = 0;
  static const double popularCardWidth = 165;

  /// Height factor of a popular card (design: 190 x 264).
  static const double popularCardAspect = 2;

  /// Card corner radius — the card art uses 8, not the 16 of the auth cards.
  static const double popularCardRadius = 12;
  static const double popularStarSize = 16;
  static const double popularImageHeight = 96;
  static const double featureCardWidth = 100;

  /// Feature cards are a fixed size so a horizontal [ListView] can lay them
  /// out; 96 x 132 matches the design (and the home reference's ~94 x 130).
  static const double featureCardHeight = 134;
  static const double featureIconSize = 10;

  /// Feature card text sizes (the name and price are deliberately small so
  /// "$ 25.00/ hours" fits the card's inner width).
  static const double featureNameSize = 13;
  static const double featurePriceSize = 9;

  /// Height of the card's text block (padding + heart/rating row + name +
  /// price + gaps). Used to grow the card when the system font is enlarged,
  /// so a fixed aspect never crops accessible text.
  static const double featureTextBlockHeight = 67;

  /// Row viewport = card height + the shadow headroom on both sides.
  static const double popularRowHeight =
      popularCardWidth * popularCardAspect + 2 * homeCardRowPaddingV;
  static const double featureRowHeight =
      featureCardHeight + 2 * homeCardRowPaddingV;

  static const double doctorAvatarSize = 55;

  // ── Bottom navigation ─────────────────────────────────────────────────────
  static const double bottomNavHeight = 70;

  /// Bar corner radius (top corners, like the header's bottom corners).
  static const double navTopRadius = 12;

  /// Horizontal inset so each item's slot is ~80px wide, matching the design's
  /// tighter grouping (items are not spread over the full width).
  static const double navPaddingH = 26;
  static const double navActiveCircle = 44;

  /// Height used for every nav SVG glyph so they keep their own aspect ratio
  /// instead of being stretched into a square.
  static const double navSvgHeight = 22;

  // ── Doctor details ────────────────────────────────────────────────────────
  /// Top bar row height, excluding the status-bar inset.
  static const double detailsTopBarHeight = 44;
  static const double detailsBackButton = 32;

  /// The top-bar buttons are rounded squares, not circles.
  static const double detailsActionRadius = 10;
  static const double detailsActionIcon = 22;
  static const double detailsCardRadius = 12;
  static const double detailsPhotoSize = 92;
  static const double detailsHeartSize = 22;
  static const double detailsBookButtonWidth = 150;
  static const double detailsBookButtonHeight = 36;
  static const double detailsBookButtonRadius = 8;
  static const double detailsStatHeight = 72;
  static const double detailsStatRadius = 10;

  /// Padding inside the stats card that holds the three stat tiles.
  static const double detailsStatsPadding = 11;
  static const double detailsMapHeight = 204;
  static const double detailsMapTopRadius = 24;
  static const double detailsMapMarker = 28;
  static const double detailsMapDot = 16;

  // ── Booking ──────────────────────────────────────────────────────────────
  static const double bookingCardPhoto = 64;
  static const double bookingCardRadius = 12;
  static const double bookingDateWidth = 150;
  static const double bookingDateHeight = 64;
  static const double bookingDateRadius = 10;

  /// Height of a date card's two text lines, used to grow the strip when the
  /// system font is enlarged.
  static const double bookingDateTextBlock = 34;
  static const double bookingSlotHeight = 40;
  static const double bookingSlotRadius = 8;
  static const double bookingActionHeight = 48;
  static const double bookingActionRadius = 10;

  /// Fill of an unselected time slot: the accent at 8%. Selected slots use the
  /// accent solid.
  static const double slotIdleAlpha = 0.08;

  // ── Search ───────────────────────────────────────────────────────────────
  static const double searchFieldHeight = 56;
  static const double searchPhotoSize = 80;
  static const double searchCardRadius = 16;
  static const double searchRankDot = 8;
  static const double searchBookWidth = 110;
  static const double searchBookHeight = 40;

  // ── Appointment ──────────────────────────────────────────────────────────
  static const double appointmentPhotoWidth = 87;
  static const double appointmentPhotoHeight = 92;
  static const double appointmentNextHeight = 56;
  static const double patientTileWidth = 100;
  static const double patientTileHeight = 125;
  static const double patientTileRadius = 14;

  /// Caption line height under a patient tile. Text keeps its size while the
  /// tile scales with the width, so this is added unscaled.
  static const double patientLabelLine = 17;

  // ── Schedule ─────────────────────────────────────────────────────────────
  static const double calendarHeaderHeight = 44;
  static const double calendarCell = 36;
  static const double calendarRadius = 16;
  static const double calendarMaxWidth = 420;
  static const double choiceChipHeight = 44;
  static const double confirmHeight = 56;

  // ── Success dialog ───────────────────────────────────────────────────────
  static const double dialogRadius = 24;
  static const double dialogIconBadge = 64;
  static const double dialogIconGlyph = 32;
  static const double dialogInset = 32;
  static const double dialogPadding = 28;
  static const double dialogTitleSize = 28;

  /// Services section padding (design: 19 sides, 27 top, 30 bottom).
  static const double servicesPaddingH = 19;
  static const double servicesPaddingTop = 27;
  static const double servicesPaddingBottom = 30;
}
