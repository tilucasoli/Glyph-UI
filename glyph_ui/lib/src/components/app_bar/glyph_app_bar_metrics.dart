import 'package:flutter/widgets.dart';

import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';

/// Dimensional metrics for [GlyphAppBar].
@immutable
final class GlyphAppBarMetrics {
  const GlyphAppBarMetrics({
    required this.padding,
    required this.minHeight,
    required this.titleTextStyle,
    required this.breadcrumbTitleGap,
    required this.actionSpacing,
  });

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle titleTextStyle;
  final double breadcrumbTitleGap;
  final double actionSpacing;

  /// Matches the design reference: 8 / 4 padding, 70 min height, h2 title.
  factory GlyphAppBarMetrics.medium() {
    return const .new(
      padding: EdgeInsets.symmetric(
        horizontal: Spacing.x8,
        vertical: Spacing.x4,
      ),
      minHeight: 70,
      titleTextStyle: GlyphTextStyles.titleXsmall,
      breadcrumbTitleGap: Spacing.x2,
      actionSpacing: Spacing.x2,
    );
  }

  GlyphAppBarMetrics copyWith({
    EdgeInsets? padding,
    double? minHeight,
    TextStyle? titleTextStyle,
    double? breadcrumbTitleGap,
    double? actionSpacing,
  }) {
    return .new(
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      breadcrumbTitleGap: breadcrumbTitleGap ?? this.breadcrumbTitleGap,
      actionSpacing: actionSpacing ?? this.actionSpacing,
    );
  }
}
