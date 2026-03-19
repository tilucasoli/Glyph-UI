# Unified Glyph Buttons — Design Spec

**Date:** 2025-03-18  
**Status:** Approved

## Summary

Replace the four existing button components with two unified components: **GlyphButton** (label ± icons) and **GlyphIconButton** (icon-only). Both share the same variant system (filled, stroke, ghost), size system (xsmall, small, medium), and theme-driven `ButtonStyle`. Optimized for desktop: hover, focus, disabled (muted background), and optional expand/loading on GlyphButton.

---

## 1. Architecture and boundaries

### Components

- **GlyphButton** — Label required. Optional leading and/or trailing icon. Supports `expand`, `isLoading`, `onPressed`, `variant`, `size`, optional `style`.
- **GlyphIconButton** — Icon required, no label. Requires `semanticLabel` for accessibility. Supports `onPressed`, `variant`, `size`, optional `style`.

### Shared

- **Variant** — Enum `GlyphButtonVariant { filled, stroke, ghost }`. Both widgets take `variant` and resolve style from theme, then merge optional `style`.
- **Size** — Enum `GlyphButtonSize { xsmall, small, medium }`. Single lookup for padding, min height, and text/icon scale so both components stay aligned.
- **Style** — Flutter `ButtonStyle`. Theme holds three prebuilt styles (one per variant). Widgets use `ButtonStyle.merge(themeStyleFor(variant), widgetStyle)`.

### Theme

- Default styles live in app theme. **GlyphButtonTheme** (or equivalent) provides three `ButtonStyle`s keyed by variant. No extra widget tree beyond existing theme.

### Files

All four button-related files live under `glyph_ui/lib/src/components/buttons/`. Theme/style types can live in the same folder or under `lib/src/theme/` as preferred.

| File | Path | Purpose |
|------|------|--------|
| `glyph_button_style.dart` | `lib/src/components/buttons/` | Enums `GlyphButtonVariant`, `GlyphButtonSize`; size metrics (e.g. class `GlyphButtonStyleMetrics` or function `getButtonStyleMetrics(size)`). |
| `glyph_button_theme.dart` | `lib/src/components/buttons/` or `lib/src/theme/` | `GlyphButtonThemeData` with three `ButtonStyle`s; `styleFor(GlyphButtonVariant)`; registration in theme. |
| `glyph_button.dart` | `lib/src/components/buttons/` | Widget `GlyphButton` (label, leading/trailing icon, expand, isLoading). |
| `glyph_icon_button.dart` | `lib/src/components/buttons/` | Widget `GlyphIconButton` (icon, semanticLabel, optional tooltip). |

Theme updates in `glyph_theme.dart`: add `GlyphButtonThemeData` to theme (e.g. via `extensions` or existing pattern).

---

## 2. API

### GlyphButton

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|--------------|
| `label` | `String` | Yes | — | Button label. |
| `onPressed` | `VoidCallback?` | Yes | — | Null = disabled. |
| `variant` | `GlyphButtonVariant` | No | `filled` | filled / stroke / ghost. |
| `size` | `GlyphButtonSize` | No | `medium` | xsmall / small / medium. |
| `style` | `ButtonStyle?` | No | `null` | Merged over theme style. |
| `leadingIcon` | `Widget?` | No | `null` | Icon before label. |
| `trailingIcon` | `Widget?` | No | `null` | Icon after label. |
| `expand` | `bool` | No | `false` | When true, button fills width. |
| `isLoading` | `bool` | No | `false` | When true, label is replaced by a centered spinner; spinner size matches the size variant’s icon size; button is disabled. |
| `key` | `Key?` | No | `null` | Widget key. |

### GlyphIconButton

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|--------------|
| `icon` | `Widget` | Yes | — | Icon widget. |
| `onPressed` | `VoidCallback?` | Yes | — | Null = disabled. |
| `semanticLabel` | `String` | Yes | — | A11y label (required for icon-only). |
| `variant` | `GlyphButtonVariant` | No | `stroke` | filled / stroke / ghost. |
| `size` | `GlyphButtonSize` | No | `medium` | xsmall / small / medium. |
| `style` | `ButtonStyle?` | No | `null` | Merged over theme style. |
| `tooltip` | `String?` | No | `null` | Optional hover tooltip. |
| `key` | `Key?` | No | `null` | Widget key. |

### Enums (glyph_button_style.dart)

- `GlyphButtonVariant { filled, stroke, ghost }`
- `GlyphButtonSize { xsmall, small, medium }`

### Style resolution

Both widgets: base style = `GlyphButtonTheme.of(context).styleFor(variant)`. If `style != null`, use `ButtonStyle.merge(base, style)`. Apply size-specific padding/minSize/iconSize at build time (merge into resolved style).

---

## 3. Variants and ButtonStyle (visuals and states)

### Variants

- **Filled** — Solid background (e.g. `GlyphColors.accentSolid`), contrasting foreground. Border: none.
- **Stroke** — Transparent (or surface) background, 1px border (`borderMedium` / `borderLight`), foreground e.g. `textPrimary`.
- **Ghost** — No border, transparent background; foreground as above. Hover/pressed add subtle background (e.g. `bgBody`).

All encoded in `ButtonStyle` via `WidgetStateProperty`.

### States

- **Default** — Base background, foreground, side.
- **Hovered** — Slight background change; stroke/ghost get soft fill.
- **Pressed** — Stronger feedback (e.g. darker or scale).
- **Disabled** — **Muted background** (not only opacity); muted foreground so clearly non-interactive.
- **Focused** — Visible focus ring. Implement via `overlayColor` or `side` in `ButtonStyle` using `WidgetState.focused` (e.g. border or overlay with `accentBlue` or `outlineColor`).

Implementation: `glyph_button_theme.dart` builds three `ButtonStyle`s with `WidgetStateProperty<Color>` (and similar for `side`, etc.) for backgroundColor, foregroundColor, side, overlayColor. Widgets use Material-style button or a single custom widget that applies the resolved style and forwards state.

Tokens: `GlyphColors`, `GlyphRadius` only; no new tokens.

---

## 4. Sizes (xsmall, small, medium)

Size metrics are defined in `glyph_button_style.dart` via a lookup (e.g. class `GlyphButtonStyleMetrics` or function `getButtonStyleMetrics(size)`). Use `GlyphSpacing` and `GlyphRadius` where applicable.

### GlyphButton (label ± icons)

| Size   | Padding (v×h) | Min height | Label text style (GlyphTextStyles) | Icon size |
|--------|----------------|------------|------------------------------------|-----------|
| medium | 18×24          | 56         | `buttonPrimary` (16px w600)       | 16        |
| small  | 10×14          | 40         | `small` (13px w500)                | 14        |
| xsmall | 8×12           | 32         | `meta` (12px w500)                 | 12        |

### GlyphIconButton (icon-only)

| Size   | Min width × min height | Icon size |
|--------|-------------------------|-----------|
| medium | 44×44                    | 20        |
| small  | 36×36                    | 16        |
| xsmall | 28×28                    | 14        |

Size is applied at build time by merging padding and minimumSize (and icon size when building content) into the resolved `ButtonStyle`.

---

## 5. Theme wiring and replacement of old buttons

### Theme

- **GlyphButtonThemeData** — Holds three `ButtonStyle`s (filled, stroke, ghost). Exposed via `ThemeData.extensions` (or existing Glyph theme pattern). `GlyphTheme.light()` builds default `GlyphButtonThemeData` and adds it to theme.
- **Resolution** — Widgets call `GlyphButtonTheme.of(context).styleFor(variant)`, then merge optional `style` and size-specific metrics.

### Replacement (no deprecation)

- **Remove** the four components `GlyphPrimaryButton`, `GlyphActionButton`, `GlyphIconOutlineButton`, `GlyphBadgeIconButton` and update all usages to `GlyphButton` / `GlyphIconButton`:
  - `glyph_app_bar.dart`
  - `glyph_view_state.dart`
  - `glyph_secure_badge.dart`
  - Example app and widgetbook (`lib/main.dart`, `widgetbook/buttons.dart`, `widgetbook/layout.dart`)
- **Exports** — In `glyph_ui.dart`, export the new components and theme; remove exports of the old button classes.

---

## 6. Out of scope (this spec)

- Notification dot on icon button (dropped).
- Migration path or deprecation period (direct replacement only).
