import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: GlyphTextField,
  path: '[Glyph]/Forms',
)
Widget textField(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Cardholder Name',
  );
  final placeholder = context.knobs.string(
    label: 'Placeholder',
    initialValue: 'John Doe',
  );
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['medium', 'large'],
    labelBuilder: (v) => v,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final obscureText = context.knobs.boolean(
    label: 'Obscure text',
    initialValue: false,
  );
  final showTrailing = context.knobs.boolean(
    label: 'Trailing icon',
    initialValue: false,
  );

  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: GlyphTextField(
        label: label,
        placeholder: placeholder,
        style: GlyphTextFieldStyle.stroke(),
        metrics: _metricsFrom(size),
        enabled: enabled,
        obscureText: obscureText,
        trailing: showTrailing ? const Icon(Icons.credit_card, size: 20) : null,
      ),
    ),
  );
}

GlyphTextFieldMetrics _metricsFrom(String size) {
  return switch (size) {
    'large' => GlyphTextFieldMetrics.large(),
    _ => GlyphTextFieldMetrics.medium(),
  };
}
