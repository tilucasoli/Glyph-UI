import 'package:flutter/material.dart';

import 'glyph_icon_button_metrics.dart';
import 'glyph_icon_button_style.dart';

final class GlyphIconButton extends StatefulWidget {
  const GlyphIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    required this.style,
    this.metrics,
    this.tooltip,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final String semanticLabel;
  final GlyphIconButtonStyle style;
  final GlyphIconButtonMetrics? metrics;
  final String? tooltip;

  @override
  State<GlyphIconButton> createState() => _GlyphIconButtonState();
}

class _GlyphIconButtonState extends State<GlyphIconButton> {
  final _controller = WidgetStatesController();

  bool get _isDisabled => widget.onPressed == null;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(.disabled, _isDisabled);
  }

  @override
  void didUpdateWidget(covariant GlyphIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(.disabled, _isDisabled);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    _controller.update(.pressed, true);
  }

  void _onTapUp(TapUpDetails _) {
    _controller.update(.pressed, false);
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.update(.pressed, false);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final metrics = widget.metrics ?? GlyphIconButtonMetrics.medium();
    final states = _controller.value;

    Widget result = Semantics(
      button: true,
      label: widget.semanticLabel,
      child: Focus(
        onFocusChange: (focused) => _controller.update(.focused, focused),
        child: MouseRegion(
          cursor: _isDisabled
              ? SystemMouseCursors.basic
              : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(.hovered, true),
          onExit: (_) => _controller.update(.hovered, false),
          child: GestureDetector(
            onTapDown: _isDisabled ? null : _onTapDown,
            onTapUp: _isDisabled ? null : _onTapUp,
            onTapCancel: _isDisabled ? null : _onTapCancel,
            behavior: .opaque,
            child: AnimatedContainer(
              duration: style.animationDuration,
              curve: style.animationCurve,
              width: metrics.buttonSize,
              height: metrics.buttonSize,
              decoration: ShapeDecoration(
                color: style.backgroundColor.resolve(states),
                shape: style.shape.resolve(states),
                shadows: style.shadows.resolve(states),
              ),
              alignment: .center,
              child: IconTheme(
                data: IconThemeData(
                  size: metrics.iconSize,
                  color: style.foregroundColor.resolve(states),
                ),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null && widget.tooltip!.isNotEmpty) {
      result = Tooltip(message: widget.tooltip!, child: result);
    }

    return result;
  }
}
