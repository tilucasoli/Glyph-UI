import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'widgetbook/badges.dart';
import 'widgetbook/buttons.dart';
import 'widgetbook/cards.dart';
import 'widgetbook/dropdowns.dart';
import 'widgetbook/forms.dart';
import 'widgetbook/layout.dart';
import 'widgetbook/nav.dart';
import 'widgetbook/sidebar.dart';

void main() {
  runApp(const GlyphWidgetbookApp());
}

@widgetbook.App()
class GlyphWidgetbookApp extends StatelessWidget {
  const GlyphWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [WidgetbookTheme(name: 'Light', data: GlyphTheme.light())],
        ),
      ],
    );
  }
}

/// Manual directory structure for the widget catalog (components only).
final directories = [
  WidgetbookFolder(
    name: 'Components',
    children: [
      WidgetbookComponent(
        name: 'GlyphAppBar',
        useCases: [WidgetbookUseCase(name: 'App Bar', builder: appBar)],
      ),
      WidgetbookComponent(
        name: 'GlyphBadge',
        useCases: [WidgetbookUseCase(name: 'All Styles', builder: badgeStyles)],
      ),
      WidgetbookComponent(
        name: 'GlyphBreadcrumbs',
        useCases: [
          WidgetbookUseCase(name: 'Breadcrumbs', builder: breadcrumbs),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphButton',
        useCases: [WidgetbookUseCase(name: 'Button', builder: buttonUseCase)],
      ),
      WidgetbookComponent(
        name: 'GlyphCard',
        useCases: [WidgetbookUseCase(name: 'Default', builder: cardDefault)],
      ),
      // WidgetbookComponent(
      //   name: 'GlyphDataTable',
      //   useCases: [
      //     WidgetbookUseCase(name: 'Data Table', builder: dataTableUseCase),
      //   ],
      // ),
      WidgetbookComponent(
        name: 'GlyphDropdown',
        useCases: [
          WidgetbookUseCase(name: 'Dropdown', builder: dropdownUseCase),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphIconButton',
        useCases: [
          WidgetbookUseCase(name: 'Icon Button', builder: iconButtonUseCase),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphPagination',
        useCases: [WidgetbookUseCase(name: 'Pagination', builder: pagination)],
      ),
      WidgetbookComponent(
        name: 'GlyphScaffold',
        useCases: [
          WidgetbookUseCase(name: 'Scaffold', builder: scaffoldUseCase),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphSidebar',
        useCases: [WidgetbookUseCase(name: 'Sidebar', builder: sidebarUseCase)],
      ),
      WidgetbookComponent(
        name: 'GlyphSidebarItemTile',
        useCases: [
          WidgetbookUseCase(
            name: 'Sidebar Item Tile',
            builder: sidebarItemTileUseCase,
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphTextField',
        useCases: [WidgetbookUseCase(name: 'Default', builder: textField)],
      ),
    ],
  ),
];
