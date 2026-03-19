import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';

@immutable
final class GlyphButtonStyle {
  const GlyphButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.side,
    required this.shape,
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<BorderSide> side;
  final WidgetStateProperty<OutlinedBorder> shape;

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;
  final double iconSize;
  final double iconGap;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphButtonStyle.filled() {
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
      padding: const .symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  factory GlyphButtonStyle.stroke() {
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
      padding: const .symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  factory GlyphButtonStyle.ghost() {
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
      padding: const .symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  GlyphButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<BorderSide>? side,
    WidgetStateProperty<OutlinedBorder>? shape,
    EdgeInsets? padding,
    double? minHeight,
    TextStyle? labelTextStyle,
    double? iconSize,
    double? iconGap,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      iconSize: iconSize ?? this.iconSize,
      iconGap: iconGap ?? this.iconGap,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
