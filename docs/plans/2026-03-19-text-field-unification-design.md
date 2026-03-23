# Glyph Text Field Unification Design

**Date:** 2026-03-19  
**Status:** Approved

## Goal

Unify form text input components into a single reusable text-field component, remove the dedicated search input component, and align text-field visual language with the existing button stroke style while supporting exactly two sizes.

## Context

The current form layer contains two separate input components:
- `glyph_input_field.dart` (`GlyphInputField`)
- `glyph_search_input.dart` (`GlyphSearchInput`)

This split duplicates interaction behavior and diverges API surface. The design direction is to have one text field component with a clearer API and consistent stroke visuals.

## Decisions

### 1) Single Component

- Remove `glyph_search_input.dart`.
- Keep only one text field component in the form package.

### 2) Naming

- Rename `GlyphInputField` to `GlyphTextField`.
- Rename file `glyph_input_field.dart` to `glyph_text_field.dart`.

This avoids conflict with Flutter's built-in `TextField` while still matching the intended "single TextField component" concept in the design system.

### 3) Public API

`GlyphTextField` exposes:
- `label` (required)
- `placeholder`
- `controller`
- `keyboardType`
- `textInputAction`
- `obscureText`
- `onChanged`
- `trailing`
- `size` (`GlyphTextFieldSize`, default `.medium`)

`GlyphTextFieldSize` supports exactly:
- `.medium`
- `.large`

### 4) Visual Behavior

Text field style should mirror button stroke language:
- Border color default: `GlyphColors.borderMedium`
- Border color focused: `GlyphColors.textPrimary`
- Border radius: `8` (`GlyphRadius.borderSm`)
- Surface feel aligned with stroke button treatment

Interaction support:
- Idle
- Focused
- Disabled (if wired by parent usage)

Hover/pressed styling remains minimal for input ergonomics.

### 5) Structure and Exporting

- Replace export of `glyph_input_field.dart` with `glyph_text_field.dart`.
- Remove export of `glyph_search_input.dart`.
- Update all examples/widgetbook use-cases to `GlyphTextField`.

## Migration Impact

### Affected files

- `glyph_ui/lib/src/components/form/glyph_input_field.dart` (rename + class rename)
- `glyph_ui/lib/src/components/form/glyph_search_input.dart` (delete)
- `glyph_ui/lib/glyph_ui.dart` (exports)
- `glyph_ui/example/lib/widgetbook/forms.dart` (use-cases)
- `glyph_ui/example/lib/main.dart` (component naming in catalog)

### Breaking Changes

- `GlyphInputField` symbol removed in favor of `GlyphTextField`.
- `GlyphSearchInput` removed.

Consumers must migrate imports/usages to `GlyphTextField`.

## Acceptance Criteria

- Only one form text input component remains in the codebase.
- Component is named `GlyphTextField`.
- Exactly two sizes are supported: `medium` and `large`.
- Visual presentation follows stroke-button border language.
- Package exports and examples compile against new API.
