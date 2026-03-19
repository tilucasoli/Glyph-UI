import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

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
      panelBackgroundColor: GlyphColors.bgSurface,
      panelBorderSide: BorderSide(color: GlyphColors.borderMedium),
      panelBorderRadius: GlyphRadius.borderSm,
      panelShadows: [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const .new(0, 8),
          spreadRadius: -4,
        ),
      ],
      headerColor: GlyphColors.textTertiary,
      optionBackgroundColor: const Color(0x00000000),
      optionSelectedBackgroundColor: GlyphColors.bgSidebar,
      optionHoveredBackgroundColor: GlyphColors.bgBody,
      optionForegroundColor: GlyphColors.textPrimary,
      optionBorderRadius: GlyphRadius.borderSm,
      checkmarkColor: GlyphColors.textPrimary,
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
      optionBackgroundColor: optionBackgroundColor ?? this.optionBackgroundColor,
      optionSelectedBackgroundColor:
          optionSelectedBackgroundColor ?? this.optionSelectedBackgroundColor,
      optionHoveredBackgroundColor:
          optionHoveredBackgroundColor ?? this.optionHoveredBackgroundColor,
      optionForegroundColor: optionForegroundColor ?? this.optionForegroundColor,
      optionBorderRadius: optionBorderRadius ?? this.optionBorderRadius,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
    );
  }
}
