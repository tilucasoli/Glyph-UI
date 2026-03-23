import 'package:flutter/material.dart';

import 'glyph_sidebar_item_style.dart';
import 'glyph_sidebar_metrics.dart';

export 'glyph_sidebar_item_style.dart';

/// Data model for a single navigation item in the sidebar.
///
/// ```dart
/// GlyphSidebarItem(
///   icon: Icon(Icons.confirmation_number_outlined),
///   label: 'Tickets',
///   isActive: true,
///   onTap: () {},
/// )
/// ```
class GlyphSidebarItem {
  const GlyphSidebarItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final Widget icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;
}

/// Interactive row for one [GlyphSidebarItem].
///
/// Uses [GlyphSidebarItemStyle] for colors, shape, and motion; dimensions come
/// from [GlyphSidebarMetrics] when the tile sits inside [GlyphSidebar].
final class GlyphSidebarItemTile extends StatefulWidget {
  const GlyphSidebarItemTile({
    super.key,
    required this.style,
    required this.metrics,
    required this.item,
  });

  final GlyphSidebarItemStyle style;
  final GlyphSidebarMetrics metrics;
  final GlyphSidebarItem item;

  @override
  State<GlyphSidebarItemTile> createState() => _GlyphSidebarItemTileState();
}

class _GlyphSidebarItemTileState extends State<GlyphSidebarItemTile> {
  final _controller = WidgetStatesController();

  bool get _disabled => widget.item.onTap == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(WidgetState.disabled, _disabled);
    _controller.update(WidgetState.selected, widget.item.isActive);
  }

  @override
  void didUpdateWidget(covariant GlyphSidebarItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(WidgetState.disabled, _disabled);
    _controller.update(WidgetState.selected, widget.item.isActive);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.update(WidgetState.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.update(WidgetState.pressed, false);
  }

  void _onTapCancel() {
    _controller.update(WidgetState.pressed, false);
  }

  @override
  Widget build(BuildContext context) {
    final states = _controller.value;
    final bg = widget.style.backgroundColor.resolve(states);
    final fg = widget.style.foregroundColor.resolve(states);
    final shadows = widget.style.shadows.resolve(states);
    final shape = widget.style.shape.resolve(states);

    return Semantics(
      button: true,
      child: Focus(
        onFocusChange: (f) => _controller.update(WidgetState.focused, f),
        child: MouseRegion(
          cursor: _disabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(WidgetState.hovered, true),
          onExit: (_) => _controller.update(WidgetState.hovered, false),
          child: GestureDetector(
            onTapDown: _disabled ? null : _onTapDown,
            onTapUp: _disabled ? null : _onTapUp,
            onTapCancel: _disabled ? null : _onTapCancel,
            onTap: widget.item.onTap,
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: widget.style.animationDuration,
              curve: widget.style.animationCurve,
              margin: EdgeInsets.only(
                bottom: widget.metrics.navItemBottomMargin,
              ),
              padding: widget.metrics.navItemPadding,
              decoration: ShapeDecoration(
                color: bg,
                shape: shape,
                shadows: shadows,
              ),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: widget.style.iconColor.resolve(states),
                      size: widget.metrics.navItemIconSize,
                    ),
                    child: widget.item.icon,
                  ),
                  SizedBox(width: widget.metrics.navItemIconGap),
                  Text(
                    widget.item.label,
                    style: widget.style.labelTextStyle
                        .resolve(states)
                        .copyWith(color: fg),
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
