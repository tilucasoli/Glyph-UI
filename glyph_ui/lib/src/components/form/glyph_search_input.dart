import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Search input with a leading search icon.
///
/// Matches `.search-box` + `.search-input` from the design reference:
/// - Gray-50 fill, medium border, radius-sm corners
/// - Leading search icon in gray-400
/// - Focus: border color switches to [GlyphColors.accentBlue], fill to white
/// - Optional [maxWidth] (default 400)
///
/// ```dart
/// GlyphSearchInput(
///   placeholder: 'Search by name, email or ticket ID…',
///   onChanged: (v) => setState(() => query = v),
/// )
/// ```
class GlyphSearchInput extends StatefulWidget {
  const GlyphSearchInput({
    super.key,
    this.placeholder = 'Search…',
    this.controller,
    this.onChanged,
    this.maxWidth = 400,
  });

  final String placeholder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final double maxWidth;

  @override
  State<GlyphSearchInput> createState() => _GlyphSearchInputState();
}

class _GlyphSearchInputState extends State<GlyphSearchInput> {
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: _focused ? GlyphColors.bgSurface : GlyphColors.bgBody,
          border: Border.all(
            color:
                _focused ? GlyphColors.accentBlue : GlyphColors.borderMedium,
          ),
          borderRadius: GlyphRadius.borderSm,
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Icon(
              Icons.search_rounded,
              size: 16,
              color: GlyphColors.textTertiary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                focusNode: _focus,
                controller: widget.controller,
                onChanged: widget.onChanged,
                style: GlyphTextStyles.small.copyWith(
                  color: GlyphColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: GlyphTextStyles.small,
                  isCollapsed: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
