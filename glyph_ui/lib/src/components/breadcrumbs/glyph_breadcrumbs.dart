import 'package:flutter/material.dart';

import 'glyph_breadcrumbs_style.dart';

/// Horizontal breadcrumb trail.
///
/// Items are separated by a chevron icon. Ancestor segments use
/// [GlyphBreadcrumbsStyle.ancestorSegmentStyle] with
/// [GlyphBreadcrumbsStyle.ancestorTextColor]; the last segment uses
/// [GlyphBreadcrumbsStyle.currentSegmentStyle] with
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
    this.size = GlyphBreadcrumbsSize.medium,
  });

  final List<String> items;
  final GlyphBreadcrumbsStyle style;
  final GlyphBreadcrumbsSize size;

  @override
  Widget build(BuildContext context) {
    final m = style;
    final sz = size;
    final children = <Widget>[];

    for (var i = 0; i < items.length; i++) {
      final isLast = i == items.length - 1;
      children.add(
        Text(
          items[i],
          style: (isLast
                  ? m.currentSegmentStyle.resolve(sz)
                  : m.ancestorSegmentStyle.resolve(sz))
              .copyWith(
            color: isLast ? m.currentTextColor : m.ancestorTextColor,
          ),
        ),
      );
      if (!isLast) {
        children.add(
          Padding(
            padding: .symmetric(horizontal: m.chevronHorizontalGutter.resolve(sz)),
            child: Icon(
              Icons.chevron_right_rounded,
              size: m.chevronSize.resolve(sz),
              color: m.separatorIconColor,
            ),
          ),
        );
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
