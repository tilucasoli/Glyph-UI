# Glyph UI Widgetbook

A component catalog for the Glyph design system, built with [Widgetbook](https://widgetbook.io/).

## Running the catalog

```bash
cd glyph_ui/example
flutter run -d chrome
```

Or for macOS desktop:

```bash
flutter run -d macos
```

## Structure

- `lib/main.dart` — Widgetbook app entry point with Glyph theme
- `lib/widgetbook/` — Use case files organized by component category:
  - `buttons.dart` — Primary and action buttons
  - `cards.dart` — Cards
  - `payment.dart` — Payment method cards and secure badge
  - `tokens.dart` — Colors, spacing, typography
  - `forms.dart` — Input fields and search
  - `badges.dart` — Tag pills, availability badges, color badges
  - `avatars.dart` — Avatars
  - `nav.dart` — Breadcrumbs, pagination, notification dot
  - `layout.dart` — App bar

## Regenerating directories (optional)

The catalog uses a manual directory structure. To switch to code generation:

1. Run `dart run build_runner build --delete-conflicting-outputs`
2. Replace the manual `directories` list in `main.dart` with `import 'main.directories.g.dart';` and `directories: directories`
