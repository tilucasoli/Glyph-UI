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
    return const .new(
      padding: .symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  factory GlyphButtonMetrics.small() {
    return const .new(
      padding: .symmetric(vertical: 10, horizontal: 14),
      minHeight: 42,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 14,
      iconGap: 4,
    );
  }

  factory GlyphButtonMetrics.xsmall() {
    return const .new(
      padding: .symmetric(vertical: 8, horizontal: 12),
      minHeight: 38,
      labelTextStyle: GlyphTextStyles.small,
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
