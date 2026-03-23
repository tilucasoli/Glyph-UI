import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Dropdown',
  type: GlyphDropdown,
  path: '[Glyph]/Dropdown',
)
Widget dropdownUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['medium', 'large'],
    labelBuilder: (v) => v,
  );
  final direction = context.knobs.object.dropdown<String>(
    label: 'Direction',
    options: ['down', 'up', 'right', 'left'],
    labelBuilder: (v) => v,
  );
  final disabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );
  final showHeader = context.knobs.boolean(
    label: 'Show header',
    initialValue: true,
  );
  final showLeading = context.knobs.boolean(
    label: 'Show leading',
    initialValue: false,
  );

  return Center(
    child: _DropdownDemo(
      size: size,
      direction: direction,
      disabled: disabled,
      showHeader: showHeader,
      showLeading: showLeading,
    ),
  );
}

class _DropdownDemo extends StatefulWidget {
  const _DropdownDemo({
    required this.size,
    required this.direction,
    required this.disabled,
    required this.showHeader,
    required this.showLeading,
  });

  final String size;
  final String direction;
  final bool disabled;
  final bool showHeader;
  final bool showLeading;

  @override
  State<_DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<_DropdownDemo> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return GlyphDropdown<String>(
      value: _selected,
      placeholder: 'Select event…',
      header: widget.showHeader ? 'Events' : null,
      leading: widget.showLeading
          ? Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: GlyphColors.feedbackSuccess,
                shape: BoxShape.circle,
              ),
            )
          : null,
      direction: _directionFrom(widget.direction),
      triggerStyle: .stroke(),
      size: _dropdownSizeFrom(widget.size),
      items: const [
        GlyphDropdownItem(value: 'conf', label: 'Design Conference 2024'),
        GlyphDropdownItem(value: 'summit', label: 'TechPulse Summit'),
        GlyphDropdownItem(value: 'meetup', label: 'Flutter Meetup'),
      ],
      onChanged: widget.disabled ? null : (v) => setState(() => _selected = v),
    );
  }
}

GlyphDropdownSize _dropdownSizeFrom(String value) {
  return switch (value) {
    'large' => .large,
    _ => .medium,
  };
}

GlyphDropdownDirection _directionFrom(String value) {
  return switch (value) {
    'up' => .up,
    'right' => .right,
    'left' => .left,
    _ => .down,
  };
}
