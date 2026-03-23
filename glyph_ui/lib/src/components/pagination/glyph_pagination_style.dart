import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Visual properties for [GlyphPagination].
///
/// Controls the bar chrome only. Page buttons are [GlyphButton] and carry
/// their own style.
@immutable
final class GlyphPaginationStyle {
  const GlyphPaginationStyle({
    required this.barBackgroundColor,
    required this.barTopBorderSide,
    required this.summaryTextColor,
  });

  final Color barBackgroundColor;
  final BorderSide barTopBorderSide;
  final Color summaryTextColor;

  factory GlyphPaginationStyle.standard() {
    return const .new(
      barBackgroundColor: GlyphColors.surface,
      barTopBorderSide: BorderSide(color: GlyphColors.border),
      summaryTextColor: GlyphColors.contentSubtle,
    );
  }

  GlyphPaginationStyle copyWith({
    Color? barBackgroundColor,
    BorderSide? barTopBorderSide,
    Color? summaryTextColor,
  }) {
    return .new(
      barBackgroundColor: barBackgroundColor ?? this.barBackgroundColor,
      barTopBorderSide: barTopBorderSide ?? this.barTopBorderSide,
      summaryTextColor: summaryTextColor ?? this.summaryTextColor,
    );
  }
}
