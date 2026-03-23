import 'package:flutter/material.dart';

import 'glyph_text_field_style.dart';

/// Labeled text field using [GlyphTextFieldStyle].
///
/// ```dart
/// GlyphTextField(
///   label: 'Cardholder Name',
///   placeholder: 'John Doe',
///   style: GlyphTextFieldStyle.stroke(),
/// )
/// ```
final class GlyphTextField extends StatefulWidget {
  const GlyphTextField({
    super.key,
    required this.label,
    required this.style,
    this.size = GlyphTextFieldSize.medium,
    this.placeholder,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.trailing,
  });

  final String label;
  final GlyphTextFieldStyle style;
  final GlyphTextFieldSize size;

  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  /// Optional widget on the trailing edge of the input row.
  final Widget? trailing;

  @override
  State<GlyphTextField> createState() => _GlyphTextFieldState();
}

OutlineInputBorder _toOutlineInputBorder(OutlinedBorder border) {
  if (border is RoundedRectangleBorder) {
    return OutlineInputBorder(
      borderRadius: border.borderRadius.resolve(TextDirection.ltr),
      borderSide: border.side,
    );
  }
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: border.side,
  );
}

Set<WidgetState> _statesForEnabledBorder(Set<WidgetState> current) {
  if (current.contains(WidgetState.disabled)) {
    return {WidgetState.disabled};
  }
  return Set<WidgetState>.from(current)..remove(WidgetState.focused);
}

Set<WidgetState> _statesForFocusedBorder(Set<WidgetState> current) {
  if (current.contains(WidgetState.disabled)) {
    return {WidgetState.disabled};
  }
  return Set<WidgetState>.from(current)..add(WidgetState.focused);
}

class _GlyphTextFieldState extends State<GlyphTextField> {
  final _statesController = WidgetStatesController();
  late final FocusNode _focus;

  bool get _isDisabled => !widget.enabled;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode(
      debugLabel: widget.label,
      canRequestFocus: widget.enabled,
    )..addListener(_onFocusNodeChanged);
    _statesController.addListener(() => setState(() {}));
    _statesController.update(WidgetState.disabled, _isDisabled);
  }

  void _onFocusNodeChanged() {
    _statesController.update(WidgetState.focused, _focus.hasFocus);
  }

  @override
  void didUpdateWidget(covariant GlyphTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      _focus.canRequestFocus = widget.enabled;
      if (!widget.enabled && _focus.hasFocus) {
        _focus.unfocus();
      }
    }
    _statesController.update(WidgetState.disabled, _isDisabled);
  }

  @override
  void dispose() {
    _focus
      ..removeListener(_onFocusNodeChanged)
      ..dispose();
    _statesController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _statesController.update(WidgetState.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _statesController.update(WidgetState.pressed, false);
  }

  void _onTapCancel() {
    _statesController.update(WidgetState.pressed, false);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final sz = widget.size;
    final states = _statesController.value;

    final bgColor = style.backgroundColor.resolve(states);
    final fgColor = style.foregroundColor.resolve(states);
    final hintColor = style.hintColor.resolve(states);
    final shadows = style.shadows.resolve(states);

    final labelStyle =
        style.labelTextStyle.resolve(sz).copyWith(color: fgColor);
    final inputStyle =
        style.inputTextStyle.resolve(sz).copyWith(color: fgColor);
    final hintStyle =
        style.inputTextStyle.resolve(sz).copyWith(color: hintColor);

    final enabledBorder = _toOutlineInputBorder(
      style.shape.resolve(_statesForEnabledBorder(states)),
    );
    final focusedBorder = _toOutlineInputBorder(
      style.shape.resolve(_statesForFocusedBorder(states)),
    );
    final disabledBorder = _toOutlineInputBorder(
      style.shape.resolve({WidgetState.disabled}),
    );

    final contentPadding = style.inputContentPadding.resolve(sz);
    final trailingGap = style.trailingGap.resolve(sz);
    final labelBottomSpacing = style.labelBottomSpacing.resolve(sz);

    Widget textField = TextField(
      focusNode: _focus,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      style: inputStyle,
      decoration: InputDecoration(
        filled: true,
        fillColor: bgColor,
        isCollapsed: true,
        contentPadding: contentPadding,
        hintText: widget.placeholder,
        hintStyle: hintStyle,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        maintainHintSize: false,
        disabledBorder: disabledBorder,
        suffixIcon: widget.trailing == null
            ? null
            : IconTheme(
                data: IconThemeData(size: 20, color: fgColor),
                child: Padding(
                  padding: EdgeInsets.only(right: trailingGap),
                  child: widget.trailing,
                ),
              ),
      ),
    );

    if (shadows.isNotEmpty) {
      final radius = enabledBorder.borderRadius;
      textField = DecoratedBox(
        decoration: BoxDecoration(borderRadius: radius, boxShadow: shadows),
        child: textField,
      );
    }

    return Semantics(
      container: true,
      label: widget.label,
      enabled: widget.enabled,
      child: MouseRegion(
        cursor: _isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.text,
        onEnter: (_) => _statesController.update(WidgetState.hovered, true),
        onExit: (_) => _statesController.update(WidgetState.hovered, false),
        child: GestureDetector(
          onTapDown: _isDisabled ? null : _onTapDown,
          onTapUp: _isDisabled ? null : _onTapUp,
          onTapCancel: _isDisabled ? null : _onTapCancel,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: labelBottomSpacing,
            children: [
              Text(widget.label, style: labelStyle),
              textField,
            ],
          ),
        ),
      ),
    );
  }
}
