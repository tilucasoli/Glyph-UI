import 'dart:ui';

import 'package:flutter/material.dart';

/// Spacing constants from the Glyph design system.
/// Based on --space-* CSS variables in the reference UI.
abstract final class GlyphSpacing {
  /// 8px  — --space-2
  static const double s2 = 8.0;

  /// 12px — --space-3
  static const double s3 = 12.0;

  /// 16px — --space-4
  static const double s4 = 16.0;

  /// 24px — --space-6
  static const double s6 = 24.0;

  /// 32px — --space-8
  static const double s8 = 32.0;

  /// 48px — --space-12
  static const double s12 = 48.0;
}

/// ThemeExtension for spacing tokens.
/// Access via: `Theme.of(context).extension<GlyphSpacingTokens>()!`
@immutable
class GlyphSpacingTokens extends ThemeExtension<GlyphSpacingTokens> {
  const GlyphSpacingTokens({
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s6,
    required this.s8,
    required this.s12,
  });

  factory GlyphSpacingTokens.defaults() => const GlyphSpacingTokens(
        s2: GlyphSpacing.s2,
        s3: GlyphSpacing.s3,
        s4: GlyphSpacing.s4,
        s6: GlyphSpacing.s6,
        s8: GlyphSpacing.s8,
        s12: GlyphSpacing.s12,
      );

  final double s2;
  final double s3;
  final double s4;
  final double s6;
  final double s8;
  final double s12;

  @override
  GlyphSpacingTokens copyWith({
    double? s2,
    double? s3,
    double? s4,
    double? s6,
    double? s8,
    double? s12,
  }) {
    return GlyphSpacingTokens(
      s2: s2 ?? this.s2,
      s3: s3 ?? this.s3,
      s4: s4 ?? this.s4,
      s6: s6 ?? this.s6,
      s8: s8 ?? this.s8,
      s12: s12 ?? this.s12,
    );
  }

  @override
  GlyphSpacingTokens lerp(GlyphSpacingTokens? other, double t) {
    if (other == null) return this;
    return GlyphSpacingTokens(
      s2: lerpDouble(s2, other.s2, t)!,
      s3: lerpDouble(s3, other.s3, t)!,
      s4: lerpDouble(s4, other.s4, t)!,
      s6: lerpDouble(s6, other.s6, t)!,
      s8: lerpDouble(s8, other.s8, t)!,
      s12: lerpDouble(s12, other.s12, t)!,
    );
  }
}
