import 'package:flutter/material.dart';

import '../button/glyph_button.dart';
import '../button/glyph_button_style.dart';
import 'glyph_pagination_style.dart';

/// Pagination bar with item count info and prev / next controls.
///
/// Matches `.pagination` from the design reference:
/// - Left: "Showing X to Y of Z items" label
/// - Right: Previous / Next buttons (disabled at boundaries)
///
/// ```dart
/// GlyphPagination(
///   style: .standard(),
///   currentPage: 1,
///   totalItems: 1240,
///   itemsPerPage: 10,
///   onPrevious: () {},
///   onNext: () {},
/// )
/// ```
final class GlyphPagination extends StatelessWidget {
  const GlyphPagination({
    super.key,
    required this.currentPage,
    required this.totalItems,
    required this.itemsPerPage,
    required this.style,
    this.size = GlyphPaginationSize.medium,
    this.onPrevious,
    this.onNext,
  });

  /// 1-based current page index.
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final GlyphPaginationStyle style;
  final GlyphPaginationSize size;
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
    final s = style;
    final sz = size;

    return Container(
      padding: s.barPadding.resolve(sz),
      decoration: BoxDecoration(
        color: s.barBackgroundColor,
        border: Border(top: s.barTopBorderSide),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing $_firstItem to $_lastItem of $totalItems',
            style: s.summaryLabelStyle
                .resolve(sz)
                .copyWith(color: s.summaryTextColor),
          ),
          Row(
            spacing: s.pageButtonGap.resolve(sz),
            children: [
              GlyphButton(
                label: 'Previous',
                onPressed: currentPage > 1 ? onPrevious : null,
                style: GlyphButtonStyle.stroke(),
                size: .xsmall,
              ),
              GlyphButton(
                label: 'Next',
                onPressed: currentPage < _totalPages ? onNext : null,
                style: GlyphButtonStyle.stroke(),
                size: .xsmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
