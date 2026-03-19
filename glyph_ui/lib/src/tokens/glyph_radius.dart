import 'dart:ui';

import 'package:flutter/material.dart';

/// Border radius constants from the Glyph design system.
/// Based on --radius-* CSS variables in the reference UI.
abstract final class GlyphRadius {
  /// 8px  — --radius-sm
  static const double sm = 8.0;

  /// 16px — --radius-md
  static const double md = 16.0;

  /// 24px — --radius-lg
  static const double lg = 24.0;

  /// 999px — --radius-pill
  static const double pill = 999.0;

  // BorderRadius shorthands
  static const BorderRadius borderSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius borderMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius borderLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius borderPill =
      BorderRadius.all(Radius.circular(pill));
}

/// ThemeExtension for radius tokens.
/// Access via: `Theme.of(context).extension<GlyphRadiusTokens>()!`
@immutable
class GlyphRadiusTokens extends ThemeExtension<GlyphRadiusTokens> {
  const GlyphRadiusTokens({
    required this.sm,
    required this.md,
    required this.lg,
    required this.pill,
  });

  factory GlyphRadiusTokens.defaults() => const GlyphRadiusTokens(
        sm: GlyphRadius.sm,
        md: GlyphRadius.md,
        lg: GlyphRadius.lg,
        pill: GlyphRadius.pill,
      );

  final double sm;
  final double md;
  final double lg;
  final double pill;

  BorderRadius get borderSm => BorderRadius.all(Radius.circular(sm));
  BorderRadius get borderMd => BorderRadius.all(Radius.circular(md));
  BorderRadius get borderLg => BorderRadius.all(Radius.circular(lg));
  BorderRadius get borderPill => BorderRadius.all(Radius.circular(pill));

  @override
  GlyphRadiusTokens copyWith({
    double? sm,
    double? md,
    double? lg,
    double? pill,
  }) {
    return GlyphRadiusTokens(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      pill: pill ?? this.pill,
    );
  }

  @override
  GlyphRadiusTokens lerp(GlyphRadiusTokens? other, double t) {
    if (other == null) return this;
    return GlyphRadiusTokens(
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      pill: lerpDouble(pill, other.pill, t)!,
    );
  }
}
