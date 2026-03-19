import 'package:flutter/material.dart';

import 'glyph_colors.dart';

/// Typography constants from the Glyph design system.
///
/// Font sizes converted from rem (base 16px):
///   2rem    → 32px  (h1)
///   1.25rem → 20px  (h2)
///   1.125rem→ 18px  (ticket-price)
///   1rem    → 16px  (h3, btn)
///   0.9375rem→ 15px (body)
///   0.875rem → 14px (meta-item)
///   0.8125rem→ 13px (small)
///   0.75rem → 12px  (meta)
///   0.6875rem→ 11px (availability badge)
///
/// Letter spacing converted from em: value * fontSize.
abstract final class GlyphTextStyles {
  static const String _fontFamily = 'Inter';

  /// h1 — 32px, w700, letterSpacing -0.96
  static const TextStyle h1 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.96,
    height: 1.1,
    color: GlyphColors.textPrimary,
  );

  /// h2 — 20px, w600, letterSpacing -0.4
  static const TextStyle h2 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    color: GlyphColors.textPrimary,
  );

  /// h3 — 16px, w600
  static const TextStyle h3 = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: GlyphColors.textPrimary,
  );

  /// .text-body — 15px, secondary color
  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: GlyphColors.textSecondary,
  );

  /// .text-small — 13px, secondary color, w500
  static const TextStyle small = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: GlyphColors.textSecondary,
    leadingDistribution: TextLeadingDistribution.proportional,
  );

  /// .text-meta — 12px, secondary color
  static const TextStyle meta = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: GlyphColors.textSecondary,
  );

  /// meta-item — 14px, secondary color, w500
  static const TextStyle metaItem = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: GlyphColors.textSecondary,
  );

  /// ticket-price — 18px, w600, primary color
  static const TextStyle price = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: GlyphColors.textPrimary,
  );

  /// nav-logo — 20px, w700, letterSpacing -0.6
  static const TextStyle navLogo = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    color: GlyphColors.textPrimary,
  );

  /// btn-primary label — 16px, w600
  static const TextStyle buttonPrimary = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: GlyphColors.accentSolidText,
  );

  /// availability badge — 11px, w600
  static const TextStyle badge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: GlyphColors.textSecondary,
  );

  /// summary total — 20px, w700
  static const TextStyle summaryTotal = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: GlyphColors.textPrimary,
  );

  /// Builds a [TextTheme] for use with [ThemeData].
  static TextTheme buildTextTheme() {
    return const TextTheme(
      // h1
      displayLarge: h1,
      // h2
      titleLarge: h2,
      // h3
      titleMedium: h3,
      // body
      bodyMedium: body,
      // small
      bodySmall: small,
      // meta
      labelSmall: meta,
    );
  }
}
