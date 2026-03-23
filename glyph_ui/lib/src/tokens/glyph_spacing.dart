import 'dart:ui';

import 'package:flutter/material.dart';

/// Spacing scale: each step [xN] equals N × 4 logical pixels.
abstract final class Spacing {
  static const double unit = 4.0;

  static const double x1 = 4.0;
  static const double x2 = 8.0;
  static const double x3 = 12.0;
  static const double x4 = 16.0;
  static const double x5 = 20.0;
  static const double x6 = 24.0;
  static const double x7 = 28.0;
  static const double x8 = 32.0;
  static const double x9 = 36.0;
  static const double x10 = 40.0;
  static const double x11 = 44.0;
  static const double x12 = 48.0;
  static const double x13 = 52.0;
  static const double x14 = 56.0;
  static const double x15 = 60.0;
  static const double x16 = 64.0;
  static const double x17 = 68.0;
  static const double x18 = 72.0;
  static const double x19 = 76.0;
  static const double x20 = 80.0;
}

/// ThemeExtension for spacing tokens.
/// Access via: `Theme.of(context).extension<GlyphSpacingTokens>()!`
@immutable
class GlyphSpacingTokens extends ThemeExtension<GlyphSpacingTokens> {
  const GlyphSpacingTokens({
    required this.x1,
    required this.x2,
    required this.x3,
    required this.x4,
    required this.x5,
    required this.x6,
    required this.x7,
    required this.x8,
    required this.x9,
    required this.x10,
    required this.x11,
    required this.x12,
    required this.x13,
    required this.x14,
    required this.x15,
    required this.x16,
    required this.x17,
    required this.x18,
    required this.x19,
    required this.x20,
  });

  factory GlyphSpacingTokens.defaults() => const GlyphSpacingTokens(
        x1: Spacing.x1,
        x2: Spacing.x2,
        x3: Spacing.x3,
        x4: Spacing.x4,
        x5: Spacing.x5,
        x6: Spacing.x6,
        x7: Spacing.x7,
        x8: Spacing.x8,
        x9: Spacing.x9,
        x10: Spacing.x10,
        x11: Spacing.x11,
        x12: Spacing.x12,
        x13: Spacing.x13,
        x14: Spacing.x14,
        x15: Spacing.x15,
        x16: Spacing.x16,
        x17: Spacing.x17,
        x18: Spacing.x18,
        x19: Spacing.x19,
        x20: Spacing.x20,
      );

  final double x1;
  final double x2;
  final double x3;
  final double x4;
  final double x5;
  final double x6;
  final double x7;
  final double x8;
  final double x9;
  final double x10;
  final double x11;
  final double x12;
  final double x13;
  final double x14;
  final double x15;
  final double x16;
  final double x17;
  final double x18;
  final double x19;
  final double x20;

  @override
  GlyphSpacingTokens copyWith({
    double? x1,
    double? x2,
    double? x3,
    double? x4,
    double? x5,
    double? x6,
    double? x7,
    double? x8,
    double? x9,
    double? x10,
    double? x11,
    double? x12,
    double? x13,
    double? x14,
    double? x15,
    double? x16,
    double? x17,
    double? x18,
    double? x19,
    double? x20,
  }) {
    return GlyphSpacingTokens(
      x1: x1 ?? this.x1,
      x2: x2 ?? this.x2,
      x3: x3 ?? this.x3,
      x4: x4 ?? this.x4,
      x5: x5 ?? this.x5,
      x6: x6 ?? this.x6,
      x7: x7 ?? this.x7,
      x8: x8 ?? this.x8,
      x9: x9 ?? this.x9,
      x10: x10 ?? this.x10,
      x11: x11 ?? this.x11,
      x12: x12 ?? this.x12,
      x13: x13 ?? this.x13,
      x14: x14 ?? this.x14,
      x15: x15 ?? this.x15,
      x16: x16 ?? this.x16,
      x17: x17 ?? this.x17,
      x18: x18 ?? this.x18,
      x19: x19 ?? this.x19,
      x20: x20 ?? this.x20,
    );
  }

  @override
  GlyphSpacingTokens lerp(GlyphSpacingTokens? other, double t) {
    if (other == null) return this;
    return GlyphSpacingTokens(
      x1: lerpDouble(x1, other.x1, t)!,
      x2: lerpDouble(x2, other.x2, t)!,
      x3: lerpDouble(x3, other.x3, t)!,
      x4: lerpDouble(x4, other.x4, t)!,
      x5: lerpDouble(x5, other.x5, t)!,
      x6: lerpDouble(x6, other.x6, t)!,
      x7: lerpDouble(x7, other.x7, t)!,
      x8: lerpDouble(x8, other.x8, t)!,
      x9: lerpDouble(x9, other.x9, t)!,
      x10: lerpDouble(x10, other.x10, t)!,
      x11: lerpDouble(x11, other.x11, t)!,
      x12: lerpDouble(x12, other.x12, t)!,
      x13: lerpDouble(x13, other.x13, t)!,
      x14: lerpDouble(x14, other.x14, t)!,
      x15: lerpDouble(x15, other.x15, t)!,
      x16: lerpDouble(x16, other.x16, t)!,
      x17: lerpDouble(x17, other.x17, t)!,
      x18: lerpDouble(x18, other.x18, t)!,
      x19: lerpDouble(x19, other.x19, t)!,
      x20: lerpDouble(x20, other.x20, t)!,
    );
  }
}
