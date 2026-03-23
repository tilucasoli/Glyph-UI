import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_typography.dart';
import 'glyph_dropdown_metrics.dart';
import 'glyph_dropdown_style.dart';
import 'glyph_dropdown_trigger_style.dart';

/// Direction in which [GlyphDropdown] opens its overlay panel.
enum GlyphDropdownDirection {
  /// Panel opens below the trigger (default).
  down,

  /// Panel opens above the trigger.
  up,

  /// Panel opens to the right of the trigger.
  right,

  /// Panel opens to the left of the trigger.
  left,
}

// ── Direction helpers ─────────────────────────────────────────────────────────

extension _DirectionX on GlyphDropdownDirection {
  /// Where on the trigger the panel attaches.
  Alignment get targetAnchor => switch (this) {
    .down => .bottomLeft,
    .up => .topLeft,
    .right => .centerRight,
    .left => .centerLeft,
  };

  /// Which corner/edge of the panel aligns to [targetAnchor].
  Alignment get followerAnchor => switch (this) {
    .down => .topLeft,
    .up => .bottomLeft,
    .right => .centerLeft,
    .left => .centerRight,
  };

  /// Gap between trigger and panel.
  Offset get offset => switch (this) {
    .down => const .new(0, 6),
    .up => const .new(0, -6),
    .right => const .new(6, 0),
    .left => const .new(-6, 0),
  };

  /// [Align] used to keep the panel from stretching to screen edges.
  Alignment get panelAlign => switch (this) {
    .down => .topLeft,
    .up => .bottomLeft,
    .right => .centerLeft,
    .left => .centerRight,
  };

  /// Chevron rotation (in turns) when the panel is **closed**.
  ///
  /// The animation plays `forward()` on open and `reverse()` on close,
  /// so `begin` = closed angle and `end` = open angle.
  double get chevronBegin => switch (this) {
    .down => 0.0, // ↓ pointing down
    .up => 0.5, // ↑ pointing up
    .right => -0.25, // → pointing right
    .left => 0.25, // ← pointing left
  };

  /// Chevron rotation (in turns) when the panel is **open**.
  double get chevronEnd => switch (this) {
    .down => 0.5, // ↑ flipped up
    .up => 1.0, // ↓ flipped down (360° = 0°)
    .right => 0.25, // ← flipped left
    .left => -0.25, // → flipped right
  };
}

/// A single selectable item in [GlyphDropdown].
///
/// [leading] is typically a coloured avatar/logo or icon.
class GlyphDropdownItem<T> {
  const GlyphDropdownItem({
    required this.value,
    required this.label,
    this.leading,
  });

  final T value;
  final String label;

  /// Optional leading widget rendered at the start of each option row.
  final Widget? leading;
}

/// Styled dropdown selector with an animated overlay panel.
///
/// Use [direction] to control which side the panel opens toward.
/// The chevron icon in the trigger automatically rotates to reflect the
/// open direction. Pass `null` to [onChanged] to disable the dropdown.
final class GlyphDropdown<T> extends StatefulWidget {
  const GlyphDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.placeholder,
    this.header,
    this.leading,
    this.minWidth = 220,
    this.direction = .down,
    required this.triggerStyle,
    this.dropdownStyle,
    this.metrics,
  });

  final List<GlyphDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T>? onChanged;

  /// Shown in the trigger when [value] is null.
  final String? placeholder;

  /// Optional section label at the top of the panel
  /// (e.g. "Switch Community"). Rendered in uppercase 12px.
  final String? header;

  /// Fixed leading widget shown inside the trigger before the label.
  final Widget? leading;

  /// Minimum width of both the trigger and the panel.
  final double minWidth;

  /// Which side the panel opens toward.
  final GlyphDropdownDirection direction;

  final GlyphDropdownTriggerStyle triggerStyle;
  final GlyphDropdownStyle? dropdownStyle;
  final GlyphDropdownMetrics? metrics;

  @override
  State<GlyphDropdown<T>> createState() => _GlyphDropdownState<T>();
}

class _GlyphDropdownState<T> extends State<GlyphDropdown<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = .new();
  final OverlayPortalController _overlayController = .new();
  final WidgetStatesController _controller = .new();
  late final AnimationController _chevronAnim;

  bool get _isOpen => _overlayController.isShowing;
  bool get _isDisabled => widget.onChanged == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(.disabled, _isDisabled);
    _chevronAnim = AnimationController(
      vsync: this,
      duration: const .new(milliseconds: 150),
    );
  }

  @override
  void didUpdateWidget(covariant GlyphDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(.disabled, _isDisabled);
  }

  @override
  void dispose() {
    _controller.dispose();
    _chevronAnim.dispose();
    super.dispose();
  }

  void _open() {
    _overlayController.show();
    _chevronAnim.forward();
  }

  void _close() {
    _overlayController.hide();
    _chevronAnim.reverse();
  }

  void _toggle() {
    if (_isDisabled) return;
    _isOpen ? _close() : _open();
  }

  void _select(T value) {
    if (_isDisabled) return;
    widget.onChanged!(value);
    _close();
  }

  GlyphDropdownItem<T>? get _selectedItem {
    if (widget.value == null) return null;
    for (final item in widget.items) {
      if (item.value == widget.value) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedItem;
    final label = selected?.label ?? widget.placeholder ?? '';
    final leading = widget.leading ?? selected?.leading;
    final dir = widget.direction;
    final dropdownStyle = widget.dropdownStyle ?? GlyphDropdownStyle.standard();
    final metrics = widget.metrics ?? GlyphDropdownMetrics.medium();

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (ctx) => Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(onTap: _close, behavior: .opaque),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              targetAnchor: dir.targetAnchor,
              followerAnchor: dir.followerAnchor,
              offset: dir.offset,
              child: Align(
                alignment: dir.panelAlign,
                child: SizedBox(
                  width: _layerLink.leaderSize?.width,
                  child: _DropdownPanel<T>(
                    items: widget.items,
                    value: widget.value,
                    header: widget.header,
                    minWidth: widget.minWidth,
                    onSelect: _select,
                    style: dropdownStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        child: _DropdownTrigger(
          label: label,
          leading: leading,
          chevronAnim: _chevronAnim,
          direction: dir,
          minWidth: widget.minWidth,
          onTap: _toggle,
          isDisabled: _isDisabled,
          controller: _controller,
          triggerStyle: widget.triggerStyle,
          metrics: metrics,
        ),
      ),
    );
  }
}

// ── Trigger ───────────────────────────────────────────────────────────────────

class _DropdownTrigger extends StatelessWidget {
  const _DropdownTrigger({
    required this.label,
    this.leading,
    required this.chevronAnim,
    required this.direction,
    required this.minWidth,
    required this.onTap,
    required this.isDisabled,
    required this.controller,
    required this.triggerStyle,
    required this.metrics,
  });

  final String label;
  final Widget? leading;
  final AnimationController chevronAnim;
  final GlyphDropdownDirection direction;
  final double minWidth;
  final VoidCallback onTap;
  final bool isDisabled;
  final WidgetStatesController controller;
  final GlyphDropdownTriggerStyle triggerStyle;
  final GlyphDropdownMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final states = controller.value;
    final fgColor = triggerStyle.foregroundColor.resolve(states);
    final chevronColor = triggerStyle.chevronColor.resolve(states);

    return Semantics(
      button: true,
      child: Focus(
        onFocusChange: (f) => controller.update(.focused, f),
        child: MouseRegion(
          cursor: isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => controller.update(.hovered, true),
          onExit: (_) => controller.update(.hovered, false),
          child: GestureDetector(
            onTap: isDisabled ? null : onTap,
            behavior: .opaque,
            child: AnimatedContainer(
              duration: triggerStyle.animationDuration,
              curve: triggerStyle.animationCurve,
              constraints: BoxConstraints(minWidth: minWidth),
              decoration: ShapeDecoration(
                color: triggerStyle.backgroundColor.resolve(states),
                shape: triggerStyle.shape.resolve(states),
                shadows: triggerStyle.shadows.resolve(states),
              ),
              padding: metrics.triggerPadding,
              child: Row(
                mainAxisSize: .max,
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    mainAxisSize: .min,
                    children: [
                      if (leading != null) ...[
                        leading!,
                        SizedBox(width: metrics.triggerLeadingGap),
                      ],
                      Text(
                        label,
                        style: metrics.triggerLabelTextStyle.copyWith(
                          color: fgColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  RotationTransition(
                    turns:
                        Tween(
                          begin: direction.chevronBegin,
                          end: direction.chevronEnd,
                        ).animate(
                          CurvedAnimation(
                            parent: chevronAnim,
                            curve: Curves.easeInOut,
                          ),
                        ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: metrics.chevronSize,
                      color: chevronColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Panel ─────────────────────────────────────────────────────────────────────

class _DropdownPanel<T> extends StatelessWidget {
  const _DropdownPanel({
    required this.items,
    required this.value,
    required this.header,
    required this.minWidth,
    required this.onSelect,
    required this.style,
  });

  final List<GlyphDropdownItem<T>> items;
  final T? value;
  final String? header;
  final double minWidth;
  final ValueChanged<T> onSelect;
  final GlyphDropdownStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: GlyphColors.surface,
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: style.panelBackgroundColor,
          border: Border.fromBorderSide(style.panelBorderSide),
          borderRadius: style.panelBorderRadius,
          boxShadow: style.panelShadows,
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            if (header != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Text(
                  header!.toUpperCase(),
                  style: GlyphTextStyles.labelXsmallStrong.copyWith(
                    color: style.headerColor,
                  ),
                ),
              ),
            ...items.map(
              (item) => _DropdownOption<T>(
                item: item,
                isSelected: item.value == value,
                onTap: () => onSelect(item.value),
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Option row ────────────────────────────────────────────────────────────────

class _DropdownOption<T> extends StatefulWidget {
  const _DropdownOption({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.style,
  });

  final GlyphDropdownItem<T> item;
  final bool isSelected;
  final VoidCallback onTap;
  final GlyphDropdownStyle style;

  @override
  State<_DropdownOption<T>> createState() => _DropdownOptionState<T>();
}

class _DropdownOptionState<T> extends State<_DropdownOption<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final bgColor = widget.isSelected
        ? style.optionSelectedBackgroundColor
        : _hovered
        ? style.optionHoveredBackgroundColor
        : style.optionBackgroundColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const .new(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: style.optionBorderRadius,
          ),
          child: Row(
            mainAxisSize: .max,
            children: [
              if (widget.item.leading != null) ...[
                widget.item.leading!,
                const SizedBox(width: 10),
              ],
              Text(
                widget.item.label,
                style: GlyphTextStyles.labelSmallStrong.copyWith(
                  color: style.optionForegroundColor,
                ),
              ),
              const Spacer(),
              if (widget.isSelected) ...[
                const SizedBox(width: 12),
                Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: style.checkmarkColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
