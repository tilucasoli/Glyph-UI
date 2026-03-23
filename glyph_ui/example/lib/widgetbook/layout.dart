import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'sidebar.dart';

@widgetbook.UseCase(name: 'App Bar', type: GlyphAppBar, path: '[Glyph]/Layout')
Widget appBar(BuildContext context) {
  return GlyphAppBar(
    style: .standard(),
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

@widgetbook.UseCase(
  name: 'Scaffold',
  type: GlyphScaffold,
  path: '[Glyph]/Layout',
)
Widget scaffoldUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 920,
      height: 560,
      child: GlyphScaffold(
        style: .standard(),
        sidebar: widgetbookSampleGlyphSidebar(),
        body: Center(
          child: Text(
            'Main content',
            style: GlyphTextStyles.paragraphMedium,
          ),
        ),
      ),
    ),
  );
}
