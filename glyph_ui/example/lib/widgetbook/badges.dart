import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'All Styles',
  type: GlyphBadge,
  path: '[Glyph]/Badges',
)
Widget badgeStyles(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        GlyphBadge(label: 'Default', style: .accent()),
        GlyphBadge(label: 'Neutral', style: .neutral()),
        GlyphBadge(label: 'Confirmed', style: .success()),
        GlyphBadge(label: 'Pending', style: .attention()),
        GlyphBadge(label: 'Overdue', style: .critical()),
      ],
    ),
  );
}
