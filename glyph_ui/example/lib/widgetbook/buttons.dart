import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Primary', type: GlyphButton, path: '[Glyph]/Buttons')
Widget primaryButton(BuildContext context) {
  return GlyphButton(
    label: 'Continue to Payment',
    onPressed: () {},
    trailingIcon: const Icon(Icons.arrow_forward),
  );
}

@widgetbook.UseCase(name: 'Primary Compact', type: GlyphButton, path: '[Glyph]/Buttons')
Widget primaryButtonCompact(BuildContext context) {
  return GlyphButton(
    label: 'New Event',
    size: GlyphButtonSize.small,
    expand: false,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Primary Loading', type: GlyphButton, path: '[Glyph]/Buttons')
Widget primaryButtonLoading(BuildContext context) {
  return GlyphButton(
    label: 'Processing…',
    isLoading: true,
    onPressed: null,
  );
}

@widgetbook.UseCase(name: 'Primary Disabled', type: GlyphButton, path: '[Glyph]/Buttons')
Widget primaryButtonDisabled(BuildContext context) {
  return GlyphButton(
    label: 'Continue',
    onPressed: null,
  );
}

@widgetbook.UseCase(name: 'Action', type: GlyphButton, path: '[Glyph]/Buttons')
Widget actionButton(BuildContext context) {
  return GlyphButton(
    label: 'Filters',
    variant: GlyphButtonVariant.stroke,
    leadingIcon: const Icon(Icons.filter_list_rounded),
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Action Without Icon', type: GlyphButton, path: '[Glyph]/Buttons')
Widget actionButtonNoIcon(BuildContext context) {
  return GlyphButton(
    label: 'Export CSV',
    variant: GlyphButtonVariant.stroke,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Ghost', type: GlyphButton, path: '[Glyph]/Buttons')
Widget ghostButton(BuildContext context) {
  return GlyphButton(
    label: 'Cancel',
    variant: GlyphButtonVariant.ghost,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Icon Button', type: GlyphIconButton, path: '[Glyph]/Buttons')
Widget iconButton(BuildContext context) {
  return GlyphIconButton(
    icon: const Icon(Icons.search),
    onPressed: () {},
    semanticLabel: 'Search',
    tooltip: 'Search',
  );
}
