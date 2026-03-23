import 'package:flutter/material.dart';

import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';
export 'glyph_sidebar_item.dart';
import 'glyph_sidebar_item.dart';
import 'glyph_sidebar_metrics.dart';
import 'glyph_sidebar_style.dart';

/// Data model for a labeled group of [GlyphSidebarItem]s.
///
/// ```dart
/// GlyphNavGroup(
///   title: 'Event Management',
///   items: [...],
/// )
/// ```
class GlyphNavGroup {
  const GlyphNavGroup({required this.title, required this.items});

  final String title;
  final List<GlyphSidebarItem> items;
}

/// Sidebar navigation panel.
///
/// Matches the `.sidebar` element from the design reference. Supply
/// [style] (and optionally [metrics]) from the design system; the widget does
/// not read token colors directly.
///
/// ```dart
/// GlyphSidebar(
///   style: .standard(),
///   brandName: 'Eventis',
///   brandIcon: ...,
///   groups: [
///     GlyphNavGroup(
///       title: 'Event Management',
///       items: [
///         GlyphSidebarItem(
///           icon: Icon(Icons.dashboard_outlined),
///           label: 'Dashboard',
///           onTap: () {},
///         ),
///       ],
///     ),
///   ],
///   footer: CommunitySwitcher(),
/// )
/// ```
final class GlyphSidebar extends StatelessWidget {
  const GlyphSidebar({
    super.key,
    required this.style,
    this.metrics,
    required this.brandName,
    required this.brandIcon,
    required this.groups,
    this.footer,
    this.header,
  });

  final GlyphSidebarStyle style;

  /// Defaults to [GlyphSidebarMetrics.medium] when omitted.
  final GlyphSidebarMetrics? metrics;

  final String brandName;
  final Widget brandIcon;
  final List<GlyphNavGroup> groups;

  /// Widget pinned to the bottom of the sidebar, above the inner padding.
  final Widget? footer;

  /// Replaces the default brand row when non-null.
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final m = metrics ?? .medium();

    return Container(
      width: m.width,
      decoration: BoxDecoration(
        color: style.sidebarBackgroundColor,
        borderRadius: style.sidebarBorderRadius,
        boxShadow: style.sidebarShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header ??
              _SidebarBrand(
                metrics: m,
                brandName: brandName,
                brandIcon: brandIcon,
              ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groups
                    .map(
                      (g) => _NavGroupSection(
                        style: style,
                        metrics: m,
                        group: g,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (footer != null)
            Container(
              padding: m.footerPadding,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: style.footerTopBorderColor),
                ),
              ),
              child: footer!,
            ),
        ],
      ),
    );
  }
}

class _SidebarBrand extends StatelessWidget {
  const _SidebarBrand({
    required this.metrics,
    required this.brandName,
    required this.brandIcon,
  });

  final GlyphSidebarMetrics metrics;
  final String brandName;
  final Widget brandIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: metrics.brandPadding,
      child: Row(
        children: [
          brandIcon,
          const SizedBox(width: 10),
          Text(brandName, style: GlyphTextStyles.titleXsmall),
        ],
      ),
    );
  }
}

class _NavGroupSection extends StatelessWidget {
  const _NavGroupSection({
    required this.style,
    required this.metrics,
    required this.group,
  });

  final GlyphSidebarStyle style;
  final GlyphSidebarMetrics metrics;
  final GlyphNavGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: metrics.navGroupVerticalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: metrics.navGroupTitleHorizontalPadding,
            ),
            child: Text(group.title, style: style.navGroupTitleStyle),
          ),
          SizedBox(height: Spacing.x2),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: metrics.navItemsHorizontalPadding,
            ),
            child: Column(
              children: group.items
                  .map(
                    (item) => GlyphSidebarItemTile(
                      style: style.itemStyle,
                      metrics: metrics,
                      item: item,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

