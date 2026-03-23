import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Visual style for [GlyphIconButton].
///
/// State-dependent properties use [WidgetStateProperty] and are resolved
/// against the button's internal [WidgetStatesController].
/// Dimensional metrics (button size, icon size) live in
/// [GlyphIconButtonMetrics].
@immutable
final class GlyphIconButtonStyle {
  const GlyphIconButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphIconButtonStyle.filled() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.surfaceSubtle;
        }
        if (states.contains(WidgetState.pressed)) {
          return GlyphColors.accentSubtleContainer;
        }
        if (states.contains(WidgetState.hovered)) {
          return GlyphColors.accentSubtleContainer;
        }
        return GlyphColors.accentPrimary;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.accentPrimary;
        }
        return GlyphColors.surface;
      }),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(10))),
    );
  }

  factory GlyphIconButtonStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.surfaceSubtle;
        }
        if (states.contains(WidgetState.pressed)) {
          return GlyphColors.accentSubtleContainer;
        }
        if (states.contains(WidgetState.hovered)) {
          return GlyphColors.accentSubtleContainer;
        }
        return GlyphColors.surface;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.accentPrimary;
        }
        return GlyphColors.content;
      }),
      shape: .all(
        RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: GlyphColors.borderStrong),
        ),
      ),
    );
  }

  factory GlyphIconButtonStyle.ghost() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.border;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.accentSubtleContainer;
        }
        return GlyphColors.surface.withValues(alpha: 0);
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.accentPrimary;
        }
        return GlyphColors.content;
      }),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
    );
  }

  GlyphIconButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
