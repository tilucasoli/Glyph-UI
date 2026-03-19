import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Pill-shaped category / tag chip.
///
/// Matches `.tag-pill` from the design reference:
/// - Border: 1px solid --border-light (#f0f0f0)
/// - Border radius: --radius-pill
/// - Padding: 6px vertical, 14px horizontal
/// - Font: 13px, w500, textPrimary
/// - Optional trailing icon (e.g. chevron down)
///
/// ```dart
/// GlyphTagPill(
///   label: 'Technology',
///   trailing: Icon(Icons.keyboard_arrow_down, size: 12),
///   onTap: () {},
/// )
/// ```
class GlyphTagPill extends StatelessWidget {
  const GlyphTagPill({
    super.key,
    required this.label,
    this.trailing,
    this.onTap,
  });

  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: GlyphRadius.borderPill,
          border: Border.all(color: GlyphColors.borderLight),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GlyphTextStyles.small.copyWith(
                color: GlyphColors.textPrimary,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 6),
              IconTheme(
                data: const IconThemeData(
                  color: GlyphColors.textPrimary,
                  size: 12,
                ),
                child: trailing!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
