import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Colors', type: Widget, path: '[Glyph]/Tokens')
Widget colorsToken(BuildContext context) {
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: [
      _colorSwatch('Primary', GlyphColors.textPrimary),
      _colorSwatch('Secondary', GlyphColors.textSecondary),
      _colorSwatch('Accent', GlyphColors.accentSolid),
      _colorSwatch('Danger', GlyphColors.accentDanger),
      _colorSwatch('Success', GlyphColors.statusSuccess),
      _colorSwatch('Warning', GlyphColors.statusWarning),
      _colorSwatch('Surface', GlyphColors.bgSurface),
      _colorSwatch('Body', GlyphColors.bgBody),
    ],
  );
}

Widget _colorSwatch(String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: GlyphRadius.borderSm,
          border: Border.all(color: GlyphColors.borderLight),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: GlyphTextStyles.meta),
    ],
  );
}

@widgetbook.UseCase(name: 'Spacing', type: Widget, path: '[Glyph]/Tokens')
Widget spacingToken(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('s2: ${GlyphSpacing.s2}px', style: GlyphTextStyles.small),
      Text('s3: ${GlyphSpacing.s3}px', style: GlyphTextStyles.small),
      Text('s4: ${GlyphSpacing.s4}px', style: GlyphTextStyles.small),
      Text('s6: ${GlyphSpacing.s6}px', style: GlyphTextStyles.small),
      Text('s8: ${GlyphSpacing.s8}px', style: GlyphTextStyles.small),
      Text('s12: ${GlyphSpacing.s12}px', style: GlyphTextStyles.small),
    ],
  );
}

@widgetbook.UseCase(name: 'Typography', type: Widget, path: '[Glyph]/Tokens')
Widget typographyToken(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Heading', style: GlyphTextStyles.h1),
      const SizedBox(height: 8),
      Text('Body text', style: GlyphTextStyles.body),
      const SizedBox(height: 8),
      Text('Small text', style: GlyphTextStyles.small),
      const SizedBox(height: 8),
      Text('Meta / Caption', style: GlyphTextStyles.meta),
    ],
  );
}
