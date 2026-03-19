import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import '../../tokens/glyph_radius.dart';
import '../../tokens/glyph_typography.dart';

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
    GlyphDropdownDirection.down => Alignment.bottomLeft,
    GlyphDropdownDirection.up => Alignment.topLeft,
    GlyphDropdownDirection.right => Alignment.centerRight,
    GlyphDropdownDirection.left => Alignment.centerLeft,
  };

  /// Which corner/edge of the panel aligns to [targetAnchor].
  Alignment get followerAnchor => switch (this) {
    GlyphDropdownDirection.down => Alignment.topLeft,
    GlyphDropdownDirection.up => Alignment.bottomLeft,
    GlyphDropdownDirection.right => Alignment.centerLeft,
    GlyphDropdownDirection.left => Alignment.centerRight,
  };

  /// Gap between trigger and panel.
  Offset get offset => switch (this) {
    GlyphDropdownDirection.down => const Offset(0, 6),
    GlyphDropdownDirection.up => const Offset(0, -6),
    GlyphDropdownDirection.right => const Offset(6, 0),
    GlyphDropdownDirection.left => const Offset(-6, 0),
  };

  /// [Align] used to keep the panel from stretching to screen edges.
  Alignment get panelAlign => switch (this) {
    GlyphDropdownDirection.down => Alignment.topLeft,
    GlyphDropdownDirection.up => Alignment.bottomLeft,
    GlyphDropdownDirection.right => Alignment.centerLeft,
    GlyphDropdownDirection.left => Alignment.centerRight,
  };

  /// Chevron rotation (in turns) when the panel is **closed**.
  ///
  /// The animation plays `forward()` on open and `reverse()` on close,
  /// so `begin` = closed angle and `end` = open angle.
  double get chevronBegin => switch (this) {
    GlyphDropdownDirection.down => 0.0, // ↓ pointing down
    GlyphDropdownDirection.up => 0.5, // ↑ pointing up
    GlyphDropdownDirection.right => -0.25, // → pointing right
    GlyphDropdownDirection.left => 0.25, // ← pointing left
  };

  /// Chevron rotation (in turns) when the panel is **open**.
  double get chevronEnd => switch (this) {
    GlyphDropdownDirection.down => 0.5, // ↑ flipped up
    GlyphDropdownDirection.up => 1.0, // ↓ flipped down (360° = 0°)
    GlyphDropdownDirection.right => 0.25, // ← flipped left
    GlyphDropdownDirection.left => -0.25, // → flipped right
  };
}

/// A single selectable item in [GlyphDropdown].
///
/// [leading] is typically a coloured avatar/logo or icon.
/// [subtitle] appears below [label] in smaller gray text.
class GlyphDropdownItem<T> {
  const GlyphDropdownItem({
    required this.value,
    required this.label,
    this.subtitle,
    this.leading,
  });

  final T value;
  final String label;
  final String? subtitle;

  /// Optional leading widget rendered at the start of each option row.
  final Widget? leading;
}

/// Styled dropdown selector with an animated overlay panel.
///
/// Matches two patterns from the design reference:
/// - `.event-selector-btn` — compact trigger (dot + label + chevron)
/// - `.community-dropdown` — panel with optional header, leading widgets,
///   subtitles, and a check mark on the selected item
///
/// Use [direction] to control which side the panel opens toward.
/// The chevron icon in the trigger automatically rotates to reflect the
/// open direction.
///
/// ```dart
/// // Opens below (default)
/// GlyphDropdown<String>(
///   value: _eventId,
///   placeholder: 'Select event…',
///   items: const [
///     GlyphDropdownItem(value: 'conf', label: 'Design Conference 2024'),
///     GlyphDropdownItem(value: 'summit', label: 'TechPulse Summit'),
///   ],
///   onChanged: (v) => setState(() => _eventId = v),
/// )
///
/// // Opens above (e.g. sidebar footer community switcher)
/// GlyphDropdown<String>(
///   value: _communityId,
///   direction: GlyphDropdownDirection.up,
///   header: 'Switch Community',
///   items: [...],
///   onChanged: (v) => setState(() => _communityId = v),
/// )
///
/// // Opens to the right (e.g. context menu beside a sidebar item)
/// GlyphDropdown<String>(
///   value: _selected,
///   direction: GlyphDropdownDirection.right,
///   items: [...],
///   onChanged: (v) => setState(() => _selected = v),
/// )
/// ```
class GlyphDropdown<T> extends StatefulWidget {
  const GlyphDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.placeholder,
    this.header,
    this.leading,
    this.minWidth = 220,
    this.direction = GlyphDropdownDirection.down,
  });

  final List<GlyphDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T> onChanged;

  /// Shown in the trigger when [value] is null.
  final String? placeholder;

  /// Optional section label at the top of the panel
  /// (e.g. "Switch Community"). Rendered in uppercase 11px.
  final String? header;

  /// Fixed leading widget shown inside the trigger before the label.
  /// Useful for a status dot, avatar, or icon that doesn't change
  /// with the selection. Takes precedence over the selected item's leading.
  final Widget? leading;

  /// Minimum width of both the trigger and the panel. Defaults to 220.
  final double minWidth;

  /// Which side the panel opens toward. Defaults to [GlyphDropdownDirection.down].
  final GlyphDropdownDirection direction;

  @override
  State<GlyphDropdown<T>> createState() => _GlyphDropdownState<T>();
}

class _GlyphDropdownState<T> extends State<GlyphDropdown<T>>
    with SingleTickerProviderStateMixin {
  final _layerLink = LayerLink();
  final _overlayController = OverlayPortalController();
  late final AnimationController _chevronAnim;

  bool get _isOpen => _overlayController.isShowing;

  @override
  void initState() {
    super.initState();
    _chevronAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
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

  void _toggle() => _isOpen ? _close() : _open();

  void _select(T value) {
    widget.onChanged(value);
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

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (ctx) => Stack(
          children: [
            // Full-screen barrier — tapping outside closes the panel
            Positioned.fill(
              child: GestureDetector(
                onTap: _close,
                behavior: HitTestBehavior.opaque,
              ),
            ),
            // Panel anchored according to [direction]
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
        ),
      ),
    );
  }
}

// ── Trigger ───────────────────────────────────────────────────────────────────

class _DropdownTrigger extends StatefulWidget {
  const _DropdownTrigger({
    required this.label,
    this.leading,
    required this.chevronAnim,
    required this.direction,
    required this.minWidth,
    required this.onTap,
  });

  final String label;
  final Widget? leading;
  final AnimationController chevronAnim;
  final GlyphDropdownDirection direction;
  final double minWidth;
  final VoidCallback onTap;

  @override
  State<_DropdownTrigger> createState() => _DropdownTriggerState();
}

class _DropdownTriggerState extends State<_DropdownTrigger> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          constraints: BoxConstraints(minWidth: widget.minWidth),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: _hovered ? GlyphColors.bgCanvas : GlyphColors.bgBody,
            border: Border.all(color: GlyphColors.borderMedium),
            borderRadius: GlyphRadius.borderSm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: GlyphTextStyles.small.copyWith(
                      color: GlyphColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              RotationTransition(
                turns:
                    Tween(
                      begin: widget.direction.chevronBegin,
                      end: widget.direction.chevronEnd,
                    ).animate(
                      CurvedAnimation(
                        parent: widget.chevronAnim,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: GlyphColors.textTertiary,
                ),
              ),
            ],
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
  });

  final List<GlyphDropdownItem<T>> items;
  final T? value;
  final String? header;
  final double minWidth;
  final ValueChanged<T> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: GlyphColors.bgSurface,
          border: Border.all(color: GlyphColors.borderMedium),
          borderRadius: GlyphRadius.borderSm,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
              spreadRadius: -4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 8),
                child: Text(
                  header!.toUpperCase(),
                  style: GlyphTextStyles.meta.copyWith(
                    fontWeight: FontWeight.w600,
                    color: GlyphColors.textTertiary,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ...items.map(
              (item) => _DropdownOption<T>(
                item: item,
                isSelected: item.value == value,
                onTap: () => onSelect(item.value),
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
  });

  final GlyphDropdownItem<T> item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_DropdownOption<T>> createState() => _DropdownOptionState<T>();
}

class _DropdownOptionState<T> extends State<_DropdownOption<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSelected
        ? GlyphColors.bgSidebar
        : _hovered
        ? GlyphColors.bgBody
        : GlyphColors.bgBody.withValues(alpha: 0.0);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: GlyphRadius.borderSm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.item.leading != null) ...[
                widget.item.leading!,
                const SizedBox(width: 10),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.label,
                    style: GlyphTextStyles.small.copyWith(
                      color: GlyphColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (widget.isSelected) ...[
                const SizedBox(width: 12),
                const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: GlyphColors.textPrimary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
