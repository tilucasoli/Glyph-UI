import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Tag Pill', type: GlyphTagPill, path: '[Glyph]/Badges')
Widget tagPill(BuildContext context) {
  return GlyphTagPill(
    label: 'Technology',
    trailing: const Icon(Icons.keyboard_arrow_down, size: 12),
    onTap: () {},
  );
}

@widgetbook.UseCase(name: 'Availability Badge', type: GlyphAvailabilityBadge, path: '[Glyph]/Badges')
Widget availabilityBadge(BuildContext context) {
  return const GlyphAvailabilityBadge(label: 'Available');
}

@widgetbook.UseCase(name: 'Color Badges', type: GlyphColorBadge, path: '[Glyph]/Badges')
Widget colorBadges(BuildContext context) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      GlyphColorBadge.vip(),
      GlyphColorBadge.general(),
      GlyphColorBadge.student(),
      GlyphColorBadge.success(label: 'Confirmed'),
    ],
  );
}
