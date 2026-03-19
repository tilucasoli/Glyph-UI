import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import 'glyph_button_style.dart';
import 'glyph_button_theme.dart';

/// A unified text button with [variant], [size], optional [leadingIcon] and
/// [trailingIcon], and [loading] state. Uses [ButtonStyleButton] for focus
/// and hover behavior.
///
/// Resolves [ButtonStyle] from [GlyphButtonThemeData.styleFor] and optional
/// [style] override, then merges size metrics (padding, minimumSize, textStyle).
final class GlyphButton extends StatelessWidget {
  const GlyphButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GlyphButtonVariant.filled,
    this.size = GlyphButtonSize.medium,
    this.style,
    this.leadingIcon,
    this.trailingIcon,
    this.expand = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final GlyphButtonVariant variant;
  final GlyphButtonSize size;
  final ButtonStyle? style;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool expand;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final themeData = GlyphButtonThemeData.of(context);
    final base = themeData.styleFor(variant);
    final resolved = style != null ? base.merge(style) : base;

    final metrics = GlyphButtonStyleMetrics.forSize(size);
    final sizeOverrides = ButtonStyle(
      padding: .all(metrics.padding),
      minimumSize: .all(Size(expand ? .infinity : 0, metrics.minHeight)),
      textStyle: .all(metrics.labelTextStyle),
      iconSize: .all(metrics.iconSize),
    );
    final finalStyle = resolved.merge(sizeOverrides);

    final loadingIndicator = SizedBox(
      width: metrics.iconSize,
      height: metrics.iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color:
            resolved.foregroundColor?.resolve({.disabled}) ??
            GlyphColors.textTertiary,
      ),
    );

    final content = Row(
      mainAxisSize: expand ? .max : .min,
      mainAxisAlignment: .center,
      spacing: metrics.iconGap,
      children: [
        if (leadingIcon != null) leadingIcon!,
        Text(
          label,
          strutStyle: const .new(forceStrutHeight: true, height: 1.05),
        ),
        if (trailingIcon != null) trailingIcon!,
      ],
    );

    return FilledButton(
      style: finalStyle,
      onPressed: loading ? null : onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(opacity: !loading ? 1 : 0, child: content),
          Visibility(visible: loading, child: loadingIndicator),
        ],
      ),
    );
  }
}
