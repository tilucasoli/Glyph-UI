import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

/// Column definition for [GlyphDataTable].
///
/// [flex] controls the relative width share (like [Expanded.flex]).
/// Pass [fixedWidth] to opt out of flex sizing (e.g. for action columns).
class GlyphColumn<T> {
  const GlyphColumn({
    required this.header,
    required this.cell,
    this.flex = 1,
    this.fixedWidth,
  });

  final String header;
  final Widget Function(T row) cell;

  /// Relative width weight. Ignored when [fixedWidth] is set.
  final int flex;

  /// Fixed pixel width. When set, the column does not participate in flex.
  final double? fixedWidth;
}

/// Generic data table with a styled header and hover rows.
///
/// Matches `.table-container` + `table` from the design reference:
/// - Rounded outer container with [GlyphColors.borderMedium] border
/// - Gray-50 header row with uppercase 11px column labels
/// - Body rows separated by [GlyphColors.borderLight] bottom borders
/// - Subtle hover background on each row
///
/// ```dart
/// GlyphDataTable<Attendee>(
///   columns: [
///     GlyphColumn(
///       header: 'Attendee',
///       flex: 3,
///       cell: (row) => Row(children: [
///         GlyphAvatar(initials: row.initials),
///         const SizedBox(width: 12),
///         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
///           Text(row.name, style: GlyphTextStyles.small.copyWith(
///             fontWeight: FontWeight.w600, color: GlyphColors.textPrimary)),
///           Text(row.email, style: GlyphTextStyles.meta),
///         ]),
///       ]),
///     ),
///     GlyphColumn(
///       header: 'Status',
///       cell: (row) => GlyphStatusIndicator.checkedIn(),
///     ),
///     GlyphColumn(
///       header: '',
///       fixedWidth: 50,
///       cell: (_) => Icon(Icons.more_vert, size: 18,
///           color: GlyphColors.textTertiary),
///     ),
///   ],
///   rows: attendees,
///   onRowTap: (row) => openDetail(row),
/// )
/// ```
class GlyphDataTable<T> extends StatelessWidget {
  const GlyphDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
  });

  final List<GlyphColumn<T>> columns;
  final List<T> rows;
  final void Function(T row)? onRowTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: GlyphColors.borderMedium,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: GlyphRadius.borderSm,
        color: GlyphColors.bgSurface,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeaderRow(columns: columns),
          ...rows.asMap().entries.map(
            (e) => _DataRow(
              columns: columns,
              row: e.value,
              isLast: e.key == rows.length - 1,
              onTap: onRowTap != null ? () => onRowTap!(e.value) : null,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Internal widgets ──────────────────────────────────────────────────────────

class _HeaderRow<T> extends StatelessWidget {
  const _HeaderRow({required this.columns});

  final List<GlyphColumn<T>> columns;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        border: Border(bottom: BorderSide(color: GlyphColors.borderMedium)),
      ),
      child: Row(
        children: columns
            .map((col) => _wrapCell(col, _headerCell(col)))
            .toList(),
      ),
    );
  }

  Widget _headerCell(GlyphColumn<T> col) {
    return Text(
      col.header.toUpperCase(),
      style: GlyphTextStyles.meta.copyWith(
        fontWeight: FontWeight.w600,
        color: GlyphColors.textSecondary,
        letterSpacing: 0.6,
      ),
    );
  }

  Widget _wrapCell(GlyphColumn<T> col, Widget child) {
    if (col.fixedWidth != null) {
      return SizedBox(width: col.fixedWidth, child: child);
    }
    return Expanded(flex: col.flex, child: child);
  }
}

class _DataRow<T> extends StatefulWidget {
  const _DataRow({
    required this.columns,
    required this.row,
    required this.isLast,
    this.onTap,
  });

  final List<GlyphColumn<T>> columns;
  final T row;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  State<_DataRow<T>> createState() => _DataRowState<T>();
}

class _DataRowState<T> extends State<_DataRow<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFFFAFAFB) : GlyphColors.bgSurface,
            border: widget.isLast
                ? null
                : const Border(
                    bottom: BorderSide(color: GlyphColors.borderLight),
                  ),
          ),
          child: Row(
            children: widget.columns
                .map((col) => _wrapCell(col, col.cell(widget.row)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _wrapCell(GlyphColumn<T> col, Widget child) {
    if (col.fixedWidth != null) {
      return SizedBox(
        width: col.fixedWidth,
        child: Align(alignment: Alignment.centerLeft, child: child),
      );
    }
    return Expanded(
      flex: col.flex,
      child: Align(alignment: Alignment.centerLeft, child: child),
    );
  }
}
