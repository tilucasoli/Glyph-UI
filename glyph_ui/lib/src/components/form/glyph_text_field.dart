import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Available size presets for [GlyphTextField].
enum GlyphTextFieldSize { medium, large }

/// Labeled text input field with stroke-style visuals.
///
/// ```dart
/// GlyphTextField(
///   label: 'Cardholder Name',
///   placeholder: 'John Doe',
///   size: GlyphTextFieldSize.medium,
/// )
/// GlyphTextField(
///   label: 'Card Number',
///   placeholder: '0000 0000 0000 0000',
///   size: GlyphTextFieldSize.large,
///   trailing: Icon(Icons.credit_card),
/// )
/// ```
class GlyphTextField extends StatefulWidget {
  const GlyphTextField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.trailing,
    this.size = GlyphTextFieldSize.medium,
  });

  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;
  final GlyphTextFieldSize size;

  @override
  State<GlyphTextField> createState() => _GlyphTextFieldState();
}

class _GlyphTextFieldState extends State<GlyphTextField> {
  late final FocusNode _focus;
  bool _focused = false;

  double get _height => switch (widget.size) {
    .medium => 48,
    .large => 56,
  };

  EdgeInsets get _contentPadding => switch (widget.size) {
    .medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    .large => const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  };

  @override
  void initState() {
    super.initState();
    _focus = FocusNode()..addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() => _focused = _focus.hasFocus);

  @override
  void dispose() {
    _focus
      ..removeListener(_onFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: _labelStyle),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _height,
          decoration: BoxDecoration(
            color: GlyphColors.bgSurface,
            border: Border.all(
              color: _focused ? GlyphColors.textPrimary : GlyphColors.borderMedium,
            ),
            borderRadius: GlyphRadius.borderSm,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focus,
                  controller: widget.controller,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  obscureText: widget.obscureText,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: GlyphColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: GlyphColors.textTertiary,
                    ),
                    isCollapsed: true,
                    contentPadding: _contentPadding,
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.trailing != null) ...[
                widget.trailing!,
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static const TextStyle _labelStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: GlyphColors.textPrimary,
  );
}
