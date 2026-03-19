import 'package:flutter/material.dart';
import 'package:glyph_ui/glyph_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'widgetbook/avatars.dart';
import 'widgetbook/badges.dart';
import 'widgetbook/buttons.dart';
import 'widgetbook/cards.dart';
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
        useCases: [
          WidgetbookUseCase(name: 'Default', builder: cardDefault),
          WidgetbookUseCase(name: 'Selected', builder: cardSelected),
        ],
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
        name: 'GlyphSecureBadge',
        useCases: [
          WidgetbookUseCase(name: 'Secure Badge', builder: secureBadge),
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
        name: 'GlyphInputField',
        useCases: [
          WidgetbookUseCase(name: 'Input Field', builder: inputField),
          WidgetbookUseCase(
            name: 'Input With Trailing',
            builder: inputFieldTrailing,
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphSearchInput',
        useCases: [
          WidgetbookUseCase(name: 'Search Input', builder: searchInput),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphTagPill',
        useCases: [WidgetbookUseCase(name: 'Tag Pill', builder: tagPill)],
      ),
      WidgetbookComponent(
        name: 'GlyphAvailabilityBadge',
        useCases: [
          WidgetbookUseCase(
            name: 'Availability Badge',
            builder: availabilityBadge,
          ),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphColorBadge',
        useCases: [
          WidgetbookUseCase(name: 'Color Badges', builder: colorBadges),
        ],
      ),
      WidgetbookComponent(
        name: 'GlyphAvatar',
        useCases: [
          WidgetbookUseCase(name: 'Initials', builder: avatarInitials),
          WidgetbookUseCase(name: 'Colored Initials', builder: avatarColored),
          WidgetbookUseCase(name: 'Multiple Sizes', builder: avatarSizes),
        ],
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
        name: 'GlyphAppBar',
        useCases: [.new(name: 'App Bar', builder: appBar)],
      ),
    ],
  ),
];
