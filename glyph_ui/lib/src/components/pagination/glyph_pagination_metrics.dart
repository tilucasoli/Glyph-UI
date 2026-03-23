import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphPagination].
@immutable
final class GlyphPaginationMetrics {
  const GlyphPaginationMetrics({
    required this.barPadding,
    required this.pageButtonGap,
    required this.summaryLabelStyle,
  });

  final EdgeInsets barPadding;
  final double pageButtonGap;

  /// Base typography for the "Showing X to Y of Z" label; color from style.
  final TextStyle summaryLabelStyle;

  factory GlyphPaginationMetrics.small() {
    return const .new(
      barPadding: .symmetric(vertical: 12, horizontal: 16),
      pageButtonGap: 6,
      summaryLabelStyle: GlyphTextStyles.labelXsmall,
    );
  }

  factory GlyphPaginationMetrics.medium() {
    return const .new(
      barPadding: .symmetric(vertical: 16, horizontal: 20),
      pageButtonGap: 8,
      summaryLabelStyle: GlyphTextStyles.labelXsmall,
    );
  }

  GlyphPaginationMetrics copyWith({
    EdgeInsets? barPadding,
    double? pageButtonGap,
    TextStyle? summaryLabelStyle,
  }) {
    return .new(
      barPadding: barPadding ?? this.barPadding,
      pageButtonGap: pageButtonGap ?? this.pageButtonGap,
      summaryLabelStyle: summaryLabelStyle ?? this.summaryLabelStyle,
    );
  }
}
