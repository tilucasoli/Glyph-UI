import 'package:flutter/material.dart';

import 'glyph_sidebar_item_style.dart';
import 'glyph_sidebar_style.dart';

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
/// from [GlyphSidebarStyle] when the tile sits inside [GlyphSidebar].
final class GlyphSidebarItemTile extends StatefulWidget {
  const GlyphSidebarItemTile({
    super.key,
    required this.sidebarStyle,
    required this.size,
    required this.item,
  });

  final GlyphSidebarStyle sidebarStyle;
  final GlyphSidebarSize size;
  final GlyphSidebarItem item;

  @override
  State<GlyphSidebarItemTile> createState() => _GlyphSidebarItemTileState();
}

class _GlyphSidebarItemTileState extends State<GlyphSidebarItemTile> {
  final _controller = WidgetStatesController();

  bool get _disabled => widget.item.onTap == null;

  GlyphSidebarItemStyle get _itemStyle => widget.sidebarStyle.itemStyle;

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
    final s = widget.sidebarStyle;
    final sz = widget.size;
    final style = _itemStyle;
    final bg = style.backgroundColor.resolve(states);
    final fg = style.foregroundColor.resolve(states);
    final shadows = style.shadows.resolve(states);
    final shape = style.shape.resolve(states);

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
              duration: style.animationDuration,
              curve: style.animationCurve,
              margin: EdgeInsets.only(
                bottom: s.navItemBottomMargin.resolve(sz),
              ),
              padding: s.navItemPadding.resolve(sz),
              decoration: ShapeDecoration(
                color: bg,
                shape: shape,
                shadows: shadows,
              ),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: style.iconColor.resolve(states),
                      size: s.navItemIconSize.resolve(sz),
                    ),
                    child: widget.item.icon,
                  ),
                  SizedBox(width: s.navItemIconGap.resolve(sz)),
                  Text(
                    widget.item.label,
                    style: style.labelTextStyle
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
