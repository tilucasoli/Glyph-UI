import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Initials', type: GlyphAvatar, path: '[Glyph]/Avatars')
Widget avatarInitials(BuildContext context) {
  return const GlyphAvatar(initials: 'AW');
}

@widgetbook.UseCase(name: 'Colored Initials', type: GlyphAvatar, path: '[Glyph]/Avatars')
Widget avatarColored(BuildContext context) {
  return const GlyphAvatar(
    initials: 'JS',
    backgroundColor: Color(0xFFE0E7FF),
    foregroundColor: Color(0xFF4338CA),
  );
}

@widgetbook.UseCase(name: 'Multiple Sizes', type: GlyphAvatar, path: '[Glyph]/Avatars')
Widget avatarSizes(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GlyphAvatar(initials: 'S', size: 24),
      const SizedBox(width: 12),
      GlyphAvatar(initials: 'M', size: 32),
      const SizedBox(width: 12),
      GlyphAvatar(initials: 'L', size: 48),
    ],
  );
}
