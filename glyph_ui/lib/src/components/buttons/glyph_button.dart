import 'package:flutter/material.dart';

import '../../tokens/glyph_colors.dart';
import 'glyph_button_style.dart';
import 'glyph_button_theme.dart';

/// Unified text button with variant, size, optional leading/trailing icons,
/// and loading state. Uses [ButtonStyleButton] for focus/hover behavior.
///
/// Resolves [ButtonStyle] from [GlyphButtonThemeData.styleFor] and optional
/// [style] override, then merges size metrics (padding, minimumSize, textStyle).
class GlyphButton extends StatelessWidget {
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
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final GlyphButtonVariant variant;
  final GlyphButtonSize size;
  final ButtonStyle? style;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool expand;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final themeData = GlyphButtonThemeData.of(context);
    final base = themeData.styleFor(variant);
    final resolved = style != null ? base.merge(style) : base;

    final metrics = GlyphButtonStyleMetrics.forSize(size);
    final sizeOverrides = ButtonStyle(
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(metrics.padding),
      minimumSize: WidgetStatePropertyAll<Size>(
        Size(expand ? double.infinity : 0, metrics.minHeight),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle>(metrics.labelTextStyle),
    );
    final finalStyle = resolved.merge(sizeOverrides);

    final iconColor = resolved.foregroundColor?.resolve(
          isLoading ? const {WidgetState.disabled} : const <WidgetState>{},
        ) ??
        (isLoading ? GlyphColors.textTertiary : GlyphColors.textPrimary);

    final content = isLoading
        ? SizedBox(
            width: metrics.iconSize,
            height: metrics.iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: iconColor,
            ),
          )
        : Row(
            mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                IconTheme(
                  data: IconThemeData(size: metrics.iconSize, color: iconColor),
                  child: leadingIcon!,
                ),
                const SizedBox(width: 8),
              ],
              Text(label),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                IconTheme(
                  data: IconThemeData(size: metrics.iconSize, color: iconColor),
                  child: trailingIcon!,
                ),
              ],
            ],
          );

    return FilledButton(
      style: finalStyle,
      onPressed: isLoading ? null : onPressed,
      child: content,
    );
  }
}
