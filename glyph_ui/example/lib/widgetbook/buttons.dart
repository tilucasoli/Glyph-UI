import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Button', type: GlyphButton, path: '[Glyph]/Button')
Widget buttonUseCase(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Continue');
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: ['filled', 'stroke', 'ghost'],
    labelBuilder: (v) => v,
  );
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['xsmall', 'small', 'medium'],
    labelBuilder: (v) => v,
  );
  final expand = context.knobs.boolean(label: 'Expand', initialValue: false);
  final isLoading = context.knobs.boolean(
    label: 'Loading',
    initialValue: false,
  );
  final disabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );
  final showLeadingIcon = context.knobs.boolean(
    label: 'Leading icon',
    initialValue: false,
  );
  final showTrailingIcon = context.knobs.boolean(
    label: 'Trailing icon',
    initialValue: false,
  );

  return Center(
    child: GlyphButton(
      label: label,
      onPressed: (isLoading || disabled) ? null : () {},
      variant: _variantFrom(variant),
      size: _sizeFrom(size),
      expand: expand,
      loading: isLoading,
      leadingIcon: showLeadingIcon
          ? const Icon(Icons.filter_list_rounded)
          : null,
      trailingIcon: showTrailingIcon ? const Icon(Icons.arrow_forward) : null,
    ),
  );
}

@widgetbook.UseCase(
  name: 'Icon Button',
  type: GlyphIconButton,
  path: '[Glyph]/Icon Button',
)
Widget iconButtonUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown<String>(
    label: 'Variant',
    options: ['stroke', 'filled', 'ghost'],
    labelBuilder: (v) => v,
  );
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['xsmall', 'small', 'medium'],
    labelBuilder: (v) => v,
  );
  final semanticLabel = context.knobs.string(
    label: 'Semantic label',
    initialValue: 'Search',
  );
  final tooltip = context.knobs.string(
    label: 'Tooltip',
    initialValue: 'Search',
  );
  final disabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  return Center(
    child: GlyphIconButton(
      icon: Icon(_iconFor(semanticLabel)),
      onPressed: disabled ? null : () {},
      semanticLabel: semanticLabel,
      variant: _variantFrom(variant),
      size: _sizeFrom(size),
      tooltip: tooltip.isEmpty ? null : tooltip,
    ),
  );
}

GlyphButtonVariant _variantFrom(String value) {
  return switch (value) {
    'stroke' => GlyphButtonVariant.stroke,
    'ghost' => GlyphButtonVariant.ghost,
    _ => GlyphButtonVariant.filled,
  };
}

GlyphButtonSize _sizeFrom(String value) {
  return switch (value) {
    'xsmall' => GlyphButtonSize.xsmall,
    'small' => GlyphButtonSize.small,
    _ => GlyphButtonSize.medium,
  };
}

IconData _iconFor(String label) {
  if (label.toLowerCase().contains('search')) return Icons.search;
  if (label.toLowerCase().contains('settings')) return Icons.settings_outlined;
  return Icons.touch_app;
}
