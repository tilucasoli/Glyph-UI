# Unified Glyph Buttons Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the four existing button widgets with two unified components (GlyphButton, GlyphIconButton) sharing variant (filled/stroke/ghost), size (xsmall/small/medium), and theme-driven ButtonStyle; desktop-optimized with hover, focus, disabled muted background, expand/loading on GlyphButton.

**Architecture:** New files under `glyph_ui/lib/src/components/buttons/`: `glyph_button_style.dart` (enums + size metrics), `glyph_button_theme.dart` (GlyphButtonThemeData with three ButtonStyles). Widgets resolve style from theme and merge optional override and size metrics. GlyphTheme.light() adds the button theme to ThemeData.extensions. Old four button files are removed and all usages updated to the new API.

**Tech Stack:** Flutter, Material 3 (WidgetStateProperty), existing Glyph tokens (GlyphColors, GlyphRadius, GlyphTextStyles).

**Spec:** `docs/superpowers/specs/2025-03-18-unified-buttons-design.md`

---

## File structure

| Action | Path | Responsibility |
|--------|------|----------------|
| Create | `glyph_ui/lib/src/components/buttons/glyph_button_style.dart` | `GlyphButtonVariant`, `GlyphButtonSize` enums; `GlyphButtonStyleMetrics` (or `getButtonStyleMetrics(size)`) returning padding, minHeight, iconSize, labelTextStyle per size. |
| Create | `glyph_ui/lib/src/components/buttons/glyph_button_theme.dart` | `GlyphButtonThemeData` with three `ButtonStyle`s; `styleFor(GlyphButtonVariant)`; static `of(BuildContext)`; default factory building filled/stroke/ghost with all states (hover, pressed, disabled muted background, focused). |
| Create | `glyph_ui/lib/src/components/buttons/glyph_button.dart` | `GlyphButton` widget: label, leadingIcon, trailingIcon, expand, isLoading, variant, size, style; uses theme + merge; applies metrics. |
| Create | `glyph_ui/lib/src/components/buttons/glyph_icon_button.dart` | `GlyphIconButton` widget: icon, semanticLabel, tooltip, variant, size, style; uses theme + merge; applies metrics. |
| Modify | `glyph_ui/lib/src/theme/glyph_theme.dart` | Add `GlyphButtonThemeData` to `ThemeData.extensions` in `GlyphTheme.light()`. |
| Modify | `glyph_ui/lib/glyph_ui.dart` | Replace exports of old four buttons with `glyph_button_style.dart`, `glyph_button_theme.dart`, `glyph_button.dart`, `glyph_icon_button.dart`. |
| Modify | `glyph_ui/lib/src/components/scaffold/glyph_app_bar.dart` | Update doc comment example: `GlyphPrimaryButton` → `GlyphButton`. |
| Modify | `glyph_ui/lib/src/components/state/glyph_view_state.dart` | Update doc comment example: `GlyphPrimaryButton` → `GlyphButton`. |
| Modify | `glyph_ui/lib/src/components/payment/glyph_secure_badge.dart` | Update doc comment example: `GlyphPrimaryButton` → `GlyphButton`. |
| Modify | `glyph_ui/example/lib/widgetbook/buttons.dart` | Rewrite use cases to use `GlyphButton` / `GlyphIconButton` and new API. |
| Modify | `glyph_ui/example/lib/widgetbook/layout.dart` | Replace `GlyphActionButton` with `GlyphButton(variant: stroke, ...)`. |
| Modify | `glyph_ui/example/lib/main.dart` | Update WidgetbookComponent names and use case builders to match new buttons. |
| Delete | `glyph_ui/lib/src/components/buttons/glyph_primary_button.dart` | — |
| Delete | `glyph_ui/lib/src/components/buttons/glyph_action_button.dart` | — |
| Delete | `glyph_ui/lib/src/components/buttons/glyph_icon_outline_button.dart` | — |
| Delete | `glyph_ui/lib/src/components/buttons/glyph_badge_icon_button.dart` | — |

---

## Task 1: Create glyph_button_style.dart (enums + size metrics)

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_button_style.dart`

- [ ] **Step 1: Add enums and size metrics**

Create the file with:
- `enum GlyphButtonVariant { filled, stroke, ghost }`
- `enum GlyphButtonSize { xsmall, small, medium }`
- A way to get metrics per size. Use a class or top-level function. Spec table:

**GlyphButton:** medium → padding 18×24, minHeight 56, GlyphTextStyles.buttonPrimary, iconSize 16; small → 10×14, 40, GlyphTextStyles.small, 14; xsmall → 8×12, 32, GlyphTextStyles.meta (or copyWith fontWeight w500), 12.

**GlyphIconButton:** medium → 44×44, iconSize 20; small → 36×36, 16; xsmall → 28×28, 14.

Example shape (implementer can use class or function):

```dart
import 'package:flutter/material.dart';
import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

enum GlyphButtonVariant { filled, stroke, ghost }

enum GlyphButtonSize { xsmall, small, medium }

/// Metrics for [GlyphButton] and [GlyphIconButton] per [GlyphButtonSize].
class GlyphButtonStyleMetrics {
  const GlyphButtonStyleMetrics({
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconButtonSize,
    required this.iconButtonIconSize,
  });

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;
  /// Icon size for [GlyphButton] leading/trailing icons.
  final double iconSize;
  /// Min width/height for [GlyphIconButton].
  final double iconButtonSize;
  /// Icon size for [GlyphIconButton] (icon-only); spec 20/16/14.
  final double iconButtonIconSize;

  static GlyphButtonStyleMetrics forSize(GlyphButtonSize size) {
    switch (size) {
      case GlyphButtonSize.medium:
        return const GlyphButtonStyleMetrics(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          minHeight: 56,
          labelTextStyle: GlyphTextStyles.buttonPrimary,
          iconSize: 16,
          iconButtonSize: 44,
          iconButtonIconSize: 20,
        );
      case GlyphButtonSize.small:
        return GlyphButtonStyleMetrics(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          minHeight: 40,
          labelTextStyle: GlyphTextStyles.small.copyWith(color: GlyphColors.textPrimary),
          iconSize: 14,
          iconButtonSize: 36,
          iconButtonIconSize: 16,
        );
      case GlyphButtonSize.xsmall:
        return GlyphButtonStyleMetrics(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          minHeight: 32,
          labelTextStyle: GlyphTextStyles.meta.copyWith(
            color: GlyphColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          iconSize: 12,
          iconButtonSize: 28,
          iconButtonIconSize: 14,
        );
    }
  }
}
```

- [ ] **Step 2: Verify compilation**

Run: `cd glyph_ui && flutter analyze lib/src/components/buttons/glyph_button_style.dart`  
Expected: No analysis errors.

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_button_style.dart
git commit -m "feat(buttons): add glyph_button_style with enums and size metrics"
```

---

## Task 2: Create glyph_button_theme.dart (theme data + 3 ButtonStyles)

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_button_theme.dart`
- Depends on: `glyph_button_style.dart`, `glyph_colors.dart`, `glyph_radius.dart`

- [ ] **Step 1: Implement GlyphButtonThemeData and default styles**

Create the file. Requirements:
- Class `GlyphButtonThemeData` with three `ButtonStyle` fields (e.g. `filledStyle`, `strokeStyle`, `ghostStyle`) or a map/list keyed by `GlyphButtonVariant`.
- Method `ButtonStyle styleFor(GlyphButtonVariant variant)`.
- Static `GlyphButtonThemeData of(BuildContext context)` that reads from `Theme.of(context).extension<GlyphButtonThemeData>()` (so we register it as a ThemeExtension).
- `GlyphButtonThemeData` must extend `ThemeExtension<GlyphButtonThemeData>` and implement `copyWith` and `lerp` so it can be registered in `ThemeData.extensions`. (`lerp` can return `this` if theme animation is not needed.)
- Factory (e.g. `GlyphButtonThemeData.light()`) that builds three ButtonStyles with:
  - **Filled:** backgroundColor = accentSolid, foregroundColor = accentSolidText, side = none (or BorderSide.none), shape = borderMd. Disabled: backgroundColor = muted (use `GlyphColors.borderLight` as disabled fill), foregroundColor = textTertiary. Hover: slight darken (e.g. Color.lerp(accentSolid, black, 0.1)). Pressed: darker. Focused: overlayColor or side with accentBlue.
  - **Stroke:** backgroundColor = transparent (or bgSurface), foregroundColor = textPrimary, side = 1px borderLight/borderMedium. Disabled: backgroundColor = borderLight (muted), foregroundColor = textTertiary. Hover: backgroundColor = bgBody. Pressed: slightly darker. Focused: overlay or side with accentBlue.
  - **Ghost:** backgroundColor = transparent, foregroundColor = textPrimary, side = none. Disabled: backgroundColor = borderLight, foregroundColor = textTertiary. Hover/Pressed: backgroundColor = bgBody. Focused: overlay with accentBlue.

Use `WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states)` (or individual `WidgetStatePropertyAll` where a state is single) for backgroundColor, foregroundColor, side, overlayColor. Use `GlyphRadius.borderMd` for shape (or borderSm for small if you prefer; spec says radius from tokens). Use `RoundedRectangleBorder(borderRadius: GlyphRadius.borderMd)` for filled/stroke; ghost same or borderSm.

Example structure (implementer fills in full state resolution):

```dart
import 'package:flutter/material.dart';
import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import 'glyph_button_style.dart';

class GlyphButtonThemeData extends ThemeExtension<GlyphButtonThemeData> {
  const GlyphButtonThemeData({
    required this.filledStyle,
    required this.strokeStyle,
    required this.ghostStyle,
  });

  final ButtonStyle filledStyle;
  final ButtonStyle strokeStyle;
  final ButtonStyle ghostStyle;

  ButtonStyle styleFor(GlyphButtonVariant variant) {
    switch (variant) {
      case GlyphButtonVariant.filled: return filledStyle;
      case GlyphButtonVariant.stroke: return strokeStyle;
      case GlyphButtonVariant.ghost: return ghostStyle;
    }
  }

  static GlyphButtonThemeData of(BuildContext context) {
    final data = Theme.of(context).extension<GlyphButtonThemeData>();
    assert(data != null, 'GlyphButtonThemeData not found. Wrap with GlyphTheme.light().');
    return data!;
  }

  @override
  GlyphButtonThemeData copyWith({ ButtonStyle? filledStyle, ButtonStyle? strokeStyle, ButtonStyle? ghostStyle }) =>
      GlyphButtonThemeData(
        filledStyle: filledStyle ?? this.filledStyle,
        strokeStyle: strokeStyle ?? this.strokeStyle,
        ghostStyle: ghostStyle ?? this.ghostStyle,
      );

  @override
  GlyphButtonThemeData lerp(ThemeExtension<GlyphButtonThemeData>? other, double t) => this;

  static GlyphButtonThemeData light() {
    // Build filled, stroke, ghost with WidgetStateProperty for
    // backgroundColor, foregroundColor, side, overlayColor for
    // default, hovered, pressed, disabled, focused.
    return GlyphButtonThemeData(
      filledStyle: _buildFilledStyle(),
      strokeStyle: _buildStrokeStyle(),
      ghostStyle: _buildGhostStyle(),
    );
  }

  static ButtonStyle _buildFilledStyle() { ... }
  static ButtonStyle _buildStrokeStyle() { ... }
  static ButtonStyle _buildGhostStyle() { ... }
}
```

- [ ] **Step 2: Verify compilation**

Run: `cd glyph_ui && flutter analyze lib/src/components/buttons/glyph_button_theme.dart`  
Expected: No analysis errors.

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_button_theme.dart
git commit -m "feat(buttons): add GlyphButtonThemeData with filled/stroke/ghost styles"
```

---

## Task 3: Wire GlyphButtonThemeData into GlyphTheme.light()

**Files:**
- Modify: `glyph_ui/lib/src/theme/glyph_theme.dart`

- [ ] **Step 1: Register extension**

In `GlyphTheme.light()`, inside `ThemeData( ... )`, add to the `extensions` list:

```dart
import '../components/buttons/glyph_button_theme.dart'; // adjust path if theme lives elsewhere
// In extensions: [... existing, GlyphButtonThemeData.light(), ]
```

So the list becomes:

```dart
extensions: [
  GlyphColorTokens.light(),
  GlyphSpacingTokens.defaults(),
  GlyphRadiusTokens.defaults(),
  GlyphButtonThemeData.light(),
],
```

Note: ThemeExtension requires a `copyWith` and `lerp`; if `GlyphButtonThemeData` is not a ThemeExtension yet, register it as one. Flutter's ThemeExtension<T> requires `T copyWith(...)` and `T lerp(T? other, double t)`. So `GlyphButtonThemeData` should extend or implement ThemeExtension, or we use a different registration. Checking Flutter: ThemeData.extensions takes Map<Object, ThemeExtension>. So we need `GlyphButtonThemeData` to extend `ThemeExtension<GlyphButtonThemeData>`. Add that to Task 2: make `class GlyphButtonThemeData extends ThemeExtension<GlyphButtonThemeData>` and implement `copyWith` and `lerp` (lerp can return this for simplicity if we don't animate theme).

- [ ] **Step 2: Verify**

Run: `cd glyph_ui && flutter analyze lib/src/theme/glyph_theme.dart`  
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/src/theme/glyph_theme.dart
git commit -m "feat(theme): register GlyphButtonThemeData in GlyphTheme.light()"
```

---

## Task 4: Create GlyphButton widget

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_button.dart`
- Depends on: glyph_button_style.dart, glyph_button_theme.dart, tokens

- [ ] **Step 1: Implement GlyphButton**

- Required: `label` (String), `onPressed` (VoidCallback?).
- Optional: `variant` (default filled), `size` (default medium), `style` (ButtonStyle?), `leadingIcon`, `trailingIcon`, `expand` (default false), `isLoading` (default false), `key`.
- Resolve style: `base = GlyphButtonThemeData.of(context).styleFor(variant)`; then `resolved = style != null ? ButtonStyle.merge(base, style) : base`.
- Get metrics: `GlyphButtonStyleMetrics.forSize(size)`.
- Merge size into resolved style: padding and minimumSize from metrics (and textStyle from metrics for the label). Use `ButtonStyle.merge(resolved, ButtonStyle(padding: WidgetStateProperty.all(metrics.padding), minimumSize: WidgetStateProperty.all(Size(expand ? double.infinity : 0, metrics.minHeight)), textStyle: WidgetStateProperty.all(metrics.labelTextStyle)))` or equivalent.
- Build a button that respects `onPressed` (null = disabled). When `isLoading` is true, replace label with centered `SizedBox(width: metrics.iconSize, height: metrics.iconSize, child: CircularProgressIndicator(strokeWidth: 2, color: foregroundColor))` and treat as disabled.
- Use a Material button (e.g. FilledButton.offstage or ButtonStyleButton) so that focus and hover are handled, or use InkWell/FocusableActionDetector and apply the resolved ButtonStyle manually (e.g. Container with decoration from style). Prefer using Flutter's ButtonStyleButton with the resolved style so focus/hover come for free.
- Leading/trailing icon: wrap in IconTheme with size = metrics.iconSize and color from style foreground.
- Semantics: `Semantics(button: true, ...)` if using a custom tap target.

Implementer note: Flutter's `ButtonStyleButton` takes `style`, `onPressed`, and a `child`. So we can do: `ButtonStyleButton(style: resolved, onPressed: isLoading ? null : onPressed, child: content)`. But ButtonStyleButton expects a single child. So our content is a Row with optional leading icon, label (or loading indicator), optional trailing icon. For "expand", we wrap in SizedBox(width: double.infinity) or set minimumSize to (double.infinity, metrics.minHeight). So the widget structure: get resolved style with size merged; build content (loading ? spinner : [leadingIcon?, label, trailingIcon?]); wrap in ButtonStyleButton or Material button with that style.

- [ ] **Step 2: Verify**

Run: `cd glyph_ui && flutter analyze lib/src/components/buttons/glyph_button.dart`  
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_button.dart
git commit -m "feat(buttons): add GlyphButton widget"
```

---

## Task 5: Create GlyphIconButton widget

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_icon_button.dart`
- Depends on: glyph_button_style.dart, glyph_button_theme.dart

- [ ] **Step 1: Implement GlyphIconButton**

- Required: `icon` (Widget), `onPressed` (VoidCallback?), `semanticLabel` (String).
- Optional: `variant` (default stroke), `size` (default medium), `style` (ButtonStyle?), `tooltip` (String?), `key`.
- Resolve style and metrics same way as GlyphButton. Merge size: padding = EdgeInsets.zero or symmetric with same inset so hit area is metrics.iconButtonSize; minimumSize = Size(metrics.iconButtonSize, metrics.iconButtonSize).
- Build: icon centered in a square of iconButtonSize; apply resolved style (Container/Decoration or ButtonStyleButton). Wrap with `Semantics(button: true, label: semanticLabel)`. If tooltip != null, wrap with `Tooltip(message: tooltip!, child: ...)`.
- IconTheme size = metrics.iconButtonIconSize (GlyphButtonStyleMetrics has iconButtonIconSize 20/16/14 for medium/small/xsmall).

- [ ] **Step 2: Verify**

Run: `cd glyph_ui && flutter analyze lib/src/components/buttons/glyph_icon_button.dart`  
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_icon_button.dart
git commit -m "feat(buttons): add GlyphIconButton widget"
```

---

## Task 6: Update glyph_ui.dart exports

**Files:**
- Modify: `glyph_ui/lib/glyph_ui.dart`

- [ ] **Step 1: Replace button exports**

Remove:
- `export 'src/components/buttons/glyph_primary_button.dart';`
- `export 'src/components/buttons/glyph_badge_icon_button.dart';`
- `export 'src/components/buttons/glyph_icon_outline_button.dart';`
- `export 'src/components/buttons/glyph_action_button.dart';`

Add:
- `export 'src/components/buttons/glyph_button_style.dart';`
- `export 'src/components/buttons/glyph_button_theme.dart';`
- `export 'src/components/buttons/glyph_button.dart';`
- `export 'src/components/buttons/glyph_icon_button.dart';`

- [ ] **Step 2: Verify**

Run: `cd glyph_ui && flutter analyze lib/`  
Expected: No errors (other files may break until we update usages).

- [ ] **Step 3: Commit**

```bash
git add glyph_ui/lib/glyph_ui.dart
git commit -m "refactor(buttons): export new GlyphButton and GlyphIconButton"
```

---

## Task 7: Update doc comments in app_bar, view_state, secure_badge

**Files:**
- Modify: `glyph_ui/lib/src/components/scaffold/glyph_app_bar.dart` (doc comment only)
- Modify: `glyph_ui/lib/src/components/state/glyph_view_state.dart` (doc comment only)
- Modify: `glyph_ui/lib/src/components/payment/glyph_secure_badge.dart` (doc comment only)

- [ ] **Step 1: Update examples in doc comments**

In `glyph_app_bar.dart`, change the example from:
`GlyphPrimaryButton(label: 'New Event', onPressed: () {}),`
to:
`GlyphButton(label: 'New Event', onPressed: () {}),`

In `glyph_view_state.dart`, change:
`action: GlyphPrimaryButton(label: 'Create Event', onPressed: () {}),`
to:
`action: GlyphButton(label: 'Create Event', onPressed: () {}),`

In `glyph_secure_badge.dart`, change:
`GlyphPrimaryButton(label: 'Pay \$523.95', onPressed: _pay),`
to:
`GlyphButton(label: 'Pay \$523.95', onPressed: _pay),`

- [ ] **Step 2: Commit**

```bash
git add glyph_ui/lib/src/components/scaffold/glyph_app_bar.dart glyph_ui/lib/src/components/state/glyph_view_state.dart glyph_ui/lib/src/components/payment/glyph_secure_badge.dart
git commit -m "docs: update button examples to GlyphButton in doc comments"
```

---

## Task 8: Update example app and widgetbook

**Files:**
- Modify: `glyph_ui/example/lib/widgetbook/buttons.dart`
- Modify: `glyph_ui/example/lib/widgetbook/layout.dart`
- Modify: `glyph_ui/example/lib/main.dart`

- [ ] **Step 1: Rewrite widgetbook/buttons.dart**

Replace all use cases with the new API. Example mapping:
- Primary → `GlyphButton(label: 'Continue to Payment', onPressed: () {}, trailingIcon: Icon(Icons.arrow_forward))`
- Primary Compact → `GlyphButton(label: 'New Event', size: GlyphButtonSize.small, expand: false, onPressed: () {})`
- Primary Loading → `GlyphButton(label: 'Processing…', isLoading: true, onPressed: null)`
- Primary Disabled → `GlyphButton(label: 'Continue', onPressed: null)`
- Action → `GlyphButton(label: 'Filters', variant: GlyphButtonVariant.stroke, leadingIcon: Icon(Icons.filter_list_rounded), onPressed: () {})`
- Action Without Icon → `GlyphButton(label: 'Export CSV', variant: GlyphButtonVariant.stroke, onPressed: () {})`

Add use cases for GlyphIconButton and for ghost variant if desired. Use `path: '[Glyph]/Buttons'` and types `GlyphButton` / `GlyphIconButton` as needed.

- [ ] **Step 2: Update widgetbook/layout.dart**

Replace `GlyphActionButton(label: 'Settings', icon: const Icon(Icons.settings_outlined), onPressed: () {})` with `GlyphButton(label: 'Settings', variant: GlyphButtonVariant.stroke, leadingIcon: const Icon(Icons.settings_outlined), onPressed: () {})`.

- [ ] **Step 3: Update example/lib/main.dart**

In the `directories` list, replace the two WidgetbookComponent entries for GlyphPrimaryButton and GlyphActionButton with one or two components for GlyphButton and GlyphIconButton, pointing to the new use case builders from buttons.dart. Ensure builder names match (e.g. primaryButton → a builder that returns GlyphButton).

- [ ] **Step 4: Run example app**

Run: `cd glyph_ui/example && flutter run` (or open in device/simulator).  
Expected: App runs; Buttons section shows new buttons without errors.

- [ ] **Step 5: Commit**

```bash
git add glyph_ui/example/lib/widgetbook/buttons.dart glyph_ui/example/lib/widgetbook/layout.dart glyph_ui/example/lib/main.dart
git commit -m "refactor(example): switch widgetbook to GlyphButton and GlyphIconButton"
```

---

## Task 9: Delete old button files

**Files:**
- Delete: `glyph_ui/lib/src/components/buttons/glyph_primary_button.dart`
- Delete: `glyph_ui/lib/src/components/buttons/glyph_action_button.dart`
- Delete: `glyph_ui/lib/src/components/buttons/glyph_icon_outline_button.dart`
- Delete: `glyph_ui/lib/src/components/buttons/glyph_badge_icon_button.dart`

- [ ] **Step 1: Delete files**

Remove the four files. Ensure no remaining imports reference them (glyph_ui.dart already updated in Task 6; example updated in Task 8).

- [ ] **Step 2: Verify full package**

Run: `cd glyph_ui && flutter analyze lib/` and `cd glyph_ui/example && flutter analyze lib/`  
Expected: No errors.

- [ ] **Step 3: Commit**

```bash
git add -A glyph_ui/lib/src/components/buttons/
git commit -m "chore(buttons): remove old GlyphPrimaryButton, GlyphActionButton, GlyphIconOutlineButton, GlyphBadgeIconButton"
```

---

## Verification (after all tasks)

- Run `cd glyph_ui && flutter analyze`
- Run `cd glyph_ui/example && flutter run` and open the Buttons section in the widgetbook; confirm filled, stroke, ghost, sizes, loading, disabled, and icon button render and behave as in the spec.
