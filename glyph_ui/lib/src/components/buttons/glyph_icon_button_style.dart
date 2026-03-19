import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

@immutable
final class GlyphIconButtonStyle {
  const GlyphIconButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.side,
    required this.shape,
    required this.buttonSize,
    required this.iconSize,
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<BorderSide> side;
  final WidgetStateProperty<OutlinedBorder> shape;

  final double buttonSize;
  final double iconSize;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphIconButtonStyle.filled() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.borderLight;
        }
        if (states.contains(WidgetState.pressed)) {
          return const .new(0xFF080808);
        }
        if (states.contains(WidgetState.hovered)) {
          return const .new(0xFF0D0D0D);
        }
        return GlyphColors.accentSolid;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.textTertiary;
        }
        return GlyphColors.accentSolidText;
      }),
      side: .all(.none),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(10))),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  factory GlyphIconButtonStyle.stroke() {
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
      side: .all(const BorderSide(color: GlyphColors.borderMedium)),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  factory GlyphIconButtonStyle.ghost() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.borderLight;
        }
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.bgBody;
        }
        return const .new(0x00000000);
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.textTertiary;
        }
        return GlyphColors.textPrimary;
      }),
      side: .all(.none),
      shape: .all(RoundedRectangleBorder(borderRadius: .circular(8))),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  GlyphIconButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<BorderSide>? side,
    WidgetStateProperty<OutlinedBorder>? shape,
    double? buttonSize,
    double? iconSize,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      buttonSize: buttonSize ?? this.buttonSize,
      iconSize: iconSize ?? this.iconSize,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
