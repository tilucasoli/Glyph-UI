# Buttons Rebuild Design

Recreate Glyph button components from scratch — no Material `ButtonStyleButton` dependency. Each button manages its own `WidgetStatesController` internally.

## File Structure

```
buttons/
  glyph_button.dart            # GlyphButton widget (StatefulWidget)
  glyph_button_style.dart      # GlyphButtonStyle class
  glyph_icon_button.dart       # GlyphIconButton widget (StatefulWidget)
  glyph_icon_button_style.dart # GlyphIconButtonStyle class
```

`glyph_button_theme.dart` is deleted — no more ThemeExtension.

## GlyphButtonStyle

`WidgetStateProperty` fields for state-dependent visuals. Plain fields for sizing.

```dart
@immutable
final class GlyphButtonStyle {
  const GlyphButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.side,
    required this.shape,
    required this.padding,
    required this.minHeight,
    required this.labelTextStyle,
    required this.iconSize,
    required this.iconGap,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<BorderSide> side;
  final WidgetStateProperty<OutlinedBorder> shape;
  final EdgeInsets padding;
  final double minHeight;
  final TextStyle labelTextStyle;
  final double iconSize;
  final double iconGap;
  final Duration animationDuration;
  final Curve animationCurve;

  // Factory constructors with Glyph token defaults
  factory GlyphButtonStyle.filled({ ... });
  factory GlyphButtonStyle.stroke({ ... });
  factory GlyphButtonStyle.ghost({ ... });

  GlyphButtonStyle copyWith({ ... });
  GlyphButtonStyle merge(GlyphButtonStyle? other);
}
```

## GlyphIconButtonStyle

Same pattern, tailored for icon-only buttons.

```dart
@immutable
final class GlyphIconButtonStyle {
  const GlyphIconButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.side,
    required this.shape,
    required this.buttonSize,
    required this.iconSize,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeOut,
  });

  final WidgetStateProperty<Color> backgroundColor;
  final WidgetStateProperty<Color> foregroundColor;
  final WidgetStateProperty<BorderSide> side;
  final WidgetStateProperty<OutlinedBorder> shape;
  final double buttonSize;
  final double iconSize;
  final Duration animationDuration;
  final Curve animationCurve;

  factory GlyphIconButtonStyle.filled({ ... });
  factory GlyphIconButtonStyle.stroke({ ... });
  factory GlyphIconButtonStyle.ghost({ ... });

  GlyphIconButtonStyle copyWith({ ... });
  GlyphIconButtonStyle merge(GlyphIconButtonStyle? other);
}
```

## GlyphButton Widget

StatefulWidget. Owns `WidgetStatesController` fully internally.

### Constructor

```dart
const GlyphButton({
  super.key,
  required this.label,
  required this.onPressed,
  required this.style,
  this.leadingIcon,
  this.trailingIcon,
  this.expand = false,
  this.loading = false,
});
```

### Widget Tree

```
Semantics(button: true)
  └─ Focus(onFocusChange → update controller)
     └─ MouseRegion(onEnter/onExit → update controller)
        └─ GestureDetector(onTapDown/onTapUp/onTapCancel → update controller)
           └─ AnimatedContainer(
                duration: style.animationDuration,
                curve: style.animationCurve,
                decoration: resolved from WidgetStateProperty fields,
                padding: style.padding,
                constraints: BoxConstraints(minHeight: style.minHeight),
                child: content
              )
```

### State Management

1. `initState`: create `WidgetStatesController`, add listener → `setState`.
2. Disabled: `onPressed == null || loading == true` → set disabled state.
3. `MouseRegion.onEnter/onExit` → toggle `WidgetState.hovered`.
4. `Focus.onFocusChange` → toggle `WidgetState.focused`.
5. `GestureDetector.onTapDown` → set pressed. `onTapUp` → clear pressed + invoke callback. `onTapCancel` → clear pressed.
6. `dispose`: dispose the controller.

### Content

- Normal: `Row([leadingIcon?, Text(label), trailingIcon?])` with `style.iconGap` spacing.
- Loading: `Stack(Opacity(child: Row), loadingIndicator)` to preserve size.

## GlyphIconButton Widget

Same StatefulWidget + WidgetStatesController pattern.

### Constructor

```dart
const GlyphIconButton({
  super.key,
  required this.icon,
  required this.onPressed,
  required this.semanticLabel,
  required this.style,
  this.tooltip,
});
```

### Content

Square `AnimatedContainer` with `BoxConstraints.tightFor(width: style.buttonSize, height: style.buttonSize)`, centered icon with `IconTheme(data: IconThemeData(size: style.iconSize, color: resolved foregroundColor))`. Optional `Tooltip` wrapper.

## Key Decisions

- **No Material button dependency** — GestureDetector + Focus + MouseRegion primitives.
- **Fully internal WidgetStatesController** — no external access.
- **Animated color transitions** — 150ms ease-out via AnimatedContainer.
- **WidgetStateProperty** for state-dependent visuals (background, foreground, border, shape).
- **Plain fields** for non-state-dependent sizing (padding, minHeight, iconSize).
- **Factory constructors** for variant defaults (`.filled()`, `.stroke()`, `.ghost()`).
- **No focus ring** — Focus widget for traversal only, no visual indicator.
- **All features preserved** — loading, leading/trailing icons, expand, tooltip, semanticLabel.

## Consumer API

```dart
GlyphButton(
  label: 'Add to cart',
  onPressed: () {},
  style: GlyphButtonStyle.filled(),
  leadingIcon: Icon(Icons.add),
);

GlyphIconButton(
  icon: Icon(Icons.search),
  onPressed: () {},
  semanticLabel: 'Search',
  style: GlyphIconButtonStyle.stroke(),
  tooltip: 'Search',
);
```
