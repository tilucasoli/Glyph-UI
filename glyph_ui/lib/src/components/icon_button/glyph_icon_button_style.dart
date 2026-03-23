import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphIconButton] layout, resolved through
/// [GlyphIconButtonStyle] layout properties.
enum GlyphIconButtonSize {
  xsmall,
  small,
  medium,
}

/// Style for [GlyphIconButton]: interaction state visuals and size-keyed layout.
///
/// Colors, shape, and shadows use [WidgetStateProperty]. Layout values use
/// [WidgetCustomProperty] keyed by [GlyphIconButtonSize].
@immutable
final class GlyphIconButtonStyle {
  GlyphIconButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    required this.buttonSide,
    required this.iconSize,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  static final WidgetCustomProperty<double, GlyphIconButtonSize> _defaultButtonSide =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .xsmall => 28,
      .small => 32,
      .medium => 40,
    },
  );

  static final WidgetCustomProperty<double, GlyphIconButtonSize> _defaultIconSize =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .xsmall => 14,
      .small => 16,
      .medium => 20,
    },
  );

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  final WidgetCustomProperty<double, GlyphIconButtonSize> buttonSide;
  final WidgetCustomProperty<double, GlyphIconButtonSize> iconSize;

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
      buttonSide: _defaultButtonSide,
      iconSize: _defaultIconSize,
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
      buttonSide: _defaultButtonSide,
      iconSize: _defaultIconSize,
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
      buttonSide: _defaultButtonSide,
      iconSize: _defaultIconSize,
    );
  }

  GlyphIconButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
    WidgetCustomProperty<double, GlyphIconButtonSize>? buttonSide,
    WidgetCustomProperty<double, GlyphIconButtonSize>? iconSize,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      buttonSide: buttonSide ?? this.buttonSide,
      iconSize: iconSize ?? this.iconSize,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
