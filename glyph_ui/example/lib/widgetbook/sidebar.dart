import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Shared sample sidebar for layout demos (e.g. [GlyphScaffold]).
GlyphSidebar widgetbookSampleGlyphSidebar() {
  return GlyphSidebar(
    style: .standard(),
    brandName: 'Glyph UI',
    brandIcon: const Icon(Icons.layers_outlined, size: 28),
    groups: [
      GlyphNavGroup(
        title: 'Examples',
        items: [
          GlyphSidebarItem(
            icon: const Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
            isActive: true,
            onTap: () {},
          ),
          GlyphSidebarItem(
            icon: const Icon(Icons.table_chart_outlined),
            label: 'Tables',
            onTap: () {},
          ),
          GlyphSidebarItem(
            icon: const Icon(Icons.settings_outlined),
            label: 'Settings',
            onTap: () {},
          ),
        ],
      ),
    ],
  );
}

@widgetbook.UseCase(
  name: 'Sidebar',
  type: GlyphSidebar,
  path: '[Glyph]/Sidebar',
)
Widget sidebarUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      height: 520,
      child: widgetbookSampleGlyphSidebar(),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Sidebar Item Tile',
  type: GlyphSidebarItemTile,
  path: '[Glyph]/Sidebar',
)
Widget sidebarItemTileUseCase(BuildContext context) {
  final active = context.knobs.boolean(label: 'Active', initialValue: false);
  final disabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );
  final sidebarStyle = GlyphSidebarStyle.standard();
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: GlyphSidebarItemTile(
        sidebarStyle: sidebarStyle,
        size: .medium,
        item: GlyphSidebarItem(
          icon: const Icon(Icons.inbox_outlined),
          label: 'Inbox',
          isActive: active,
          onTap: disabled ? null : () {},
        ),
      ),
    ),
  );
}
