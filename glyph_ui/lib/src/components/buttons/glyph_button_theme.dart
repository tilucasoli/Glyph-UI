import 'package:flutter/material.dart';

import 'glyph_button_style.dart';
import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Theme extension providing [ButtonStyle]s for filled, stroke, and ghost
/// [GlyphButtonVariant]s. Access via [GlyphButtonThemeData.of].
@immutable
class GlyphButtonThemeData extends ThemeExtension<GlyphButtonThemeData> {
  const GlyphButtonThemeData({
    required this.filledStyle,
    required this.strokeStyle,
    required this.ghostStyle,
  });

  final ButtonStyle filledStyle;
  final ButtonStyle strokeStyle;
  final ButtonStyle ghostStyle;

  /// Returns the [ButtonStyle] for the given [variant].
  ButtonStyle styleFor(GlyphButtonVariant variant) {
    switch (variant) {
      case GlyphButtonVariant.filled:
        return filledStyle;
      case GlyphButtonVariant.stroke:
        return strokeStyle;
      case GlyphButtonVariant.ghost:
        return ghostStyle;
    }
  }

  /// Reads [GlyphButtonThemeData] from the current theme. Asserts if missing.
  static GlyphButtonThemeData of(BuildContext context) {
    final data = Theme.of(context).extension<GlyphButtonThemeData>();
    assert(data != null, 'GlyphButtonThemeData not found. Add it to Theme.extensions.');
    return data!;
  }

  @override
  GlyphButtonThemeData copyWith({
    ButtonStyle? filledStyle,
    ButtonStyle? strokeStyle,
    ButtonStyle? ghostStyle,
  }) {
    return GlyphButtonThemeData(
      filledStyle: filledStyle ?? this.filledStyle,
      strokeStyle: strokeStyle ?? this.strokeStyle,
      ghostStyle: ghostStyle ?? this.ghostStyle,
    );
  }

  @override
  GlyphButtonThemeData lerp(ThemeExtension<GlyphButtonThemeData>? other, double t) {
    return this;
  }

  /// Light theme button styles (filled, stroke, ghost) with full state resolution.
  factory GlyphButtonThemeData.light() {
    return GlyphButtonThemeData(
      filledStyle: _buildFilledStyle(),
      strokeStyle: _buildStrokeStyle(),
      ghostStyle: _buildGhostStyle(),
    );
  }
}

// Slight darken steps for accent solid (hover / pressed)
const Color _accentSolidHover = Color(0xFF0D0D0D);
const Color _accentSolidPressed = Color(0xFF080808);

ButtonStyle _buildFilledStyle() {
  return ButtonStyle(
    elevation: WidgetStatePropertyAll<double>(0),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed)) return _accentSolidPressed;
      if (states.contains(WidgetState.hovered)) return _accentSolidHover;
      return GlyphColors.accentSolid;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
      return GlyphColors.accentSolidText;
    }),
    side: const WidgetStatePropertyAll<BorderSide>(BorderSide.none),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.focused)) return GlyphColors.accentBlue.withValues(alpha: 0.2);
      return null;
    }),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: GlyphRadius.borderMd),
    ),
  );
}

ButtonStyle _buildStrokeStyle() {
  return ButtonStyle(
    elevation: WidgetStatePropertyAll<double>(0),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed)) return GlyphColors.borderMedium;
      if (states.contains(WidgetState.hovered)) return GlyphColors.bgBody;
      return GlyphColors.bgSurface;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
      return GlyphColors.textPrimary;
    }),
    side: WidgetStateProperty.resolveWith<BorderSide?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: GlyphColors.accentBlue, width: 1);
      }
      return const BorderSide(color: GlyphColors.borderMedium, width: 1);
    }),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.focused)) return GlyphColors.accentBlue.withValues(alpha: 0.15);
      return null;
    }),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: GlyphRadius.borderMd),
    ),
  );
}

ButtonStyle _buildGhostStyle() {
  return ButtonStyle(
    elevation: WidgetStatePropertyAll<double>(0),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
        return GlyphColors.bgBody;
      }
      return Colors.transparent;
    }),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
      return GlyphColors.textPrimary;
    }),
    side: const WidgetStatePropertyAll<BorderSide>(BorderSide.none),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
      if (states.contains(WidgetState.focused)) return GlyphColors.accentBlue.withValues(alpha: 0.15);
      return null;
    }),
    shape: WidgetStatePropertyAll<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: GlyphRadius.borderMd),
    ),
  );
}
