# Dropdown Refactor Design

Refactor `GlyphDropdown` from a monolithic 512-line file into the Style / Metrics / Widget architecture, adding a disabled state and splitting visual concerns into two style classes.

---

## Requirements

- Conform to the three-file architecture from `ARCHITECTURE.md`
- Two style classes: `GlyphDropdownTriggerStyle` (interactive trigger) and `GlyphDropdownStyle` (panel + option rows)
- Disabled state via nullable `onChanged`
- Leading widget support on both trigger and items (already partially present — formalize it)
- Medium and large size presets in Metrics (trigger only — panel dimensions are fixed)
- Keep: panel header, direction (up/down/left/right), checkmark, placeholder
- Drop: item subtitle

---

## File Layout

```
glyph_dropdown_trigger_style.dart   ← Trigger visuals (WidgetStateProperty)
glyph_dropdown_style.dart           ← Panel + option row visuals (plain values)
glyph_dropdown_metrics.dart         ← Trigger dimensions (medium / large)
glyph_dropdown.dart                 ← Widget + GlyphDropdownItem<T> + direction enum
```

All four exported from `glyph_ui.dart`.

---

## GlyphDropdownTriggerStyle

Mirrors `GlyphButtonStyle`. All visual properties use `WidgetStateProperty` to react to disabled / hovered / pressed states.

```dart
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

  factory GlyphDropdownTriggerStyle.stroke() { ... }

  GlyphDropdownTriggerStyle copyWith({ ... });
}
```

- `chevronColor` is separate from `foregroundColor` (tertiary when idle, dims when disabled).
- Single `.stroke()` factory — stroke button look with border.
- State resolution: disabled → pressed → hovered → default.

---

## GlyphDropdownStyle

Covers the panel overlay and option rows. Properties are plain values since the panel is not interactive at the trigger level. Option hover/selected are simple `Color` fields — option rows manage their own hover state internally.

```dart
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

  factory GlyphDropdownStyle.standard() { ... }

  GlyphDropdownStyle copyWith({ ... });
}
```

- Single `.standard()` factory sourcing from `GlyphColors` / `GlyphRadius`.

---

## GlyphDropdownMetrics

Only trigger dimensions vary between sizes. Panel and option row dimensions are fixed constants internal to the widget.

```dart
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

  factory GlyphDropdownMetrics.medium() { ... }
  factory GlyphDropdownMetrics.large() { ... }

  GlyphDropdownMetrics copyWith({ ... });
}
```

---

## Widget API

```dart
final class GlyphDropdown<T> extends StatefulWidget {
  const GlyphDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,        // nullable → null = disabled
    this.placeholder,
    this.header,
    this.leading,
    this.minWidth = 220,
    this.direction = GlyphDropdownDirection.down,
    required this.triggerStyle,
    this.dropdownStyle,             // defaults to .standard()
    this.metrics,                   // defaults to .medium()
  });
}
```

- `onChanged` nullable for disabled state (matches `GlyphButton.onPressed` pattern).
- `triggerStyle` required; `dropdownStyle` and `metrics` optional with defaults.

### GlyphDropdownItem\<T\>

```dart
class GlyphDropdownItem<T> {
  const GlyphDropdownItem({
    required this.value,
    required this.label,
    this.leading,
  });
}
```

Subtitle removed per requirements.

### State Machine

Trigger uses `WidgetStatesController` per the architecture:
- `initState` → listener + initial disabled state
- `didUpdateWidget` → sync disabled when `onChanged` changes
- `dispose` → clean up controller
- Wrapper: `Semantics → Focus → MouseRegion → GestureDetector → AnimatedContainer`
- All gesture callbacks null when disabled; cursor switches `click` / `basic`

Panel and option rows stay as lightweight private widgets with local `_hovered` booleans.

### Direction

`GlyphDropdownDirection` enum and `_DirectionX` extension unchanged. The 6px gap between trigger and panel stays hardcoded in the extension since panel dimensions are fixed.
