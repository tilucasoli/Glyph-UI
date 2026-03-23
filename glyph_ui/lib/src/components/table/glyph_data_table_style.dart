import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Visual properties for [GlyphDataTable].
///
/// Row backgrounds use [WidgetStateProperty] so hover, press, and disabled
/// (non-tappable) states resolve in one place. The outer frame and header use
/// plain colors — they are not interactive.
@immutable
final class GlyphDataTableStyle {
  const GlyphDataTableStyle({
    required this.containerBackgroundColor,
    required this.containerBorderSide,
    required this.containerBorderRadius,
    required this.headerBackgroundColor,
    required this.headerBottomBorderSide,
    required this.rowBackgroundColor,
    required this.rowBottomBorderSide,
    required this.headerForegroundColor,
    this.rowAnimationDuration = const Duration(milliseconds: 150),
    this.rowAnimationCurve = Curves.easeOut,
  });

  final Color containerBackgroundColor;
  final BorderSide containerBorderSide;
  final BorderRadiusGeometry containerBorderRadius;

  final Color headerBackgroundColor;
  final BorderSide headerBottomBorderSide;
  final Color headerForegroundColor;

  final WidgetStateProperty<Color> rowBackgroundColor;
  final BorderSide rowBottomBorderSide;

  final Duration rowAnimationDuration;
  final Curve rowAnimationCurve;

  /// Default table chrome: surface container, gray header, light row dividers.
  factory GlyphDataTableStyle.standard() {
    return .new(
      containerBackgroundColor: GlyphColors.surface,
      containerBorderSide: BorderSide(
        color: GlyphColors.border,
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      containerBorderRadius: GlyphRadius.borderMedium,
      headerBackgroundColor: GlyphColors.surfaceSubtle,
      headerBottomBorderSide: const BorderSide(color: GlyphColors.border),
      headerForegroundColor: GlyphColors.contentSubtle,
      rowBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.surface;
        }
        if (states.contains(WidgetState.pressed)) {
          return GlyphColors.surfaceSubtle;
        }
        if (states.contains(WidgetState.hovered)) {
          return GlyphColors.surfaceSubtle;
        }
        return GlyphColors.surface;
      }),
      rowBottomBorderSide: const BorderSide(color: GlyphColors.border),
    );
  }

  GlyphDataTableStyle copyWith({
    Color? containerBackgroundColor,
    BorderSide? containerBorderSide,
    BorderRadiusGeometry? containerBorderRadius,
    Color? headerBackgroundColor,
    BorderSide? headerBottomBorderSide,
    Color? headerForegroundColor,
    WidgetStateProperty<Color>? rowBackgroundColor,
    BorderSide? rowBottomBorderSide,
    Duration? rowAnimationDuration,
    Curve? rowAnimationCurve,
  }) {
    return .new(
      containerBackgroundColor:
          containerBackgroundColor ?? this.containerBackgroundColor,
      containerBorderSide: containerBorderSide ?? this.containerBorderSide,
      containerBorderRadius:
          containerBorderRadius ?? this.containerBorderRadius,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerBottomBorderSide:
          headerBottomBorderSide ?? this.headerBottomBorderSide,
      headerForegroundColor:
          headerForegroundColor ?? this.headerForegroundColor,
      rowBackgroundColor: rowBackgroundColor ?? this.rowBackgroundColor,
      rowBottomBorderSide: rowBottomBorderSide ?? this.rowBottomBorderSide,
      rowAnimationDuration: rowAnimationDuration ?? this.rowAnimationDuration,
      rowAnimationCurve: rowAnimationCurve ?? this.rowAnimationCurve,
    );
  }
}
