import 'dart:ui';

import 'package:flutter/material.dart';

/// Border radius constants from the Glyph design system.
abstract final class GlyphRadius {
  /// 0px
  static const double none = 0.0;

  /// 4px
  static const double small = 4.0;

  /// 8px
  static const double medium = 8.0;

  /// 16px
  static const double large = 16.0;

  /// 64px
  static const double jumbo = 64.0;

  /// Fully rounded pill / stadium shape (not on the size scale).
  static const double pill = 999.0;

  static const BorderRadius borderNone =
      BorderRadius.all(Radius.circular(none));
  static const BorderRadius borderSmall =
      BorderRadius.all(Radius.circular(small));
  static const BorderRadius borderMedium =
      BorderRadius.all(Radius.circular(medium));
  static const BorderRadius borderLarge =
      BorderRadius.all(Radius.circular(large));
  static const BorderRadius borderJumbo =
      BorderRadius.all(Radius.circular(jumbo));
  static const BorderRadius borderPill =
      BorderRadius.all(Radius.circular(pill));
}

/// ThemeExtension for radius tokens.
/// Access via: `Theme.of(context).extension<GlyphRadiusTokens>()!`
@immutable
class GlyphRadiusTokens extends ThemeExtension<GlyphRadiusTokens> {
  const GlyphRadiusTokens({
    required this.none,
    required this.small,
    required this.medium,
    required this.large,
    required this.jumbo,
    required this.pill,
  });

  factory GlyphRadiusTokens.defaults() => const GlyphRadiusTokens(
        none: GlyphRadius.none,
        small: GlyphRadius.small,
        medium: GlyphRadius.medium,
        large: GlyphRadius.large,
        jumbo: GlyphRadius.jumbo,
        pill: GlyphRadius.pill,
      );

  final double none;
  final double small;
  final double medium;
  final double large;
  final double jumbo;
  final double pill;

  BorderRadius get borderNone => BorderRadius.all(Radius.circular(none));
  BorderRadius get borderSmall => BorderRadius.all(Radius.circular(small));
  BorderRadius get borderMedium => BorderRadius.all(Radius.circular(medium));
  BorderRadius get borderLarge => BorderRadius.all(Radius.circular(large));
  BorderRadius get borderJumbo => BorderRadius.all(Radius.circular(jumbo));
  BorderRadius get borderPill => BorderRadius.all(Radius.circular(pill));

  @override
  GlyphRadiusTokens copyWith({
    double? none,
    double? small,
    double? medium,
    double? large,
    double? jumbo,
    double? pill,
  }) {
    return GlyphRadiusTokens(
      none: none ?? this.none,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      jumbo: jumbo ?? this.jumbo,
      pill: pill ?? this.pill,
    );
  }

  @override
  GlyphRadiusTokens lerp(GlyphRadiusTokens? other, double t) {
    if (other == null) return this;
    return GlyphRadiusTokens(
      none: lerpDouble(none, other.none, t)!,
      small: lerpDouble(small, other.small, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      large: lerpDouble(large, other.large, t)!,
      jumbo: lerpDouble(jumbo, other.jumbo, t)!,
      pill: lerpDouble(pill, other.pill, t)!,
    );
  }
}
