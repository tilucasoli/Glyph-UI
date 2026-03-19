import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_spacing.dart';
import '../../tokens/glyph_typography.dart';

/// Data model for a single navigation item in the sidebar.
///
/// ```dart
/// GlyphSidebarItem(
///   icon: Icon(Icons.confirmation_number_outlined),
///   label: 'Tickets',
///   isActive: true,
///   onTap: () {},
/// )
/// ```
class GlyphSidebarItem {
  const GlyphSidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
}

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
/// Matches the `.sidebar` element from the design reference:
/// - Fixed 260px width, [GlyphColors.bgSidebar] background
/// - [GlyphRadius.borderLg] (24px) corner radius, panel shadow
/// - Brand header (icon + name)
/// - One or more [GlyphNavGroup]s, each with a title and nav items
/// - Optional [footer] pinned to the bottom (e.g. a community switcher)
///
/// ```dart
/// GlyphSidebar(
///   brandName: 'Eventis',
///   brandIcon: Container(
///     width: 24, height: 24,
///     decoration: BoxDecoration(color: Color(0xFFFFF0ED), borderRadius: BorderRadius.circular(6)),
///     child: Icon(Icons.play_arrow, size: 14, color: Color(0xFFED5D3A)),
///   ),
///   groups: [
///     GlyphNavGroup(
///       title: 'Event Management',
///       items: [
///         GlyphSidebarItem(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard', onTap: () {}),
///         GlyphSidebarItem(icon: Icon(Icons.confirmation_number_outlined), label: 'Tickets', isActive: true, onTap: () {}),
///       ],
///     ),
///   ],
///   footer: CommunitySwitcher(),
/// )
/// ```
class GlyphSidebar extends StatelessWidget {
  const GlyphSidebar({
    super.key,
    required this.brandName,
    required this.brandIcon,
    required this.groups,
    this.footer,
    this.header,
  });

  final String brandName;
  final Widget brandIcon;
  final List<GlyphNavGroup> groups;

  /// Widget pinned to the bottom of the sidebar, above the inner padding.
  /// Typically used for a community/workspace switcher.
  final Widget? footer;
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: GlyphColors.bgSidebar,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _SidebarBrand(brandName: brandName, brandIcon: brandIcon),
          ?header,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: groups
                    .map((g) => _NavGroupSection(group: g))
                    .toList(),
              ),
            ),
          ),
          if (footer != null)
            Container(
              padding: const EdgeInsets.all(GlyphSpacing.s4),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: GlyphColors.borderMedium),
                ),
              ),
              child: footer!,
            ),
        ],
      ),
    );
  }
}

// ── Internal widgets ──────────────────────────────────────────────────────────

class _SidebarBrand extends StatelessWidget {
  const _SidebarBrand({required this.brandName, required this.brandIcon});

  final String brandName;
  final Widget brandIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        GlyphSpacing.s6,
        20,
        GlyphSpacing.s4,
      ),
      child: Row(
        children: [
          brandIcon,
          const SizedBox(width: 10),
          Text(brandName, style: GlyphTextStyles.navLogo),
        ],
      ),
    );
  }
}

class _NavGroupSection extends StatelessWidget {
  const _NavGroupSection({required this.group});

  final GlyphNavGroup group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: GlyphSpacing.s2,
        bottom: GlyphSpacing.s2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GlyphSpacing.s6),
            child: Text(
              group.title,
              style: GlyphTextStyles.meta.copyWith(
                color: GlyphColors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: GlyphSpacing.s2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: GlyphSpacing.s3),
            child: Column(
              children: group.items
                  .map((item) => _NavItemTile(item: item))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItemTile extends StatefulWidget {
  const _NavItemTile({required this.item});

  final GlyphSidebarItem item;

  @override
  State<_NavItemTile> createState() => _NavItemTileState();
}

class _NavItemTileState extends State<_NavItemTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.item.isActive;

    final bgColor = isActive
        ? GlyphColors.bgSurface
        : _hovered
        ? GlyphColors.bgSurface.withValues(alpha: 0.7)
        : GlyphColors.bgSurface.withValues(alpha: 0.0);

    final fgColor = isActive
        ? GlyphColors.textPrimary
        : GlyphColors.textSecondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(
            horizontal: GlyphSpacing.s3,
            vertical: GlyphSpacing.s2,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: GlyphRadius.borderSm,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: fgColor, size: 18),
                child: widget.item.icon,
              ),
              const SizedBox(width: GlyphSpacing.s3),
              Text(
                widget.item.label,
                style: GlyphTextStyles.small.copyWith(
                  color: fgColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
