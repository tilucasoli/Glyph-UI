import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

@immutable
final class GlyphDropdownTriggerStyle {
  const GlyphDropdownTriggerStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    required this.chevronColor,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<Color> chevronColor;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphDropdownTriggerStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.borderLight;
        }
        if (states.contains(WidgetState.pressed)) {
          return GlyphColors.borderMedium;
        }
        if (states.contains(WidgetState.hovered)) return GlyphColors.bgBody;
        return GlyphColors.bgSurface;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.textTertiary;
        }
        return GlyphColors.textPrimary;
      }),
      shape: .all(
        RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: GlyphColors.borderMedium),
        ),
      ),
      chevronColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.borderMedium;
        }
        return GlyphColors.textTertiary;
      }),
    );
  }

  GlyphDropdownTriggerStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<Color>? chevronColor,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      chevronColor: chevronColor ?? this.chevronColor,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
