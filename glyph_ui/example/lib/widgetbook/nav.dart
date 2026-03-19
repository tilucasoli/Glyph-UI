import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Breadcrumbs', type: GlyphBreadcrumbs, path: '[Glyph]/Navigation')
Widget breadcrumbs(BuildContext context) {
  return GlyphBreadcrumbs(
    items: ['Design Conference 2024', 'Attendees'],
  );
}

@widgetbook.UseCase(name: 'Pagination', type: GlyphPagination, path: '[Glyph]/Navigation')
Widget pagination(BuildContext context) {
  return GlyphPagination(
    currentPage: 2,
    totalItems: 124,
    itemsPerPage: 10,
    onPrevious: () {},
    onNext: () {},
  );
}

@widgetbook.UseCase(name: 'Notification Dot', type: GlyphNotificationDot, path: '[Glyph]/Navigation')
Widget notificationDot(BuildContext context) {
  return const GlyphNotificationDot();
}
