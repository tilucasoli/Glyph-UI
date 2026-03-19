import 'package:flutter/material.dart';

/// Raw color constants extracted from the Glyph design system.
/// Maps directly to the CSS custom properties in the reference UI.
abstract final class GlyphColors {
  // Backgrounds
  static const Color bgCanvas = Color(0xFFF0F0F3);
  static const Color bgSidebar = Color(0xFFF7F7F9);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color bgBody = Color(0xFFFDFDFD);

  // Text
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF8A8A8E);
  static const Color textTertiary = Color(0xFFC4C4C6);

  // Borders
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderMedium = Color(0xFFE5E5E5);

  // Accent
  static const Color accentSolid = Color(0xFF111111);
  static const Color accentSolidText = Color(0xFFFFFFFF);
  static const Color accentDanger = Color(0xFFFF4B4B);

  // Accent blue (used for focus rings, selected states, links)
  static const Color accentBlue = Color(0xFF5C61E6);
  static const Color accentBlueSurface = Color(0xFFEEF2FF);

  // Status — success
  static const Color statusSuccess = Color(0xFF10B981);
  static const Color statusSuccessSurface = Color(0xFFD1FAE5);

  // Status — warning
  static const Color statusWarning = Color(0xFFF59E0B);
  static const Color statusWarningSurface = Color(0xFFFEF3C7);
}

/// ThemeExtension that carries Glyph's semantic colors through the widget tree.
/// Access via: `Theme.of(context).extension<GlyphColorTokens>()!`
@immutable
class GlyphColorTokens extends ThemeExtension<GlyphColorTokens> {
  const GlyphColorTokens({
    required this.bgCanvas,
    required this.bgSidebar,
    required this.bgSurface,
    required this.bgBody,
    required this.textSecondary,
    required this.textTertiary,
    required this.borderLight,
    required this.borderMedium,
    required this.accentDanger,
  });

  factory GlyphColorTokens.light() => const GlyphColorTokens(
        bgCanvas: GlyphColors.bgCanvas,
        bgSidebar: GlyphColors.bgSidebar,
        bgSurface: GlyphColors.bgSurface,
        bgBody: GlyphColors.bgBody,
        textSecondary: GlyphColors.textSecondary,
        textTertiary: GlyphColors.textTertiary,
        borderLight: GlyphColors.borderLight,
        borderMedium: GlyphColors.borderMedium,
        accentDanger: GlyphColors.accentDanger,
      );

  final Color bgCanvas;
  final Color bgSidebar;
  final Color bgSurface;
  final Color bgBody;
  final Color textSecondary;
  final Color textTertiary;
  final Color borderLight;
  final Color borderMedium;
  final Color accentDanger;

  @override
  GlyphColorTokens copyWith({
    Color? bgCanvas,
    Color? bgSidebar,
    Color? bgSurface,
    Color? bgBody,
    Color? textSecondary,
    Color? textTertiary,
    Color? borderLight,
    Color? borderMedium,
    Color? accentDanger,
  }) {
    return GlyphColorTokens(
      bgCanvas: bgCanvas ?? this.bgCanvas,
      bgSidebar: bgSidebar ?? this.bgSidebar,
      bgSurface: bgSurface ?? this.bgSurface,
      bgBody: bgBody ?? this.bgBody,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      borderLight: borderLight ?? this.borderLight,
      borderMedium: borderMedium ?? this.borderMedium,
      accentDanger: accentDanger ?? this.accentDanger,
    );
  }

  @override
  GlyphColorTokens lerp(GlyphColorTokens? other, double t) {
    if (other == null) return this;
    return GlyphColorTokens(
      bgCanvas: Color.lerp(bgCanvas, other.bgCanvas, t)!,
      bgSidebar: Color.lerp(bgSidebar, other.bgSidebar, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgBody: Color.lerp(bgBody, other.bgBody, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      borderMedium: Color.lerp(borderMedium, other.borderMedium, t)!,
      accentDanger: Color.lerp(accentDanger, other.accentDanger, t)!,
    );
  }
}
