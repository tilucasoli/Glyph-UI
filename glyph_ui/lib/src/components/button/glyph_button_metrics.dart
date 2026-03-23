import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphButton].
///
/// Holds non-state-dependent sizing: padding, minimum height, label text style,
/// icon size, and icon gap. Use factory constructors for standard size presets.
@immutable
final class GlyphButtonMetrics {
  const GlyphButtonMetrics({
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
  });

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;
  final double iconSize;
  final double iconGap;

  factory GlyphButtonMetrics.medium() {
    return .new(
      padding: .symmetric(horizontal: 14),
      minHeight: 40,
      labelTextStyle: GlyphTextStyles.labelSmallStrong,
      iconSize: 14,
      iconGap: 6,
    );
  }

  factory GlyphButtonMetrics.small() {
    return const .new(
      padding: .symmetric(horizontal: 12),
      minHeight: 36,
      labelTextStyle: GlyphTextStyles.labelSmallStrong,
      iconSize: 14,
      iconGap: 4,
    );
  }

  factory GlyphButtonMetrics.xsmall() {
    return const .new(
      padding: .symmetric(horizontal: 10),
      minHeight: 32,
      labelTextStyle: GlyphTextStyles.labelSmallStrong,
      iconSize: 14,
      iconGap: 4,
    );
  }

  GlyphButtonMetrics copyWith({
    EdgeInsets? padding,
    double? minHeight,
    TextStyle? labelTextStyle,
    double? iconSize,
    double? iconGap,
  }) {
    return .new(
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      iconSize: iconSize ?? this.iconSize,
      iconGap: iconGap ?? this.iconGap,
    );
  }
}
