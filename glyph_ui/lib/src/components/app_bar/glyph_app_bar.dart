import 'package:flutter/material.dart';

import '../breadcrumbs/glyph_breadcrumbs.dart';
import '../breadcrumbs/glyph_breadcrumbs_style.dart';
import 'glyph_app_bar_style.dart';

/// Page-level app bar that sits at the top of a content panel.
///
/// Layout rules:
/// - When only [breadcrumbs] or only [title] is provided: single row.
/// - When both are provided: [breadcrumbs] on the first row, [title] on the
///   second row using metrics [GlyphAppBarStyle.titleTextStyle].
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
    this.size = GlyphAppBarSize.medium,
    this.breadcrumbs,
    this.title,
    this.actions,
  });

  final GlyphAppBarStyle style;
  final GlyphAppBarSize size;

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
    final m = style;
    final sz = size;
    final titleStyle = m.titleTextStyle.resolve(sz);

    final Widget? topLeft = _hasBreadcrumbs
        ? GlyphBreadcrumbs(
            items: breadcrumbs!,
            style: GlyphBreadcrumbsStyle.standard(),
          )
        : _hasTitle
        ? Text(title!, style: titleStyle)
        : null;

    return Container(
      padding: m.padding.resolve(sz),
      decoration: BoxDecoration(
        color: m.backgroundColor,
        border: Border(bottom: m.bottomBorder),
      ),
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: m.minHeight.resolve(sz)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topLeft != null || _hasActions)
            Row(
              children: [
                if (topLeft != null) topLeft,
                const Spacer(),
                if (_hasActions)
                  _ActionsRow(
                    spacing: m.actionSpacing.resolve(sz),
                    actions: actions!,
                  ),
              ],
            ),
          if (_hasBreadcrumbs && _hasTitle) ...[
            SizedBox(height: m.breadcrumbTitleGap.resolve(sz)),
            Text(title!, style: titleStyle),
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
