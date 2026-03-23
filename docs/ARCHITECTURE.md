# Glyph Component Architecture

This document describes the three-file architecture used by the Button component family and serves as the blueprint for building any new Glyph component.

---

## Core Principle: Style / Metrics / Widget

Every interactive Glyph component is split into **three files** that separate concerns cleanly:

```
glyph_<component>.dart          ← StatefulWidget (behavior + render tree)
glyph_<component>_style.dart    ← Visual properties that change with state
glyph_<component>_metrics.dart  ← Dimensional constants (size presets)
```

| File | What it holds | Changes with `WidgetState`? |
|------|---------------|----------------------------|
| **Style** | Colors, shape, shadows, animation config | **Yes** — uses `WidgetStateProperty<T>` |
| **Metrics** | Padding, min-height, icon size, text style | **No** — plain `final` fields |
| **Widget** | State machine, gesture handling, render tree | N/A — consumes both |

This split keeps the widget file focused on *behavior* while style and metrics are independently reusable, testable, and composable via `copyWith`.

---

## 1. The Style Class

**File:** `glyph_<component>_style.dart`

The Style class holds every property that visually reacts to interaction states (idle, hovered, pressed, focused, disabled).

### Structure

```dart
@immutable
final class GlyphFooStyle {
  const GlyphFooStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.shape,
    this.shadows = const WidgetStatePropertyAll([]),
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  // State-dependent — resolved via WidgetStateProperty
  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<OutlinedBorder> shape;
  final WidgetStateProperty<List<BoxShadow>> shadows;

  // Static animation config
  final Duration animationDuration;
  final Curve animationCurve;
}
```

### Rules

1. **`@immutable` and `final class`** — styles are value objects, never subclassed.
2. **State-dependent properties** use `WidgetStateProperty<T>`. Resolve them inside `build()` against the current `Set<WidgetState>`.
3. **Static properties** (animation duration/curve) are plain `final` fields with sensible defaults.
4. **Factory constructors** provide named design-system presets:
   - `.filled()` — solid accent background, inverted foreground.
   - `.stroke()` — transparent background with a visible border via `BorderSide` on the shape.
   - `.ghost()` — no background, text-only.
5. **`copyWith`** — always provide one for per-instance overrides.
6. **Color values** come from `GlyphColors` (the token layer), keeping the style layer decoupled from raw hex values.

### State Resolution Order

Inside each `WidgetStateProperty.resolveWith` callback, check states in this priority order:

```
disabled → pressed → hovered → (default)
```

This matches user perception: a disabled button ignores all other states; a press overrides a hover.

---

## 2. The Metrics Class

**File:** `glyph_<component>_metrics.dart`

The Metrics class holds dimension-only values that do **not** depend on interaction state.

### Structure

```dart
@immutable
final class GlyphFooMetrics {
  const GlyphFooMetrics({
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
  });

  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;
  final double iconSize;
  final double iconGap;
}
```

### Rules

1. **`@immutable` and `final class`** — same as Style.
2. **Factory constructors** provide T-shirt size presets: `.xsmall()`, `.small()`, `.medium()`. Each one returns a `const` instance when possible.
3. **Text styles** reference `GlyphTextStyles` from the token layer.
4. **`copyWith`** — always provide one.
5. **No colors** — colors belong in Style. Metrics is purely geometry.

### Why Separate from Style?

- Metrics rarely change at runtime; style reacts per-frame to hover/press.
- Consumers can swap metrics (`.small()` vs `.medium()`) without rethinking colors.
- Keeps `WidgetStateProperty` out of dimensional logic — simpler mental model.

---

## 3. The Widget

**File:** `glyph_<component>.dart`

The widget is a `StatefulWidget` that owns a `WidgetStatesController` and builds a render tree that resolves Style + Metrics at build time.

### Skeleton

```dart
final class GlyphFoo extends StatefulWidget {
  const GlyphFoo({
    super.key,
    required this.onPressed,
    required this.style,
    this.metrics,
    // ...component-specific props
  });

  final VoidCallback? onPressed;
  final GlyphFooStyle style;
  final GlyphFooMetrics? metrics;  // nullable — falls back to default preset

  @override
  State<GlyphFoo> createState() => _GlyphFooState();
}
```

### State Machine

The `State` class manages interaction through `WidgetStatesController`:

```dart
class _GlyphFooState extends State<GlyphFoo> {
  final _controller = WidgetStatesController();

  bool get _isDisabled => widget.onPressed == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(WidgetState.disabled, _isDisabled);
  }

  @override
  void didUpdateWidget(covariant GlyphFoo oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(WidgetState.disabled, _isDisabled);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

Key points:
- `_controller.addListener(() => setState(() {}))` — any state change triggers a rebuild.
- `didUpdateWidget` syncs the disabled flag when the parent rebuilds with a different `onPressed`.
- The controller is disposed to avoid leaks.

### Gesture & Focus Wiring

Use the standard wrapper stack for interactive components:

```
Semantics
  └─ Focus
       └─ MouseRegion
            └─ GestureDetector
                 └─ AnimatedContainer  ← resolves style here
```

Each layer updates a single `WidgetState`:

| Widget | State updated |
|--------|---------------|
| `Focus` | `.focused` |
| `MouseRegion` | `.hovered` |
| `GestureDetector` | `.pressed` (on tap down/up/cancel) |

All gesture callbacks are `null` when disabled — the system ignores taps naturally.

### Build Method Pattern

```dart
@override
Widget build(BuildContext context) {
  final style = widget.style;
  final metrics = widget.metrics ?? GlyphFooMetrics.medium();
  final states = _controller.value;

  // Resolve state-dependent values once
  final bgColor = style.backgroundColor.resolve(states);
  final fgColor = style.foregroundColor.resolve(states);
  final shape   = style.shape.resolve(states);
  final shadows = style.shadows.resolve(states);

  return Semantics(
    button: true,
    child: Focus(
      onFocusChange: (f) => _controller.update(WidgetState.focused, f),
      child: MouseRegion(
        cursor: _isDisabled
            ? SystemMouseCursors.basic
            : SystemMouseCursors.click,
        onEnter: (_) => _controller.update(WidgetState.hovered, true),
        onExit:  (_) => _controller.update(WidgetState.hovered, false),
        child: GestureDetector(
          onTapDown:   _isDisabled ? null : _onTapDown,
          onTapUp:     _isDisabled ? null : _onTapUp,
          onTapCancel: _isDisabled ? null : _onTapCancel,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: style.animationDuration,
            curve: style.animationCurve,
            decoration: ShapeDecoration(
              color: bgColor,
              shape: shape,
              shadows: shadows,
            ),
            padding: metrics.padding,
            constraints: BoxConstraints(minHeight: metrics.minHeight),
            child: /* ...component content... */,
          ),
        ),
      ),
    ),
  );
}
```

### Foreground Color Propagation

Wrap content in `IconTheme` so child icons automatically pick up the resolved foreground color without needing explicit wiring:

```dart
IconTheme(
  data: IconThemeData(size: metrics.iconSize, color: fgColor),
  child: /* ... */,
)
```

Text color is applied via `style.copyWith(color: fgColor)` on the metrics' text style.

---

## Dependency Graph

```
┌──────────────────────────────────────────────────────┐
│                    Token Layer                        │
│  GlyphColors  ·  GlyphTextStyles  ·  GlyphRadius     │
└─────────────────────┬────────────────────────────────┘
                      │ referenced by
        ┌─────────────┴─────────────┐
        ▼                           ▼
  GlyphFooStyle              GlyphFooMetrics
  (colors, shape)            (padding, sizes, text)
        │                           │
        └─────────┬─────────────────┘
                  │ consumed by
                  ▼
            GlyphFoo (Widget)
```

- **Tokens → Style/Metrics → Widget.** Never skip a layer.
- The Widget never imports `GlyphColors` directly — it goes through its Style.

---

## Checklist: Adding a New Component

Use this checklist when creating `GlyphBar` (or any new component):

### Files to Create

- [ ] `glyph_bar_style.dart`
- [ ] `glyph_bar_metrics.dart`
- [ ] `glyph_bar.dart`

### Style Class (`GlyphBarStyle`)

- [ ] `@immutable final class`
- [ ] All visual, state-reactive properties are `WidgetStateProperty<T>`
- [ ] Default `shadows` = `WidgetStatePropertyAll([])`
- [ ] Default `animationDuration` = `Duration(milliseconds: 150)`
- [ ] Default `animationCurve` = `Curves.easeOut`
- [ ] Factory constructors for each design-system variant (`.filled()`, `.stroke()`, `.ghost()`, etc.)
- [ ] State resolution order inside resolvers: disabled → pressed → hovered → default
- [ ] `copyWith` method
- [ ] All colors sourced from `GlyphColors`

### Metrics Class (`GlyphBarMetrics`)

- [ ] `@immutable final class`
- [ ] Factory constructors for T-shirt sizes (`.xsmall()`, `.small()`, `.medium()`)
- [ ] Use `const` constructors where possible
- [ ] Text styles sourced from `GlyphTextStyles`
- [ ] `copyWith` method
- [ ] No color properties

### Widget Class (`GlyphBar`)

- [ ] `final class extends StatefulWidget`
- [ ] `style` is **required**, `metrics` is **optional** (nullable with default)
- [ ] State owns a `WidgetStatesController`
- [ ] Controller listener calls `setState(() {})`
- [ ] `initState` sets initial disabled state
- [ ] `didUpdateWidget` syncs disabled state
- [ ] `dispose` cleans up the controller
- [ ] Wrapper stack: `Semantics → Focus → MouseRegion → GestureDetector → AnimatedContainer`
- [ ] Cursor switches between `click` and `basic` based on disabled
- [ ] All gesture callbacks are `null` when disabled
- [ ] `IconTheme` propagates foreground color to child icons
- [ ] Content text uses resolved foreground color

---

## Real-World Reference: GlyphButton vs GlyphIconButton

Comparing the two existing buttons shows how the architecture flexes:

| Aspect | GlyphButton | GlyphIconButton |
|--------|------------|-----------------|
| Content | Label text + optional leading/trailing icons | Single icon |
| Extra features | `expand`, `loading` | `tooltip`, `semanticLabel` |
| Metrics fields | `padding`, `minHeight`, `labelTextStyle`, `iconSize`, `iconGap` | `buttonSize`, `iconSize` |
| Container sizing | `constraints` with `minHeight` | Fixed `width` + `height` |
| Style class | Identical structure | Identical structure |
| State machine | Identical | Identical |
| Gesture stack | Identical | Identical |

The **Style** classes are structurally identical — both have the same six fields. Only the **Metrics** differ because the components have different dimensional needs. The **Widget** state machine and gesture stack are copy-paste identical; only the `build` body diverges to render different content.

This is the design intent: when creating a new component, you reuse the state-management pattern verbatim and only customize what goes inside the `AnimatedContainer`.
