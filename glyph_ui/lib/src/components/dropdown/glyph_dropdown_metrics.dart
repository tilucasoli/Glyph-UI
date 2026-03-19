import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for the dropdown trigger.
///
/// Holds non-state-dependent trigger sizing: padding, minimum height, label
/// text style, leading gap, and chevron size. Panel/option row metrics stay
/// internal to the widget. Use factory constructors for standard size presets.
@immutable
final class GlyphDropdownMetrics {
  const GlyphDropdownMetrics({
    required this.triggerPadding,
    required this.triggerMinHeight,
    required this.triggerLabelTextStyle,
    required this.triggerLeadingGap,
    required this.chevronSize,
  });

  final EdgeInsets triggerPadding;
  final double triggerMinHeight;
  final TextStyle triggerLabelTextStyle;
  final double triggerLeadingGap;
  final double chevronSize;

  factory GlyphDropdownMetrics.medium() {
    return const .new(
      triggerPadding: .symmetric(vertical: 8, horizontal: 14),
      triggerMinHeight: 40,
      triggerLabelTextStyle: GlyphTextStyles.small,
      triggerLeadingGap: 8,
      chevronSize: 14,
    );
  }

  factory GlyphDropdownMetrics.large() {
    return const .new(
      triggerPadding: .symmetric(vertical: 10, horizontal: 16),
      triggerMinHeight: 48,
      triggerLabelTextStyle: GlyphTextStyles.metaItem,
      triggerLeadingGap: 10,
      chevronSize: 16,
    );
  }

  GlyphDropdownMetrics copyWith({
    EdgeInsets? triggerPadding,
    double? triggerMinHeight,
    TextStyle? triggerLabelTextStyle,
    double? triggerLeadingGap,
    double? chevronSize,
  }) {
    return .new(
      triggerPadding: triggerPadding ?? this.triggerPadding,
      triggerMinHeight: triggerMinHeight ?? this.triggerMinHeight,
      triggerLabelTextStyle:
          triggerLabelTextStyle ?? this.triggerLabelTextStyle,
      triggerLeadingGap: triggerLeadingGap ?? this.triggerLeadingGap,
      chevronSize: chevronSize ?? this.chevronSize,
    );
  }
}
