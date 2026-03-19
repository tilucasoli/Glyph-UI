import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';
import '../nav/glyph_breadcrumbs.dart';

/// Page-level app bar that sits at the top of a content panel.
///
/// Layout rules:
/// - When only [breadcrumbs] or only [title] is provided: single row.
/// - When both are provided: [breadcrumbs] on the first row, [title] on the
///   second row as [GlyphTextStyles.h2].
/// - [actions] are always trailing on the first row.
///
/// ```dart
/// GlyphAppBar(
///   breadcrumbs: ['Design Conference 2024', 'Events'],
///   title: 'Events',
///   actions: [
///     GlyphButton(label: 'New Event', onPressed: () {}),
///   ],
/// )
/// ```
class GlyphAppBar extends StatelessWidget {
  const GlyphAppBar({super.key, this.breadcrumbs, this.title, this.actions});

  /// Breadcrumb labels shown at the top-left in small secondary text.
  final List<String>? breadcrumbs;

  /// Page title displayed as [GlyphTextStyles.h2].
  /// When [breadcrumbs] are also set, rendered on a second row below them.
  /// When [breadcrumbs] are absent, replaces them on the first row.
  final String? title;

  /// Trailing widgets (buttons, icons) pinned to the right of the first row.
  final List<Widget>? actions;

  bool get _hasBreadcrumbs => breadcrumbs != null && breadcrumbs!.isNotEmpty;
  bool get _hasTitle => title != null;
  bool get _hasActions => actions != null && actions!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    // What sits on the left of the first row.
    final Widget? topLeft = _hasBreadcrumbs
        ? GlyphBreadcrumbs(items: breadcrumbs!)
        : _hasTitle
        ? Text(title!, style: GlyphTextStyles.h2)
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: GlyphSpacing.s8,
        vertical: GlyphSpacing.s4,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: GlyphColors.borderLight)),
      ),
      alignment: .center,
      constraints: const BoxConstraints(minHeight: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topLeft != null || _hasActions)
            Row(
              children: [
                if (topLeft != null) topLeft,
                const Spacer(),
                if (_hasActions) _ActionsRow(actions: actions!),
              ],
            ),
          // Second row: title only when breadcrumbs occupy the first row.
          if (_hasBreadcrumbs && _hasTitle) ...[
            const SizedBox(height: GlyphSpacing.s2),
            Text(title!, style: GlyphTextStyles.h2),
          ],
        ],
      ),
    );
  }
}

class _ActionsRow extends StatelessWidget {
  const _ActionsRow({required this.actions});

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: GlyphSpacing.s2),
          actions[i],
        ],
      ],
    );
  }
}
