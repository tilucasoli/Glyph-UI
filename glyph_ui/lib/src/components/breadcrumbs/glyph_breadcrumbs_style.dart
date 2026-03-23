import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Visual properties for [GlyphBreadcrumbs].
///
/// Segment colors are plain values: which segment is “current” is driven by
/// item index, not pointer/focus state.
@immutable
final class GlyphBreadcrumbsStyle {
  const GlyphBreadcrumbsStyle({
    required this.ancestorTextColor,
    required this.currentTextColor,
    required this.separatorIconColor,
  });

  final Color ancestorTextColor;
  final Color currentTextColor;
  final Color separatorIconColor;

  factory GlyphBreadcrumbsStyle.standard() {
    return const .new(
      ancestorTextColor: GlyphColors.contentSubtle,
      currentTextColor: GlyphColors.content,
      separatorIconColor: GlyphColors.contentDisabled,
    );
  }

  GlyphBreadcrumbsStyle copyWith({
    Color? ancestorTextColor,
    Color? currentTextColor,
    Color? separatorIconColor,
  }) {
    return .new(
      ancestorTextColor: ancestorTextColor ?? this.ancestorTextColor,
      currentTextColor: currentTextColor ?? this.currentTextColor,
      separatorIconColor: separatorIconColor ?? this.separatorIconColor,
    );
  }
}
