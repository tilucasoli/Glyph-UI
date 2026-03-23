import 'package:flutter/material.dart';

import '../sidebar/glyph_sidebar.dart';
import 'glyph_scaffold_style.dart';

/// App-level scaffold that composes a [GlyphSidebar] with a main content area.
///
/// Matches the `.layout-wrapper` structure from the design reference:
/// - Full-screen canvas background from [GlyphScaffoldStyle.canvasColor]
/// - Inset padding and gap from [GlyphScaffoldStyle] layout properties
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
    this.size = GlyphScaffoldSize.medium,
    required this.sidebar,
    required this.body,
  });

  final GlyphScaffoldStyle style;
  final GlyphScaffoldSize size;
  final GlyphSidebar sidebar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final s = style;
    final sz = size;

    return Scaffold(
      backgroundColor: s.canvasColor,
      body: Padding(
        padding: s.outerPadding.resolve(sz),
        child: Row(
          spacing: s.sidebarContentGap.resolve(sz),
          children: [
            sidebar,
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: s.contentSurfaceColor,
                  borderRadius: s.contentBorderRadius,
                  boxShadow: s.contentShadows,
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
