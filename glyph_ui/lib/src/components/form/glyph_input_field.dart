import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

/// Labeled text input field.
///
/// Matches `.input-wrapper` + `.input-label` + `.input-field` from the design:
/// - Label: 13px, w600, textPrimary
/// - Input: 48px height, 16px horizontal padding
/// - Border: 1px solid --border-medium (#e5e5e5), radius-sm (8px)
/// - Focus: border color animates to textPrimary
///
/// ```dart
/// GlyphInputField(
///   label: 'Cardholder Name',
///   placeholder: 'John Doe',
///   controller: _nameController,
/// )
/// GlyphInputField(
///   label: 'Card Number',
///   placeholder: '0000 0000 0000 0000',
///   trailing: Icon(Icons.credit_card),
/// )
/// ```
class GlyphInputField extends StatefulWidget {
  const GlyphInputField({
    super.key,
    required this.label,
    this.placeholder,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.trailing,
  });

  final String label;
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  /// Optional widget placed inside the input on the trailing edge
  /// (e.g. a card-brand icon next to the card number field).
  final Widget? trailing;

  @override
  State<GlyphInputField> createState() => _GlyphInputFieldState();
}

class _GlyphInputFieldState extends State<GlyphInputField> {
  late final FocusNode _focus;
  bool _focused = false;

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
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
              color: _focused
                  ? GlyphColors.textPrimary
                  : GlyphColors.borderMedium,
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
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
