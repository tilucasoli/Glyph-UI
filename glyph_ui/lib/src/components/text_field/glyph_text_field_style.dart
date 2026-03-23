import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Visual style for [GlyphTextField].
///
/// State-dependent values resolve against the field's internal
/// [WidgetStatesController]. Dimensions live in [GlyphTextFieldMetrics].
@immutable
final class GlyphTextFieldStyle {
  const GlyphTextFieldStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.hintColor,
    required this.shape,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<Color> hintColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  /// Stroke field matching [GlyphButtonStyle.stroke] with a focused border.
  factory GlyphTextFieldStyle.stroke() {
    return GlyphTextFieldStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        // if (states.contains(WidgetState.disabled)) {
        //   return GlyphColors.surfaceDisabled;
        // }
        // if (states.contains(WidgetState.pressed)) {
        //   return GlyphColors.surfaceSubtle;
        // }
        // if (states.contains(WidgetState.hovered)) {
        //   return GlyphColors.surfaceSubtle;
        // }
        return GlyphColors.surface;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        return GlyphColors.content;
      }),
      hintColor: const WidgetStatePropertyAll(GlyphColors.contentSubtle),
      shape: WidgetStateProperty.resolveWith((states) {
        final sideColor = _borderColorFor(states);
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: sideColor),
        );
      }),
    );
  }

  static Color _borderColorFor(Set<WidgetState> states) {
    if (states.contains(WidgetState.disabled)) {
      return GlyphColors.borderStrong;
    }
    if (states.contains(WidgetState.focused)) {
      return GlyphColors.borderStrong;
    }
    return GlyphColors.border;
  }

  GlyphTextFieldStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<Color>? hintColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return GlyphTextFieldStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      hintColor: hintColor ?? this.hintColor,
      shape: shape ?? this.shape,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
