import 'package:flutter/material.dart';

import 'glyph_colors.dart';

/// Typography tokens for the Glyph design system (Title, Subtitle, Paragraph,
/// Label scales only).
///
/// Components use [GlyphTextStyles] only — no raw [TextStyle] literals.
/// [TextStyle.copyWith] is allowed for **color** when driven by style/state/theme.
abstract final class GlyphTextStyles {
  static const String _fontFamily = 'Inter';

  // ── Title ─────────────────────────────────────────────────────────────────
  static const TextStyle titleXlarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 44,
    fontWeight: FontWeight.w500,
    height: 1.1,
    letterSpacing: -1.3,
    color: GlyphColors.content,
  );

  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.1,
    letterSpacing: -1.1,
    color: GlyphColors.content,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -0.8,
    color: GlyphColors.content,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -0.5,
    color: GlyphColors.content,
  );

  static const TextStyle titleXsmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: -0.5,
    color: GlyphColors.content,
  );

  // ── Subtitle (sizes that alias labels are declared after [labelMedium].) ───

  static const TextStyle subtitleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.2,
    color: GlyphColors.content,
  );

  static const TextStyle subtitleMediumStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: -0.2,
    color: GlyphColors.content,
  );

  // ── Label (shared 16px rows; subtitle aliases follow) ──────────────────────

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.2,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle labelMediumStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: -0.2,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle subtitleSmall = labelMedium;
  static const TextStyle subtitleSmallStrong = labelMediumStrong;

  // ── Paragraph ─────────────────────────────────────────────────────────────

  static const TextStyle paragraphMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.2,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle paragraphMediumStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -0.2,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle paragraphSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.1,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle paragraphSmallStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -0.1,
    color: GlyphColors.contentSubtle,
  );

  // ── Label (smaller steps) ─────────────────────────────────────────────────

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: -0.1,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle labelSmallStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: -0.1,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle labelXsmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle labelXsmallStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle label2Xsmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
    color: GlyphColors.contentSubtle,
  );

  static const TextStyle label2XsmallStrong = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0,
    color: GlyphColors.contentSubtle,
  );

  /// Builds a [TextTheme] for use with [ThemeData].
  static TextTheme buildTextTheme() {
    return const TextTheme(
      displayLarge: titleXlarge,
      displayMedium: titleLarge,
      displaySmall: titleMedium,
      headlineLarge: titleSmall,
      headlineMedium: titleXsmall,
      headlineSmall: subtitleMediumStrong,
      titleLarge: subtitleSmallStrong,
      titleMedium: paragraphSmallStrong,
      titleSmall: labelXsmallStrong,
      bodyLarge: paragraphMedium,
      bodyMedium: paragraphSmall,
      bodySmall: labelXsmall,
      labelLarge: labelMediumStrong,
      labelMedium: labelSmallStrong,
      labelSmall: label2XsmallStrong,
    );
  }
}
