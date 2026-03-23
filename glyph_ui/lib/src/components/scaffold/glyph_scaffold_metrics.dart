import 'package:flutter/widgets.dart';

import '../../tokens/glyph_spacing.dart';

/// Dimensional metrics for [GlyphScaffold].
@immutable
final class GlyphScaffoldMetrics {
  const GlyphScaffoldMetrics({
    required this.outerPadding,
    required this.sidebarContentGap,
  });

  final EdgeInsets outerPadding;
  final double sidebarContentGap;

  /// 16px outer inset and 16px gap between sidebar and main panel.
  factory GlyphScaffoldMetrics.medium() {
    return const .new(
      outerPadding: EdgeInsets.all(Spacing.x4),
      sidebarContentGap: Spacing.x4,
    );
  }

  GlyphScaffoldMetrics copyWith({
    EdgeInsets? outerPadding,
    double? sidebarContentGap,
  }) {
    return .new(
      outerPadding: outerPadding ?? this.outerPadding,
      sidebarContentGap: sidebarContentGap ?? this.sidebarContentGap,
    );
  }
}
