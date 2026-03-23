import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional and typographic metrics for [GlyphBreadcrumbs].
@immutable
final class GlyphBreadcrumbsMetrics {
  const GlyphBreadcrumbsMetrics({
    required this.ancestorSegmentStyle,
    required this.currentSegmentStyle,
    required this.chevronSize,
    required this.chevronHorizontalGutter,
  });

  /// Typography for non-final segments; [GlyphBreadcrumbs] applies color from style.
  final TextStyle ancestorSegmentStyle;

  /// Typography for the final segment; [GlyphBreadcrumbs] applies color from style.
  final TextStyle currentSegmentStyle;

  final double chevronSize;
  final double chevronHorizontalGutter;

  factory GlyphBreadcrumbsMetrics.small() {
    return .new(
      ancestorSegmentStyle: GlyphTextStyles.labelSmall,
      currentSegmentStyle: GlyphTextStyles.labelSmallStrong,
      chevronSize: 10,
      chevronHorizontalGutter: 6,
    );
  }

  factory GlyphBreadcrumbsMetrics.medium() {
    return .new(
      ancestorSegmentStyle: GlyphTextStyles.labelSmall,
      currentSegmentStyle: GlyphTextStyles.labelSmallStrong,
      chevronSize: 12,
      chevronHorizontalGutter: 8,
    );
  }

  GlyphBreadcrumbsMetrics copyWith({
    TextStyle? ancestorSegmentStyle,
    TextStyle? currentSegmentStyle,
    double? chevronSize,
    double? chevronHorizontalGutter,
  }) {
    return .new(
      ancestorSegmentStyle: ancestorSegmentStyle ?? this.ancestorSegmentStyle,
      currentSegmentStyle: currentSegmentStyle ?? this.currentSegmentStyle,
      chevronSize: chevronSize ?? this.chevronSize,
      chevronHorizontalGutter:
          chevronHorizontalGutter ?? this.chevronHorizontalGutter,
    );
  }
}
