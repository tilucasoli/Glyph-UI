import 'package:flutter/material.dart';

import 'glyph_breadcrumbs_metrics.dart';
import 'glyph_breadcrumbs_style.dart';

/// Horizontal breadcrumb trail.
///
/// Items are separated by a chevron icon. Ancestor segments use
/// [GlyphBreadcrumbsMetrics.ancestorSegmentStyle] with
/// [GlyphBreadcrumbsStyle.ancestorTextColor]; the last segment uses
/// [GlyphBreadcrumbsMetrics.currentSegmentStyle] with
/// [GlyphBreadcrumbsStyle.currentTextColor].
///
/// ```dart
/// GlyphBreadcrumbs(
///   style: .standard(),
///   items: ['Design Conference 2024', 'Attendees'],
/// )
/// ```
final class GlyphBreadcrumbs extends StatelessWidget {
  const GlyphBreadcrumbs({
    super.key,
    required this.items,
    required this.style,
    this.metrics,
  });

  final List<String> items;
  final GlyphBreadcrumbsStyle style;

  /// Defaults to [GlyphBreadcrumbsMetrics.medium] when omitted.
  final GlyphBreadcrumbsMetrics? metrics;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();
    final children = <Widget>[];

    for (var i = 0; i < items.length; i++) {
      final isLast = i == items.length - 1;
      children.add(
        Text(
          items[i],
          style: (isLast ? m.currentSegmentStyle : m.ancestorSegmentStyle)
              .copyWith(
            color: isLast ? style.currentTextColor : style.ancestorTextColor,
          ),
        ),
      );
      if (!isLast) {
        children.add(
          Padding(
            padding: .symmetric(horizontal: m.chevronHorizontalGutter),
            child: Icon(
              Icons.chevron_right_rounded,
              size: m.chevronSize,
              color: style.separatorIconColor,
            ),
          ),
        );
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
