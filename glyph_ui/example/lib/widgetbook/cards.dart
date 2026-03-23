import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: GlyphCard, path: '[Glyph]/Cards')
Widget cardDefault(BuildContext context) {
  return Center(
    child: GlyphCard(
      style: GlyphCardStyle.surface(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Card Title',
            style: GlyphTextStyles.titleXsmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Card content goes here.',
            style: GlyphTextStyles.paragraphMedium,
          ),
        ],
      ),
    ),
  );
}
