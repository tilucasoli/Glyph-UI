import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Input Field', type: GlyphInputField, path: '[Glyph]/Forms')
Widget inputField(BuildContext context) {
  return GlyphInputField(
    label: 'Cardholder Name',
    placeholder: 'John Doe',
  );
}

@widgetbook.UseCase(name: 'Input With Trailing', type: GlyphInputField, path: '[Glyph]/Forms')
Widget inputFieldTrailing(BuildContext context) {
  return GlyphInputField(
    label: 'Card Number',
    placeholder: '0000 0000 0000 0000',
    trailing: const Icon(Icons.credit_card, size: 20),
  );
}

@widgetbook.UseCase(name: 'Search Input', type: GlyphSearchInput, path: '[Glyph]/Forms')
Widget searchInput(BuildContext context) {
  return GlyphSearchInput(
    placeholder: 'Search…',
    onChanged: (_) {},
  );
}
