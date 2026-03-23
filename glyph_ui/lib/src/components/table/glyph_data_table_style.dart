import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphDataTable] layout.
enum GlyphDataTableSize {
  small,
  medium,
  large,
}

/// Visual and layout properties for [GlyphDataTable].
///
/// Row backgrounds use [WidgetStateProperty] so hover, press, and disabled
/// (non-tappable) states resolve in one place. Layout uses
/// [WidgetCustomProperty] keyed by [GlyphDataTableSize].
@immutable
final class GlyphDataTableStyle {
  GlyphDataTableStyle({
    required this.containerBackgroundColor,
    required this.containerBorderSide,
    required this.containerBorderRadius,
    required this.headerBackgroundColor,
    required this.headerBottomBorderSide,
    required this.rowBackgroundColor,
    required this.rowBottomBorderSide,
    required this.headerForegroundColor,
    required this.headerPadding,
    required this.rowPadding,
    required this.headerLabelStyle,
    this.rowAnimationDuration = const Duration(milliseconds: 150),
    this.rowAnimationCurve = Curves.easeOut,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphDataTableSize>
      _defaultHeaderPadding = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      .medium => const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      .large => const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
    },
  );

  static final WidgetCustomProperty<EdgeInsets, GlyphDataTableSize>
      _defaultRowPadding = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      .medium => const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      .large => const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
    },
  );

  static final WidgetCustomProperty<TextStyle, GlyphDataTableSize>
      _defaultHeaderLabelStyle = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .small => GlyphTextStyles.labelXsmallStrong,
      .medium => GlyphTextStyles.labelXsmallStrong,
      .large => GlyphTextStyles.labelSmallStrong,
    },
  );

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

  final WidgetCustomProperty<EdgeInsets, GlyphDataTableSize> headerPadding;
  final WidgetCustomProperty<EdgeInsets, GlyphDataTableSize> rowPadding;
  final WidgetCustomProperty<TextStyle, GlyphDataTableSize> headerLabelStyle;

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
      rowBackgroundColor: .resolveWith((states) {
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
      headerPadding: _defaultHeaderPadding,
      rowPadding: _defaultRowPadding,
      headerLabelStyle: _defaultHeaderLabelStyle,
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
    WidgetCustomProperty<EdgeInsets, GlyphDataTableSize>? headerPadding,
    WidgetCustomProperty<EdgeInsets, GlyphDataTableSize>? rowPadding,
    WidgetCustomProperty<TextStyle, GlyphDataTableSize>? headerLabelStyle,
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
      headerPadding: headerPadding ?? this.headerPadding,
      rowPadding: rowPadding ?? this.rowPadding,
      headerLabelStyle: headerLabelStyle ?? this.headerLabelStyle,
    );
  }
}
