import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';
import 'glyph_badge_style.dart';

/// Pill-shaped label badge.
///
/// A non-interactive display element used for status labels, tags, and
/// category indicators. Uses [GlyphBadgeStyle] for visual variants.
///
/// ```dart
/// GlyphBadge(label: 'Available', style: GlyphBadgeStyle.neutral())
/// GlyphBadge(label: 'Confirmed', style: GlyphBadgeStyle.success())
/// GlyphBadge(label: 'Overdue',   style: GlyphBadgeStyle.critical())
/// ```
final class GlyphBadge extends StatelessWidget {
  const GlyphBadge({
    super.key,
    required this.label,
    this.style = const .accent(),
  });

  final String label;
  final GlyphBadgeStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: .fromBorderSide(style.borderSide),
        borderRadius: style.borderRadius,
      ),
      child: Text(
        label,
        style:
            GlyphTextStyles.label2XsmallStrong.copyWith(color: style.foregroundColor),
      ),
    );
  }
}
