import 'package:flutter/material.dart';

import '../tokens/glyph_colors.dart';
import '../tokens/glyph_radius.dart';
import '../tokens/glyph_spacing.dart';
import '../tokens/glyph_typography.dart';

/// Builds the Glyph [ThemeData] and wires up all design tokens.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: GlyphTheme.light(),
///   ...
/// )
/// ```
abstract final class GlyphTheme {
  static ThemeData light() {
    final colorScheme = const ColorScheme.light(
      // accent-solid → primary
      primary: GlyphColors.accentSolid,
      onPrimary: GlyphColors.accentSolidText,
      // bg-surface → surface
      surface: GlyphColors.bgSurface,
      onSurface: GlyphColors.textPrimary,
      // bg-body → surfaceContainerLowest
      surfaceContainerLowest: GlyphColors.bgBody,
      // accent-danger → error
      error: GlyphColors.accentDanger,
      onError: GlyphColors.accentSolidText,
      // borders
      outlineVariant: GlyphColors.borderLight,
      outline: GlyphColors.borderMedium,
      // secondary text
      secondary: GlyphColors.textSecondary,
      onSecondary: GlyphColors.accentSolidText,
    );

    final textTheme = GlyphTextStyles.buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: GlyphColors.bgBody,
      fontFamily: 'Inter',

      // ── Card ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: GlyphColors.bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: GlyphRadius.borderLg,
          side: const BorderSide(color: GlyphColors.borderLight),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Elevated / Filled Button (maps to btn-primary) ────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(GlyphColors.accentSolid),
          foregroundColor:
              const WidgetStatePropertyAll(GlyphColors.accentSolidText),
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 56)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: GlyphRadius.borderMd),
          ),
          textStyle: const WidgetStatePropertyAll(
            GlyphTextStyles.buttonPrimary,
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              const WidgetStatePropertyAll(GlyphColors.textPrimary),
          side: const WidgetStatePropertyAll(
            BorderSide(color: GlyphColors.borderLight),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: GlyphRadius.borderPill),
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: GlyphColors.borderLight,
        thickness: 1,
        space: 0,
      ),

      // ── Input ─────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: GlyphColors.bgSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: GlyphSpacing.s4,
          vertical: GlyphSpacing.s3,
        ),
        border: OutlineInputBorder(
          borderRadius: GlyphRadius.borderMd,
          borderSide: const BorderSide(color: GlyphColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: GlyphRadius.borderMd,
          borderSide: const BorderSide(color: GlyphColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: GlyphRadius.borderMd,
          borderSide: const BorderSide(color: GlyphColors.textPrimary),
        ),
      ),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: GlyphColors.bgSurface,
        foregroundColor: GlyphColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GlyphTextStyles.navLogo,
      ),

      // ── Theme extensions ──────────────────────────────────────────────────
      extensions: [
        GlyphColorTokens.light(),
        GlyphSpacingTokens.defaults(),
        GlyphRadiusTokens.defaults(),
      ],
    );
  }
}

/// Convenience extension so widgets can access Glyph tokens without boilerplate.
///
/// ```dart
/// final colors = context.glyphColors;
/// final spacing = context.glyphSpacing;
/// final radius = context.glyphRadius;
/// ```
extension GlyphThemeX on BuildContext {
  GlyphColorTokens get glyphColors =>
      Theme.of(this).extension<GlyphColorTokens>()!;

  GlyphSpacingTokens get glyphSpacing =>
      Theme.of(this).extension<GlyphSpacingTokens>()!;

  GlyphRadiusTokens get glyphRadius =>
      Theme.of(this).extension<GlyphRadiusTokens>()!;

  TextTheme get glyphText => Theme.of(this).textTheme;

  ColorScheme get glyphScheme => Theme.of(this).colorScheme;
}
