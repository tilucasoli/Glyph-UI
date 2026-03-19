import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: GlyphCard, path: '[Glyph]/Cards')
Widget cardDefault(BuildContext context) {
  return GlyphCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Card Title',
          style: GlyphTextStyles.h2.copyWith(color: GlyphColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Card content goes here.',
          style: GlyphTextStyles.body.copyWith(color: GlyphColors.textSecondary),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Selected', type: GlyphCard, path: '[Glyph]/Cards')
Widget cardSelected(BuildContext context) {
  return GlyphCard(
    isSelected: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selected Card',
          style: GlyphTextStyles.h2.copyWith(color: GlyphColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'This card has the selected state.',
          style: GlyphTextStyles.body.copyWith(color: GlyphColors.textSecondary),
        ),
      ],
    ),
  );
}
