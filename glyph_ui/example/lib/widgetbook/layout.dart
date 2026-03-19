import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'App Bar', type: GlyphAppBar, path: '[Glyph]/Layout')
Widget appBar(BuildContext context) {
  return GlyphAppBar(
    title: 'Glyph UI',
    actions: [
      GlyphButton(
        label: 'Settings',
        style: .stroke(),
        leadingIcon: const Icon(Icons.settings_outlined),
        onPressed: () {},
      ),
    ],
  );
}
