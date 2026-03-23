import 'package:flutter/material.dart';

import '../sidebar/glyph_sidebar.dart';
import 'glyph_scaffold_metrics.dart';
import 'glyph_scaffold_style.dart';

/// App-level scaffold that composes a [GlyphSidebar] with a main content area.
///
/// Matches the `.layout-wrapper` structure from the design reference:
/// - Full-screen canvas background from [GlyphScaffoldStyle.canvasColor]
/// - Inset padding and gap from [GlyphScaffoldMetrics]
/// - Main content in a rounded surface panel with shadow from [GlyphScaffoldStyle]
///
/// Intended to replace [Scaffold] at the root of a desktop/tablet layout.
///
/// ```dart
/// GlyphScaffold(
///   style: .standard(),
///   sidebar: GlyphSidebar(
///     style: .standard(),
///     brandName: 'Eventis',
///     brandIcon: ...,
///     groups: [...],
///   ),
///   body: TicketsPage(),
/// )
/// ```
final class GlyphScaffold extends StatelessWidget {
  const GlyphScaffold({
    super.key,
    required this.style,
    this.metrics,
    required this.sidebar,
    required this.body,
  });

  final GlyphScaffoldStyle style;

  /// Defaults to [GlyphScaffoldMetrics.medium] when omitted.
  final GlyphScaffoldMetrics? metrics;

  final GlyphSidebar sidebar;

  /// The main content displayed to the right of the sidebar.
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();

    return Scaffold(
      backgroundColor: style.canvasColor,
      body: Padding(
        padding: m.outerPadding,
        child: Row(
          spacing: m.sidebarContentGap,
          children: [
            sidebar,
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: style.contentSurfaceColor,
                  borderRadius: style.contentBorderRadius,
                  boxShadow: style.contentShadows,
                ),
                child: body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
