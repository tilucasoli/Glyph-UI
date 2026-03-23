import 'package:flutter/material.dart';

import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';
export 'glyph_sidebar_item.dart';
import 'glyph_sidebar_item.dart';
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
/// Matches the `.sidebar` element from the design reference. Supply [style]
/// from the design system; the widget does not read token colors directly.
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
    this.size = GlyphSidebarSize.medium,
    required this.brandName,
    required this.brandIcon,
    required this.groups,
    this.footer,
    this.header,
  });

  final GlyphSidebarStyle style;
  final GlyphSidebarSize size;
  final String brandName;
  final Widget brandIcon;
  final List<GlyphNavGroup> groups;
  final Widget? footer;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final s = style;
    final sz = size;

    return Container(
      width: s.width.resolve(sz),
      decoration: BoxDecoration(
        color: s.sidebarBackgroundColor,
        borderRadius: s.sidebarBorderRadius,
        boxShadow: s.sidebarShadows,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header ??
              _SidebarBrand(
                style: s,
                size: sz,
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
                        style: s,
                        size: sz,
                        group: g,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          if (footer != null)
            Container(
              padding: s.footerPadding.resolve(sz),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: s.footerTopBorderColor),
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
    required this.style,
    required this.size,
    required this.brandName,
    required this.brandIcon,
  });

  final GlyphSidebarStyle style;
  final GlyphSidebarSize size;
  final String brandName;
  final Widget brandIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.brandPadding.resolve(size),
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
    required this.size,
    required this.group,
  });

  final GlyphSidebarStyle style;
  final GlyphSidebarSize size;
  final GlyphNavGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: style.navGroupVerticalPadding.resolve(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: style.navGroupTitleHorizontalPadding.resolve(size),
            ),
            child: Text(group.title, style: style.navGroupTitleStyle),
          ),
          SizedBox(height: Spacing.x2),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: style.navItemsHorizontalPadding.resolve(size),
            ),
            child: Column(
              children: group.items
                  .map(
                    (item) => GlyphSidebarItemTile(
                      sidebarStyle: style,
                      size: size,
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
