import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Breadcrumbs',
  type: GlyphBreadcrumbs,
  path: '[Glyph]/Navigation',
)
Widget breadcrumbs(BuildContext context) {
  return Center(
    child: GlyphBreadcrumbs(
      style: .standard(),
      items: ['Design Conference 2024', 'Attendees'],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Pagination',
  type: GlyphPagination,
  path: '[Glyph]/Navigation',
)
Widget pagination(BuildContext context) {
  return Center(
    child: GlyphPagination(
      style: .standard(),
      currentPage: 2,
      totalItems: 124,
      itemsPerPage: 10,
      onPrevious: () {},
      onNext: () {},
    ),
  );
}
