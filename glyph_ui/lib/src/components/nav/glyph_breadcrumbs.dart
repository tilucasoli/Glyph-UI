import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';

/// Horizontal breadcrumb trail.
///
/// Items are separated by a chevron icon. All but the last item use
/// [GlyphColors.textSecondary] / w400; the last uses [GlyphColors.textPrimary] / w500.
///
/// ```dart
/// GlyphBreadcrumbs(
///   items: ['Design Conference 2024', 'Attendees'],
/// )
/// ```
class GlyphBreadcrumbs extends StatelessWidget {
  const GlyphBreadcrumbs({super.key, required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final isLast = i == items.length - 1;
      children.add(
        Text(
          items[i],
          style: GlyphTextStyles.small.copyWith(
            color: isLast ? GlyphColors.textPrimary : GlyphColors.textSecondary,
            fontWeight: isLast ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      );
      if (!isLast) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Icons.chevron_right_rounded,
              size: 12,
              color: GlyphColors.textTertiary,
            ),
          ),
        );
      }
    }

    return Row(mainAxisSize: MainAxisSize.min, children: children);
  }
}
