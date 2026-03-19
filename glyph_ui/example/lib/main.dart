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
import 'widgetbook/payment.dart';
import 'widgetbook/tokens.dart';

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

/// Manual directory structure for the widget catalog.
/// All components are centralized under a single folder.
final directories = [
  WidgetbookFolder(
    name: 'Components',
    children: [
      WidgetbookComponent(
        name: 'Button',
        useCases: [WidgetbookUseCase(name: 'Button', builder: buttonUseCase)],
      ),
      WidgetbookComponent(
        name: 'Icon Button',
        useCases: [
          WidgetbookUseCase(name: 'Icon Button', builder: iconButtonUseCase),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphCard',
        useCases: [WidgetbookUseCase(name: 'Default', builder: cardDefault)],
      ),
      WidgetbookComponent(
        name: 'GlyphPaymentMethodCard',
        useCases: [
          WidgetbookUseCase(
            name: 'Payment Method Cards',
            builder: paymentMethodCards,
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'Colors',
        useCases: [WidgetbookUseCase(name: 'Colors', builder: colorsToken)],
      ),
      WidgetbookComponent(
        name: 'Spacing',
        useCases: [WidgetbookUseCase(name: 'Spacing', builder: spacingToken)],
      ),
      WidgetbookComponent(
        name: 'Typography',
        useCases: [
          WidgetbookUseCase(name: 'Typography', builder: typographyToken),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphTextField',
        useCases: [
          WidgetbookUseCase(name: 'Text Field (Medium)', builder: inputField),
          WidgetbookUseCase(
            name: 'Text Field (Large)',
            builder: inputFieldTrailing,
          ),
        ],
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
        name: 'GlyphPagination',
        useCases: [WidgetbookUseCase(name: 'Pagination', builder: pagination)],
      ),
      WidgetbookComponent(
        name: 'GlyphNotificationDot',
        useCases: [
          WidgetbookUseCase(name: 'Notification Dot', builder: notificationDot),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphDropdown',
        useCases: [
          .new(name: 'Dropdown', builder: dropdownUseCase),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphAppBar',
        useCases: [.new(name: 'App Bar', builder: appBar)],
      ),
    ],
  ),
];
