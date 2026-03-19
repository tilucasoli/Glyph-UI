import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';

enum GlyphButtonVariant { filled, stroke, ghost }

enum GlyphButtonSize { xsmall, small, medium }

/// Metrics for [GlyphButton] and [GlyphIconButton] per [GlyphButtonSize].
final class GlyphButtonStyleMetrics {
  const GlyphButtonStyleMetrics({
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
    required this.iconButtonSize,
    required this.iconButtonIconSize,
  });

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;

  /// Icon size for [GlyphButton] leading/trailing icons.
  final double iconSize;

  /// Horizontal gap between label and leading/trailing icons in [GlyphButton].
  final double iconGap;

  /// Min width/height for [GlyphIconButton].
  final double iconButtonSize;

  /// Icon size for [GlyphIconButton] (icon-only); spec 20/16/14.
  final double iconButtonIconSize;

  static GlyphButtonStyleMetrics forSize(GlyphButtonSize size) {
    switch (size) {
      case GlyphButtonSize.medium:
        return const GlyphButtonStyleMetrics(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          minHeight: 46,
          labelTextStyle: GlyphTextStyles.small,
          iconSize: 16,
          iconGap: 6,
          iconButtonSize: 44,
          iconButtonIconSize: 20,
        );
      case GlyphButtonSize.small:
        return GlyphButtonStyleMetrics(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          minHeight: 42,
          labelTextStyle: GlyphTextStyles.small.copyWith(
            color: GlyphColors.textPrimary,
          ),
          iconSize: 14,
          iconGap: 4,
          iconButtonSize: 36,
          iconButtonIconSize: 16,
        );
      case GlyphButtonSize.xsmall:
        return GlyphButtonStyleMetrics(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          minHeight: 38,
          labelTextStyle: GlyphTextStyles.small.copyWith(
            color: GlyphColors.textPrimary,
          ),
          iconSize: 14,
          iconGap: 4,
          iconButtonSize: 28,
          iconButtonIconSize: 14,
        );
    }
  }
}
