# Buttons Rebuild Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Rebuild Glyph button components from scratch without Material ButtonStyleButton, using internal WidgetStatesController and WidgetStateProperty-based styles.

**Architecture:** Each button (GlyphButton, GlyphIconButton) is a StatefulWidget that owns a WidgetStatesController. Style classes hold WidgetStateProperty fields for state-dependent visuals and plain fields for sizing. Factory constructors provide variant defaults (filled/stroke/ghost). AnimatedContainer handles 150ms color transitions.

**Tech Stack:** Flutter widgets (GestureDetector, Focus, MouseRegion, AnimatedContainer), WidgetStatesController, WidgetStateProperty, existing Glyph design tokens.

---

### Task 1: Create GlyphButtonStyle

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_button_style.dart`

**Step 1: Write the style class**

Replace the current file entirely with:

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';

/// Style configuration for [GlyphButton].
///
/// State-dependent properties use [WidgetStateProperty] and are resolved
/// against the button's internal [WidgetStatesController] state set.
/// Non-state-dependent sizing properties are plain fields.
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

  factory GlyphButtonStyle.filled() {
    return GlyphButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed)) return const Color(0xFF080808);
        if (states.contains(WidgetState.hovered)) return const Color(0xFF0D0D0D);
        return GlyphColors.accentSolid;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.accentSolidText;
      }),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  factory GlyphButtonStyle.stroke() {
    return GlyphButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed)) return GlyphColors.borderMedium;
        if (states.contains(WidgetState.hovered)) return GlyphColors.bgBody;
        return GlyphColors.bgSurface;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.textPrimary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        return const BorderSide(color: GlyphColors.borderMedium, width: 1);
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  factory GlyphButtonStyle.ghost() {
    return GlyphButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.bgBody;
        }
        return const Color(0x00000000);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.textPrimary;
      }),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      minHeight: 46,
      labelTextStyle: GlyphTextStyles.small,
      iconSize: 16,
      iconGap: 6,
    );
  }

  GlyphButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<BorderSide>? side,
    WidgetStateProperty<OutlinedBorder>? shape,
    EdgeInsets? padding,
    double? minHeight,
    TextStyle? labelTextStyle,
    double? iconSize,
    double? iconGap,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return GlyphButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      padding: padding ?? this.padding,
      minHeight: minHeight ?? this.minHeight,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      iconSize: iconSize ?? this.iconSize,
      iconGap: iconGap ?? this.iconGap,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
```

**Step 2: Verify no analysis errors**

Run: `cd glyph_ui && dart analyze lib/src/components/buttons/glyph_button_style.dart`
Expected: No issues found

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_button_style.dart
git commit -m "feat(buttons): add GlyphButtonStyle with WidgetStateProperty fields"
```

---

### Task 2: Create GlyphButton

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_button.dart`

**Step 1: Write the widget**

Replace the current file entirely with:

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';
import 'glyph_button_style.dart';

/// A text button built from raw Flutter primitives.
///
/// Owns an internal [WidgetStatesController] to track hovered, pressed,
/// focused, and disabled states. Resolves [GlyphButtonStyle] properties
/// against the current state set and animates color transitions.
final class GlyphButton extends StatefulWidget {
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

  final String label;
  final VoidCallback? onPressed;
  final GlyphButtonStyle style;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool expand;
  final bool loading;

  @override
  State<GlyphButton> createState() => _GlyphButtonState();
}

class _GlyphButtonState extends State<GlyphButton> {
  final WidgetStatesController _controller = WidgetStatesController();

  bool get _isDisabled => widget.onPressed == null || widget.loading;

  Set<WidgetState> get _states => _controller.value;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onStateChanged);
    _syncDisabled();
  }

  @override
  void didUpdateWidget(covariant GlyphButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncDisabled();
  }

  void _syncDisabled() {
    _controller.update(WidgetState.disabled, _isDisabled);
  }

  void _onStateChanged() {
    setState(() {});
  }

  void _onTapDown(TapDownDetails _) {
    if (!_isDisabled) _controller.update(WidgetState.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.update(WidgetState.pressed, false);
    if (!_isDisabled) widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.update(WidgetState.pressed, false);
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final states = _states;

    final bgColor = style.backgroundColor.resolve(states);
    final fgColor = style.foregroundColor.resolve(states);
    final border = style.side.resolve(states);
    final shape = style.shape.resolve(states);

    final loadingIndicator = SizedBox(
      width: style.iconSize,
      height: style.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: style.foregroundColor.resolve({WidgetState.disabled}) ??
            GlyphColors.textTertiary,
      ),
    );

    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: style.iconGap,
      children: [
        if (widget.leadingIcon != null) widget.leadingIcon!,
        Text(
          widget.label,
          style: style.labelTextStyle.copyWith(color: fgColor),
          strutStyle: const StrutStyle(forceStrutHeight: true, height: 1.05),
        ),
        if (widget.trailingIcon != null) widget.trailingIcon!,
      ],
    );

    return Semantics(
      button: true,
      child: Focus(
        onFocusChange: (focused) {
          _controller.update(WidgetState.focused, focused);
        },
        child: MouseRegion(
          cursor: _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(WidgetState.hovered, true),
          onExit: (_) => _controller.update(WidgetState.hovered, false),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: style.animationDuration,
              curve: style.animationCurve,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: shape.copyWith(side: border),
              ),
              padding: style.padding,
              constraints: BoxConstraints(
                minHeight: style.minHeight,
                minWidth: widget.expand ? double.infinity : 0,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(opacity: widget.loading ? 0 : 1, child: content),
                  Visibility(visible: widget.loading, child: loadingIndicator),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

**Step 2: Verify no analysis errors**

Run: `cd glyph_ui && dart analyze lib/src/components/buttons/glyph_button.dart`
Expected: No issues found

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_button.dart
git commit -m "feat(buttons): add GlyphButton with internal WidgetStatesController"
```

---

### Task 3: Create GlyphIconButtonStyle

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_icon_button_style.dart`

**Step 1: Write the style class**

```dart
import 'package:flutter/widgets.dart';

import '../../tokens/glyph_colors.dart';

/// Style configuration for [GlyphIconButton].
///
/// State-dependent properties use [WidgetStateProperty]. Non-state-dependent
/// sizing (buttonSize, iconSize) are plain fields.
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

  factory GlyphIconButtonStyle.filled() {
    return GlyphIconButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed)) return const Color(0xFF080808);
        if (states.contains(WidgetState.hovered)) return const Color(0xFF0D0D0D);
        return GlyphColors.accentSolid;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.accentSolidText;
      }),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  factory GlyphIconButtonStyle.stroke() {
    return GlyphIconButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed)) return GlyphColors.borderMedium;
        if (states.contains(WidgetState.hovered)) return GlyphColors.bgBody;
        return GlyphColors.bgSurface;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.textPrimary;
      }),
      side: WidgetStateProperty.resolveWith((states) {
        return const BorderSide(color: GlyphColors.borderMedium, width: 1);
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  factory GlyphIconButtonStyle.ghost() {
    return GlyphIconButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.borderLight;
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.hovered)) {
          return GlyphColors.bgBody;
        }
        return const Color(0x00000000);
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) return GlyphColors.textTertiary;
        return GlyphColors.textPrimary;
      }),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      buttonSize: 44,
      iconSize: 20,
    );
  }

  GlyphIconButtonStyle copyWith({
    WidgetStateProperty<Color>? backgroundColor,
    WidgetStateProperty<Color>? foregroundColor,
    WidgetStateProperty<BorderSide>? side,
    WidgetStateProperty<OutlinedBorder>? shape,
    double? buttonSize,
    double? iconSize,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return GlyphIconButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      buttonSize: buttonSize ?? this.buttonSize,
      iconSize: iconSize ?? this.iconSize,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
}
```

**Step 2: Verify no analysis errors**

Run: `cd glyph_ui && dart analyze lib/src/components/buttons/glyph_icon_button_style.dart`
Expected: No issues found

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_icon_button_style.dart
git commit -m "feat(buttons): add GlyphIconButtonStyle with WidgetStateProperty fields"
```

---

### Task 4: Create GlyphIconButton

**Files:**
- Create: `glyph_ui/lib/src/components/buttons/glyph_icon_button.dart`

**Step 1: Write the widget**

Replace the current file entirely with:

```dart
import 'package:flutter/widgets.dart';

import 'glyph_icon_button_style.dart';

/// An icon-only button built from raw Flutter primitives.
///
/// Owns an internal [WidgetStatesController] to track hovered, pressed,
/// focused, and disabled states. Resolves [GlyphIconButtonStyle] properties
/// against the current state set and animates color transitions.
final class GlyphIconButton extends StatefulWidget {
  const GlyphIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    required this.style,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final GlyphIconButtonStyle style;
  final String? tooltip;

  @override
  State<GlyphIconButton> createState() => _GlyphIconButtonState();
}

class _GlyphIconButtonState extends State<GlyphIconButton> {
  final WidgetStatesController _controller = WidgetStatesController();

  bool get _isDisabled => widget.onPressed == null;

  Set<WidgetState> get _states => _controller.value;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onStateChanged);
    _syncDisabled();
  }

  @override
  void didUpdateWidget(covariant GlyphIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncDisabled();
  }

  void _syncDisabled() {
    _controller.update(WidgetState.disabled, _isDisabled);
  }

  void _onStateChanged() {
    setState(() {});
  }

  void _onTapDown(TapDownDetails _) {
    if (!_isDisabled) _controller.update(WidgetState.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.update(WidgetState.pressed, false);
    if (!_isDisabled) widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.update(WidgetState.pressed, false);
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final states = _states;

    final bgColor = style.backgroundColor.resolve(states);
    final fgColor = style.foregroundColor.resolve(states);
    final border = style.side.resolve(states);
    final shape = style.shape.resolve(states);

    Widget button = Semantics(
      button: true,
      label: widget.semanticLabel,
      child: Focus(
        onFocusChange: (focused) {
          _controller.update(WidgetState.focused, focused);
        },
        child: MouseRegion(
          cursor: _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(WidgetState.hovered, true),
          onExit: (_) => _controller.update(WidgetState.hovered, false),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: style.animationDuration,
              curve: style.animationCurve,
              width: style.buttonSize,
              height: style.buttonSize,
              decoration: ShapeDecoration(
                color: bgColor,
                shape: shape.copyWith(side: border),
              ),
              alignment: Alignment.center,
              child: IconTheme(
                data: IconThemeData(size: style.iconSize, color: fgColor),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null && widget.tooltip!.isNotEmpty) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }
    return button;
  }
}
```

**Step 2: Verify no analysis errors**

Run: `cd glyph_ui && dart analyze lib/src/components/buttons/glyph_icon_button.dart`
Expected: No issues found

**Step 3: Commit**

```bash
git add glyph_ui/lib/src/components/buttons/glyph_icon_button.dart
git commit -m "feat(buttons): add GlyphIconButton with internal WidgetStatesController"
```

---

### Task 5: Delete GlyphButtonThemeData and Update Exports

**Files:**
- Delete: `glyph_ui/lib/src/components/buttons/glyph_button_theme.dart`
- Modify: barrel/export files that reference it

**Step 1: Delete the theme file**

```bash
rm glyph_ui/lib/src/components/buttons/glyph_button_theme.dart
```

**Step 2: Find and update all imports/exports that reference glyph_button_theme.dart**

Search for `glyph_button_theme` across the codebase. Update barrel exports to export the new files:
- `glyph_button_style.dart` (new)
- `glyph_button.dart` (new)
- `glyph_icon_button_style.dart` (new)
- `glyph_icon_button.dart` (new)

Remove any references to `GlyphButtonThemeData`, `GlyphButtonVariant`, `GlyphButtonSize`, `GlyphButtonStyleMetrics`.

**Step 3: Update GlyphTheme.light() if it registers GlyphButtonThemeData**

Find where `GlyphButtonThemeData.light()` is registered as a ThemeExtension and remove that registration.

**Step 4: Verify no analysis errors**

Run: `cd glyph_ui && dart analyze`
Expected: No issues found (some warnings about unused imports in example app are OK to fix in next task)

**Step 5: Commit**

```bash
git add -A
git commit -m "refactor(buttons): remove GlyphButtonThemeData and update exports"
```

---

### Task 6: Update Example App / Widgetbook

**Files:**
- Modify: `glyph_ui/example/lib/widgetbook/buttons.dart`
- Modify: any other example files referencing old API

**Step 1: Update button use cases**

Replace `GlyphButtonVariant` / `GlyphButtonSize` enum usage with the new `style:` parameter using factory constructors.

Old:
```dart
GlyphButton(label: 'Click', onPressed: () {}, variant: GlyphButtonVariant.filled)
```

New:
```dart
GlyphButton(label: 'Click', onPressed: () {}, style: GlyphButtonStyle.filled())
```

Same for `GlyphIconButton` — replace `variant:` with `style: GlyphIconButtonStyle.stroke()`.

**Step 2: Verify the example app builds**

Run: `cd glyph_ui/example && flutter analyze`
Expected: No issues found

**Step 3: Commit**

```bash
git add -A
git commit -m "refactor(example): update widgetbook to new button API"
```
