import 'package:flutter/material.dart';

import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphDataTable].
///
/// Padding and header label typography only — colors come from
/// [GlyphDataTableStyle].
@immutable
final class GlyphDataTableMetrics {
  const GlyphDataTableMetrics({
    required this.headerPadding,
    required this.rowPadding,
    required this.headerLabelStyle,
  });

  final EdgeInsets headerPadding;
  final EdgeInsets rowPadding;

  /// Base style for uppercase column headers; [GlyphDataTable] applies
  /// [headerForegroundColor] from style at build time.
  final TextStyle headerLabelStyle;

  factory GlyphDataTableMetrics.small() {
    return .new(
      headerPadding: const .symmetric(vertical: 10, horizontal: 16),
      rowPadding: const .symmetric(vertical: 12, horizontal: 16),
      headerLabelStyle: GlyphTextStyles.labelXsmallStrong,
    );
  }

  factory GlyphDataTableMetrics.medium() {
    return .new(
      headerPadding: const .symmetric(vertical: 14, horizontal: 20),
      rowPadding: const .symmetric(vertical: 16, horizontal: 20),
      headerLabelStyle: GlyphTextStyles.labelXsmallStrong,
    );
  }

  factory GlyphDataTableMetrics.large() {
    return .new(
      headerPadding: const .symmetric(vertical: 18, horizontal: 24),
      rowPadding: const .symmetric(vertical: 20, horizontal: 24),
      headerLabelStyle: GlyphTextStyles.labelSmallStrong,
    );
  }

  GlyphDataTableMetrics copyWith({
    EdgeInsets? headerPadding,
    EdgeInsets? rowPadding,
    TextStyle? headerLabelStyle,
  }) {
    return .new(
      headerPadding: headerPadding ?? this.headerPadding,
      rowPadding: rowPadding ?? this.rowPadding,
      headerLabelStyle: headerLabelStyle ?? this.headerLabelStyle,
    );
  }
}
