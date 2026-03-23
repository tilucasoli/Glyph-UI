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
      primary: GlyphColors.accentPrimary,
      onPrimary: GlyphColors.surface,
      // bg-surface → surface
      surface: GlyphColors.surface,
      onSurface: GlyphColors.content,
      // bg-body → surfaceContainerLowest
      surfaceContainerLowest: GlyphColors.surfaceSubtle,
      // accent-danger → error
      error: GlyphColors.feedbackError,
      onError: GlyphColors.surface,
      // borders
      outlineVariant: GlyphColors.border,
      outline: GlyphColors.borderStrong,
      // secondary text
      secondary: GlyphColors.contentSubtle,
      onSecondary: GlyphColors.surface,
    );

    final textTheme = GlyphTextStyles.buildTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: GlyphColors.surfaceSubtle,
      fontFamily: 'Inter',

      // ── Card ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: GlyphColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: GlyphRadius.borderLarge,
          side: const BorderSide(color: GlyphColors.border),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Elevated / Filled Button (maps to btn-primary) ────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              const WidgetStatePropertyAll(GlyphColors.accentPrimary),
          foregroundColor:
              const WidgetStatePropertyAll(GlyphColors.surface),
          minimumSize: const WidgetStatePropertyAll(Size(double.infinity, 56)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: GlyphRadius.borderLarge),
          ),
          textStyle: WidgetStatePropertyAll(
            GlyphTextStyles.labelMediumStrong.copyWith(
              color: GlyphColors.surface,
            ),
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              const WidgetStatePropertyAll(GlyphColors.content),
          side: const WidgetStatePropertyAll(
            BorderSide(color: GlyphColors.border),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: GlyphRadius.borderPill),
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      // ── Divider ───────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: GlyphColors.border,
        thickness: 1,
        space: 0,
      ),

      // ── Input ─────────────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: GlyphColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.x4,
          vertical: Spacing.x3,
        ),
        border: OutlineInputBorder(
          borderRadius: GlyphRadius.borderLarge,
          borderSide: const BorderSide(color: GlyphColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: GlyphRadius.borderLarge,
          borderSide: const BorderSide(color: GlyphColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: GlyphRadius.borderLarge,
          borderSide: const BorderSide(color: GlyphColors.accentPrimary),
        ),
      ),

      // ── AppBar ────────────────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: GlyphColors.surface,
        foregroundColor: GlyphColors.content,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GlyphTextStyles.titleXsmall,
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
