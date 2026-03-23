import 'package:flutter/material.dart';

import '../breadcrumbs/glyph_breadcrumbs.dart';
import 'glyph_app_bar_metrics.dart';
import 'glyph_app_bar_style.dart';

/// Page-level app bar that sits at the top of a content panel.
///
/// Layout rules:
/// - When only [breadcrumbs] or only [title] is provided: single row.
/// - When both are provided: [breadcrumbs] on the first row, [title] on the
///   second row using metrics [GlyphAppBarMetrics.titleTextStyle].
/// - [actions] are always trailing on the first row.
///
/// ```dart
/// GlyphAppBar(
///   style: .standard(),
///   breadcrumbs: ['Design Conference 2024', 'Events'],
///   title: 'Events',
///   actions: [
///     GlyphButton(label: 'New Event', onPressed: () {}),
///   ],
/// )
/// ```
final class GlyphAppBar extends StatelessWidget {
  const GlyphAppBar({
    super.key,
    required this.style,
    this.metrics,
    this.breadcrumbs,
    this.title,
    this.actions,
  });

  final GlyphAppBarStyle style;

  /// Defaults to [GlyphAppBarMetrics.medium] when omitted.
  final GlyphAppBarMetrics? metrics;

  /// Breadcrumb labels shown at the top-left in small secondary text.
  final List<String>? breadcrumbs;

  /// Page title; see class documentation for row behavior.
  final String? title;

  /// Trailing widgets (buttons, icons) pinned to the right of the first row.
  final List<Widget>? actions;

  bool get _hasBreadcrumbs => breadcrumbs != null && breadcrumbs!.isNotEmpty;
  bool get _hasTitle => title != null;
  bool get _hasActions => actions != null && actions!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();

    final Widget? topLeft = _hasBreadcrumbs
        ? GlyphBreadcrumbs(items: breadcrumbs!, style: .standard())
        : _hasTitle
        ? Text(title!, style: m.titleTextStyle)
        : null;

    return Container(
      padding: m.padding,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: Border(bottom: style.bottomBorder),
      ),
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: m.minHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topLeft != null || _hasActions)
            Row(
              children: [
                if (topLeft != null) topLeft,
                const Spacer(),
                if (_hasActions) _ActionsRow(spacing: m.actionSpacing, actions: actions!),
              ],
            ),
          if (_hasBreadcrumbs && _hasTitle) ...[
            SizedBox(height: m.breadcrumbTitleGap),
            Text(title!, style: m.titleTextStyle),
          ],
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({required this.spacing, required this.actions});

  final double spacing;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) SizedBox(width: spacing),
          actions[i],
        ],
      ],
    );
  }
}
