import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Pagination bar with item count info and prev / next controls.
///
/// Matches `.pagination` from the design reference:
/// - Left: "Showing X to Y of Z items" label
/// - Right: Previous / Next buttons (disabled at boundaries)
///
/// ```dart
/// GlyphPagination(
///   currentPage: 1,
///   totalItems: 1240,
///   itemsPerPage: 10,
///   onPrevious: () {},
///   onNext: () {},
/// )
/// ```
class GlyphPagination extends StatelessWidget {
  const GlyphPagination({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    this.onPrevious,
    this.onNext,
  });

  /// 1-based current page index.
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  int get _firstItem => (currentPage - 1) * itemsPerPage + 1;

  int get _lastItem {
    final last = currentPage * itemsPerPage;
    return last > totalItems ? totalItems : last;
  }

  int get _totalPages => (totalItems / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: const BoxDecoration(
        color: GlyphColors.bgSurface,
        border: Border(top: BorderSide(color: GlyphColors.borderLight)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing $_firstItem to $_lastItem of $totalItems',
            style: GlyphTextStyles.meta.copyWith(
              color: GlyphColors.textSecondary,
            ),
          ),
          Row(
            children: [
              _PageButton(
                label: 'Previous',
                enabled: currentPage > 1,
                onPressed: onPrevious,
              ),
              const SizedBox(width: 8),
              _PageButton(
                label: 'Next',
                enabled: currentPage < _totalPages,
                onPressed: onNext,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatefulWidget {
  const _PageButton({
    required this.label,
    required this.enabled,
    this.onPressed,
  });

  final String label;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  State<_PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<_PageButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: _hovered && widget.enabled
                ? GlyphColors.bgBody
                : GlyphColors.bgSurface,
            border: Border.all(color: GlyphColors.borderMedium),
            borderRadius: GlyphRadius.borderSm,
          ),
          child: Text(
            widget.label,
            style: GlyphTextStyles.meta.copyWith(
              fontWeight: FontWeight.w500,
              color: widget.enabled
                  ? GlyphColors.textSecondary
                  : GlyphColors.textTertiary,
            ),
          ),
        ),
      ),
    );
  }
}
