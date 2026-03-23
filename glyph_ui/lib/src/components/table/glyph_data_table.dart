import 'package:flutter/material.dart';

import 'glyph_data_table_metrics.dart';
import 'glyph_data_table_style.dart';

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

/// Generic data table with a styled header and interactive rows.
///
/// Matches `.table-container` + `table` from the design reference:
/// - Rounded outer container with configurable border ([GlyphDataTableStyle])
/// - Header row with uppercase column labels ([GlyphDataTableMetrics])
/// - Body rows with hover / press feedback when [onRowTap] is set
///
/// ```dart
/// GlyphDataTable<Attendee>(
///   style: GlyphDataTableStyle.standard(),
///   metrics: GlyphDataTableMetrics.medium(),
///   columns: [
///     GlyphColumn(
///       header: 'Attendee',
///       flex: 3,
///       cell: (row) => Text(row.name),
///     ),
///   ],
///   rows: attendees,
///   onRowTap: (row) => openDetail(row),
/// )
/// ```
final class GlyphDataTable<T> extends StatelessWidget {
  const GlyphDataTable({
    super.key,
    required this.columns,
    required this.rows,
    required this.style,
    this.metrics,
    this.onRowTap,
    this.footer,
  });

  final List<GlyphColumn<T>> columns;
  final List<T> rows;
  final GlyphDataTableStyle style;

  /// Defaults to [GlyphDataTableMetrics.medium] when omitted.
  final GlyphDataTableMetrics? metrics;

  final void Function(T row)? onRowTap;

  /// Optional widget rendered inside the clipped container below the last row.
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();

    return Container(
      decoration: BoxDecoration(
        color: style.containerBackgroundColor,
        border: .fromBorderSide(style.containerBorderSide),
        borderRadius: style.containerBorderRadius,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeaderRow<T>(columns: columns, style: style, metrics: m),
          ...rows.asMap().entries.map(
            (e) => _DataRow<T>(
              columns: columns,
              row: e.value,
              isLast: e.key == rows.length - 1,
              style: style,
              metrics: m,
              onTap: onRowTap != null ? () => onRowTap!(e.value) : null,
            ),
          ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

// ── Internal widgets ──────────────────────────────────────────────────────────

class _HeaderRow<T> extends StatelessWidget {
  const _HeaderRow({
    required this.columns,
    required this.style,
    required this.metrics,
  });

  final List<GlyphColumn<T>> columns;
  final GlyphDataTableStyle style;
  final GlyphDataTableMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: metrics.headerPadding,
      decoration: BoxDecoration(
        color: style.headerBackgroundColor,
        border: Border(bottom: style.headerBottomBorderSide),
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
      style: metrics.headerLabelStyle.copyWith(
        color: style.headerForegroundColor,
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
    required this.style,
    required this.metrics,
    this.onTap,
  });

  final List<GlyphColumn<T>> columns;
  final T row;
  final bool isLast;
  final GlyphDataTableStyle style;
  final GlyphDataTableMetrics metrics;
  final VoidCallback? onTap;

  @override
  State<_DataRow<T>> createState() => _DataRowState<T>();
}

class _DataRowState<T> extends State<_DataRow<T>> {
  final _controller = WidgetStatesController();

  bool get _isDisabled => widget.onTap == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(.disabled, _isDisabled);
  }

  @override
  void didUpdateWidget(covariant _DataRow<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(.disabled, _isDisabled);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.update(.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.update(.pressed, false);
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.update(.pressed, false);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final metrics = widget.metrics;
    final states = _controller.value;
    final rowBg = style.rowBackgroundColor.resolve(states);

    return Semantics(
      container: true,
      onTap: widget.onTap,
      child: Focus(
        onFocusChange: (focused) => _controller.update(.focused, focused),
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(.hovered, true),
          onExit: (_) => _controller.update(.hovered, false),
          child: GestureDetector(
            onTapDown: _isDisabled ? null : _onTapDown,
            onTapUp: _isDisabled ? null : _onTapUp,
            onTapCancel: _isDisabled ? null : _onTapCancel,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: style.rowAnimationDuration,
              curve: style.rowAnimationCurve,
              padding: metrics.rowPadding,
              decoration: BoxDecoration(
                color: rowBg,
                border: widget.isLast
                    ? null
                    : Border(bottom: style.rowBottomBorderSide),
              ),
              child: Row(
                children: widget.columns
                    .map((col) => _wrapCell(col, col.cell(widget.row)))
                    .toList(),
              ),
            ),
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
