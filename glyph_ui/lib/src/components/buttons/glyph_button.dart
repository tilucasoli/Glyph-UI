import 'package:flutter/material.dart';

import 'glyph_button_style.dart';

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
  final _controller = WidgetStatesController();

  bool get _isDisabled => widget.onPressed == null || widget.loading;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.update(WidgetState.disabled, _isDisabled);
  }

  @override
  void didUpdateWidget(covariant GlyphButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.update(WidgetState.disabled, _isDisabled);
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
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    _controller.update(WidgetState.pressed, false);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final states = _controller.value;
    final fgColor = style.foregroundColor.resolve(states);

    final content = Row(
      mainAxisSize: widget.expand ? .max : .min,
      mainAxisAlignment: .center,
      spacing: style.iconGap,
      children: [
        if (widget.leadingIcon != null) widget.leadingIcon!,
        Text(
          widget.label,
          style: style.labelTextStyle.copyWith(color: fgColor),
        ),
        if (widget.trailingIcon != null) widget.trailingIcon!,
      ],
    );

    final loadingIndicator = SizedBox(
      width: style.iconSize,
      height: style.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: style.foregroundColor.resolve({WidgetState.disabled}),
      ),
    );

    return Semantics(
      button: true,
      child: Focus(
        onFocusChange: (focused) =>
            _controller.update(WidgetState.focused, focused),
        child: MouseRegion(
          cursor: _isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
          onEnter: (_) => _controller.update(WidgetState.hovered, true),
          onExit: (_) => _controller.update(WidgetState.hovered, false),
          child: GestureDetector(
            onTapDown: _isDisabled ? null : _onTapDown,
            onTapUp: _isDisabled ? null : _onTapUp,
            onTapCancel: _isDisabled ? null : _onTapCancel,
            behavior: .opaque,
            child: AnimatedContainer(
              duration: style.animationDuration,
              curve: style.animationCurve,
              decoration: ShapeDecoration(
                color: style.backgroundColor.resolve(states),
                shape: style.shape.resolve(states).copyWith(
                  side: style.side.resolve(states),
                ),
              ),
              padding: style.padding,
              constraints: BoxConstraints(
                minHeight: style.minHeight,
                minWidth: widget.expand ? .infinity : 0,
              ),
              child: Stack(
                alignment: .center,
                children: [
                  Opacity(
                    opacity: widget.loading ? 0 : 1,
                    child: content,
                  ),
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
