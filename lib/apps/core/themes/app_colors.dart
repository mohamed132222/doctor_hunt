import 'package:flutter/material.dart';

/// Central color tokens for the app.
///
/// Values follow the Doctor Hunt design system:
/// emerald-green primary, dark charcoal text, and soft ice/mint gradient
/// washes for the auth and onboarding backgrounds.
class AppColors {
  AppColors._();

  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF10B981);
  static const Color primaryLight = Color(0xFF6EE7B7);
  static const Color primaryDark = Color(0xFF047857);

  static const Color secondary = Color(0xFF60A5FA);
  static const Color secondaryLight = Color(0xFF93C5FD);
  static const Color secondaryDark = Color(0xFF2563EB);
  static const Color shadow = Color(0x14000000);
  static const Color geryLight = Color(0xFFC4C4C4);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textMain = Color(0xFF1A1A1A);
  static const Color textSub = Color(0xFF6B7280);
  static const Color textTitle = Color(0xFF333333);
  static const Color textPlaceholder = Color(0xFF9CA3AF);
  static const Color textBorders = Color(0xFFE5E7EB);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerLight = Color(0xFFFEE2E2);

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color boxShadow = Color(0x14000000);

  // ── Background gradient (auth / onboarding) ───────────────────────────────
  static const Color gradientIce = Color(0xFFEAF6FB);
  static const Color gradientMint = Color(0xFFE2F6EC);

  // ── Social brands ─────────────────────────────────────────────────────────
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color facebookBlue = Color(0xFF1877F2);
}
