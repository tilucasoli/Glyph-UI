import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Text Field (Medium)', type: GlyphTextField, path: '[Glyph]/Forms')
Widget inputField(BuildContext context) {
  return GlyphTextField(
    label: 'Cardholder Name',
    placeholder: 'John Doe',
    size: GlyphTextFieldSize.medium,
  );
}

@widgetbook.UseCase(name: 'Text Field (Large)', type: GlyphTextField, path: '[Glyph]/Forms')
Widget inputFieldTrailing(BuildContext context) {
  return const GlyphTextField(
    label: 'Card Number',
    placeholder: '0000 0000 0000 0000',
    size: GlyphTextFieldSize.large,
    trailing: Icon(Icons.credit_card, size: 20),
  );
}
