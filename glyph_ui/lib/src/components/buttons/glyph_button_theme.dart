import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import 'glyph_button_style.dart';

/// Theme data providing [ButtonStyle]s for filled, stroke, and ghost
/// [GlyphButtonVariant]s. Access via [GlyphButtonThemeData.of].
@immutable
final class GlyphButtonThemeData extends ThemeExtension<GlyphButtonThemeData> {
  const GlyphButtonThemeData({
    required this.filledStyle,
    required this.strokeStyle,
    required this.ghostStyle,
  });

  final ButtonStyle filledStyle;
  final ButtonStyle strokeStyle;
  final ButtonStyle ghostStyle;

  /// Returns the [ButtonStyle] for [variant].
  ButtonStyle styleFor(GlyphButtonVariant variant) {
    switch (variant) {
      case .filled:
        return filledStyle;
      case .stroke:
        return strokeStyle;
      case .ghost:
        return ghostStyle;
    }
  }

  /// Reads [GlyphButtonThemeData] from the current [Theme].
  ///
  /// Throws if this extension is not found in [Theme.extensions]. In debug
  /// mode, asserts with a message; ensure the extension is added to the theme.
  static GlyphButtonThemeData of(BuildContext context) {
    final data = Theme.of(context).extension<GlyphButtonThemeData>();
    assert(
      data != null,
      'GlyphButtonThemeData not found. Add it to Theme.extensions.',
    );
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
  GlyphButtonThemeData lerp(
    ThemeExtension<GlyphButtonThemeData>? other,
    double t,
  ) {
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
    elevation: .all(0),
    backgroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed)) return _accentSolidPressed;
      if (states.contains(WidgetState.hovered)) return _accentSolidHover;
      return GlyphColors.accentSolid;
    }),
    foregroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled))
        return GlyphColors.textTertiary;
      return GlyphColors.accentSolidText;
    }),
    side: .all(BorderSide.none),
    overlayColor: .resolveWith((states) {
      if (states.contains(WidgetState.focused))
        return GlyphColors.accentBlue.withValues(alpha: 0.2);
      return null;
    }),
    shape: .all(RoundedRectangleBorder(borderRadius: .circular(10))),
  );
}

ButtonStyle _buildStrokeStyle() {
  return ButtonStyle(
    elevation: .all(0),
    backgroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed)) return GlyphColors.borderMedium;
      if (states.contains(WidgetState.hovered)) return GlyphColors.bgBody;
      return GlyphColors.bgSurface;
    }),
    foregroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled))
        return GlyphColors.textTertiary;
      return GlyphColors.textPrimary;
    }),
    side: .resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return const BorderSide(color: GlyphColors.accentBlue, width: 1);
      }
      return const BorderSide(color: GlyphColors.borderMedium, width: 1);
    }),
    overlayColor: .resolveWith((states) {
      if (states.contains(WidgetState.focused))
        return GlyphColors.accentBlue.withValues(alpha: 0.15);
      return null;
    }),
    shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
  );
}

ButtonStyle _buildGhostStyle() {
  return ButtonStyle(
    elevation: .all(0),
    backgroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
      if (states.contains(WidgetState.pressed) ||
          states.contains(WidgetState.hovered)) {
        return GlyphColors.bgBody;
      }
      return Colors.transparent;
    }),
    foregroundColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled))
        return GlyphColors.textTertiary;
      return GlyphColors.textPrimary;
    }),
    iconColor: .resolveWith((states) {
      if (states.contains(WidgetState.disabled))
        return GlyphColors.textTertiary;
      return GlyphColors.textPrimary;
    }),
    side: .all(.none),
    overlayColor: .resolveWith((states) {
      if (states.contains(WidgetState.focused))
        return GlyphColors.accentBlue.withValues(alpha: 0.15);
      return null;
    }),
    shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
  );
}
