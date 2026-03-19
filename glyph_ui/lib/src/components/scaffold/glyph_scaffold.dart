import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';
import 'glyph_sidebar.dart';

/// App-level scaffold that composes a [GlyphSidebar] with a main content area.
///
/// Matches the `.layout-wrapper` structure from the design reference:
/// - Full-screen [GlyphColors.bgCanvas] background
/// - 16px inset padding on all sides
/// - 16px gap between sidebar and main content panel
/// - Main content wrapped in a white [GlyphColors.bgSurface] panel with
///   [GlyphRadius.borderLg] corners and a subtle panel shadow
///
/// Intended to replace [Scaffold] at the root of a desktop/tablet layout.
///
/// ```dart
/// GlyphScaffold(
///   sidebar: GlyphSidebar(
///     brandName: 'Eventis',
///     brandIcon: ...,
///     groups: [...],
///   ),
///   body: TicketsPage(),
/// )
/// ```
class GlyphScaffold extends StatelessWidget {
  const GlyphScaffold({
    super.key,
    required this.sidebar,
    required this.body,
  });

  final GlyphSidebar sidebar;

  /// The main content displayed to the right of the sidebar.
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlyphColors.bgCanvas,
      body: Padding(
        padding: const EdgeInsets.all(GlyphSpacing.s4),
        child: Row(
          children: [
            sidebar,
            const SizedBox(width: GlyphSpacing.s4),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: GlyphColors.bgSurface,
                  borderRadius: GlyphRadius.borderLg,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                      spreadRadius: -5,
                    ),
                  ],
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
