import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Visual properties for [GlyphSidebarItemTile].
///
/// State-dependent fields use [WidgetStateProperty], resolved in priority order:
/// `disabled → pressed → selected → hovered → default`.
@immutable
final class GlyphSidebarItemStyle {
  const GlyphSidebarItemStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.iconColor,
    required this.shadows,
    required this.shape,
    required this.labelTextStyle,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<Color> iconColor;
  final WidgetStateProperty<TextStyle> labelTextStyle;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final WidgetStateProperty<OutlinedBorder> shape;

  final Duration animationDuration;
  final Curve animationCurve;

  static WidgetStateProperty<Color> _background() {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return GlyphColors.surface.withValues(alpha: 0);
      }
      if (states.contains(WidgetState.pressed)) {
        if (states.contains(WidgetState.selected)) {
          return GlyphColors.surfaceSubtle;
        }
        return GlyphColors.surface.withValues(alpha: 0.85);
      }
      if (states.contains(WidgetState.selected)) {
        return GlyphColors.surfaceSubtle;
      }
      if (states.contains(WidgetState.hovered)) {
        return GlyphColors.surface.withValues(alpha: 0.7);
      }
      return GlyphColors.surface.withValues(alpha: 0);
    });
  }

  static WidgetStateProperty<Color> _foreground() {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return GlyphColors.contentDisabled;
      }
      // if (states.contains(WidgetState.selected)) {
      //   return GlyphColors.accentPrimary;
      // }
      return GlyphColors.contentSubtle;
    });
  }

  static WidgetStateProperty<Color> _iconColor() {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.disabled)) {
        return GlyphColors.contentDisabled;
      }
      if (states.contains(WidgetState.selected)) {
        return GlyphColors.accentPrimary;
      }
      return GlyphColors.contentSubtle;
    });
  }

  static WidgetStateProperty<TextStyle> _labelTextStyle() {
    return WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return GlyphTextStyles.labelSmall;
      }
      return GlyphTextStyles.labelSmall;
    });
  }

  static WidgetStateProperty<List<BoxShadow>> _shadows() {
    return WidgetStateProperty.resolveWith((states) {
      return const [];
    });
  }

  static WidgetStateProperty<OutlinedBorder> _shape() {
    return const WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: GlyphRadius.borderMedium),
    );
  }

  /// Default nav row appearance aligned with the sidebar design reference.
  factory GlyphSidebarItemStyle.standard() {
    return .new(
      backgroundColor: _background(),
      iconColor: _iconColor(),
      foregroundColor: _foreground(),
      shadows: _shadows(),
      shape: _shape(),
      labelTextStyle: _labelTextStyle(),
    );
  }

  GlyphSidebarItemStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<Color>? iconColor,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<TextStyle>? labelTextStyle,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      iconColor: iconColor ?? this.iconColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      shadows: shadows ?? this.shadows,
      shape: shape ?? this.shape,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
