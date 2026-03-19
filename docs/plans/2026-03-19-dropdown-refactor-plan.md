# Dropdown Refactor Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Refactor the monolithic `GlyphDropdown` into the Style / Metrics / Widget architecture with two style classes, a disabled state, and medium/large size presets.

**Architecture:** Two style classes (`GlyphDropdownTriggerStyle` for the interactive trigger, `GlyphDropdownStyle` for the passive panel + option rows), one metrics class (trigger-only dimensions with medium/large presets), and the widget file containing the `GlyphDropdown<T>` StatefulWidget with `WidgetStatesController` on the trigger.

**Tech Stack:** Flutter, Dart — references `GlyphColors`, `GlyphRadius`, `GlyphTextStyles` token layer.

---

### Task 1: Create `GlyphDropdownTriggerStyle`

**Files:**
- Create: `glyph_ui/lib/src/components/dropdown/glyph_dropdown_trigger_style.dart`

**Step 1: Create the trigger style class**

Write the full file. Mirrors `GlyphButtonStyle` (see `glyph_ui/lib/src/components/buttons/glyph_button_style.dart`). Uses `WidgetStateProperty` for all visual properties. Single `.stroke()` factory. State resolution order: disabled → pressed → hovered → default.

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

@immutable
final class GlyphDropdownTriggerStyle {
  const GlyphDropdownTriggerStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    required this.chevronColor,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<Color> chevronColor;
  final WidgetStateProperty<List<BoxShadow>> shadows;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphDropdownTriggerStyle.stroke() {
    return .new(
      backgroundColor: .resolveWith((states) {
        if (states.contains(.disabled)) return GlyphColors.borderLight;
        if (states.contains(.pressed)) return GlyphColors.borderMedium;
        if (states.contains(.hovered)) return GlyphColors.bgBody;
        return GlyphColors.bgSurface;
      }),
      foregroundColor: .resolveWith((states) {
        if (states.contains(.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.textPrimary;
      }),
      shape: .all(
        RoundedRectangleBorder(
          borderRadius: .circular(8),
          side: BorderSide(color: GlyphColors.borderMedium),
        ),
      ),
      chevronColor: .resolveWith((states) {
        if (states.contains(.disabled)) return GlyphColors.borderMedium;
        return GlyphColors.textTertiary;
      }),
    );
  }

  GlyphDropdownTriggerStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<OutlinedBorder>? shape,
    WidgetStateProperty<Color>? chevronColor,
    WidgetStateProperty<List<BoxShadow>>? shadows,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return .new(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      shape: shape ?? this.shape,
      chevronColor: chevronColor ?? this.chevronColor,
      shadows: shadows ?? this.shadows,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
```

**Step 2: Verify it analyzes cleanly**

Run: `cd glyph_ui && dart analyze lib/src/components/dropdown/glyph_dropdown_trigger_style.dart`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/dropdown/glyph_dropdown_trigger_style.dart
git commit -m "feat(dropdown): add GlyphDropdownTriggerStyle"
```

---

### Task 2: Create `GlyphDropdownStyle`

**Files:**
- Create: `glyph_ui/lib/src/components/dropdown/glyph_dropdown_style.dart`

**Step 1: Create the dropdown style class**

Panel + option row visuals. All plain values (no `WidgetStateProperty`). Single `.standard()` factory. Sources colors from `GlyphColors`, radii from `GlyphRadius`.

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';

@immutable
final class GlyphDropdownStyle {
  const GlyphDropdownStyle({
    required this.panelBackgroundColor,
    required this.panelBorderSide,
    required this.panelBorderRadius,
    this.panelShadows = const [],
    required this.headerColor,
    required this.optionBackgroundColor,
    required this.optionSelectedBackgroundColor,
    required this.optionHoveredBackgroundColor,
    required this.optionForegroundColor,
    required this.optionBorderRadius,
    required this.checkmarkColor,
  });

  final Color panelBackgroundColor;
  final BorderSide panelBorderSide;
  final BorderRadius panelBorderRadius;
  final List<BoxShadow> panelShadows;

  final Color headerColor;

  final Color optionBackgroundColor;
  final Color optionSelectedBackgroundColor;
  final Color optionHoveredBackgroundColor;
  final Color optionForegroundColor;
  final BorderRadius optionBorderRadius;

  final Color checkmarkColor;

  factory GlyphDropdownStyle.standard() {
    return .new(
      panelBackgroundColor: GlyphColors.bgSurface,
      panelBorderSide: BorderSide(color: GlyphColors.borderMedium),
      panelBorderRadius: GlyphRadius.borderSm,
      panelShadows: [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const .new(0, 8),
          spreadRadius: -4,
        ),
      ],
      headerColor: GlyphColors.textTertiary,
      optionBackgroundColor: const Color(0x00000000),
      optionSelectedBackgroundColor: GlyphColors.bgSidebar,
      optionHoveredBackgroundColor: GlyphColors.bgBody,
      optionForegroundColor: GlyphColors.textPrimary,
      optionBorderRadius: GlyphRadius.borderSm,
      checkmarkColor: GlyphColors.textPrimary,
    );
  }

  GlyphDropdownStyle copyWith({
    Color? panelBackgroundColor,
    BorderSide? panelBorderSide,
    BorderRadius? panelBorderRadius,
    List<BoxShadow>? panelShadows,
    Color? headerColor,
    Color? optionBackgroundColor,
    Color? optionSelectedBackgroundColor,
    Color? optionHoveredBackgroundColor,
    Color? optionForegroundColor,
    BorderRadius? optionBorderRadius,
    Color? checkmarkColor,
  }) {
    return .new(
      panelBackgroundColor: panelBackgroundColor ?? this.panelBackgroundColor,
      panelBorderSide: panelBorderSide ?? this.panelBorderSide,
      panelBorderRadius: panelBorderRadius ?? this.panelBorderRadius,
      panelShadows: panelShadows ?? this.panelShadows,
      headerColor: headerColor ?? this.headerColor,
      optionBackgroundColor: optionBackgroundColor ?? this.optionBackgroundColor,
      optionSelectedBackgroundColor: optionSelectedBackgroundColor ?? this.optionSelectedBackgroundColor,
      optionHoveredBackgroundColor: optionHoveredBackgroundColor ?? this.optionHoveredBackgroundColor,
      optionForegroundColor: optionForegroundColor ?? this.optionForegroundColor,
      optionBorderRadius: optionBorderRadius ?? this.optionBorderRadius,
      checkmarkColor: checkmarkColor ?? this.checkmarkColor,
    );
  }
}
```

**Step 2: Verify it analyzes cleanly**

Run: `cd glyph_ui && dart analyze lib/src/components/dropdown/glyph_dropdown_style.dart`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/dropdown/glyph_dropdown_style.dart
git commit -m "feat(dropdown): add GlyphDropdownStyle"
```

---

### Task 3: Create `GlyphDropdownMetrics`

**Files:**
- Create: `glyph_ui/lib/src/components/dropdown/glyph_dropdown_metrics.dart`

**Step 1: Create the metrics class**

Trigger-only dimensions. Medium maps to existing values. Large bumps sizes up. Text styles from `GlyphTextStyles`. No colors.

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_typography.dart';

@immutable
final class GlyphDropdownMetrics {
  const GlyphDropdownMetrics({
    required this.triggerPadding,
    required this.triggerMinHeight,
    required this.triggerLabelTextStyle,
    required this.triggerLeadingGap,
    required this.chevronSize,
  });

  final EdgeInsets triggerPadding;
  final double triggerMinHeight;
  final TextStyle triggerLabelTextStyle;
  final double triggerLeadingGap;
  final double chevronSize;

  factory GlyphDropdownMetrics.medium() {
    return const .new(
      triggerPadding: .symmetric(vertical: 8, horizontal: 14),
      triggerMinHeight: 40,
      triggerLabelTextStyle: GlyphTextStyles.small,
      triggerLeadingGap: 8,
      chevronSize: 14,
    );
  }

  factory GlyphDropdownMetrics.large() {
    return const .new(
      triggerPadding: .symmetric(vertical: 10, horizontal: 16),
      triggerMinHeight: 48,
      triggerLabelTextStyle: GlyphTextStyles.metaItem,
      triggerLeadingGap: 10,
      chevronSize: 16,
    );
  }

  GlyphDropdownMetrics copyWith({
    EdgeInsets? triggerPadding,
    double? triggerMinHeight,
    TextStyle? triggerLabelTextStyle,
    double? triggerLeadingGap,
    double? chevronSize,
  }) {
    return .new(
      triggerPadding: triggerPadding ?? this.triggerPadding,
      triggerMinHeight: triggerMinHeight ?? this.triggerMinHeight,
      triggerLabelTextStyle: triggerLabelTextStyle ?? this.triggerLabelTextStyle,
      triggerLeadingGap: triggerLeadingGap ?? this.triggerLeadingGap,
      chevronSize: chevronSize ?? this.chevronSize,
    );
  }
}
```

**Step 2: Verify it analyzes cleanly**

Run: `cd glyph_ui && dart analyze lib/src/components/dropdown/glyph_dropdown_metrics.dart`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/dropdown/glyph_dropdown_metrics.dart
git commit -m "feat(dropdown): add GlyphDropdownMetrics"
```

---

### Task 4: Rewrite `GlyphDropdown` widget

**Files:**
- Modify: `glyph_ui/lib/src/components/dropdown/glyph_dropdown.dart`

**Step 1: Rewrite the entire file**

This is the largest step. The file keeps:
- `GlyphDropdownDirection` enum and `_DirectionX` extension (unchanged)
- `GlyphDropdownItem<T>` (drop `subtitle`)
- `GlyphDropdown<T>` widget (new constructor params, `WidgetStatesController` on trigger)
- `_DropdownTrigger` (resolves `triggerStyle` + `metrics` via `WidgetStatesController`)
- `_DropdownPanel` (reads from `GlyphDropdownStyle`)
- `_DropdownOption` (reads from `GlyphDropdownStyle`)

Key changes from current code:
1. **Constructor** adds `triggerStyle` (required), `dropdownStyle` (optional), `metrics` (optional). `onChanged` becomes nullable (null = disabled).
2. **`_GlyphDropdownState`** adds `WidgetStatesController`, disabled tracking via `initState`/`didUpdateWidget`/`dispose`.
3. **`_DropdownTrigger`** replaces manual `_hovered` boolean with the parent's `WidgetStatesController`. Uses `AnimatedContainer` with `ShapeDecoration` resolved from `triggerStyle`.
4. **`_DropdownPanel`** receives `GlyphDropdownStyle` and reads panel colors/borders from it.
5. **`_DropdownOption`** receives individual style values from the parent's `GlyphDropdownStyle` instead of hardcoding `GlyphColors`.

The full file is ~350 lines. Reference the current `glyph_dropdown.dart` for the overlay/positioning logic (which stays the same) and `glyph_button.dart` for the `WidgetStatesController` pattern.

Important implementation notes:
- The `WidgetStatesController` lives on `_GlyphDropdownState`, not on `_DropdownTrigger`. The trigger is a private widget that receives the resolved style values.
- The trigger's wrapper stack follows the architecture: `Semantics → Focus → MouseRegion → GestureDetector → AnimatedContainer`.
- All gesture callbacks (`onTap` for toggle, hover enter/exit) are `null` when disabled.
- The chevron animation controller stays on the parent state (it controls overlay show/hide).
- `_DropdownPanel` and `_DropdownOption` are private `StatelessWidget`/`StatefulWidget` — they don't need `WidgetStatesController` since they manage simple hover booleans.

**Step 2: Verify it analyzes cleanly**

Run: `cd glyph_ui && dart analyze lib/src/components/dropdown/`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/dropdown/glyph_dropdown.dart
git commit -m "feat(dropdown): rewrite widget with Style/Metrics architecture"
```

---

### Task 5: Update barrel file exports

**Files:**
- Modify: `glyph_ui/lib/glyph_ui.dart`

**Step 1: Add new exports**

Find the existing dropdown export line:
```dart
export 'src/components/dropdown/glyph_dropdown.dart';
```

Replace it with:
```dart
export 'src/components/dropdown/glyph_dropdown_trigger_style.dart';
export 'src/components/dropdown/glyph_dropdown_style.dart';
export 'src/components/dropdown/glyph_dropdown_metrics.dart';
export 'src/components/dropdown/glyph_dropdown.dart';
```

**Step 2: Verify the full library analyzes cleanly**

Run: `cd glyph_ui && dart analyze lib/`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/lib/glyph_ui.dart
git commit -m "feat(dropdown): export new style and metrics classes"
```

---

### Task 6: Update example app usage

**Files:**
- Modify: `glyph_ui/example/lib/main.dart` (if it uses `GlyphDropdown`)

**Step 1: Find all usages of `GlyphDropdown` in the example app**

Search `glyph_ui/example/` for `GlyphDropdown`. Update each call site to pass `triggerStyle: GlyphDropdownTriggerStyle.stroke()`. Remove any `subtitle` from `GlyphDropdownItem` constructors.

**Step 2: Verify example analyzes cleanly**

Run: `cd glyph_ui/example && dart analyze lib/`
Expected: No issues found.

**Step 3: Commit**

```bash
git add glyph_ui/example/
git commit -m "fix(example): update dropdown usage to new API"
```

---

### Task 7: Add widgetbook use case

**Files:**
- Modify: `glyph_ui/example/lib/widgetbook/forms.dart` (or create a dedicated `dropdowns.dart` — forms.dart already covers form inputs, dropdown fits there)

**Step 1: Add a dropdown use case**

Add a widgetbook use case that demonstrates the dropdown with direction and size knobs. Pattern after `glyph_ui/example/lib/widgetbook/buttons.dart`.

**Step 2: Update `main.dart` imports if a new file was created**

If you created `dropdowns.dart`, make sure the widgetbook generator picks it up (it uses annotation scanning, so just ensure the file has the correct import).

**Step 3: Verify example analyzes cleanly**

Run: `cd glyph_ui/example && dart analyze lib/`
Expected: No issues found.

**Step 4: Commit**

```bash
git add glyph_ui/example/
git commit -m "feat(widgetbook): add dropdown use case"
```

---

### Task 8: Final verification

**Step 1: Full analysis pass**

Run: `cd glyph_ui && dart analyze`
Expected: No issues found.

**Step 2: Verify the example app builds**

Run: `cd glyph_ui/example && flutter build web --no-tree-shake-icons`
Expected: Build succeeds.

**Step 3: Final commit (if any cleanup needed)**

Only if previous steps revealed issues.
