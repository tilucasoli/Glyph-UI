import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';
import '../../utils/widget_size_property.dart';

/// Preset sizes for [GlyphDropdown] trigger layout.
enum GlyphDropdownSize {
  medium,
  large,
}

/// Panel colors and shapes for [GlyphDropdown].
@immutable
final class GlyphDropdownStyle {
  const GlyphDropdownStyle({
    required this.panelBackgroundColor,
    required this.panelBorderSide,
    required this.panelBorderRadius,
    this.panelShadows = const [],
    required this.headerColor,
    required this.optionBackgroundColor,
    required this.optionSelectedBackgroundColor,
    required this.optionHoveredBackgroundColor,
    required this.optionForegroundColor,
    required this.optionBorderRadius,
    required this.checkmarkColor,
  });

  final Color panelBackgroundColor;
  final BorderSide panelBorderSide;
  final BorderRadius panelBorderRadius;
  final List<BoxShadow> panelShadows;

  final Color headerColor;

  final Color optionBackgroundColor;
  final Color optionSelectedBackgroundColor;
  final Color optionHoveredBackgroundColor;
  final Color optionForegroundColor;
  final BorderRadius optionBorderRadius;

  final Color checkmarkColor;

  factory GlyphDropdownStyle.standard() {
    return .new(
      panelBackgroundColor: GlyphColors.surface,
      panelBorderSide: BorderSide(color: GlyphColors.border),
      panelBorderRadius: GlyphRadius.borderMedium,
      panelShadows: [
        BoxShadow(
          color: GlyphColors.content.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const .new(0, 8),
          spreadRadius: -4,
        ),
      ],
      headerColor: GlyphColors.contentDisabled,
      optionBackgroundColor: GlyphColors.surface,
      optionSelectedBackgroundColor: GlyphColors.surfaceSubtle,
      optionHoveredBackgroundColor: GlyphColors.surfaceSubtle,
      optionForegroundColor: GlyphColors.contentSubtle,
      optionBorderRadius: GlyphRadius.borderMedium,
      checkmarkColor: GlyphColors.accentPrimary,
    );
  }

  GlyphDropdownStyle copyWith({
    Color? panelBackgroundColor,
    BorderSide? panelBorderSide,
    BorderRadius? panelBorderRadius,
    List<BoxShadow>? panelShadows,
    Color? headerColor,
    Color? optionBackgroundColor,
    Color? optionSelectedBackgroundColor,
    Color? optionHoveredBackgroundColor,
    Color? optionForegroundColor,
    BorderRadius? optionBorderRadius,
    Color? checkmarkColor,
  }) {
    return .new(
      panelBackgroundColor: panelBackgroundColor ?? this.panelBackgroundColor,
      panelBorderSide: panelBorderSide ?? this.panelBorderSide,
      panelBorderRadius: panelBorderRadius ?? this.panelBorderRadius,
      panelShadows: panelShadows ?? this.panelShadows,
      headerColor: headerColor ?? this.headerColor,
      optionBackgroundColor:
          optionBackgroundColor ?? this.optionBackgroundColor,
      optionSelectedBackgroundColor:
          optionSelectedBackgroundColor ?? this.optionSelectedBackgroundColor,
      optionHoveredBackgroundColor:
          optionHoveredBackgroundColor ?? this.optionHoveredBackgroundColor,
      optionForegroundColor:
          optionForegroundColor ?? this.optionForegroundColor,
      optionBorderRadius: optionBorderRadius ?? this.optionBorderRadius,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
    );
  }
}

/// Trigger style for [GlyphDropdown]: interaction state visuals and size-keyed
/// layout.
@immutable
final class GlyphDropdownTriggerStyle {
  GlyphDropdownTriggerStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    required this.chevronColor,
    required this.triggerPadding,
    required this.triggerMinHeight,
    required this.triggerLabelTextStyle,
    required this.triggerLeadingGap,
    required this.chevronSize,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const .new(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  static final WidgetCustomProperty<EdgeInsets, GlyphDropdownSize>
      _defaultTriggerPadding = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .medium => const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      .large => const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    },
  );

  static final WidgetCustomProperty<double, GlyphDropdownSize>
      _defaultTriggerMinHeight = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .medium => 40,
      .large => 48,
    },
  );

  static final WidgetCustomProperty<TextStyle, GlyphDropdownSize>
      _defaultTriggerLabelTextStyle = WidgetCustomProperty.resolveWith(
    (_) => GlyphTextStyles.labelSmallStrong,
  );

  static final WidgetCustomProperty<double, GlyphDropdownSize>
      _defaultTriggerLeadingGap = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .medium => 8,
      .large => 10,
    },
  );

  static final WidgetCustomProperty<double, GlyphDropdownSize>
      _defaultChevronSize = WidgetCustomProperty.resolveWith(
    (size) => switch (size) {
      .medium => 14,
      .large => 16,
    },
  );

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<Color> chevronColor;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  final WidgetCustomProperty<EdgeInsets, GlyphDropdownSize> triggerPadding;
  final WidgetCustomProperty<double, GlyphDropdownSize> triggerMinHeight;
  final WidgetCustomProperty<TextStyle, GlyphDropdownSize> triggerLabelTextStyle;
  final WidgetCustomProperty<double, GlyphDropdownSize> triggerLeadingGap;
  final WidgetCustomProperty<double, GlyphDropdownSize> chevronSize;

  factory GlyphDropdownTriggerStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.surfaceStrong;
        }
        if (states.contains(WidgetState.pressed)) {
          return GlyphColors.borderStrong;
        }
        if (states.contains(WidgetState.hovered)) {
          return GlyphColors.surfaceSubtle;
        }
        return GlyphColors.surface;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.contentDisabled;
        }
        return GlyphColors.content;
      }),
      shape: .all(
        RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: GlyphColors.border),
        ),
      ),
      chevronColor: .resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return GlyphColors.borderDisabled;
        }
        return GlyphColors.contentSubtle;
      }),
      triggerPadding: _defaultTriggerPadding,
      triggerMinHeight: _defaultTriggerMinHeight,
      triggerLabelTextStyle: _defaultTriggerLabelTextStyle,
      triggerLeadingGap: _defaultTriggerLeadingGap,
      chevronSize: _defaultChevronSize,
    );
  }

  GlyphDropdownTriggerStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<Color>? chevronColor,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
    WidgetCustomProperty<EdgeInsets, GlyphDropdownSize>? triggerPadding,
    WidgetCustomProperty<double, GlyphDropdownSize>? triggerMinHeight,
    WidgetCustomProperty<TextStyle, GlyphDropdownSize>? triggerLabelTextStyle,
    WidgetCustomProperty<double, GlyphDropdownSize>? triggerLeadingGap,
    WidgetCustomProperty<double, GlyphDropdownSize>? chevronSize,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      chevronColor: chevronColor ?? this.chevronColor,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      triggerPadding: triggerPadding ?? this.triggerPadding,
      triggerMinHeight: triggerMinHeight ?? this.triggerMinHeight,
      triggerLabelTextStyle:
          triggerLabelTextStyle ?? this.triggerLabelTextStyle,
      triggerLeadingGap: triggerLeadingGap ?? this.triggerLeadingGap,
      chevronSize: chevronSize ?? this.chevronSize,
    );
  }
}
