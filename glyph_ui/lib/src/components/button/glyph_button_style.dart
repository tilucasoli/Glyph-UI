import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphButton] layout, resolved through
/// [GlyphButtonStyle] layout properties.
enum GlyphButtonSize {
  xsmall,
  small,
  medium,
}

/// Style for [GlyphButton]: interaction state visuals and size-keyed layout.
///
/// Colors, shape, and shadows use [WidgetStateProperty] and are resolved
/// against the button's internal [WidgetStatesController]. Layout values use
/// [WidgetCustomProperty] keyed by [GlyphButtonSize].
@immutable
final class GlyphButtonStyle {
  GlyphButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphButtonSize> _defaultPadding =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .xsmall => const EdgeInsets.symmetric(horizontal: 10),
      .small => const EdgeInsets.symmetric(horizontal: 12),
      .medium => const EdgeInsets.symmetric(horizontal: 14),
    },
  );

  static final WidgetCustomProperty<double, GlyphButtonSize> _defaultMinHeight =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .xsmall => 32,
      .small => 36,
      .medium => 40,
    },
  );

  static final WidgetCustomProperty<TextStyle, GlyphButtonSize>
      _defaultLabelTextStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelSmallStrong,
  );

  static final WidgetCustomProperty<double, GlyphButtonSize> _defaultIconSize =
      WidgetCustomProperty.resolveWith(
    (_) => 14,
  );

  static final WidgetCustomProperty<double, GlyphButtonSize> _defaultIconGap =
      WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .xsmall => 4,
      .small => 4,
      .medium => 6,
    },
  );

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  final WidgetCustomProperty<EdgeInsets, GlyphButtonSize> padding;
  final WidgetCustomProperty<double, GlyphButtonSize> minHeight;
  final WidgetCustomProperty<TextStyle, GlyphButtonSize> labelTextStyle;
  final WidgetCustomProperty<double, GlyphButtonSize> iconSize;
  final WidgetCustomProperty<double, GlyphButtonSize> iconGap;

  factory GlyphButtonStyle.filled() {
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
      padding: _defaultPadding,
      minHeight: _defaultMinHeight,
      labelTextStyle: _defaultLabelTextStyle,
      iconSize: _defaultIconSize,
      iconGap: _defaultIconGap,
    );
  }

  factory GlyphButtonStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.surfaceSubtle;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
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
        return GlyphColors.contentSubtle;
      }),
      shape: .resolveWith((states) {
        final borderColor = states.contains(WidgetState.disabled)
            ? GlyphColors.borderDisabled
            : GlyphColors.border;
        return RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: borderColor),
        );
      }),
      padding: _defaultPadding,
      minHeight: _defaultMinHeight,
      labelTextStyle: _defaultLabelTextStyle,
      iconSize: _defaultIconSize,
      iconGap: _defaultIconGap,
    );
  }

  factory GlyphButtonStyle.ghost() {
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
        return GlyphColors.accentPrimary;
      }),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
      padding: _defaultPadding,
      minHeight: _defaultMinHeight,
      labelTextStyle: _defaultLabelTextStyle,
      iconSize: _defaultIconSize,
      iconGap: _defaultIconGap,
    );
  }

  GlyphButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
    WidgetCustomProperty<EdgeInsets, GlyphButtonSize>? padding,
    WidgetCustomProperty<double, GlyphButtonSize>? minHeight,
    WidgetCustomProperty<TextStyle, GlyphButtonSize>? labelTextStyle,
    WidgetCustomProperty<double, GlyphButtonSize>? iconSize,
    WidgetCustomProperty<double, GlyphButtonSize>? iconGap,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      iconSize: iconSize ?? this.iconSize,
      iconGap: iconGap ?? this.iconGap,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
