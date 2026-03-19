import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';

/// Surface card with a light border and large corner radius.
///
/// Matches `.ticket-card` / `.summary-container` from the design reference:
/// - White background (#ffffff)
/// - Border: 1px solid --border-light (#f0f0f0)
/// - Border radius: --radius-lg (24px)
/// - Default padding: --space-6 (24px)
///
/// When [isSelected] is true the border turns black and a subtle shadow appears,
/// matching `.ticket-card.is-selected`.
///
/// When [isHovered] is true the border turns --border-medium,
/// matching `.ticket-card:hover`.
///
/// ```dart
/// GlyphCard(
///   isSelected: true,
///   child: Column(...),
/// )
/// ```
class GlyphCard extends StatefulWidget {
  const GlyphCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(GlyphSpacing.s6),
    this.isSelected = false,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<GlyphCard> createState() => _GlyphCardState();
}

class _GlyphCardState extends State<GlyphCard> {
  bool _hovered = false;

  Color get _borderColor {
    if (widget.isSelected) return GlyphColors.textPrimary;
    if (_hovered) return GlyphColors.borderMedium;
    return GlyphColors.borderLight;
  }

  List<BoxShadow> get _shadow {
    if (widget.isSelected) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: GlyphColors.bgSurface,
            borderRadius: GlyphRadius.borderLg,
            border: Border.all(color: _borderColor),
            boxShadow: _shadow,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
